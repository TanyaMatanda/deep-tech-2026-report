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

def check_skew():
    client = init_connection()
    if not client: return

    print("\n--- Checking Sub-Sector Skew ---")
    response = client.table("view_company_scores").select("sub_sector, patents_count").execute()
    
    if response.data:
        df = pd.DataFrame(response.data)
        # Group by sub_sector and sum patents
        stats = df.groupby('sub_sector')['patents_count'].sum().sort_values(ascending=False)
        print("Top 5 Sub-Sectors by Patent Count:")
        print(stats.head())
        
        # Check "Advanced Technology (General)" specifically
        if "Advanced Technology (General)" in stats.index:
            print(f"\nAdvanced Technology (General) Patents: {stats['Advanced Technology (General)']}")
            print(f"Total Patents: {stats.sum()}")
            print(f"Percentage: {stats['Advanced Technology (General)'] / stats.sum() * 100:.1f}%")
    else:
        print("No data in view_company_scores.")

def check_ownership():
    client = init_connection()
    if not client: return

    print("\n--- Checking Ownership Archetypes ---")
    response = client.table("view_company_scores").select("ownership_archetype").execute()
    
    if response.data:
        df = pd.DataFrame(response.data)
        counts = df['ownership_archetype'].value_counts()
        print("Ownership Archetype Counts:")
        print(counts)
    else:
        print("No data in view_company_scores.")

def check_momentum_view():
    client = init_connection()
    if not client: return

    print("\n--- Checking Momentum View Existence ---")
    try:
        response = client.table("view_innovation_momentum").select("*").limit(1).execute()
        print("✅ view_innovation_momentum exists.")
    except Exception as e:
        print(f"❌ view_innovation_momentum likely missing. Error: {e}")

if __name__ == "__main__":
    check_skew()
    check_ownership()
    check_momentum_view()
