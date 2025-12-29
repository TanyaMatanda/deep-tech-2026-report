import os
import pandas as pd
from supabase import create_client, Client, ClientOptions
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Hardcoded fallback
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def debug_exelixis():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("\n--- DEBUG EXELIXIS INC ---")
    
    # 1. Find Company ID
    name = "EXELIXIS INC"
    resp = client.table("companies").select("*").eq("company_name", name).execute()
    
    if not resp.data:
        print(f"Company '{name}' not found in 'companies' table.")
        return
        
    c = resp.data[0]
    cid = c['id']
    print(f"ID: {cid}")
    print(f"Patents Count: {c.get('patents_count')}")
    print(f"Archetype: {c.get('ownership_archetype')}")
    
    # 2. Check Board Data
    print("\nBoard Data:")
    b_resp = client.table("board_composition_annual").select("*").eq("company_id", cid).order("fiscal_year", desc=True).execute()
    if b_resp.data:
        for b in b_resp.data:
            print(f"  Year: {b['fiscal_year']}")
            print(f"  Total: {b['total_directors']}")
            print(f"  Independent: {b['independent_directors']}")
            print(f"  CEO Chair: {b['ceo_is_board_chair']}")
            if b['total_directors'] > 0:
                print(f"  Ind %: {b['independent_directors']/b['total_directors']:.2%}")
    else:
        print("  No board data found.")

    # 3. Check Score in View
    print("\nScore in View:")
    v_resp = client.table("mv_company_scores").select("governance_score").eq("id", cid).execute()
    if v_resp.data:
        print(f"  Governance Score: {v_resp.data[0]['governance_score']}")
    else:
        print("  Not found in view.")

if __name__ == "__main__":
    debug_exelixis()
