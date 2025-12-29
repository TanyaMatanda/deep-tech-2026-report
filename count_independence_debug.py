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

def count_independence():
    print("Counting non-null board_independence_pct in company_risk_factors...")
    # Since I found the column doesn't exist in the 'vendor_governance' schema for 'company_risk_factors',
    # I'll check if it exists in 'public' or if there's another table.
    
    # Wait, I already checked public and it wasn't there.
    # Let's check 'governance_scores' again.
    res = supabase.table("governance_scores").select("id", count="exact").not_.is_("board_independence_pct", "null").execute()
    print(f"governance_scores with board_independence_pct: {res.count}")
    
    # Let's check 'board_composition_annual' again.
    res = supabase.table("board_composition_annual").select("id", count="exact").not_.is_("independent_directors", "null").execute()
    print(f"board_composition_annual with independent_directors: {res.count}")

if __name__ == "__main__":
    count_independence()
