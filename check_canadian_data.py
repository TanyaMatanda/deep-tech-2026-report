
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

def check_canadian_data():
    print("Checking Canadian Companies...")
    
    # Get Canadian companies (Tier 2)
    res = supabase.table("companies").select("id, company_name, ticker_symbol").eq("data_tier", 2).execute()
    canadian_companies = res.data
    
    print(f"Found {len(canadian_companies)} Canadian companies (Tier 2).")
    
    for company in canadian_companies:
        # Check if we have board data (maybe from SEC if dual listed and matched?)
        # Note: The collector inserted them as new rows, so they have new IDs. 
        # Unless we matched by name/jurisdiction which the upsert does.
        
        res_board = supabase.table("board_composition_annual").select("*").eq("company_id", company['id']).execute()
        
        if res_board.data:
            print(f"✅ Found board data for {company['company_name']}: {res_board.data[0]}")
        else:
            # Check if there's another company record with same name (Tier 1)
            res_tier1 = supabase.table("companies").select("id, data_tier").eq("company_name", company['company_name']).eq("data_tier", 1).execute()
            if res_tier1.data:
                print(f"ℹ️  {company['company_name']} also exists as Tier 1 (SEC). Checking that...")
                tier1_id = res_tier1.data[0]['id']
                res_board_t1 = supabase.table("board_composition_annual").select("*").eq("company_id", tier1_id).execute()
                if res_board_t1.data:
                     print(f"   ✅ Found Tier 1 board data: {res_board_t1.data[0]}")
                else:
                     print(f"   ❌ No Tier 1 board data either.")
            else:
                # print(f"❌ No board data for {company['company_name']}")
                pass

if __name__ == "__main__":
    check_canadian_data()
