
import os
from supabase import create_client, Client, ClientOptions
import pandas as pd
import toml

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

def check_years():
    print("Checking board_composition_annual years...")
    try:
        # Get unique fiscal years and count
        response = supabase.table("board_composition_annual").select("fiscal_year, women_percentage").execute()
        if response.data:
            df = pd.DataFrame(response.data)
            print("Fiscal Year Counts:")
            print(df['fiscal_year'].value_counts().sort_index())
            
            print("\nWomen Percentage Stats by Year:")
            print(df.groupby('fiscal_year')['women_percentage'].describe())
        else:
            print("No data in board_composition_annual")
            
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    check_years()
