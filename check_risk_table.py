import os
from supabase import create_client, Client, ClientOptions
import toml

# Load secrets
try:
    try:
        secrets = toml.load(".streamlit/secrets.toml")
    except FileNotFoundError:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

if not url or not key:
    print("Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema="vendor_governance")
supabase: Client = create_client(url, key, options=options)

try:
    response = supabase.table('company_risk_factors').select('id').limit(1).execute()
    print("✅ Table 'company_risk_factors' exists.")
except Exception as e:
    print(f"❌ Table 'company_risk_factors' does not exist or error: {e}")
