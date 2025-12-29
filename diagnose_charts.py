import os
from supabase import create_client, Client, ClientOptions
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

def check_table(table_name):
    try:
        res = supabase.table(table_name).select("*", count="exact", head=True).execute()
        print(f"✅ {table_name}: {res.count} rows")
    except Exception as e:
        print(f"❌ {table_name}: Error - {e}")

def check_view_momentum():
    try:
        # Try to select from the view
        res = supabase.table("view_innovation_momentum").select("*", count="exact", head=True).execute()
        print(f"✅ view_innovation_momentum: {res.count} rows")
    except Exception as e:
        print(f"❌ view_innovation_momentum: Error (likely missing) - {e}")

print("--- Data Diagnostic ---")
check_table("board_composition_annual")
check_table("governance_scores")
check_table("companies")
check_view_momentum()
