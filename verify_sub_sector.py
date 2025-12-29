import os
from supabase import create_client, Client, ClientOptions
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Hardcoded fallback (same as before)
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0")

def verify_sub_sector():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("Fetching one record from view_company_scores...")
    try:
        response = client.table("view_company_scores").select("*").limit(1).execute()
        if response.data:
            record = response.data[0]
            print("Keys in record:", record.keys())
            if 'sub_sector' in record:
                print(f"SUCCESS: 'sub_sector' column found! Value: {record['sub_sector']}")
            else:
                print("FAILURE: 'sub_sector' column NOT found.")
        else:
            print("No data returned.")
    except Exception as e:
        print(f"Query failed: {e}")

if __name__ == "__main__":
    verify_sub_sector()
