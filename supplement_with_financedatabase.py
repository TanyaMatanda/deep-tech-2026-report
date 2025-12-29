#!/usr/bin/env python3
"""
Supplement with FinanceDatabase - FIXED CIK Lookup
Uses SEC's official company_tickers.json for reliable ticker-to-CIK mapping
"""

import financedatabase as fd
import pandas as pd
import requests
from supabase import create_client, ClientOptions
import toml
import time

# Configuration
secrets = toml.load("dashboard/.streamlit/secrets.toml")
supabase = create_client(secrets['SUPABASE_URL'], secrets['SUPABASE_KEY'], options=ClientOptions(schema='vendor_governance'))

# Deep tech industry mappings - focused on key sectors
DEEP_TECH_INDUSTRIES = {
    'Biotechnology': ['Pharmaceuticals, Biotechnology & Life Sciences'],
    'Advanced Computing and AI': ['Software & Services'],
    'Semi Conductors and AI': ['Semiconductors & Semiconductor Equipment'],
    'Energy and Climate': ['Energy'],
    'Advanced Materials': ['Materials'],
    'Cybersecurity Cryptography': ['Software & Services'],
}

def load_sec_ticker_cik_mapping():
    """Load official SEC ticker-to-CIK mapping"""
    print("📥 Downloading SEC ticker-CIK mapping...")
    url = "https://www.sec.gov/files/company_tickers.json"
    headers = {'User-Agent': 'Proxy Season Report research@example.com'}
    
    response = requests.get(url, headers=headers)
    data = response.json()
    
    # Create ticker -> CIK mapping
    ticker_to_cik = {}
    for item in data.values():
        ticker = item['ticker'].upper()
        cik = str(item['cik_str']).zfill(10)
        ticker_to_cik[ticker] = cik
    
    print(f"✓ Loaded {len(ticker_to_cik):,} ticker-CIK mappings")
    return ticker_to_cik

def main():
    print("=" * 70)
    print("SUPPLEMENTING WITH FINANCEDATABASE (FIXED)")
    print("=" * 70)
    print()
    
    # Load SEC mapping first
    ticker_to_cik = load_sec_ticker_cik_mapping()
    
    # Initialize FinanceDatabase
    print("\n📥 Loading FinanceDatabase...")
    equities = fd.Equities()
    
    # Get all equities
    print("📥 Fetching all equities...")
    all_equities = equities.select()
    print(f"✓ Total equities: {len(all_equities):,}")
    
    # Filter for deep tech
    print("\n🔍 Filtering for deep tech industries...")
    deep_tech = []
    
    for sector, industries in DEEP_TECH_INDUSTRIES.items():
        for industry in industries:
            filtered = all_equities[all_equities['industry_group'] == industry]
            for ticker, row in filtered.iterrows():
                # Skip if ticker is NaN
                if pd.isna(ticker) or not isinstance(ticker, str):
                    continue
                    
                deep_tech.append({
                    'ticker': ticker.upper(),
                    'name': row.get('name', ticker),
                    'sector': sector,
                    'industry': industry,
                    'country': row.get('country', 'Unknown')
                })
    
    print(f"✓ Found {len(deep_tech):,} deep tech companies")
    
    # Get existing tickers to avoid duplicates
    print("\n📥 Checking existing companies...")
    existing_res = supabase.table('companies').select('ticker_symbol,cik').execute()
    existing_tickers = set([c['ticker_symbol'] for c in existing_res.data if c.get('ticker_symbol')])
    existing_ciks = set([c['cik'] for c in existing_res.data if c.get('cik')])
    print(f"✓ {len(existing_tickers):,} companies already in database")
    
    # Filter: new tickers with CIK available
    candidates = []
    for company in deep_tech:
        ticker = company['ticker']
        if ticker not in existing_tickers and ticker in ticker_to_cik:
            cik = ticker_to_cik[ticker]
            if cik not in existing_ciks:
                company['cik'] = cik
                candidates.append(company)
    
    print(f"✓ {len(candidates):,} new companies with CIK available")
    
    # Limit to reach 5,000 total
    current_count = len(existing_tickers)
    target_count = 5000
    needed = target_count - current_count
    
    to_add = candidates[:needed]
    print(f"✓ Will add {len(to_add):,} companies (to reach {target_count:,} total)")
    
    # Insert into database
    print(f"\n💾 Inserting companies into database...")
    added = 0
    failed = 0
    
    for i, company in enumerate(to_add):
        if (i + 1) % 100 == 0:
            print(f"  Progress: {i+1}/{len(to_add)} | Added: {added} | Failed: {failed}")
        
        try:
            supabase.table('companies').insert({
                'company_name': company['name'],
                'ticker_symbol': company['ticker'],
                'cik': company['cik'],
                'listing_type': 'Public',
                'primary_sector': company['sector'],
                'incorporation_country': company['country'],
                'data_tier': 1
            }).execute()
            added += 1
        except Exception as e:
            failed += 1
        
        time.sleep(0.01)  # Small delay to avoid overwhelming DB
    
    print(f"\n✅ Supplement complete!")
    print(f"  - New companies added: {added:,}")
    print(f"  - Failed: {failed:,}")
    print(f"  - Total in database: {current_count + added:,}")
    
    print("\n" + "=" * 70)

if __name__ == "__main__":
    main()
