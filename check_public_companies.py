import os
import toml
from supabase import create_client, ClientOptions

# Load credentials
try:
    secrets = toml.load('dashboard/.streamlit/secrets.toml')
    url = secrets['SUPABASE_URL']
    key = secrets['SUPABASE_KEY']
except:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase = create_client(url, key, options=options)

print("="*60)
print("PUBLIC COMPANY DATA AUDIT")
print("="*60)

# 1. Check total companies in base table
print("\n1. Checking base 'companies' table...")
response = supabase.table('companies').select('id', count='exact', head=True).execute()
total_companies = response.count
print(f"   Total Companies: {total_companies}")

# 2. Check companies with ticker symbols in base table
print("\n2. Checking companies with ticker symbols...")
response = supabase.table('companies').select('id', count='exact', head=True).filter('ticker_symbol', 'not.is', 'null').execute()
public_companies = response.count
print(f"   Public Companies (with ticker): {public_companies}")

# 3. Check view_company_scores
print("\n3. Checking 'view_company_scores'...")
response = supabase.table('view_company_scores').select('company_id', count='exact', head=True).execute()
view_count = response.count
print(f"   Total in View: {view_count}")

# 4. Check public companies in view
# Note: view_company_scores might not have ticker_symbol column directly depending on definition
# Let's check if we can filter by ticker_symbol on the view
try:
    response = supabase.table('view_company_scores').select('company_id', count='exact', head=True).filter('ticker_symbol', 'not.is', 'null').execute()
    view_public_count = response.count
    print(f"   Public Companies in View: {view_public_count}")
except Exception as e:
    print(f"   ❌ Could not filter view by ticker_symbol: {e}")
    # Fetch a sample to see columns
    response = supabase.table('view_company_scores').select('*').limit(1).execute()
    if response.data:
        print(f"   Columns in view: {list(response.data[0].keys())}")

print("\n" + "="*60)
print("ANALYSIS")
print("="*60)

if public_companies < 2000:
    print(f"⚠️  Only {public_companies} companies have ticker symbols.")
    print("   Possible causes:")
    print("   1. Ticker symbols missing for some public companies")
    print("   2. Data ingestion incomplete")
else:
    print(f"✅ Found {public_companies} public companies in database.")
    if view_public_count < public_companies:
        print(f"⚠️  But only {view_public_count} are in the view!")
        print("   The view might be filtering them out (e.g. inner joins).")
