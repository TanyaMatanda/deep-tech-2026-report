import os
from supabase import create_client, Client, ClientOptions
from dotenv import load_dotenv

# Load environment variables (try to load from .env or use hardcoded fallback if needed for this script)
load_dotenv()

# Hardcoded fallback for this specific execution context if env vars aren't set in shell
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0")

def execute_sql_file(filename):
    print(f"Reading {filename}...")
    try:
        with open(filename, 'r') as f:
            sql_content = f.read()
    except FileNotFoundError:
        print(f"Error: File {filename} not found.")
        return

    print("Initializing connection...")
    # Use public schema for general SQL execution if possible, or try to use a direct SQL endpoint if available
    # Since we don't have a direct SQL endpoint in the python client usually, we rely on RPC or just printing instructions.
    # However, for this specific task, if we can't run it, we must instruct the user.
    # Let's try to use the 'postgres' library if available, but we only have 'supabase' client installed.
    # The 'supabase' python client doesn't support running raw SQL strings directly unless via RPC.
    
    # CHECK: Do we have an RPC function 'exec_sql'?
    # If not, we can't run this from Python easily without 'psycopg2'.
    
    print("Checking for 'exec_sql' RPC...")
    options = ClientOptions(
        schema="public",
        headers={"Content-Profile": "public"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    try:
        response = client.rpc('exec_sql', {'query': sql_content}).execute()
        print("Success! SQL executed via RPC.")
        print(response.data)
    except Exception as e:
        print(f"RPC 'exec_sql' failed: {e}")
        print("This is expected if the helper function is not installed on the server.")
        print("You must run the SQL script manually in the Supabase Dashboard SQL Editor.")

if __name__ == "__main__":
    execute_sql_file("update_scoring_year.sql")
    execute_sql_file("create_market_summary.sql")
