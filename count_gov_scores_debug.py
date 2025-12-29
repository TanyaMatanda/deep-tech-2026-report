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

def count_gov_scores():
    print("Counting non-null data in governance_scores...")
    
    res = supabase.table("governance_scores").select("id", count="exact").not_.is_("board_independence_pct", "null").execute()
    print(f"governance_scores with board_independence_pct: {res.count}")
    
    res = supabase.table("governance_scores").select("id", count="exact").not_.is_("board_diversity_pct", "null").execute()
    print(f"governance_scores with board_diversity_pct: {res.count}")
    
    res = supabase.table("governance_scores").select("id", count="exact").not_.is_("overall_governance_score", "null").execute()
    print(f"governance_scores with overall_governance_score: {res.count}")

if __name__ == "__main__":
    count_gov_scores()
