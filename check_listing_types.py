import pandas as pd
from db_connection import init_connection

def check_listing_types():
    supabase = init_connection()
    if not supabase:
        print("Failed to connect to Supabase")
        return

    # Check distribution of listing_type and ticker_symbol
    res = supabase.table('companies').select('listing_type, ticker_symbol').execute()
    if not res.data:
        print("No data found in companies table")
        return

    df = pd.DataFrame(res.data)
    
    print("--- Listing Type Distribution ---")
    print(df['listing_type'].value_counts(dropna=False))
    
    print("\n--- Ticker vs Listing Type (Sample) ---")
    # Companies with tickers but marked as Private
    ticker_private = df[(df['ticker_symbol'].notna()) & (df['listing_type'] == 'Private')]
    print(f"Companies with Ticker but marked Private: {len(ticker_private)}")
    if not ticker_private.empty:
        print(ticker_private.head(10))
        
    # Companies without tickers but marked as Public
    no_ticker_public = df[(df['ticker_symbol'].isna()) & (df['listing_type'] == 'Public')]
    print(f"\nCompanies without Ticker but marked Public: {len(no_ticker_public)}")
    if not no_ticker_public.empty:
        print(no_ticker_public.head(10))

if __name__ == "__main__":
    check_listing_types()
