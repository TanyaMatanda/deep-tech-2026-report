import os
from supabase import create_client, Client, ClientOptions

# Configuration
# It's recommended to load these from environment variables for security and flexibility.
# For local testing, you can set them directly or use a .env file.
SUPABASE_URL = os.environ.get("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
SUPABASE_KEY = os.environ.get("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0")

def get_supabase_client() -> Client:
    """
    Initializes and returns a Supabase client configured for the 'vendor_governance' schema.

    Returns:
        Client: An initialized Supabase client instance.
    """
    print("Initializing Supabase connection...")
    if not SUPABASE_URL or not SUPABASE_KEY:
        raise ValueError("Supabase URL and Key must be set in environment variables or directly.")

    options = ClientOptions(
        schema="vendor_governance",
        headers={"Content-Profile": "vendor_governance"}
    )
    client = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)
    print("Supabase client initialized.")
    return client

def check_financial_metrics_data(client: Client):
    """
    Checks the count of records in the 'financial_metrics' table.

    Args:
        client (Client): An initialized Supabase client.
    """
    print("Checking financial_metrics count...")
    try:
        # Check if table exists and has data
        response = client.table("financial_metrics").select("*", count="exact", head=True).execute()
        
        # The count is available in response.count
        record_count = response.count
        print(f"Financial Metrics Count: {record_count}")
        
        if record_count == 0:
            print("The 'financial_metrics' table is empty.")
        else:
            print(f"The 'financial_metrics' table contains {record_count} records.")
            
    except Exception as e:
        print(f"Error checking 'financial_metrics' table: {e}")

def main():
    """
    Main function to orchestrate the financial data checks.
    """
    try:
        supabase_client = get_supabase_client()
        check_financial_metrics_data(supabase_client)
    except ValueError as ve:
        print(f"Configuration Error: {ve}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    main()
