import toml
from supabase import create_client, ClientOptions

def analyze():
    print("Starting analysis...")
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
    options = ClientOptions(schema="vendor_governance")
    supabase = create_client(url, key, options=options)
    
    print("Fetching 100 Public companies...")
    res = supabase.table('companies').select('company_name, ticker_symbol, cik, sedar_id').eq('listing_type', 'Public').limit(100).execute()
    
    for row in res.data:
        print(f"Name: {row['company_name']}, Ticker: {row['ticker_symbol']}, CIK: {row['cik']}, SEDAR: {row['sedar_id']}")

if __name__ == "__main__":
    analyze()
