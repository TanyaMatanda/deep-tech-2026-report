import os
import pandas as pd
from supabase import create_client, Client, ClientOptions
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Hardcoded fallback
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0")

def debug_status():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("\n--- DEBUG STATUS V2 ---")
    
    # 1. Check Counts
    print("\n1. Row Counts:")
    try:
        c_count = client.table("companies").select("*", count="exact", head=True).execute().count
        mv_count = client.table("mv_company_scores").select("*", count="exact", head=True).execute().count
        print(f"   - 'companies' table: {c_count}")
        print(f"   - 'mv_company_scores' view: {mv_count}")
        
        if c_count != mv_count:
            print("   WARNING: Mismatch! Materialized view might be stale or partial.")
    except Exception as e:
        print(f"   Error fetching counts: {e}")

    # 2. Check Scores Stats
    print("\n2. Score Statistics (from DB):")
    try:
        # Check Sectors
        sector_resp = client.table("companies").select("primary_sector").limit(1000).execute()
        if sector_resp.data:
            sectors = set([r['primary_sector'] for r in sector_resp.data])
            print(f"   - Unique Sectors Found: {sectors}")
            
        # Get True Max Score
        max_resp = client.table("mv_company_scores").select("governance_score").order("governance_score", desc=True).limit(1).execute()
        if max_resp.data:
            true_max = max_resp.data[0]['governance_score']
            print(f"   - TRUE MAX Score in DB: {true_max}")
        
        # Get True Avg (approximate via larger sample of top rows)
        response = client.table("mv_company_scores").select("id, company_name, governance_score").order("governance_score", desc=True).limit(5).execute()
        if response.data:
            top_companies = response.data
            print(f"   - Top 5 Companies: {[c['company_name'] + ': ' + str(c['governance_score']) for c in top_companies]}")
            
            # Inspect Data for the first one
            target_id = top_companies[0]['id']
            print(f"\n3. Inspecting Data for {top_companies[0]['company_name']} ({target_id}):")
            
            board_resp = client.table("board_composition_annual").select("*").eq("company_id", target_id).order("fiscal_year", desc=True).limit(1).execute()
            if board_resp.data:
                b = board_resp.data[0]
                print(f"   - Fiscal Year: {b['fiscal_year']}")
                print(f"   - Total Directors: {b['total_directors']}")
                print(f"   - Independent: {b['independent_directors']}")
                print(f"   - CEO is Chair: {b['ceo_is_board_chair']}")
                
                # Calculate expected score manually
                ind_pct = b['independent_directors'] / b['total_directors']
                print(f"   - Independence %: {ind_pct:.2%}")
                if ind_pct < 0.5:
                    print("   -> SHOULD BE PENALIZED (-25)")
                else:
                    print("   -> PASSES Independence Check")
            else:
                print("   - NO BOARD DATA FOUND for this company.")
        else:
            print("   NO DATA in view.")
    except Exception as e:
        print(f"   Error fetching scores: {e}")

if __name__ == "__main__":
    debug_status()
