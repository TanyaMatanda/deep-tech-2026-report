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

options = ClientOptions(schema='vendor_governance')
supabase = create_client(url, key, options=options)

print("Checking if view exists in information_schema...")

try:
    # We can't query information_schema directly via PostgREST usually, 
    # but we can try to RPC or just infer from the error.
    
    # Let's try to list all tables in the schema
    # This often works if the schema is exposed
    print("Attempting to list tables in 'vendor_governance' schema...")
    # This is a hacky way to check what the API sees
    # We'll try to query a known table 'companies' which we know exists
    resp = supabase.table('companies').select('id').limit(1).execute()
    print("✅ 'companies' table is accessible.")
    
    # Now try the view again
    print("Attempting to access 'view_company_scores'...")
    resp = supabase.table('view_company_scores').select('id').limit(1).execute()
    print("✅ 'view_company_scores' is accessible!")
    
except Exception as e:
    print(f"❌ Error: {e}")
    if "404" in str(e) or "Could not find" in str(e):
        print("\nDIAGNOSIS: The view exists in DB (presumably) but PostgREST API doesn't see it.")
        print("This confirms a Schema Cache issue.")
