import toml
from supabase import create_client, ClientOptions

def analyze():
    print("Starting analysis...")
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
    options = ClientOptions(schema="vendor_governance")
    supabase = create_client(url, key, options=options)
    
    print("Fetching Public companies...")
    res = supabase.table('companies').select('company_name, ticker_symbol, cik, sedar_id').eq('listing_type', 'Public').limit(100).execute()
    print(f"Found {len(res.data)} Public companies")
    
    count_no_id = 0
    for row in res.data:
        if not row.get('ticker_symbol') and not row.get('cik') and not row.get('sedar_id'):
            count_no_id += 1
            if count_no_id <= 10:
                print(f"Public but no ID: {row['company_name']}")
    
    print(f"Total Public but no ID in sample: {count_no_id}")

if __name__ == "__main__":
    analyze()
