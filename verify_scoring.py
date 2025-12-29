import os
from supabase import create_client, ClientOptions
from dotenv import load_dotenv

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0")

def verify_scoring_updates():
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("Verifying 'Active' filter and Data Penalty...")
    
    try:
        # 1. Check Total Count (Should be less than total companies if any are inactive)
        # We can't easily compare to "before" without knowing the exact number, but we can check if any inactive are present.
        # Actually, the view filters them out, so we can't query for them in the view.
        # Let's just check the count.
        res_count = client.table("view_company_scores").select("*", count="exact", head=True).execute()
        print(f"Total Active Companies in View: {res_count.count}")
        
        # 2. Debug Penalty Logic
        print("\nDebugging Penalty Logic:")
        
        # Count Public Companies
        res_public = client.table("companies").select("*", count="exact", head=True).not_.is_("ticker_symbol", "null").execute()
        print(f"Total Public Companies (Ticker != NULL): {res_public.count}")
        
        # Count Public Companies with NO Board Data (The target for penalty)
        # We need to do a left join check, which is hard via API.
        # Instead, let's look at the view again but select specific columns to see what's happening.
        
        res_debug = client.table("view_company_scores")\
            .select("company_name, ticker_symbol, governance_score")\
            .not_.is_("ticker_symbol", "null")\
            .limit(10)\
            .execute()
            
        if res_debug.data:
            print("\nSample Public Company Scores:")
            for row in res_debug.data:
                print(f"- {row['company_name']}: {row['governance_score']}")
                
        # Check if ANY public company has score < 80 (since base is 100, penalty is -50, so < 50)
        res_low = client.table("view_company_scores")\
            .select("company_name, ticker_symbol, governance_score")\
            .not_.is_("ticker_symbol", "null")\
            .lt("governance_score", 80)\
            .limit(5)\
            .execute()
            
        if res_low.data:
            print(f"\nFound {len(res_low.data)} public companies with score < 80:")
            for row in res_low.data:
                print(f"- {row['company_name']}: {row['governance_score']}")
        # 3. Check Private Company Scores (The likely cause of high average)
        print("\nChecking Private Company Scores:")
        res_private = client.table("view_company_scores")\
            .select("company_name, governance_score")\
            .is_("ticker_symbol", "null")\
            .limit(10)\
            .execute()
            
        if res_private.data:
            print("Sample Private Company Scores:")
            for row in res_private.data:
                print(f"- {row['company_name']}: {row['governance_score']}")
                
        # Count how many private companies have exactly 100
        # We can't do exact count with filter easily on view without count=exact, let's try
        res_100 = client.table("view_company_scores")\
            .select("*", count="exact", head=True)\
            .is_("ticker_symbol", "null")\
            .eq("governance_score", 100)\
            .execute()
            
        print(f"\nTotal Private Companies with Score 100: {res_100.count}")
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    verify_scoring_updates()
