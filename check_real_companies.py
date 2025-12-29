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

print("=" * 80)
print("CHECKING REAL COMPANY DATA")
print("=" * 80)

# Check for real public companies
print("\n1. Sample of public companies with ticker symbols:")
result = supabase.table('companies').select('id, company_name, ticker_symbol, primary_sector').filter('ticker_symbol', 'not.is', 'null').limit(20).execute()

print(f"\nFound {len(result.data)} public companies (showing first 10):\n")
for row in result.data[:10]:
    print(f"  {row['company_name']:<50} {row.get('ticker_symbol', 'N/A'):<10} {row.get('primary_sector', 'N/A')}")

# Check Microsoft specifically
print("\n\n2. Looking for Microsoft:")
msft = supabase.table('companies').select('*').ilike('company_name', '%microsoft%').execute()
if msft.data:
    print(f"  ✓ Found {len(msft.data)} Microsoft entries")
    for m in msft.data:
        print(f"    - {m['company_name']} (ID: {m['id'][:8]}..., Ticker: {m.get('ticker_symbol', 'N/A')})")
else:
    print("  ✗ No Microsoft found")

# Check if company_risk_factors table exists and has data
print("\n\n3. Checking for governance data in company_risk_factors:")
try:
    risk_data = supabase.table('company_risk_factors').select('company_id', count='exact', head=True).execute()
    print(f"  ✓ Table exists with {risk_data.count} records")
except Exception as e:
    print(f"  ✗ Table may not exist or is empty: {e}")

print("\n" + "=" * 80)
