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
    response = supabase.table('shareholder_proposals').select('id').limit(1).execute()
    print("✅ Table 'shareholder_proposals' exists.")
except Exception as e:
    print(f"❌ Table 'shareholder_proposals' does not exist or error: {e}")
