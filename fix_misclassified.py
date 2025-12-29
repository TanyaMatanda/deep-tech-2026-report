
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

def fix_misclassified():
    print("Fixing Misclassified Public Companies...")
    
    # Update companies with ticker but not Public
    response = supabase.table("companies")\
        .update({"listing_type": "Public", "data_tier": 1})\
        .neq("ticker_symbol", "")\
        .neq("ticker_symbol", "None")\
        .not_.is_("ticker_symbol", "null")\
        .neq("listing_type", "Public")\
        .execute()
        
    print(f"✅ Updated {len(response.data)} companies to Public.")

if __name__ == "__main__":
    fix_misclassified()
