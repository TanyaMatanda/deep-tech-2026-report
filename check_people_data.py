import os
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

def check_data():
    client = init_connection()
    if not client: return

    print("\n--- Checking People Data ---")
    try:
        p_count = client.table("people").select("*", count="exact", head=True).execute().count
        print(f"People Count: {p_count}")
        
        cp_count = client.table("company_people").select("*", count="exact", head=True).execute().count
        print(f"Company-People Relationships: {cp_count}")
        
        if p_count > 0:
            # Show sample
            sample = client.table("people").select("*").limit(5).execute()
            print("Sample People:", sample.data)
    except Exception as e:
        print(f"Error checking data: {e}")

if __name__ == "__main__":
    check_data()
