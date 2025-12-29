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

def check_diversity():
    client = init_connection()
    if not client: return

    print("Fetching 'Gov: Diversity' from view_company_scores...")
    # Fetch a batch to check
    response = client.table("view_company_scores").select('"Gov: Diversity"').limit(100).execute()
    
    if response.data:
        df = pd.DataFrame(response.data)
        print("Data sample:")
        print(df.head())
        
        null_count = df['Gov: Diversity'].isnull().sum()
        print(f"Null count in first 100 rows: {null_count}")
        
        # Check if column name is exactly as expected
        print("Columns:", df.columns.tolist())
    else:
        print("No data found.")

if __name__ == "__main__":
    check_diversity()
