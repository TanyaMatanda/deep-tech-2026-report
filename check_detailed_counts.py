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

def check_counts():
    client = init_connection()
    print("--- Detailed Data Counts ---")
    
    # 1. Total Companies
    res = client.table("companies").select("*", count="exact", head=True).execute()
    total_companies = res.count
    print(f"Total Companies: {total_companies}")
    
    # 2. Board Composition Rows
    res = client.table("board_composition_annual").select("*", count="exact", head=True).execute()
    total_board_rows = res.count
    print(f"Total Board Composition Rows: {total_board_rows}")
    
    # 3. Women Directors (Non-Null)
    # We can't easily do "is not null" with simple filters in all clients, but .neq("women_directors", "null") might work
    # Or just check count where women_directors >= 0
    res = client.table("board_composition_annual").select("*", count="exact", head=True).gte("women_directors", 0).execute()
    women_data_count = res.count
    print(f"Rows with 'women_directors' data: {women_data_count}")
    
    # 4. Tech Experts (Non-Null)
    res = client.table("board_composition_annual").select("*", count="exact", head=True).gte("tech_experts", 0).execute()
    tech_data_count = res.count
    print(f"Rows with 'tech_experts' data: {tech_data_count}")
    
    # 5. AI Governance (Companies table)
    # has_ai_ethics_board is boolean, so check for True or False (not null)
    # Actually, default is False, so we might have 90k 'False'.
    # Let's check how many are True.
    res = client.table("companies").select("*", count="exact", head=True).eq("has_ai_ethics_board", True).execute()
    ai_true_count = res.count
    print(f"Companies with 'has_ai_ethics_board' = True: {ai_true_count}")

if __name__ == "__main__":
    check_counts()
