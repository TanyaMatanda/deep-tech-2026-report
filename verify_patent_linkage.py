import os
from supabase import create_client, Client, ClientOptions
import toml
import pandas as pd
from datetime import datetime

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

def verify_patent_linkage():
    """
    Verify patent linkage for AI companies and generate AI Wash analysis.
    Returns: Dictionary with analysis results
    """
    print("=" * 70)
    print("🔍 AI WASH VERIFICATION REPORT")
    print("=" * 70)
    print(f"📅 Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")

    try:
        # 1. Fetch companies with better error handling
        print("  - Fetching companies from database...")
        res = supabase.table("companies").select("id, company_name, technology_tags, primary_sector").execute()
        
        if not res.data:
            print("  ⚠️ No companies found in database.")
            return None

        df_companies = pd.DataFrame(res.data)
        print(f"  ✓ Total companies in database: {len(df_companies):,}")
        
    except Exception as e:
        print(f"❌ Database error fetching companies: {e}")
        return None

    try:
        # 2. Fetch patents and join with companies
        print("  - Fetching patent data...")
        res_patents = supabase.table("patents").select("company_id, patent_number, is_active").execute()
        
        if res_patents.data:
            df_patents = pd.DataFrame(res_patents.data)
            # Count active patents per company
            active_patents = df_patents[df_patents['is_active'] == True].groupby('company_id').size().reset_index(name='patent_count')
            # Merge with companies
            df_companies = df_companies.merge(active_patents, left_on='id', right_on='company_id', how='left')
            df_companies['patent_count'] = df_companies['patent_count'].fillna(0).astype(int)
            print(f"  ✓ Active patents linked: {len(df_patents[df_patents['is_active'] == True]):,}")
        else:
            print("  ⚠️ No patent data found. Using patent_count column if available.")
            if 'patent_count' not in df_companies.columns:
                df_companies['patent_count'] = 0
                
    except Exception as e:
        print(f"  ⚠️ Error fetching patents: {e}. Using patent_count column if available.")
        if 'patent_count' not in df_companies.columns:
            df_companies['patent_count'] = 0

    # 3. Filter for AI-related sectors
    ai_keywords = [
        'Advanced Computing and AI', 
        'Semi Conductors and AI', 
        'Autonomous Systems',
        'AI & Machine Learning',
        'Artificial Intelligence'
    ]
    
    def is_ai_company(row):
        """Check if company is AI-related based on technology_tags or sector"""
        tags = row.get('technology_tags', []) or []
        sector = row.get('primary_sector', '') or ''
        return any(k in tags or k in str(sector) for k in ai_keywords)

    df_companies['is_ai'] = df_companies.apply(is_ai_company, axis=1)
    ai_companies = df_companies[df_companies['is_ai']]
    
    print(f"\n📊 AI COMPANY IDENTIFICATION:")
    print(f"  - Total AI Companies: {len(ai_companies):,}")
    print(f"  - % of Total Database: {len(ai_companies)/len(df_companies)*100:.1f}%")
    
    if len(ai_companies) == 0:
        print("  ⚠️ No AI companies found. Exiting.")
        return None

    # 4. Calculate AI Wash metrics
    companies_with_patents = ai_companies[ai_companies['patent_count'] > 0]
    companies_zero_patents = ai_companies[ai_companies['patent_count'] == 0]
    
    n_total = len(ai_companies)
    n_zero = len(companies_zero_patents)
    n_with = len(companies_with_patents)
    pct_wash = (n_zero / n_total) * 100 if n_total > 0 else 0
    
    print(f"\n📊 AI WASH ANALYSIS:")
    print(f"  - Total AI Companies: {n_total:,}")
    print(f"  - With Active Patents: {n_with:,}")
    print(f"  - Zero Patents ('AI Wash'): {n_zero:,}")
    print(f"  - AI Wash Rate: {pct_wash:.2f}%")
    
    # 5. Sector-level breakdown
    print(f"\n📈 SECTOR-LEVEL BREAKDOWN:")
    for keyword in ai_keywords:
        sector_df = ai_companies[ai_companies.apply(
            lambda row: keyword in (row.get('technology_tags', []) or []) or keyword in (row.get('primary_sector', '') or ''), 
            axis=1
        )]
        if len(sector_df) > 0:
            sector_wash = (sector_df['patent_count'] == 0).sum()
            sector_wash_pct = (sector_wash / len(sector_df)) * 100
            print(f"  - {keyword:40s}: {len(sector_df):5,} companies | {sector_wash_pct:5.1f}% Wash")
    
    # 6. Patent distribution statistics (for companies with patents)
    if n_with > 0:
        patent_stats = companies_with_patents['patent_count'].describe()
        print(f"\n📊 PATENT DISTRIBUTION (Companies with >0 Patents):")
        print(f"  - Mean:   {patent_stats['mean']:.1f}")
        print(f"  - Median: {patent_stats['50%']:.0f}")
        print(f"  - Max:    {patent_stats['max']:.0f}")
        print(f"  - Min:    {patent_stats['min']:.0f}")
    
    # 7. Validation against the "99.9%" claim
    print(f"\n✅ CLAIM VALIDATION:")
    if pct_wash > 99.0:
        print(f"  ✓ VERIFIED: The AI Wash rate ({pct_wash:.2f}%) supports the >99% claim.")
    elif pct_wash > 95.0:
        print(f"  ~ DIRECTIONAL: The AI Wash rate ({pct_wash:.2f}%) is high but below 99%.")
    else:
        print(f"  ✗ CHALLENGED: The AI Wash rate ({pct_wash:.2f}%) does not support the 99.9% claim.")
    
    # 8. Export results to CSV
    print(f"\n💾 EXPORTING RESULTS:")
    
    # Export AI Wash companies
    export_cols = ['company_name', 'primary_sector', 'technology_tags', 'patent_count']
    companies_zero_patents[export_cols].to_csv('ai_wash_companies.csv', index=False)
    print(f"  ✓ ai_wash_companies.csv ({len(companies_zero_patents):,} companies)")
    
    # Export companies with patents
    if n_with > 0:
        companies_with_patents[export_cols].to_csv('ai_verified_companies.csv', index=False)
        print(f"  ✓ ai_verified_companies.csv ({n_with:,} companies)")
    
    # Export summary
    summary = {
        'report_date': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        'total_database': len(df_companies),
        'total_ai_companies': n_total,
        'ai_companies_with_patents': n_with,
        'ai_companies_zero_patents': n_zero,
        'ai_wash_rate_pct': round(pct_wash, 2),
        'claim_validated': pct_wash > 99.0
    }
    pd.DataFrame([summary]).to_csv('ai_wash_summary.csv', index=False)
    print(f"  ✓ ai_wash_summary.csv")
    
    # 9. Sample output
    print(f"\n🔎 SAMPLE 'AI WASH' COMPANIES (Top 10):")
    sample_cols = ['company_name', 'primary_sector']
    if len(companies_zero_patents) > 0:
        print(companies_zero_patents[sample_cols].head(10).to_string(index=False))
    
    print("\n" + "=" * 70)
    print("✅ VERIFICATION COMPLETE")
    print("=" * 70)
    
    return summary

if __name__ == "__main__":
    results = verify_patent_linkage()
    if results:
        print(f"\n📋 Summary: {results['ai_wash_rate_pct']}% AI Wash Rate")
