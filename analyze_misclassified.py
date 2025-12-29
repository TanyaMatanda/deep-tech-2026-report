import pandas as pd
import toml
from supabase import create_client, ClientOptions

def analyze():
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
    options = ClientOptions(schema="vendor_governance")
    supabase = create_client(url, key, options=options)
    
    res = supabase.table('companies').select('id, company_name, ticker_symbol, cik, sedar_id, listing_type').execute()
    df = pd.DataFrame(res.data)
    
    # Public but no identifiers
    public_no_id = df[(df['listing_type'] == 'Public') & (df['ticker_symbol'].isna()) & (df['cik'].isna()) & (df['sedar_id'].isna())]
    print(f"Public but no identifiers: {len(public_no_id)}")
    print(public_no_id[['company_name']].head(20))
    
    # Private but has identifiers
    private_has_id = df[(df['listing_type'] == 'Private') & ((df['ticker_symbol'].notna()) | (df['cik'].notna()) | (df['sedar_id'].notna()))]
    print(f"\nPrivate but has identifiers: {len(private_has_id)}")
    print(private_has_id[['company_name', 'ticker_symbol', 'cik', 'sedar_id']].head(20))
    
    # None but has identifiers
    none_has_id = df[(df['listing_type'].isna()) & ((df['ticker_symbol'].notna()) | (df['cik'].notna()) | (df['sedar_id'].notna()))]
    print(f"\nNone but has identifiers: {len(none_has_id)}")
    print(none_has_id[['company_name', 'ticker_symbol', 'cik', 'sedar_id']].head(20))

if __name__ == "__main__":
    analyze()
