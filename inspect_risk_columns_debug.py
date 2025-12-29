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

def inspect_columns():
    print("Inspecting columns of company_risk_factors...")
    res = supabase.table("company_risk_factors").select("*").limit(1).execute()
    if res.data:
        print(f"Columns: {list(res.data[0].keys())}")
    else:
        print("No data in company_risk_factors to inspect columns.")

if __name__ == "__main__":
    inspect_columns()
