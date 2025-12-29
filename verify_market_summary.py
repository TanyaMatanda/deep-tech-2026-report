import os
from supabase import create_client, Client, ClientOptions
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Configuration (Fallback)
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0")

def verify_views():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("\n1. Verifying New Columns in 'companies' table...")
    try:
        # Fetch a single row to check columns
        res = client.table("companies").select("id, company_name, say_on_pay_support, has_clawback_policy, has_ai_ethics_board").limit(1).execute()
        if res.data:
            print("✅ Columns exist and data found:")
            print(res.data[0])
        else:
            print("❌ No data returned from companies table.")
    except Exception as e:
        print(f"❌ Error checking columns: {e}")

    print("\n2. Verifying 'view_sector_performance' (Limit 1)...")
    try:
        # Try a very limited query on the view
        res = client.table("view_sector_performance").select("sector, avg_governance_score").limit(1).execute()
        if res.data:
            print("✅ View is accessible:")
            print(res.data)
        else:
            print("❌ View returned no data.")
    except Exception as e:
        print(f"❌ Error querying view: {e}")

if __name__ == "__main__":
    verify_views()
