#!/usr/bin/env python3
"""
Second Batch: Extract governance from 3,000 additional deep tech companies
Auto-launches after first batch completes
"""

import os
import sys
sys.path.append('/Users/tanyamatanda/Desktop/Proxy Season 2026/collectors')

from supabase import create_client, Client, ClientOptions
import toml
from sec_filing_parser import SECFilingParser
import time

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

if not url or not key:
    print("❌ Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

def main():
    print("=" * 70)
    print("PHASE 5B: SECOND BATCH GOVERNANCE EXTRACTION")
    print("=" * 70)
    print()
    
    # Get companies already processed
    print("📥 Fetching already-processed companies...")
    processed_res = supabase.table("board_composition_annual").select("company_id").execute()
    processed_ids = set([r['company_id'] for r in processed_res.data])
    print(f"✓ Already processed: {len(processed_ids):,} companies")
    
    # Get remaining public companies with CIK (paginated)
    print("\n📥 Fetching remaining companies...")
    all_companies = []
    page_size = 1000
    offset = 0
    
    while len(all_companies) < 3500 and offset < 10000:  # Safety limit
        res = supabase.table("companies").select("id, company_name, cik, ticker_symbol").eq("listing_type", "Public").not_.is_("cik", "null").range(offset, offset + page_size - 1).execute()
        
        if not res.data:
            break
        
        # Filter out already processed
        new_companies = [c for c in res.data if c['id'] not in processed_ids]
        all_companies.extend(new_companies)
        offset += page_size
        
        print(f"  Fetched {len(all_companies):,} unprocessed companies...")
        
        if len(res.data) < page_size:
            break
    
    # Take first 3,000
    companies = all_companies[:3000]
    print(f"✓ Found {len(companies):,} companies for second batch")
    
    if len(companies) == 0:
        print("⚠️ No new companies to process.")
        return
    
    # Initialize parser
    parser = SECFilingParser()
    
    # Process each company
    print(f"\n🔍 Extracting governance data...")
    print(f"⏱️  Estimated time: {len(companies) * 0.5 / 60:.1f} minutes\n")
    
    processed = 0
    extracted = 0
    failed = 0
    
    for i, company in enumerate(companies):
        company_id = company['id']
        company_name = company['company_name']
        cik = company['cik']
        
        if (i + 1) % 10 == 0:
            print(f"  Progress: {i+1}/{len(companies)} | Extracted: {extracted} | Failed: {failed}")
        
        try:
            # Extract all governance factors
            factors = parser.extract_all_factors(cik, company_name)
            
            if factors.get('def14a_url') == 'Found via new API':
                # Insert board composition data with robust null checking
                # Fix: Prevent NoneType comparison errors
                indep_pct = factors.get('board_independence_pct')
                board_data = {
                    'company_id': company_id,
                    'fiscal_year': 2024,
                    'independent_directors': int(indep_pct / 10) if indep_pct is not None else None,
                    'women_percentage': factors.get('board_diversity_pct'),
                    'tech_experts': 1 if factors.get('board_ai_expertise') else 0,
                    'has_ai_oversight_committee': factors.get('has_ai_ethics_board', False),
                    'ceo_is_board_chair': not factors.get('split_chair_ceo', True),
                    'overboarded_directors_count': factors.get('overboarded_directors_count', 0)
                }
                
                # Remove None values
                board_data = {k: v for k, v in board_data.items() if v is not None}
                
                try:
                    supabase.table("board_composition_annual").upsert(
                        board_data, 
                        on_conflict="company_id, fiscal_year"
                    ).execute()
                    extracted += 1
                except Exception as e:
                    print(f"  ⚠️ Error inserting board data for {company_name}: {e}")
                    failed += 1
            else:
                failed += 1
            
            processed += 1
            
        except Exception as e:
            print(f"  ⚠️ Error processing {company_name}: {e}")
            failed += 1
        
        # Rate limit: SEC allows 10 requests/second
        time.sleep(0.25)  # Be conservative: 4 requests/second
    
    print(f"\n✅ Second batch extraction complete!")
    print(f"  - Processed: {processed:,}/{len(companies):,}")
    print(f"  - Successfully extracted: {extracted:,}")
    print(f"  - Failed: {failed:,}")
    print(f"  - Success rate: {extracted/processed*100 if processed > 0 else 0:.1f}%")
    
    # Final stats
    print(f"\n📊 TOTAL GOVERNANCE DATA:")
    res_final = supabase.table("board_composition_annual").select("id", count="exact").execute()
    print(f"  - Total board records: {res_final.count:,}")
    
    print("\n" + "=" * 70)
    print("✅ SECOND BATCH COMPLETE")
    print("=" * 70)

if __name__ == "__main__":
    main()
