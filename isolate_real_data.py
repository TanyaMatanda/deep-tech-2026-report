
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

def analyze_real_data_sources():
    print("🕵️‍♀️ Analyzing Real Data Sources...")
    
    # 1. Check SEC Filings Count
    res_filings = supabase.table("sec_filings").select("id", count="exact", head=True).execute()
    print(f"Total SEC Filings: {res_filings.count}")
    
    # 2. Check Companies with Ticker Symbols (usually public/real)
    res_tickers = supabase.table("companies").select("id", count="exact", head=True).not_.is_("ticker_symbol", "null").execute()
    print(f"Companies with Ticker Symbols: {res_tickers.count}")
    
    # 3. Check Board Data for Companies with Tickers
    # We'll fetch a sample and see if they look "real" (not just random %s)
    print("\nChecking Board Data for Public Companies (with Tickers)...")
    
    # Fetch IDs of companies with tickers
    res_public_ids = supabase.table("companies").select("id").not_.is_("ticker_symbol", "null").limit(1000).execute()
    public_ids = [r['id'] for r in res_public_ids.data]
    
    if public_ids:
        print(f"Found {len(public_ids)} public companies. Fetching board data in batches...")
        all_board_data = []
        batch_size = 100
        
        for i in range(0, len(public_ids), batch_size):
            batch = public_ids[i:i+batch_size]
            try:
                res = supabase.table("board_composition_annual").select("*").in_("company_id", batch).execute()
                all_board_data.extend(res.data)
            except Exception as e:
                print(f"Error fetching batch {i}: {e}")
                
        if all_board_data:
            df = pd.DataFrame(all_board_data)
            print(f"Found {len(df)} board records for public companies.")
            print("Sample Women % values (Real data shouldn't be just integers or clean decimals):")
            print(df['women_percentage'].head(10).tolist())
            
            # Check if these match the "synthetic" pattern (10-50%)
            print("\nStats for Public Company Board Data:")
            print(df['women_percentage'].describe())
        else:
            print("No board data found for these public companies.")
    
    # 4. Check for 'created_at' clustering
    # Synthetic data might have been created all at once
    # Real data might be more spread out or have different timestamps
    
if __name__ == "__main__":
    analyze_real_data_sources()
