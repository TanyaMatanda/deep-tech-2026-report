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

def test_query():
    print("Testing query from governance_explorer_page.py...")
    try:
        response = supabase.table('company_risk_factors')\
            .select('*, companies!inner(company_name, ticker_symbol, primary_sector, jurisdiction)')\
            .limit(5)\
            .execute()
        print(f"Success! Found {len(response.data)} rows.")
        if response.data:
            print(f"Sample row keys: {list(response.data[0].keys())}")
    except Exception as e:
        print(f"Query failed: {e}")

if __name__ == "__main__":
    test_query()
