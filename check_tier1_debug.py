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

def check_tier1_data():
    print("Checking board_composition_annual for Tier 1 companies...")
    
    # Get Tier 1 company IDs
    res = supabase.table("companies").select("id, company_name").eq("data_tier", 1).execute()
    tier1_ids = [c['id'] for c in res.data]
    print(f"Found {len(tier1_ids)} Tier 1 companies.")
    
    if not tier1_ids:
        return

    # Check board data for these companies
    res = supabase.table("board_composition_annual").select("*").in_("company_id", tier1_ids).execute()
    if res.data:
        print(f"Found {len(res.data)} board records for Tier 1.")
        for row in res.data[:10]:
            print(f"Company: {row['company_id']}")
            print(f"  Age: {row['avg_director_age']}")
            print(f"  Tenure: {row['avg_director_tenure']}")
            print(f"  Women %: {row['women_percentage']}")
            print("-" * 20)
    else:
        print("No board records found for Tier 1.")

if __name__ == "__main__":
    check_tier1_data()
