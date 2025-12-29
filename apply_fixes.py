import os
import toml
from supabase import create_client, ClientOptions

# Load credentials
try:
    secrets = toml.load('dashboard/.streamlit/secrets.toml')
    url = secrets['SUPABASE_URL']
    key = secrets['SUPABASE_KEY']
except:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

def execute_sql_file(filename):
    print(f"\nProcessing {filename}...")
    
    if not os.path.exists(filename):
        print(f"❌ File not found: {filename}")
        return

    with open(filename, 'r') as f:
        sql_content = f.read()
        
    # Try connecting to 'postgres' schema to run DDL
    options = ClientOptions(
        schema="public",
        headers={"Content-Profile": "public"}
    )
    client = create_client(url, key, options=options)
    
    print("   Attempting execution via 'exec_sql' RPC...")
    try:
        # This assumes a function 'exec_sql' exists which takes a 'query' parameter
        response = client.rpc('exec_sql', {'query': sql_content}).execute()
        print("   ✅ Success!")
    except Exception as e:
        print(f"   ⚠️  RPC execution failed: {e}")
        print("   Please run this SQL manually in Supabase SQL Editor.")

if __name__ == "__main__":
    print("="*60)
    print("APPLYING DATABASE FIXES")
    print("="*60)
    
    # 1. Fix governance scoring function
    execute_sql_file("fix_governance_scoring.sql")
    
    # 2. Fix view definition (resolves missing companies)
    execute_sql_file("fix_view_company_scores.sql")
    
    print("\n" + "="*60)
    print("INSTRUCTIONS")
    print("="*60)
    print("If the above steps failed (RPC execution failed), please:")
    print("1. Open Supabase Dashboard -> SQL Editor")
    print("2. Copy/Paste content of 'fix_view_company_scores.sql'")
    print("3. Run it")
    print("4. Copy/Paste content of 'fix_governance_scoring.sql'")
    print("5. Run it")
