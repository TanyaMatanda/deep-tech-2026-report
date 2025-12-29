import os
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

def list_sectors():
    client = init_connection()
    print("--- Distinct Sectors ---")
    
    # Supabase doesn't have a direct 'distinct' select easily via js client syntax without rpc sometimes,
    # but we can fetch all sectors and set() them in python since we have 100k rows, might be heavy.
    # Better: use a small limit and hope we see them, or just fetch 'primary_sector' for all.
    # Fetching 100k strings is fine.
    
    all_sectors = []
    offset = 0
    limit = 1000
    
    while True:
        res = client.table("companies").select("primary_sector").range(offset, offset + limit - 1).execute()
        data = res.data
        if not data: break
        
        sectors = [r['primary_sector'] for r in data if r['primary_sector']]
        all_sectors.extend(sectors)
        
        if len(data) < limit: break
        offset += limit
        
    unique_sectors = sorted(list(set(all_sectors)))
    print(f"Found {len(unique_sectors)} unique sectors:")
    for s in unique_sectors:
        print(f" - {s}")

if __name__ == "__main__":
    list_sectors()
