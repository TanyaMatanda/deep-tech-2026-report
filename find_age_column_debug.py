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

# Use public schema to query information_schema
supabase: Client = create_client(url, key)

def find_column():
    print("Searching for 'avg_director_age' in all tables...")
    # We can't query information_schema directly via Postgrest easily if it's not exposed.
    # But we can try a RPC if one exists, or just try common table names.
    
    tables_to_check = [
        "board_composition_annual",
        "company_risk_factors",
        "governance_scores",
        "companies",
        "board_members",
        "directors",
        "governance_data"
    ]
    
    schemas = ["vendor_governance", "public"]
    
    for schema in schemas:
        print(f"\nChecking schema: {schema}")
        options = ClientOptions(schema=schema)
        client = create_client(url, key, options=options)
        
        for table in tables_to_check:
            try:
                res = client.table(table).select("*").limit(1).execute()
                if res.data:
                    columns = list(res.data[0].keys())
                    if "avg_director_age" in columns or "average_age" in columns:
                        print(f"  [FOUND] Table '{table}' has age column!")
                        # Check if it has data
                        count_res = client.table(table).select("id", count="exact").not_.is_("avg_director_age" if "avg_director_age" in columns else "average_age", "null").execute()
                        print(f"    Non-null records: {count_res.count}")
                else:
                    # Table exists but empty?
                    pass
            except Exception as e:
                # Table likely doesn't exist
                pass

if __name__ == "__main__":
    find_column()
