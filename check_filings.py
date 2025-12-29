
import os
from supabase import create_client, Client, ClientOptions
import toml
import pandas as pd

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

def check_filings():
    print("Checking SEC Filings...")
    res = supabase.table("sec_filings").select("*").limit(20).execute()
    if res.data:
        df = pd.DataFrame(res.data)
        print(df[['filing_type', 'filing_url', 'accession_number']])
    else:
        print("No filings found.")

if __name__ == "__main__":
    check_filings()
