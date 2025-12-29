import os
import streamlit as st
from supabase import create_client, Client, ClientOptions
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

def debug_connection_v3():
    print("\n--- DEBUG CONNECTION V3 (Mimicking App Logic) ---")
    
    # 1. Check Credentials Source
    # Note: st.secrets works only when running via 'streamlit run', but we can check if file exists
    secrets_path = ".streamlit/secrets.toml"
    if os.path.exists(secrets_path):
        print(f"1. Found secrets file at: {secrets_path}")
        with open(secrets_path, 'r') as f:
            content = f.read()
            if "SUPABASE_URL" in content:
                print("   - Contains SUPABASE_URL")
            else:
                print("   - DOES NOT contain SUPABASE_URL")
    else:
        print("1. No .streamlit/secrets.toml found.")

    # 2. Resolve Credentials (mimic db_connection.py)
    # Since we are running as python script, st.secrets might be empty or fail if not handled
    try:
        url_secret = st.secrets.get("SUPABASE_URL")
        key_secret = st.secrets.get("SUPABASE_KEY")
        print(f"2. st.secrets: URL={'Found' if url_secret else 'None'}, Key={'Found' if key_secret else 'None'}")
    except Exception:
        print("2. st.secrets: Not available (running as script)")
        url_secret = None
        key_secret = None

    url_env = os.getenv("SUPABASE_URL")
    key_env = os.getenv("SUPABASE_KEY")
    print(f"3. os.getenv: URL={'Found' if url_env else 'None'}, Key={'Found' if key_env else 'None'}")

    # Final Resolution (Hardcoded for Debug)
    SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
    SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"
    
    if not SUPABASE_URL:
        print("CRITICAL: No SUPABASE_URL resolved!")
        return

    print(f"4. Resolved URL: {SUPABASE_URL}")

    # 3. Connect and Query 'view_company_scores' specifically
    print("\n5. Connecting to 'view_company_scores'...")
    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    try:
        client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
        
        # Count
        count = client.table("view_company_scores").select("*", count="exact", head=True).execute().count
        print(f"   - Row Count: {count}")
        
        # Sample Score
        response = client.table("view_company_scores").select("governance_score").limit(5).execute()
        if response.data:
            print(f"   - Sample Scores: {[r['governance_score'] for r in response.data]}")
        else:
            print("   - No data returned.")
            
    except Exception as e:
        print(f"   Error: {e}")

if __name__ == "__main__":
    debug_connection_v3()
