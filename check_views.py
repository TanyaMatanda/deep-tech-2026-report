import os
from supabase import create_client, Client, ClientOptions

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def list_tables():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("Listing tables/views in vendor_governance...")
    try:
        # We can't list tables directly easily without rpc, but we can try to select from them
        # and see which ones error out.
        
        views_to_check = [
            "view_innovation_momentum",
            "view_financial_resilience",
            "view_company_scores",
            "companies"
        ]
        
        for view in views_to_check:
            try:
                client.table(view).select("*", count="exact", head=True).execute()
                print(f"✅ {view} EXISTS")
            except Exception as e:
                print(f"❌ {view} MISSING or Error: {e}")
                
    except Exception as e:
        print(f"General Error: {e}")

if __name__ == "__main__":
    list_tables()
