
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

def check_company_counts():
    print("Checking Total Company Counts in Database...")
    
    # Fetch all companies (just ID, country, listing_type)
    all_companies = []
    page_size = 1000
    offset = 0
    
    while True:
        try:
            response = supabase.table("companies")\
                .select("id, company_name, listing_type, incorporation_country, data_tier")\
                .range(offset, offset + page_size - 1)\
                .execute()
            
            data = response.data
            if not data:
                break
                
            all_companies.extend(data)
            offset += page_size
            
            if len(data) < page_size:
                break
        except Exception as e:
            print(f"❌ Error fetching data: {e}")
            break
            
    df = pd.DataFrame(all_companies)
    
    if df.empty:
        print("No companies found.")
        return

    print(f"✅ Total Companies: {len(df)}")
    
    print("\nBreakdown by Country:")
    print(df['incorporation_country'].value_counts())
    
    print("\nBreakdown by Listing Type:")
    print(df['listing_type'].value_counts())
    
    print("\nBreakdown by Data Tier (1=Real Public, 2=Real Private, 3=Synthetic):")
    print(df['data_tier'].value_counts())
    
    # Check specifically for US/Canada Public
    us_public = df[(df['incorporation_country'] == 'USA') & (df['listing_type'] == 'Public')]
    can_public = df[(df['incorporation_country'] == 'CAN') & (df['listing_type'].isin(['Public', 'TSX', 'TSX-V', 'CSE']))]
    
    print(f"\n🇺🇸 US Public Companies: {len(us_public)}")
    print(f"🇨🇦 Canadian Public Companies: {len(can_public)}")

if __name__ == "__main__":
    check_company_counts()
