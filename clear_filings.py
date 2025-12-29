
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

def clear_filings():
    print("Clearing SEC Filings...")
    # Delete all rows (using a condition that is always true or neq dummy id)
    # Supabase requires a WHERE clause for delete
    res = supabase.table("sec_filings").delete().neq("id", "00000000-0000-0000-0000-000000000000").execute()
    print(f"Deleted {len(res.data)} filings.")

if __name__ == "__main__":
    clear_filings()
