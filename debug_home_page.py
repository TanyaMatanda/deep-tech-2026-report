import os
from supabase import create_client, Client, ClientOptions
import pandas as pd

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def init_connection():
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def debug_home():
    print("Initializing connection...")
    client = init_connection()
    
    print("Testing get_total_company_count...")
    try:
        response = client.table("companies").select("*", count="exact", head=True).execute()
        print(f"Total Count: {response.count}")
    except Exception as e:
        print(f"Error in get_total_company_count: {e}")
        
    print("\nTesting get_top_companies (view_company_scores)...")
    try:
        response = client.table("view_company_scores").select("*").limit(5).execute()
        data = response.data
        if data:
            print(f"Fetched {len(data)} rows.")
            print(data[0])
        else:
            print("Fetched 0 rows.")
    except Exception as e:
        print(f"Error in get_top_companies: {e}")

if __name__ == "__main__":
    debug_home()
