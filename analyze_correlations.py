
import os
import toml
import pandas as pd
from supabase import create_client, ClientOptions

# 1. Setup Supabase
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

if not url:
    print("❌ Credentials not found")
    exit(1)

supabase = create_client(url, key, options=ClientOptions(schema='vendor_governance'))

def analyze_correlations():
    print("==========================================")
    print("📊 ANALYZING GOVERNANCE CORRELATIONS")
    print("==========================================")
    
    # 1. Fetch Data
    # Join companies, board_composition, risk_factors, proposals
    # Since Supabase-py doesn't support complex joins easily, we fetch and merge in Pandas
    
    print("📥 Fetching data...")
    
    # Companies & Board Data
    res_board = supabase.table('board_composition_annual')\
        .select('company_id, women_percentage, women_board_chair, independent_women_board_chair, independent_directors, total_directors')\
        .eq('fiscal_year', 2024)\
        .execute()
    df_board = pd.DataFrame(res_board.data)
    
    # Risk Factors (Count per company)
    res_risk = supabase.table('company_risk_factors')\
        .select('company_id, risk_category, ai_related, climate_related')\
        .eq('fiscal_year', 2024)\
        .execute()
    df_risk = pd.DataFrame(res_risk.data)
    
    # Shareholder Proposals (Count per company)
    res_prop = supabase.table('shareholder_proposals')\
        .select('company_id, category, passed')\
        .eq('fiscal_year', 2024)\
        .execute()
    df_prop = pd.DataFrame(res_prop.data)
    
    if df_board.empty:
        print("⚠️ No board data available for analysis.")
        return

    # 2. Aggregation
    
    # Risks per company
    if not df_risk.empty:
        risk_counts = df_risk.groupby('company_id').agg({
            'risk_category': 'count',
            'ai_related': 'sum',
            'climate_related': 'sum'
        }).rename(columns={'risk_category': 'total_risks', 'ai_related': 'ai_risks', 'climate_related': 'climate_risks'})
    else:
        risk_counts = pd.DataFrame(columns=['total_risks', 'ai_risks', 'climate_risks'])
        
    # Proposals per company
    if not df_prop.empty:
        prop_counts = df_prop.groupby('company_id').agg({
            'category': 'count',
            'passed': 'sum'
        }).rename(columns={'category': 'total_proposals', 'passed': 'proposals_passed'})
    else:
        prop_counts = pd.DataFrame(columns=['total_proposals', 'proposals_passed'])

    # Merge
    df = df_board.merge(risk_counts, on='company_id', how='left').fillna(0)
    df = df.merge(prop_counts, on='company_id', how='left').fillna(0)
    
    # 3. Correlation Analysis
    
    # Filter for valid data (e.g., non-zero directors)
    df = df[df['total_directors'] > 0]
    
    print(f"\n✅ Analyzed {len(df)} companies")
    
    # Correlation Matrix
    cols = ['women_percentage', 'total_risks', 'ai_risks', 'climate_risks', 'total_proposals']
    corr = df[cols].corr()
    
    print("\n🔗 Correlation Matrix (Women % vs Risks/Proposals):")
    print(corr['women_percentage'].sort_values(ascending=False))
    
    # 4. Chair Analysis
    print("\n🪑 Chair Analysis:")
    women_chairs = df[df['women_board_chair'] == True]
    men_chairs = df[df['women_board_chair'] == False]
    
    print(f"   Women Chairs: {len(women_chairs)}")
    print(f"   Men Chairs:   {len(men_chairs)}")
    
    if not women_chairs.empty and not men_chairs.empty:
        avg_risk_women = women_chairs['total_risks'].mean()
        avg_risk_men = men_chairs['total_risks'].mean()
        print(f"   Avg Risks (Women Chair): {avg_risk_women:.2f}")
        print(f"   Avg Risks (Men Chair):   {avg_risk_men:.2f}")
        
        avg_prop_women = women_chairs['total_proposals'].mean()
        avg_prop_men = men_chairs['total_proposals'].mean()
        print(f"   Avg Proposals (Women Chair): {avg_prop_women:.2f}")
        print(f"   Avg Proposals (Men Chair):   {avg_prop_men:.2f}")

if __name__ == "__main__":
    analyze_correlations()
