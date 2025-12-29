import os
from collections import Counter
from supabase import create_client, Client, ClientOptions

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

def check_distribution():
    client = init_connection()
    print("--- Checking AI Data Distribution ---")
    
    # Fetch companies with AI board = True
    # We'll fetch a sample of 1000
    res = client.table("companies").select("primary_sector").eq("has_ai_ethics_board", True).limit(2000).execute()
    
    if not res.data:
        print("No AI data found.")
        return
        
    sectors = [r.get('primary_sector', 'Unknown') for r in res.data]
    counts = Counter(sectors)
    
    print(f"Sample Size: {len(sectors)}")
    print("Top Sectors with AI Ethics Boards:")
    for k, v in counts.most_common(10):
        print(f" - {k}: {v} ({v/len(sectors)*100:.1f}%)")
        
    # Check a non-tech sector if possible
    non_tech = [s for s in sectors if "Food" in s or "Retail" in s or "Mining" in s]
    print(f"\nNon-Tech Sector Hits (Potential Mock Data Indicator): {len(non_tech)}")

if __name__ == "__main__":
    check_distribution()
