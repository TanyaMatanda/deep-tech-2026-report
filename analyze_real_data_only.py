
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

def analyze_real_data():
    print("Analyzing Real Public Data...")
    
    # Get real data (Public companies with directors)
    # We can join companies and board_composition_annual
    
    query = """
    select 
        c.company_name, 
        c.ticker_symbol,
        b.total_directors,
        b.women_directors,
        b.women_percentage
    from companies c
    join board_composition_annual b on c.id = b.company_id
    where c.listing_type = 'Public'
    and b.total_directors > 0
    """
    
    res = supabase.table("board_composition_annual").select("total_directors, women_directors, women_percentage, companies!inner(company_name, ticker_symbol, listing_type, data_tier)").eq("companies.listing_type", "Public").eq("companies.data_tier", 1).gt("total_directors", 0).execute()
    
    data = []
    for row in res.data:
        company = row['companies']
        data.append({
            'company_name': company['company_name'],
            'ticker': company['ticker_symbol'],
            'total_directors': row['total_directors'],
            'women_directors': row['women_directors'],
            'women_percentage': row['women_percentage']
        })
        
    df = pd.DataFrame(data)
    
    if df.empty:
        print("No real data found (Tier 1).")
        return
        
    print(f"Found {len(df)} real companies (Tier 1).")
    print(f"Average Women %: {df['women_percentage'].mean():.1f}%")
    print(f"Zero Women Boards: {len(df[df['women_percentage'] == 0])} ({len(df[df['women_percentage'] == 0])/len(df)*100:.1f}%)")
    print(f"Parity Boards: {len(df[df['women_percentage'] >= 50])}")
    
    print("\nTop Performers:")
    print(df.sort_values('women_percentage', ascending=False).head(10)[['company_name', 'ticker', 'women_percentage']])

if __name__ == "__main__":
    analyze_real_data()
