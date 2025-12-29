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

def check_data():
    print("Checking board_composition_annual data...")
    res = supabase.table("board_composition_annual").select("*").limit(10).execute()
    if res.data:
        for row in res.data:
            print(f"Company ID: {row['company_id']}")
            print(f"  Avg Age: {row.get('avg_director_age')}")
            print(f"  Avg Tenure: {row.get('avg_director_tenure')}")
            print(f"  AI Oversight: {row.get('has_ai_oversight_committee')}")
            print(f"  Independent Directors: {row.get('independent_directors')}")
            print("-" * 20)
    else:
        print("No data found in board_composition_annual.")

if __name__ == "__main__":
    check_data()
