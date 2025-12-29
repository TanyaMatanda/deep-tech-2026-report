import os
from supabase import create_client, Client
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

from supabase import ClientOptions

if not url or not key:
    print("Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema="vendor_governance")
supabase: Client = create_client(url, key, options=options)

try:
    # Fetch one row to see columns
    response = supabase.table('companies').select('*').limit(1).execute()
    if response.data:
        print("Columns in 'companies' table:")
        for col in response.data[0].keys():
            print(f"  - {col}")
    else:
        print("Table 'companies' is empty or not accessible.")
except Exception as e:
    print(f"Error checking schema: {e}")
