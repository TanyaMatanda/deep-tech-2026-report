# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def init_connection():
    # Mocking the init_connection from db_connection.py for standalone run
    from supabase import create_client, ClientOptions
    
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def check_function():
    print("Initializing connection...")
    client = init_connection()
    if not client: return

    print("Fetching function definition...")
    # We can't query pg_proc directly via Supabase API usually (permissions).
    # But we can try to use the rpc call if we had one, or just assume we can't.
    # Alternatively, we can just test the function with a raw SQL call via rpc if we create a wrapper, 
    # but we can't create wrappers easily.
    
    # Let's try to just run the function directly on a dummy value to see what it returns.
    # We can use the .rpc() method if we knew how to call it, or just select it.
    
    # We'll try to select the function result for a hypothetical input.
    # But we can't easily do "SELECT calculate_innovation_index(100000, ARRAY['AI'])" via the JS/Python client 
    # unless we use .rpc().
    
    try:
        # Supabase client .rpc(function_name, params)
        # params is a dict
        result = client.rpc('calculate_innovation_index', {'p_patents_count': 100000, 'p_tech_tags': ['AI']}).execute()
        print(f"Test Result for 100k patents: {result.data}")
        
        result_10k = client.rpc('calculate_innovation_index', {'p_patents_count': 10000, 'p_tech_tags': ['AI']}).execute()
        print(f"Test Result for 10k patents: {result_10k.data}")
        
    except Exception as e:
        print(f"Error calling RPC: {e}")

if __name__ == "__main__":
    check_function()
