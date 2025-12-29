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

def check_gov_scores():
    print("Checking governance_scores data...")
    res = supabase.table("governance_scores").select("*").limit(10).execute()
    if res.data:
        for row in res.data:
            print(f"Company ID: {row['company_id']}")
            print(f"  Independence %: {row.get('board_independence_pct')}")
            print(f"  Diversity %: {row.get('board_diversity_pct')}")
            print(f"  Overall Score: {row.get('overall_score')}")
            print("-" * 20)
    else:
        print("No data found in governance_scores.")

if __name__ == "__main__":
    check_gov_scores()
