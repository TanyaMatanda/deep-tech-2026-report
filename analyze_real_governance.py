
import os
import pandas as pd
from supabase import create_client, Client, ClientOptions
import toml

# Configuration
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
    except:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")

if not url or not key:
    print("❌ Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

def fetch_real_data():
    print("📥 Fetching REAL board composition data (Tier 1 & Canada)...")
    
    # Fetch all public companies first to filter in memory if needed, 
    # or use complex query. simpler to fetch public and filter.
    
    all_data = []
    page_size = 1000
    offset = 0
    
    while True:
        try:
            # Fetching companies that are Public
            response = supabase.table("board_composition_annual")\
                .select("*, companies!inner(company_name, listing_type, incorporation_country, data_tier)")\
                .eq("companies.listing_type", "Public")\
                .range(offset, offset + page_size - 1)\
                .execute()
            
            data = response.data
            if not data:
                break
                
            all_data.extend(data)
            offset += page_size
            
            if len(data) < page_size:
                break
        except Exception as e:
            print(f"❌ Error fetching data: {e}")
            break
            
    df = pd.DataFrame(all_data)
    
    if df.empty:
        print("No public data found.")
        return pd.DataFrame()

    # Flatten
    df['company_name'] = df['companies'].apply(lambda x: x.get('company_name'))
    df['country'] = df['companies'].apply(lambda x: x.get('incorporation_country'))
    df['data_tier'] = df['companies'].apply(lambda x: x.get('data_tier'))
    
    # FILTER FOR REAL DATA ONLY
    # Condition 1: Data Tier = 1 (Verified Real US)
    # Condition 2: Country = CAN (Canadian Deep Tech)
    
    real_df = df[
        (df['data_tier'] == 1) | 
        (df['country'] == 'CAN')
    ].copy()
    
    print(f"✅ Total Public Records: {len(df)}")
    print(f"✅ Filtered Real Records: {len(real_df)}")
    return real_df

def analyze_governance(df):
    if df.empty:
        print("No real data to analyze.")
        return

    # Calculate Percentages
    if 'total_directors' in df.columns and 'independent_directors' in df.columns:
        df['independence_pct'] = (df['independent_directors'] / df['total_directors']) * 100
    
    # Metrics
    metrics = {
        'Independence %': 'independence_pct',
        'Women %': 'women_percentage',
        'Tech Experts': 'tech_experts',
        'AI/Cyber Experts': 'ai_cybersecurity_experts',
        'Avg Age': 'avg_director_age',
        'Avg Tenure': 'avg_director_tenure'
    }
    
    print("\n========================================================")
    print("REAL GOVERNANCE ANALYSIS (US & CANADA)")
    print("========================================================")
    
    # Group by Country
    grouped = df.groupby('country')
    
    for name, group in grouped:
        print(f"\n🇨🇦/🇺🇸 REGION: {name} (N={len(group)})")
        
        for label, col in metrics.items():
            if col in group.columns:
                avg_val = group[col].mean()
                non_null = group[col].count()
                print(f"  - {label}: {avg_val:.2f} (n={non_null})")
                
        # Check specific AI Governance
        ai_comm = group['has_ai_oversight_committee'].sum()
        ai_policy = group['has_ai_ethics_policy'].sum()
        print(f"  - Has AI Committee: {ai_comm} ({ai_comm/len(group):.1%})")
        print(f"  - Has AI Ethics Policy: {ai_policy} ({ai_policy/len(group):.1%})")

        # Print companies with REAL age/tenure data
        age_data = group[group['avg_director_age'].notnull()]
        if not age_data.empty:
            print(f"  - Companies with Age Data: {', '.join(age_data['company_name'].tolist())}")
        
        tenure_data = group[group['avg_director_tenure'].notnull()]
        if not tenure_data.empty:
            print(f"  - Companies with Tenure Data: {', '.join(tenure_data['company_name'].tolist())}")

if __name__ == "__main__":
    df = fetch_real_data()
    analyze_governance(df)
