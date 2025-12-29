
import os
from supabase import create_client, Client, ClientOptions
import toml

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

if not url or not key:
    print("❌ Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

def check_age_data():
    print("Checking for non-null age data...")
    res = supabase.table("board_composition_annual").select("avg_director_age", count="exact", head=True).not_.is_("avg_director_age", "null").execute()
    print(f"Records with Age Data: {res.count}")
    
    res_tenure = supabase.table("board_composition_annual").select("avg_director_tenure", count="exact", head=True).not_.is_("avg_director_tenure", "null").execute()
    print(f"Records with Tenure Data: {res_tenure.count}")

if __name__ == "__main__":
    check_age_data()
