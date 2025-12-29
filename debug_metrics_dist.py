import os
import pandas as pd
from supabase import create_client, ClientOptions

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWiqbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def init_connection():
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def check_metrics_distribution():
    client = init_connection()
    print("--- Checking Metrics Distribution ---")
    
    # Fetch a larger sample of board data
    res = client.table("board_composition_annual").select("avg_director_age, has_ai_oversight_committee, overall_governance_score").limit(5000).execute()
    df = pd.DataFrame(res.data)
    
    if not df.empty:
        print(f"Sample Size: {len(df)}")
        print("\nAvg Director Age Distribution:")
        print(df['avg_director_age'].describe())
        print(f"Null Age Count: {df['avg_director_age'].isnull().sum()}")
        
        print("\nAI Oversight Committee Distribution:")
        print(df['has_ai_oversight_committee'].value_counts(dropna=False))
        
        if 'overall_governance_score' in df.columns:
            print("\nOverall Governance Score (in board table) Distribution:")
            print(df['overall_governance_score'].describe())
            print(f"Null Gov Score Count: {df['overall_governance_score'].isnull().sum()}")

    # Check governance_scores table content
    res_gov = client.table("governance_scores").select("*").limit(10).execute()
    print(f"\nGovernance Scores Table Sample (Total rows: {len(res_gov.data)}):")
    print(res_gov.data)

if __name__ == "__main__":
    check_metrics_distribution()
