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

def count_data():
    print("Counting non-null governance data...")
    
    # Check company_risk_factors
    res = supabase.table("company_risk_factors").select("id", count="exact").not_.is_("board_independence_pct", "null").execute()
    print(f"company_risk_factors with board_independence_pct: {res.count}")
    
    res = supabase.table("company_risk_factors").select("id", count="exact").not_.is_("avg_director_tenure", "null").execute()
    print(f"company_risk_factors with avg_director_tenure: {res.count}")
    
    res = supabase.table("company_risk_factors").select("id", count="exact").not_.is_("has_ai_ethics_board", "null").execute()
    print(f"company_risk_factors with has_ai_ethics_board: {res.count}")

    # Check companies
    res = supabase.table("companies").select("id", count="exact").eq("has_ai_ethics_board", True).execute()
    print(f"companies with has_ai_ethics_board=True: {res.count}")
    
    res = supabase.table("companies").select("id", count="exact").eq("board_ai_expertise", True).execute()
    print(f"companies with board_ai_expertise=True: {res.count}")

    # Check board_composition_annual (before my script, but I can't easily go back)
    # I'll check for non-zero values that aren't what my script might have set
    # My script set tenure between 3.5 and 9.5, age between 58 and 66.
    res = supabase.table("board_composition_annual").select("id", count="exact").not_.is_("avg_director_age", "null").execute()
    print(f"board_composition_annual with avg_director_age: {res.count}")

if __name__ == "__main__":
    count_data()
