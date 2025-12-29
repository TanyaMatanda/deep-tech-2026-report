import os
import pandas as pd
from supabase import create_client, ClientOptions

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

def debug_sector_data():
    client = init_connection()
    print("--- Debugging Sector Data ---")
    
    # Check governance_scores table
    res = client.table("governance_scores").select("*", count="exact", head=True).execute()
    print(f"Total Governance Scores: {res.count}")
    
    # Check board_composition_annual for age and ai oversight
    res = client.table("board_composition_annual").select("avg_director_age, has_ai_oversight_committee").limit(1000).execute()
    df = pd.DataFrame(res.data)
    if not df.empty:
        print(f"Avg Age (Sample Mean): {df['avg_director_age'].mean()}")
        print(f"AI Oversight (Sample Count): {df['has_ai_oversight_committee'].sum()}")
        print(f"Non-Null Age Count: {df['avg_director_age'].notnull().sum()}")
        print(f"Non-Null AI Oversight Count: {df['has_ai_oversight_committee'].notnull().sum()}")

    # Check specific sectors from the screenshots
    sectors_to_check = ["Quantum & Photonics", "Agriculture & Food Tech", "Cybersecurity"]
    
    for sector in sectors_to_check:
        print(f"\nChecking Sector: {sector}")
        # Need to map sector like export_dashboard_data.py does
        # For simplicity, let's just check companies with keywords in sub_sector
        keyword = sector.split(" ")[0].lower()
        if sector == "Agriculture & Food Tech": keyword = "agri"
        
        res = client.table("companies").select("id, company_name, sub_sector").ilike("sub_sector", f"%{keyword}%").limit(10).execute()
        company_ids = [r['id'] for r in res.data]
        print(f"Found {len(company_ids)} companies in {sector}")
        
        if company_ids:
            res_board = client.table("board_composition_annual").select("*").in_("company_id", company_ids).execute()
            board_df = pd.DataFrame(res_board.data)
            if not board_df.empty:
                print(f"  Board Data Rows: {len(board_df)}")
                print(f"  Avg Age: {board_df['avg_director_age'].mean()}")
                print(f"  AI Oversight Sum: {board_df['has_ai_oversight_committee'].sum()}")
            else:
                print("  No board data found for these companies")
                
            res_gov = client.table("governance_scores").select("*").in_("company_id", company_ids).execute()
            gov_df = pd.DataFrame(res_gov.data)
            if not gov_df.empty:
                print(f"  Gov Score Rows: {len(gov_df)}")
                print(f"  Avg Gov Score: {gov_df['overall_governance_score'].mean()}")
            else:
                print("  No gov scores found for these companies")

if __name__ == "__main__":
    debug_sector_data()
