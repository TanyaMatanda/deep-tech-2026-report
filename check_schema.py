import os
import toml
from dashboard.db_connection import init_connection

# Load secrets
try:
    secrets = toml.load("dashboard/.streamlit/secrets.toml")
    os.environ["SUPABASE_URL"] = secrets["SUPABASE_URL"]
    os.environ["SUPABASE_KEY"] = secrets["SUPABASE_KEY"]
    print(f"Loaded secrets. URL starts with: {secrets['SUPABASE_URL'][:8]}...")
except Exception as e:
    print(f"⚠️ Could not load secrets: {e}")

from dashboard.db_connection import init_connection, SUPABASE_URL as DB_URL

print(f"DB Connection Module sees URL: {str(DB_URL)[:8]}...")

def check_columns():
    client = init_connection()
    if not client:
        print("❌ Connection failed")
        return

    print("Fetching one row from view_innovation_momentum...")
    try:
        response = client.table("view_innovation_momentum").select("*").limit(1).execute()
        if response.data:
            row = response.data[0]
            print("✅ Available columns in view_innovation_momentum:")
            for col, val in row.items():
                print(f" - {col}: {val}")
        else:
            print("❌ No data returned from view_innovation_momentum")
    except Exception as e:
        print(f"❌ Error fetching data from view_innovation_momentum: {e}")

if __name__ == "__main__":
    check_columns()
