import os
from supabase import create_client, Client, ClientOptions

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def verify_backfill():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("Checking 'companies' Sector Backfill...")
    try:
        # Count companies with NULL primary_sector
        res_null = client.table("companies").select("*", count="exact", head=True).is_("primary_sector", "null").execute()
        res_total = client.table("companies").select("*", count="exact", head=True).execute()
        
        print(f"Total Companies: {res_total.count}")
        print(f"Companies with NULL Sector: {res_null.count}")
        print(f"Backfill Status: {res_total.count - res_null.count} / {res_total.count} populated.")
        
    except Exception as e:
        print(f"Error checking sectors: {e}")
        
    print("\nChecking 'board_composition_annual' Backfill...")
    try:
        res_board = client.table("board_composition_annual").select("*", count="exact", head=True).execute()
        print(f"Board Composition Rows: {res_board.count}")
    except Exception as e:
        print(f"Error checking board data: {e}")

if __name__ == "__main__":
    verify_backfill()
