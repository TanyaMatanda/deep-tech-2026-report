import psycopg2
import os
import toml

# Load secrets
try:
    secrets = toml.load("dashboard/.streamlit/secrets.toml")
    # Construct connection string from Supabase URL and Key? 
    # No, Supabase URL is HTTP. We need the Postgres connection string.
    # Usually it's in the format: postgresql://postgres:[YOUR-PASSWORD]@db.[YOUR-PROJECT-REF].supabase.co:5432/postgres
    # But we might not have the password in secrets.toml, only the API key.
    # Let's check if we have a direct connection string or if we can use the API key for auth (unlikely for psycopg2).
    
    # Wait, if we don't have the password, we can't use psycopg2 directly.
    # Let's check secrets.toml content again (I viewed it earlier).
    # It had SUPABASE_URL and SUPABASE_KEY.
    # It did NOT have a postgres connection string.
    
    # If I can't use psycopg2 due to missing credentials, I'll have to use the Supabase Client.
    # But Supabase Client doesn't support CREATE TABLE easily.
    
    # Let's try to use the `postgres` library if available, or just print a message.
    pass
except Exception as e:
    print(f"Error loading secrets: {e}")

# Actually, I recall `real_governance_data.sql` was just a file.
# If I can't connect via psycopg2 (missing password), I can't run the DDL.
# BUT, I can try to use the `supabase-py` client to run a stored procedure `exec_sql` if it exists.
# Let's check if `exec_sql` exists by trying to call it.

from supabase import create_client, Client

url = secrets["SUPABASE_URL"]
key = secrets["SUPABASE_KEY"]
supabase: Client = create_client(url, key)

sql_content = open("create_proposals_table.sql").read()

# Try to run via RPC if available (common helper in some setups)
try:
    response = supabase.rpc("exec_sql", {"sql": sql_content}).execute()
    print("Executed via RPC")
except Exception as e:
    print(f"RPC failed: {e}")
    print("Please run 'create_proposals_table.sql' in the Supabase SQL Editor.")
