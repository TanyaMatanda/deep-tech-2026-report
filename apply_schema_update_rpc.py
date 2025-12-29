import os
from supabase import create_client, Client, ClientOptions

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def execute_sql_file(filename):
    print(f"Reading {filename}...")
    with open(filename, 'r') as f:
        sql_content = f.read()
        
    print("Initializing connection...")
    options = ClientOptions(
        schema="public",
        headers={"Content-Profile": "public"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("Executing SQL via RPC 'exec_sql'...")
    try:
        response = client.rpc('exec_sql', {'query': sql_content}).execute()
        print("Success!")
        print(response.data)
    except Exception as e:
        print(f"RPC 'exec_sql' failed: {e}")
        print("\nNOTE: If this failed, it means the 'exec_sql' function is not enabled on your Supabase instance.")
        print("You may need to run the SQL manually in the Supabase Dashboard SQL Editor.")

if __name__ == "__main__":
    execute_sql_file("update_schema_v2.sql")
