import os
import sys
from supabase import create_client, Client, ClientOptions
import json

# Load secrets
with open('dashboard/.streamlit/secrets.toml', 'r') as f:
    import toml
    secrets = toml.load(f)

supabase_url = secrets['SUPABASE_URL']
supabase_key = secrets['SUPABASE_KEY']
options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(supabase_url, supabase_key, options=options)

# Import the runner logic
from run_governance_extraction import process_company
from sec_filing_parser import SECFilingParser

def run_verification():
    parser = SECFilingParser()
    # Specific IDs for Microsoft and NVIDIA
    test_companies = [
        {'id': 'c748e3b9-b48b-4de8-bd4c-dab5b56f5649', 'company_name': 'Microsoft Corporation', 'cik': '0000789019'},
        {'id': '3cab4b4b-6089-42b1-b587-e42bd6636f65', 'company_name': 'NVIDIA', 'cik': '0001045810'}
    ]
    
    print(f"🚀 Running extraction for {len(test_companies)} companies...")
    for company in test_companies:
        print(f"Processing {company['company_name']}...")
        # Add a retry for network timeouts
        for attempt in range(3):
            try:
                process_company(company, parser)
                break
            except Exception as e:
                print(f"  ⚠️ Attempt {attempt+1} failed: {e}")
                if attempt == 2:
                    print(f"  ❌ Failed after 3 attempts.")
    
    # Verify the data in board_composition_annual
    print("\n📊 Verifying data in board_composition_annual:")
    for company in test_companies:
        data = supabase.table("board_composition_annual").select("*").eq("company_id", company['id']).eq("fiscal_year", 2024).execute().data
        if data:
            print(f"✅ {company['company_name']}:")
            print(json.dumps(data[0], indent=2))
        else:
            print(f"❌ {company['company_name']}: No data found")

if __name__ == "__main__":
    run_verification()
