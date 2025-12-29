import os
from supabase import create_client, Client, ClientOptions
import pandas as pd

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def debug_data():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("Fetching sample data from view_company_scores...")
    try:
        response = client.table("view_company_scores").select("*").limit(20).execute()
        data = response.data
        if not data:
            print("No data found in view_company_scores.")
            return

        df = pd.DataFrame(data)
        print("\n--- Sample Data (First 5 rows) ---")
        print(df[['company_name', 'primary_sector', 'governance_score', 'governance_details']].head().to_string())
        
        print("\n--- Sector Distribution (Sample) ---")
        print(df['primary_sector'].value_counts())
        
        print("\n--- Governance Details Check ---")
        # Check if governance_details is mostly empty or zeroed
        for index, row in df.head().iterrows():
            print(f"{row['company_name']}: {row['governance_details']}")

    except Exception as e:
        print(f"Error fetching data: {e}")

if __name__ == "__main__":
    debug_data()
