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

def check_nvidia_people():
    print("Checking company_people data for NVDA...")
    # Get NVDA ID
    res = supabase.table("companies").select("id").eq("ticker_symbol", "NVDA").execute()
    if not res.data:
        print("NVDA not found.")
        return
    
    company_id = res.data[0]['id']
    
    res = supabase.table("company_people").select("*, people(full_name)").eq("company_id", company_id).execute()
    if res.data:
        for row in res.data:
            print(f"Person: {row.get('people', {}).get('full_name')}")
            print(f"  Role: {row.get('role_title')}")
            print(f"  Independent: {row.get('is_independent')}")
            print(f"  Start Date: {row.get('start_date')}")
            print("-" * 20)
    else:
        print("No people found for NVDA.")

if __name__ == "__main__":
    check_nvidia_people()
