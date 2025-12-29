import os
import pandas as pd
from supabase import create_client, Client, ClientOptions
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Hardcoded fallback
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0")

def debug_scores():
    print("Initializing connection...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("\n--- DEBUGGING DATA STATE ---")
    
    # 1. Check Board Composition (Is it messy?)
    print("\n1. Checking Board Composition (Sample of 5)...")
    try:
        response = client.table("board_composition_annual")\
            .select("company_id, fiscal_year, independent_directors, total_directors, ceo_is_board_chair")\
            .limit(5)\
            .execute()
        
        if response.data:
            df_board = pd.DataFrame(response.data)
            df_board['independence_pct'] = (df_board['independent_directors'] / df_board['total_directors']) * 100
            print(df_board[['company_id', 'independence_pct', 'ceo_is_board_chair']].to_string())
        else:
            print("NO BOARD DATA FOUND!")
    except Exception as e:
        print(f"Error fetching board data: {e}")

    # 2. Check Scores (Are they high?)
    print("\n2. Checking Materialized View Scores (Sample of 5)...")
    try:
        response = client.table("mv_company_scores")\
            .select("id, company_name, governance_score, ownership_archetype")\
            .limit(5)\
            .execute()
            
        if response.data:
            df_scores = pd.DataFrame(response.data)
            print(df_scores.to_string())
        else:
            print("NO SCORES FOUND!")
    except Exception as e:
        print(f"Error fetching scores: {e}")

    # 3. Check Archetypes
    print("\n3. Checking Archetype Distribution...")
    try:
        response = client.table("companies")\
            .select("ownership_archetype", count="exact")\
            .limit(1)\
            .execute() # Just to check if column exists and has data
            
        # Group by query not supported directly in simple client, fetch sample
        response = client.table("companies").select("ownership_archetype").limit(50).execute()
        if response.data:
            archetypes = [r['ownership_archetype'] for r in response.data]
            print(f"Sample Archetypes: {set(archetypes)}")
            if all(a is None for a in archetypes):
                print("WARNING: All archetypes are NULL!")
    except Exception as e:
        print(f"Error checking archetypes: {e}")

if __name__ == "__main__":
    debug_scores()
