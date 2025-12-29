#!/usr/bin/env python3
"""
Update Women Percentage Data
Re-runs extraction for women_percentage using improved regex patterns
Targeting companies with missing data for 2024/2025
"""

import os
import time
import toml
from supabase import create_client, ClientOptions
from collectors.sec_filing_parser import SECFilingParser

# Configuration
try:
    secrets = toml.load("dashboard/.streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase = create_client(url, key, options=options)

def main():
    print("=" * 70)
    print("UPDATING WOMEN PERCENTAGE DATA")
    print("=" * 70)
    
    parser = SECFilingParser()
    
    # Get companies with missing women_percentage for 2024
    print("📥 Fetching companies with missing women data...")
    
    # We need to join companies and board_composition_annual
    # But supabase-py doesn't support complex joins easily.
    # So we'll fetch board records with null women_percentage and then get CIKs.
    
    res = supabase.table("board_composition_annual")\
        .select("company_id, fiscal_year")\
        .eq("fiscal_year", 2024)\
        .is_("women_percentage", "null")\
        .execute()
        
    missing_records = res.data
    print(f"✓ Found {len(missing_records):,} records with missing women data for 2024")
    
    if not missing_records:
        print("No records to update.")
        return

    # Get CIKs for these companies
    company_ids = [r['company_id'] for r in missing_records]
    
    # Fetch companies in batches
    batch_size = 1000
    companies_map = {}
    
    for i in range(0, len(company_ids), batch_size):
        batch_ids = company_ids[i:i+batch_size]
        c_res = supabase.table("companies")\
            .select("id, company_name, cik")\
            .in_("id", batch_ids)\
            .not_.is_("cik", "null")\
            .execute()
        
        for c in c_res.data:
            companies_map[c['id']] = c
            
    print(f"✓ Found {len(companies_map):,} companies with CIKs to process")
    
    # Process updates
    updated_count = 0
    failed_count = 0
    no_data_count = 0
    
    print("\n🚀 Starting update process...")
    
    for i, record in enumerate(missing_records):
        company_id = record['company_id']
        if company_id not in companies_map:
            continue
            
        company = companies_map[company_id]
        cik = company['cik']
        name = company['company_name']
        
        if (i+1) % 10 == 0:
            print(f"  Progress: {i+1}/{len(missing_records)} | Updated: {updated_count} | No Data: {no_data_count}")
            
        try:
            # Fetch filing text
            text = parser.fetch_filing(cik, 'DEF 14A')
            
            if text:
                # Clean and extract
                cleaned_text = parser.clean_text(text)
                women_pct = parser.extract_board_diversity(cleaned_text)
                
                if women_pct is not None:
                    # Update database
                    supabase.table("board_composition_annual").update({
                        "women_percentage": women_pct
                    }).eq("company_id", company_id).eq("fiscal_year", 2024).execute()
                    
                    print(f"  ✅ Updated {name}: {women_pct}%")
                    updated_count += 1
                else:
                    no_data_count += 1
            else:
                no_data_count += 1
                
        except Exception as e:
            print(f"  ❌ Error processing {name}: {e}")
            failed_count += 1
            
        # Rate limit
        time.sleep(0.25) # 4 requests/sec max
        
    print("\n" + "=" * 70)
    print(f"UPDATE COMPLETE")
    print(f"Updated: {updated_count}")
    print(f"No Data Found: {no_data_count}")
    print(f"Failed: {failed_count}")
    print("=" * 70)

if __name__ == "__main__":
    main()
