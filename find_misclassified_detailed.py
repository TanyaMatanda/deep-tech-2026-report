import pandas as pd
import sys
from db_connection import init_connection

def find_misclassified():
    with open('debug_output.txt', 'w') as f:
        f.write("Connecting...\n")
        supabase = init_connection()
        if not supabase:
            f.write("Failed to connect to Supabase\n")
            return
        f.write("Connected\n")

        # Fetch relevant columns
        f.write("Fetching data...\n")
        res = supabase.table('companies').select('id, company_name, ticker_symbol, cik, sedar_id, listing_type').execute()
        f.write(f"Data fetched: {len(res.data) if res.data else 0} rows\n")
        if not res.data:
            f.write("No data found\n")
            return

        df = pd.DataFrame(res.data)
        
        # Logic for Public: has ticker OR has CIK OR has SEDAR ID
        df['should_be_public'] = df['ticker_symbol'].notna() | df['cik'].notna() | df['sedar_id'].notna()
        
        # Misclassified as Private but should be Public
        private_but_public = df[(df['listing_type'] == 'Private') & (df['should_be_public'])]
        
        # Misclassified as Public but should be Private (no ticker, no CIK, no SEDAR ID)
        public_but_private = df[(df['listing_type'] == 'Public') & (~df['should_be_public'])]
        
        # None values
        none_listing = df[df['listing_type'].isna()]
        
        f.write(f"Total companies: {len(df)}\n")
        f.write(f"Private but should be Public: {len(private_but_public)}\n")
        if not private_but_public.empty:
            f.write(str(private_but_public[['company_name', 'ticker_symbol', 'cik', 'sedar_id']].head(10)) + "\n")
            
        f.write(f"\nPublic but should be Private: {len(public_but_private)}\n")
        if not public_but_private.empty:
            f.write(str(public_but_private[['company_name', 'ticker_symbol', 'cik', 'sedar_id']].head(10)) + "\n")
            
        f.write(f"\nListing Type is None: {len(none_listing)}\n")
        f.write(f"  - Of which should be Public: {len(none_listing[none_listing['should_be_public']])}\n")
        f.write(f"  - Of which should be Private: {len(none_listing[~none_listing['should_be_public']])}\n")

if __name__ == "__main__":
    find_misclassified()
