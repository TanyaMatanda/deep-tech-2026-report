
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

def check_misclassified():
    print("Checking for Misclassified Public Companies...")
    
    # Fetch companies with a ticker symbol but NOT marked as Public
    response = supabase.table("companies")\
        .select("id, company_name, ticker_symbol, listing_type, incorporation_country")\
        .neq("ticker_symbol", "")\
        .neq("ticker_symbol", "None")\
        .not_.is_("ticker_symbol", "null")\
        .neq("listing_type", "Public")\
        .execute()
        
    df = pd.DataFrame(response.data)
    
    if df.empty:
        print("✅ No misclassified companies found (all with tickers are Public).")
    else:
        print(f"⚠️ Found {len(df)} companies with tickers that are NOT marked Public.")
        print(df['incorporation_country'].value_counts())
        print(df.head(10))

    # Check specifically for Canadian companies without tickers
    print("\nChecking Canadian Companies without Tickers...")
    can_response = supabase.table("companies")\
        .select("id, company_name, listing_type")\
        .in_("incorporation_country", ["CAN", "CA"])\
        .execute()
        
    can_df = pd.DataFrame(can_response.data)
    print(f"Total Canadian Companies: {len(can_df)}")
    print(f"Public: {len(can_df[can_df['listing_type'] == 'Public'])}")
    print(f"Private/Other: {len(can_df[can_df['listing_type'] != 'Public'])}")

if __name__ == "__main__":
    check_misclassified()
