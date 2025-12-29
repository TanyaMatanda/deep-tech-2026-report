
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

def fetch_all_data():
    print("📥 Fetching ALL board composition data...")
    
    all_data = []
    page_size = 1000
    offset = 0
    
    while True:
        print(f"  - Fetching page starting at {offset}...")
        try:
            response = supabase.table("board_composition_annual")\
                .select("*, companies!inner(company_name, listing_type, incorporation_country, data_tier)")\
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
    print(f"✅ Total Records Fetched: {len(df)}")
    return df

def analyze_governance(df):
    if df.empty:
        print("No data to analyze.")
        return

    # Flatten company info
    df['company_name'] = df['companies'].apply(lambda x: x.get('company_name'))
    df['listing_type'] = df['companies'].apply(lambda x: x.get('listing_type'))
    df['country'] = df['companies'].apply(lambda x: x.get('incorporation_country'))
    df['data_tier'] = df['companies'].apply(lambda x: x.get('data_tier'))
    
    # Define Segments
    # Tier 1 = Real Public, Tier 2/3/4 = Synthetic/Private/Other
    # We'll group by 'Source'
    
    def classify_source(row):
        if row['listing_type'] == 'Public':
            return f"Real Public ({row['country']})"
        else:
            return "Synthetic / Simulation"
            
    df['source_category'] = df.apply(classify_source, axis=1)
    
    # Calculate Percentages
    if 'total_directors' in df.columns and 'independent_directors' in df.columns:
        df['independence_pct'] = (df['independent_directors'] / df['total_directors']) * 100
    
    # Metrics to Analyze
    metrics = {
        'Independence Count': 'independent_directors',
        'Independence %': 'independence_pct',
        'Avg Age': 'avg_director_age',
        'Avg Tenure': 'avg_director_tenure',
        'Tech Experts': 'tech_experts',
        'AI/Cyber Experts': 'ai_cybersecurity_experts',
        'Women %': 'women_percentage'
    }
    
    # Boolean Metrics
    bool_metrics = {
        'Has AI Committee': 'has_ai_oversight_committee',
        'Has AI Ethics Policy': 'has_ai_ethics_policy',
        'CEO is Chair': 'ceo_is_board_chair'
    }
    
    print("\n========================================================")
    print("GOVERNANCE ANALYSIS REPORT (ALL COMPANIES)")
    print("========================================================")
    
    # Group by Source
    grouped = df.groupby('source_category')
    
    for name, group in grouped:
        print(f"\n📊 SEGMENT: {name} (N={len(group)})")
        
        # Numeric Averages
        for label, col in metrics.items():
            if col in group.columns:
                avg_val = group[col].mean()
                non_null = group[col].count()
                print(f"  - {label}: {avg_val:.2f} (n={non_null})")
        
        # Boolean Percentages
        for label, col in bool_metrics.items():
            if col in group.columns:
                pct = (group[col].sum() / len(group)) * 100
                print(f"  - {label}: {pct:.1f}%")

if __name__ == "__main__":
    df = fetch_all_data()
    analyze_governance(df)
