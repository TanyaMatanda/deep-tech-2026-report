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

def check_risk_factors():
    print("Checking company_risk_factors data...")
    res = supabase.table("company_risk_factors").select("*").limit(10).execute()
    if res.data:
        for row in res.data:
            print(f"Company ID: {row['company_id']}")
            print(f"  Independence %: {row.get('board_independence_pct')}")
            print(f"  Avg Tenure: {row.get('avg_director_tenure')}")
            print(f"  AI Ethics Board: {row.get('has_ai_ethics_board')}")
            print(f"  AI Expertise: {row.get('board_ai_expertise')}")
            print("-" * 20)
    else:
        print("No data found in company_risk_factors.")

if __name__ == "__main__":
    check_risk_factors()
