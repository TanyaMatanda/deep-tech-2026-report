import os
import toml
from supabase import create_client, ClientOptions

def debug():
    try:
        secrets = toml.load(".streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
        print(f"URL: {url[:20]}...")
    except Exception as e:
        print(f"Error loading secrets: {e}")
        return

    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    
    try:
        supabase = create_client(url, key, options=options)
        print("Client created")
        res = supabase.table('companies').select('id', count='exact').limit(1).execute()
        print(f"Count: {res.count}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    debug()
