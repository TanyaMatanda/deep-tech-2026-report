import pandas as pd
# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def init_connection():
    # Mocking the init_connection from db_connection.py for standalone run
    from supabase import create_client, ClientOptions
    
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def get_top_companies(limit=2000):
    """Fetch top companies sorted by deal qualification score."""
    client = init_connection()
    if not client: return []
    
    # Order by deal_qualification_score DESC to get the best targets
    response = client.table("view_company_scores")\
        .select("*")\
        .order("deal_qualification_score", desc=True)\
        .limit(limit)\
        .execute()
    return response.data

def debug_dashboard_data():
    print("Initializing connection...")
    client = init_connection()
    if not client:
        print("❌ Failed to connect.")
        return

    print("Fetching top 5 companies via get_top_companies()...")
    data = get_top_companies(limit=5)
    
    if not data:
        print("❌ No data returned.")
        return
        
    df = pd.DataFrame(data)
    print(f"✅ Data fetched. Shape: {df.shape}")
    print("Columns:", df.columns.tolist())
    
    if 'governance_details' in df.columns:
        print("\n✅ 'governance_details' column FOUND.")
        print("Sample values:")
        print(df['governance_details'].head())
    else:
        print("\n❌ 'governance_details' column MISSING.")
        print("This means the API query is not returning the column.")

if __name__ == "__main__":
    debug_dashboard_data()
