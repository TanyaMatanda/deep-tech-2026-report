import os
from supabase import create_client, Client, ClientOptions
import pandas as pd

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def init_connection():
    if not SUPABASE_URL or not SUPABASE_KEY:
        print("❌ Error: Supabase credentials not found.")
        return None
    
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def analyze_sectors():
    client = init_connection()
    if not client: return

    print("Fetching top companies by patent count...")
    
    # Fetch top 100 companies by patent count to find the outlier
    response = client.table("companies").select("*").order("patents_count", desc=True).limit(100).execute()
    df = pd.DataFrame(response.data)
    
    if df.empty:
        print("No data found.")
        return

    print(f"Loaded {len(df)} rows.")
    
    print("\n--- Top Patent Holders ---")
    print(df[['company_name', 'primary_sector', 'patents_count']].head(20).to_string())

if __name__ == "__main__":
    analyze_sectors()
