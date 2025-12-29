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

def check_data():
    client = init_connection()
    if not client: return

    print("--- Data Readiness Check (Supabase) ---")
    
    try:
        # 1. Total Companies
        res = client.table("companies").select("*", count="exact", head=True).execute()
        print(f"Total Companies: {res.count}")
        
        # 2. Board Composition Data
        res = client.table("board_composition_annual").select("*", count="exact", head=True).execute()
        print(f"Companies with Board Data: {res.count}")
        
        # 3. Check New Columns (AI Governance)
        # Note: We can't easily do 'FILTER' in Supabase JS/Python client without raw SQL or multiple queries
        # We will check if the columns exist by fetching one row
        try:
            sample = client.table("companies").select("has_ai_ethics_board,board_ai_expertise").limit(1).execute()
            if sample.data:
                print("AI Governance columns exist: Yes")
                # Count true values
                ethics_count = client.table("companies").select("*", count="exact", head=True).eq("has_ai_ethics_board", True).execute().count
                expertise_count = client.table("companies").select("*", count="exact", head=True).eq("board_ai_expertise", True).execute().count
                print(f"Companies with 'has_ai_ethics_board' = True: {ethics_count}")
                print(f"Companies with 'board_ai_expertise' = True: {expertise_count}")
            else:
                print("AI Governance columns exist: No data to verify")
        except Exception as e:
            print(f"Error checking AI columns (likely don't exist yet): {e}")

        # 4. Check Board Chair Gender
        try:
            sample = client.table("board_composition_annual").select("board_chair_gender").limit(1).execute()
            if sample.data:
                print("Board Chair Gender column exists: Yes")
                gender_count = client.table("board_composition_annual").select("*", count="exact", head=True).neq("board_chair_gender", "null").execute().count
                print(f"Board entries with 'board_chair_gender' data: {gender_count}")
            else:
                print("Board Chair Gender column exists: No data to verify")
        except Exception as e:
            print(f"Error checking Board Chair Gender (likely doesn't exist yet): {e}")
            
        # 5. Check Shareholder Proposals
        try:
            res = client.table("shareholder_proposals").select("*", count="exact", head=True).execute()
            print(f"Total Shareholder Proposals: {res.count}")
        except Exception as e:
            print(f"Error checking Shareholder Proposals table (likely doesn't exist yet): {e}")

        # 6. Check News
        try:
            res = client.table("governance_news").select("*", count="exact", head=True).execute()
            print(f"Total News Articles: {res.count}")
        except Exception as e:
            print(f"Error checking News table (likely doesn't exist yet): {e}")
            
        # 7. Check Specific Missing Fields from Report
        # Technical Expertise, Director Age, Tenure
        try:
            # Tech Experts
            tech_count = client.table("board_composition_annual").select("*", count="exact", head=True).neq("tech_experts", "null").execute().count
            print(f"Board entries with Tech Experts data: {tech_count}")
            
            # Age
            age_count = client.table("board_composition_annual").select("*", count="exact", head=True).neq("avg_director_age", "null").execute().count
            print(f"Board entries with Avg Age data: {age_count}")
            
            # Tenure
            tenure_count = client.table("board_composition_annual").select("*", count="exact", head=True).neq("avg_director_tenure", "null").execute().count
            print(f"Board entries with Avg Tenure data: {tenure_count}")
            
        except Exception as e:
             print(f"Error checking detailed board metrics: {e}")

    except Exception as e:
        print(f"General error: {e}")

if __name__ == "__main__":
    check_data()
