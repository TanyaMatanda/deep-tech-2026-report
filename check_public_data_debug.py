import os
import toml
from supabase import create_client, Client, ClientOptions

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

# NO SCHEMA OPTION (defaults to public)
supabase: Client = create_client(url, key)

def check_public_data():
    print("Checking public schema for governance data...")
    
    tables = ["board_composition_annual", "company_risk_factors", "governance_scores"]
    
    for table in tables:
        try:
            res = supabase.table(table).select("*").limit(5).execute()
            if res.data:
                print(f"Table '{table}' in public schema has data:")
                for row in res.data:
                    print(f"  {row}")
            else:
                print(f"Table '{table}' in public schema is empty.")
        except Exception as e:
            print(f"Table '{table}' not found in public schema or error: {e}")

if __name__ == "__main__":
    check_public_data()
