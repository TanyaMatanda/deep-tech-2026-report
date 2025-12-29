import os
from supabase import create_client, Client, ClientOptions

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def check_raw_data():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("Checking 'companies' table...")
    try:
        res_companies = client.table("companies").select("id, company_name, primary_sector").limit(5).execute()
        print(f"Companies Data (First 5): {res_companies.data}")
    except Exception as e:
        print(f"Error checking companies: {e}")
        
    print("\nChecking 'board_composition_annual' table...")
    try:
        # Check if there is ANY data
        res_board = client.table("board_composition_annual").select("*", count="exact", head=True).execute()
        print(f"Board Composition Total Count: {res_board.count}")
        
        if res_board.count > 0:
            res_board_sample = client.table("board_composition_annual").select("*").limit(5).execute()
            print(f"Board Data Sample: {res_board_sample.data}")
    except Exception as e:
        print(f"Error checking board composition: {e}")

if __name__ == "__main__":
    check_raw_data()
