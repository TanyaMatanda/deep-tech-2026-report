#!/usr/bin/env python3
"""
Select 5,000 Deep Tech Companies for Governance Extraction
Ensures representative coverage across all 10 deep tech sectors
"""

import os
import toml
from supabase import create_client, Client, ClientOptions
from collections import Counter
import pandas as pd

# Configuration
try:
    secrets = toml.load("dashboard/.streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

# Deep Tech sectors
DEEP_TECH_SECTORS = [
    'Advanced Computing and AI',
    'Semi Conductors and AI',
    'Autonomous Systems',
    'Energy and Climate',
    'Biotechnology',
    'Advanced Materials',
    'Quantum and Photonics',
    'Space and Aerospace',
    'Cybersecurity Cryptography',
    'Cross Domain Enablement'
]

# Target distribution for 5,000 companies
SECTOR_TARGETS = {
    'Advanced Computing and AI': 1200,
    'Biotechnology': 800,
    'Cross Domain Enablement': 800,
    'Energy and Climate': 600,
    'Semi Conductors and AI': 400,
    'Cybersecurity Cryptography': 400,
    'Autonomous Systems': 300,
    'Advanced Materials': 250,
    'Space and Aerospace': 150,
    'Quantum and Photonics': 100
}

def main():
    print("=" *70)
    print("SELECTING 5,000 DEEP TECH COMPANIES")
    print("=" * 70)
    print()
    
    # Get all public companies with CIK
    print("📥 Fetching all public companies with CIK...")
    all_companies = []
    offset = 0
    page_size = 1000
    
    while offset < 100000:  # Safety limit
        res = supabase.table("companies").select("id, company_name, cik, ticker_symbol, primary_sector, incorporation_country").eq("listing_type", "Public").not_.is_("cik", "null").range(offset, offset + page_size - 1).execute()
        
        if not res.data:
            break
        
        all_companies.extend(res.data)
        offset += page_size
        print(f"  Fetched {len(all_companies):,} companies...")
        
        if len(res.data) < page_size:
            break
    
    print(f"✓ Total companies with CIK: {len(all_companies):,}")
    
    # Group by sector
    by_sector = {}
    for company in all_companies:
        sector = company.get('primary_sector', 'Unknown')
        if sector not in by_sector:
            by_sector[sector] = []
        by_sector[sector].append(company)
    
    print(f"\n📊 SECTOR DISTRIBUTION:")
    for sector in sorted(by_sector.keys()):
        print(f"  {sector:40s}: {len(by_sector[sector]):6,} available")
    
    # Select companies per sector
    print(f"\n🎯 SELECTING 5,000 COMPANIES:")
    selected = []
    
    for sector, target in SECTOR_TARGETS.items():
        available = by_sector.get(sector, [])
        actual = min(target, len(available))
        selected.extend(available[:actual])
        print(f"  {sector:40s}: {actual:4,} / {target:4,} (target)")
    
    print(f"\n✓ Total selected: {len(selected):,} companies")
    
    # Export to CSV for reference
    df = pd.DataFrame(selected)
    df.to_csv('selected_5000_companies.csv', index=False)
    print(f"\n💾 Exported to: selected_5000_companies.csv")
    
    # Create ID list file for extraction script
    with open('selected_5000_ids.txt', 'w') as f:
        for company in selected:
            f.write(f"{company['id']}\\n")
    
    print(f"💾 Exported IDs to: selected_5000_ids.txt")
    
    print(f"\n{'=' * 70}")
    print("✅ SELECTION COMPLETE")
    print("=" * 70)

if __name__ == "__main__":
    main()
