
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

def check_data():
    print("Checking data linkage...")
    
    # Get a company that has filings
    res = supabase.table("sec_filings").select("company_id, companies(company_name)").limit(5).execute()
    
    for row in res.data:
        company_id = row['company_id']
        company_name = row['companies']['company_name']
        print(f"\nChecking {company_name} (ID: {company_id})...")
        
        # Check people
        res_people = supabase.table("company_people").select("*").eq("company_id", company_id).execute()
        print(f"   Found {len(res_people.data)} people records.")
        
        if res_people.data:
            print(f"   Sample: {res_people.data[0]}")

if __name__ == "__main__":
    check_data()
