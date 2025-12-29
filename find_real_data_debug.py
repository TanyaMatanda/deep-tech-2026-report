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

def find_real_data():
    print("Searching for real data in board_composition_annual...")
    
    # Check for age outside 58-66 or tenure outside 3.5-9.5
    # Also check for non-null values that might have been there before
    res = supabase.table("board_composition_annual").select("*")\
        .or_("avg_director_age.lt.58,avg_director_age.gt.66,avg_director_tenure.lt.3.5,avg_director_tenure.gt.9.5")\
        .execute()
    
    if res.data:
        print(f"Found {len(res.data)} records that might be real data.")
        for row in res.data[:10]:
            print(f"Company ID: {row['company_id']}")
            print(f"  Age: {row['avg_director_age']}")
            print(f"  Tenure: {row['avg_director_tenure']}")
            print("-" * 20)
    else:
        print("No records found outside the 'realistic' range.")

if __name__ == "__main__":
    find_real_data()
