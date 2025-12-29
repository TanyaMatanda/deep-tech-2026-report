
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

def check_linkage():
    print("Fetching one ID from board_composition_annual...")
    res = supabase.table("board_composition_annual").select("company_id").limit(1).execute()
    if not res.data:
        print("No board data found.")
        return
        
    target_id = res.data[0]['company_id']
    print(f"Target Company ID: {target_id}")
    
    print("Checking existence in companies table...")
    res_company = supabase.table("companies").select("id, company_name").eq("id", target_id).execute()
    
    if res_company.data:
        print(f"✅ Found Company: {res_company.data[0]}")
    else:
        print("❌ Company ID not found in companies table.")

if __name__ == "__main__":
    check_linkage()
