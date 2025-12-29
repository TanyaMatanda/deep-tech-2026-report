
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

def verify_data_authenticity():
    print("🕵️‍♀️ Verifying Data Authenticity...")
    
    # 1. Check for known fictional/suspicious names
    suspicious_names = ["Omni Consumer Products", "Cyberdyne Systems", "Acme Corp", "Wayne Enterprises", "Stark Industries"]
    print(f"\nChecking for suspicious names: {suspicious_names}")
    
    for name in suspicious_names:
        res = supabase.table("companies").select("company_name").ilike("company_name", f"%{name}%").execute()
        if res.data:
            print(f"  ⚠️ FOUND: {res.data}")
        else:
            print(f"  ✅ Not found: {name}")

    # 2. Check Board Composition Data Source
    # Look for patterns in 'women_percentage' - is it too perfect?
    print("\nChecking Board Composition Value Distribution...")
    res = supabase.table("board_composition_annual").select("women_percentage").limit(1000).execute()
    if res.data:
        df = pd.DataFrame(res.data)
        print(df['women_percentage'].value_counts().head(10))
        
    # 3. Check for 'Faker' patterns in People
    # Real data usually doesn't have perfectly distributed names or specific Faker artifacts
    print("\nChecking People Names (Sample)...")
    res_people = supabase.table("people").select("full_name").limit(20).execute()
    for p in res_people.data:
        print(f"  - {p['full_name']}")

if __name__ == "__main__":
    verify_data_authenticity()
