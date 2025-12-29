import os
import pandas as pd
from supabase import create_client, Client, ClientOptions

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def init_connection():
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def analyze():
    client = init_connection()
    print("--- Analyzing Real Governance Data ---")
    
    # Fetch all board data for 2025 (or latest)
    # We'll fetch everything and filter in pandas for flexibility
    res = client.table("board_composition_annual").select("*, companies(company_name, ticker_symbol, primary_sector)").execute()
    
    if not res.data:
        print("No data found.")
        return

    df = pd.DataFrame(res.data)
    
    # Flatten company info
    df['company_name'] = df['companies'].apply(lambda x: x.get('company_name') if x else None)
    df['ticker'] = df['companies'].apply(lambda x: x.get('ticker_symbol') if x else None)
    df['sector'] = df['companies'].apply(lambda x: x.get('primary_sector') if x else None)
    
    # Filter for "Real" data (where we have women_directors populated)
    # Assuming 0 is valid but None is not. Our extraction script sets 0 if not found.
    # Let's look for rows where we recently updated (maybe filter by created_at? No, just use non-nulls)
    
    real_df = df[df['women_directors'].notnull()]
    
    print(f"Total Records: {len(df)}")
    print(f"Records with Governance Data: {len(real_df)}")
    
    if len(real_df) == 0:
        print("No governance data to analyze.")
        return

    # 1. Diversity
    avg_women_pct = real_df['women_percentage'].mean()
    zero_women_count = len(real_df[real_df['women_directors'] == 0])
    parity_count = len(real_df[real_df['women_percentage'] >= 50])
    
    print(f"\n1. Diversity:")
    print(f"   - Average Women on Boards: {avg_women_pct:.1f}%")
    print(f"   - Companies with Zero Women: {zero_women_count} ({zero_women_count/len(real_df)*100:.1f}%)")
    print(f"   - Gender Parity (>=50%): {parity_count} ({parity_count/len(real_df)*100:.1f}%)")
    
    # 2. Tech Expertise
    # Filter for rows where tech_experts is not null (our script updates this)
    tech_df = df[df['tech_experts'].notnull()]
    if len(tech_df) > 0:
        avg_tech = tech_df['tech_experts'].mean()
        print(f"\n2. Technical Expertise (N={len(tech_df)}):")
        print(f"   - Average Tech Experts per Board: {avg_tech:.1f}")
        print(f"   - Max Tech Experts: {tech_df['tech_experts'].max()}")
    
    # 3. AI Governance
    # Check has_ai_oversight_committee
    ai_gov_count = len(df[df['has_ai_oversight_committee'] == True])
    print(f"\n3. AI Governance:")
    print(f"   - Companies with AI Oversight Committee: {ai_gov_count} ({ai_gov_count/len(df)*100:.1f}%)")
    
    # 4. Top Performers
    print("\n4. Top Diversity Performers:")
    top_div = real_df.sort_values('women_percentage', ascending=False).head(5)
    for _, row in top_div.iterrows():
        print(f"   - {row['company_name']} ({row['ticker']}): {row['women_percentage']:.1f}% Women, {row['tech_experts']} Tech Experts")

if __name__ == "__main__":
    analyze()
