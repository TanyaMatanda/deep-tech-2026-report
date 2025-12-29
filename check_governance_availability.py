
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

def check_data_availability():
    print("Checking Governance Data Availability (Real Public Companies)...")
    
    # Fetch all columns for public companies
    query = supabase.table("board_composition_annual")\
        .select("*, companies!inner(company_name, listing_type, incorporation_country)")\
        .eq("companies.listing_type", "Public")\
        .execute()
        
    df = pd.DataFrame(query.data)
    
    if df.empty:
        print("No public company board data found.")
        return

    print(f"Total Records: {len(df)}")
    
    # Columns to check
    metrics = [
        'independent_directors', 
        'avg_director_age', 
        'avg_director_tenure', 
        'tech_experts', 
        'ai_cybersecurity_experts',
        'has_ai_oversight_committee',
        'has_ai_ethics_policy',
        'board_meetings_per_year'
    ]
    
    print("\nData Availability (Non-Null Counts):")
    for metric in metrics:
        non_null = df[metric].count()
        pct = (non_null / len(df)) * 100
        print(f"  - {metric}: {non_null} ({pct:.1f}%)")
        
    # Check Canadian specific
    canadian = df[df['companies'].apply(lambda x: x.get('incorporation_country') == 'CAN')]
    print(f"\nCanadian Companies with Data: {len(canadian)}")

if __name__ == "__main__":
    check_data_availability()
