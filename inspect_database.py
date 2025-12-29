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

print("🔍 DATABASE CONTENT INSPECTION")
print("=" * 70)

# 1. Get all companies
res = supabase.table("companies").select("id, company_name, primary_sector, technology_tags").limit(100).execute()

if res.data:
    df = pd.DataFrame(res.data)
    
    print(f"\n📊 Total Companies Sample: {len(df)}")
    print(f"\n🏷️  PRIMARY SECTORS (Unique Values):")
    sectors = df['primary_sector'].value_counts()
    print(sectors.head(20))
    
    print(f"\n🏷️  TECHNOLOGY_TAGS (Sample):")
    # Get non-null tags
    tags_sample = df[df['technology_tags'].notna()]['technology_tags'].head(10)
    for idx, tags in tags_sample.items():
        print(f"  - {tags}")
    
    print(f"\n🏢 SAMPLE COMPANIES:")
    print(df[['company_name', 'primary_sector']].head(20))
else:
    print("No data found")
