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
    # Try connecting to 'postgres' schema to run DDL
    options = ClientOptions(
        schema="public",
        headers={"Content-Profile": "public"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    
    print("Executing SQL via RPC 'exec_sql'...")
    try:
        # This assumes a function 'exec_sql' exists which takes a 'query' parameter
        # This is a common helper function. If it doesn't exist, this will fail.
        response = client.rpc('exec_sql', {'query': sql_content}).execute()
        print("Success!")
        print(response.data)
    except Exception as e:
        print(f"RPC 'exec_sql' failed: {e}")
        print("Attempting fallback: direct REST execution (unlikely to work for DDL without specific endpoint)...")
        
        # Fallback: Try to use the 'sql' endpoint if available (some setups have it)
        # or just print instructions.
        print("\nCRITICAL: Could not execute SQL automatically.")
        print("Please run the following SQL in your Supabase SQL Editor:")
        print("-" * 20)
        print(sql_content)
        print("-" * 20)

if __name__ == "__main__":
    execute_sql_file("create_innovation_momentum.sql")
