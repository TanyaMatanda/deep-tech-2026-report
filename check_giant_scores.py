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

def check_giant_scores():
    print("Initializing connection...")
    client = init_connection()
    if not client: return

    giants = ['APPLE INC', 'IBM', 'QUALCOMM INC', 'MICROSOFT TECHNOLOGY LICENSING LLC']
    
    print(f"Checking scores for: {giants}")
    
    response = client.table("view_company_scores")\
        .select("*")\
        .in_("company_name", giants)\
        .execute()
        
    if not response.data:
        print("❌ No data found for these companies.")
        return
        
    df = pd.DataFrame(response.data)
    print("\n--- Tech Giants Scores ---")
    print(df[['company_name', 'patents_count', 'innovation_score', 'deal_qualification_score']].to_string())

if __name__ == "__main__":
    check_giant_scores()
