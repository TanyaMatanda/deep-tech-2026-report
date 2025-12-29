import os
import time
from supabase import create_client, Client, ClientOptions
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Configuration (Fallback)
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0")

def verify_dashboard_fix():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("\nTesting 'view_company_scores' performance...")
    start_time = time.time()
    try:
        # Simulate dashboard query: fetch top 20 companies
        res = client.table("view_company_scores")\
            .select("company_name, deal_qualification_score, governance_score, innovation_score")\
            .order("deal_qualification_score", desc=True)\
            .limit(20)\
            .execute()
            
        end_time = time.time()
        duration = end_time - start_time
        
        if res.data:
            print(f"✅ Success! Fetched {len(res.data)} rows in {duration:.2f} seconds.")
            print("Top result:", res.data[0])
        else:
            print("❌ Query returned no data.")
            
    except Exception as e:
        print(f"❌ Query failed: {e}")

if __name__ == "__main__":
    verify_dashboard_fix()
