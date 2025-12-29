import os
from supabase import create_client, Client, ClientOptions
import toml

# Load secrets
try:
    try:
        secrets = toml.load(".streamlit/secrets.toml")
    except FileNotFoundError:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

if not url or not key:
    print("Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema="vendor_governance")
supabase: Client = create_client(url, key, options=options)

try:
    response = supabase.table('companies').select('id', count='exact').execute()
    print(f"✅ Total companies in DB: {response.count}")
    
    # Check for tickers
    response_tickers = supabase.table('companies').select('id, ticker_symbol').neq('ticker_symbol', 'NULL').execute()
    print(f"✅ Companies with Tickers: {len(response_tickers.data)}")
    
    if len(response_tickers.data) > 0:
        print(f"Sample: {response_tickers.data[0]}")
        
except Exception as e:
    print(f"❌ Error: {e}")
