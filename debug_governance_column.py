import os
from supabase import create_client, Client, ClientOptions
import pandas as pd

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

def check_column():
    client = init_connection()
    if not client: return

    print("Fetching one row from view_company_scores...")
    response = client.table("view_company_scores").select("*").limit(1).execute()
    
    if response.data:
        row = response.data[0]
        print("Columns found:", row.keys())
        if 'governance_details' in row:
            print("✅ 'governance_details' column EXISTS!")
            print("Value:", row['governance_details'])
        else:
            print("❌ 'governance_details' column MISSING.")
    else:
        print("No data found.")

if __name__ == "__main__":
    check_column()
