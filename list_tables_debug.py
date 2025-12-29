import os
import toml
from supabase import create_client, Client, ClientOptions

# Configuration
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
    except:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

def list_tables():
    print("Listing tables in vendor_governance schema...")
    # We can't easily list tables via the API without RPC, but we can try to query common ones or use a known RPC if it exists.
    # However, I can try to use the 'postgres' connection if I had it.
    # Since I don't, I'll try to guess or look at the schema files again.
    
    # Let's try to query information_schema if possible (might not be allowed via API)
    try:
        # This usually fails on Supabase API unless specifically allowed
        res = supabase.table("information_schema.tables").select("table_name").eq("table_schema", "vendor_governance").execute()
        print(res.data)
    except:
        print("Could not query information_schema via API.")

if __name__ == "__main__":
    list_tables()
