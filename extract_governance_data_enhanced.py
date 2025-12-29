#!/usr/bin/env python3
"""
Phase 5: Extract Governance Data Enhanced
Uses SEC Filing Parser to extract real governance data from DEF 14A proxy filings
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
    print("PHASE 5: EXTRACT GOVERNANCE DATA (ENHANCED)")
    print("=" * 70)
    print()
    
    # Get all public companies with CIK (with pagination)
    print("📥 Fetching public companies...")
    
    all_companies = []
    page_size = 1000
    offset = 0
    
    while True:
        res = supabase.table("companies").select("id, company_name, cik, ticker_symbol").eq("listing_type", "Public").not_.is_("cik", "null").range(offset, offset + page_size - 1).execute()
        
        if not res.data:
            break
            
        all_companies.extend(res.data)
        offset += page_size
        
        print(f"  Fetched {len(all_companies):,} companies...")
        
        if len(res.data) < page_size:
            break
    
    companies = all_companies
    print(f"✓ Found {len(companies):,} public companies with CIK total")
    
    if len(companies) == 0:
        print("⚠️ No companies with CIK found. Run SEC collector first.")
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
                # Insert board composition data - USE ALL AVAILABLE COLUMNS
                board_data = {
                    'company_id': company_id,
                    'fiscal_year': 2024,
                    'total_directors': None,
                    'independent_directors': int(factors.get('board_independence_pct', 0) / 10) if factors.get('board_independence_pct') else None,
                    'women_percentage': factors.get('board_diversity_pct'),
                    'tech_experts': 1 if factors.get('board_ai_expertise') else 0,
                    'has_ai_oversight_committee': factors.get('has_ai_ethics_board', False),
                    'ceo_is_board_chair': not factors.get('split_chair_ceo', True),
                    'independent_board_chair': factors.get('independent_board_chair', False),
                    'women_board_chair': factors.get('women_board_chair', False)
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
    
    print(f"\n✅ Governance extraction complete!")
    print(f"  - Processed: {processed:,}/{len(companies):,}")
    print(f"  - Successfully extracted: {extracted:,}")
    print(f"  - Failed: {failed:,}")
    print(f"  - Success rate: {extracted/processed*100 if processed > 0 else 0:.1f}%")
    
    # Summary stats
    print(f"\n📊 GOVERNANCE DATA SUMMARY:")
    res_board = supabase.table("board_composition_annual").select("tech_experts, women_percentage, has_ai_oversight_committee").execute()
    
    if res_board.data:
        board_records = res_board.data
        print(f"  - Total board records: {len(board_records):,}")
        
        with_tech = sum(1 for r in board_records if (r.get('tech_experts') or 0) > 0)
        print(f"  - With tech experts: {with_tech:,} ({with_tech/len(board_records)*100:.1f}%)")
        
        with_ai_committee = sum(1 for r in board_records if r.get('has_ai_oversight_committee'))
        print(f"  - With AI oversight committee: {with_ai_committee:,} ({with_ai_committee/len(board_records)*100:.1f}%)")
        
        women_pcts = [r.get('women_percentage') for r in board_records if r.get('women_percentage')]
        if women_pcts:
            avg_women = sum(women_pcts) / len(women_pcts)
            print(f"  - Avg women on boards: {avg_women:.1f}%")
    
    print("\n" + "=" * 70)
    print("✅ PHASE 5 COMPLETE")
    print("=" * 70)

if __name__ == "__main__":
    main()
