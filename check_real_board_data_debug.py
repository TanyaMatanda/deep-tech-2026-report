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

def check_board_data():
    print("Checking board_composition_annual for real data...")
    
    # Check total count
    res = supabase.table("board_composition_annual").select("id", count="exact").execute()
    total = res.count
    print(f"Total records: {total}")
    
    # Check for records with age/tenure that are NOT in the range I set (58-66 for age, 3.5-9.5 for tenure)
    # This is a bit tricky, but I can check for values outside that range.
    res = supabase.table("board_composition_annual").select("*")\
        .or_("avg_director_age.lt.58,avg_director_age.gt.66,avg_director_tenure.lt.3.5,avg_director_tenure.gt.9.5")\
        .limit(10).execute()
    
    if res.data:
        print("Found records outside my 'realistic' range (likely real data):")
        for row in res.data:
            print(f"Company ID: {row['company_id']}")
            print(f"  Age: {row['avg_director_age']}")
            print(f"  Tenure: {row['avg_director_tenure']}")
            print("-" * 20)
    else:
        print("No records found outside the 'realistic' range.")

if __name__ == "__main__":
    check_board_data()
