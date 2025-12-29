import os
from supabase import create_client, ClientOptions
from dotenv import load_dotenv

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0")

def check_status_values():
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("Fetching distinct company_status values...")
    try:
        # Fetch all statuses (assuming reasonable number of unique values)
        # Since we can't do distinct() easily via API without RPC, we'll fetch a sample or use a hack
        # Actually, we can just fetch 'company_status' and python set() it, but for 95k rows that's slow.
        # Let's try to fetch just 1000 rows and see what we get, or assume 'Active' is standard.
        # Better: Use the 'view_market_summary' logic if it had it, but it doesn't.
        
        # Let's just check a few rows to confirm 'Active' is the string.
        res = client.table("companies").select("company_status").limit(100).execute()
        statuses = set(row['company_status'] for row in res.data if row['company_status'])
        print("Sample statuses found:", statuses)
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    check_status_values()
