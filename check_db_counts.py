
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

def check_counts():
    print("Checking total counts...")
    
    # Count companies
    res_companies = supabase.table("companies").select("id", count="exact", head=True).execute()
    print(f"Total Companies in DB: {res_companies.count}")
    
    # Count board data
    res_board = supabase.table("board_composition_annual").select("id", count="exact", head=True).execute()
    print(f"Total Board Composition Records: {res_board.count}")
    
    # Check breakdown by year
    res_2025 = supabase.table("board_composition_annual").select("id", count="exact", head=True).eq("fiscal_year", 2025).execute()
    print(f"Board Records for 2025: {res_2025.count}")

if __name__ == "__main__":
    check_counts()
