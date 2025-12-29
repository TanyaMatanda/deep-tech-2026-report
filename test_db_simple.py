print("Starting...")
import os
import toml
from supabase import create_client, ClientOptions

def test():
    print("Loading secrets...")
    try:
        secrets = toml.load(".streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
        print(f"URL loaded: {url[:10]}...")
    except Exception as e:
        print(f"Error: {e}")
        return

    print("Creating client...")
    options = ClientOptions(schema="vendor_governance")
    supabase = create_client(url, key, options=options)
    print("Client created")
    
    print("Querying...")
    res = supabase.table('companies').select('id, company_name, ticker_symbol, listing_type').limit(5).execute()
    print(f"Results: {len(res.data)}")
    for row in res.data:
        print(row)

if __name__ == "__main__":
    test()
