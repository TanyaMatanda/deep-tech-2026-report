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

def check_committees():
    print("Checking board_committees data...")
    res = supabase.table("board_committees").select("*").limit(10).execute()
    if res.data:
        for row in res.data:
            print(f"Company ID: {row['company_id']}")
            print(f"  Committee: {row['committee_name']}")
            print(f"  Role: {row['role']}")
            print(f"  Independent: {row['is_independent']}")
            print("-" * 20)
    else:
        print("No data found in board_committees.")

if __name__ == "__main__":
    check_committees()
