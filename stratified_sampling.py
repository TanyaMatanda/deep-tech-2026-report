"""
Stratified Sampling for 20K+ Deep Tech Companies
Selects representative sample across sectors with CIK/SEDAR priority
"""

from supabase import create_client, Client, ClientOptions
import toml
import os
import json
from collections import defaultdict
import random

# Supabase setup
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

# Target distribution based on analysis
SECTOR_TARGETS = {
    'Advanced Technology': 8000,  # 40% - largest sector
    'Biotechnology': 3000,  # 15%
    'Energy & Climate': 2500,  # 12.5%
    'Cybersecurity': 1500,  # 7.5%
    'Agriculture & Food Tech': 1200,  # 6%
    'Advanced Computing': 1000,  # 5%
    'Robotics': 1000,  # 5%
    'Advanced Materials': 800,  # 4%
    'Space Technology': 700,  # 3.5%
    'Quantum Computing': 500,  # 2.5%
    'Other': 800  # 4% - catch-all
}

def fetch_sector_companies(sector: str, limit: int = 10000):
    """Fetch all companies in a sector"""
    companies = []
    offset = 0
    batch_size = 1000
    
    while len(companies) < limit:
        if sector == 'Other':
            # Get companies not in main sectors
            batch = supabase.table('companies')\
                .select('id, company_name, ticker_symbol, cik, sedar_id, primary_sector')\
                .not_.in_('primary_sector', list(SECTOR_TARGETS.keys())[:-1])\
                .range(offset, offset + batch_size - 1)\
                .execute()
        else:
            batch = supabase.table('companies')\
                .select('id, company_name, ticker_symbol, cik, sedar_id, primary_sector')\
                .eq('primary_sector', sector)\
                .range(offset, offset + batch_size - 1)\
                .execute()
        
        if not batch.data:
            break
        
        companies.extend(batch.data)
        offset += batch_size
        
        if len(batch.data) < batch_size:
            break
    
    return companies

def stratified_sample(sector: str, target_count: int, all_companies: list):
    """
    Sample companies with priority:
    1. Companies with CIK/SEDAR (can extract compensation)
    2. PubliclyTraded companies
    3. Random from remaining
    """
    
    # Separate by data availability
    with_filing_id = [c for c in all_companies if c.get('cik') or c.get('sedar_id')]
    without_filing_id = [c for c in all_companies if not (c.get('cik') or c.get('sedar_id'))]
    
    print(f'\n  {sector}:')
    print(f'    Total available: {len(all_companies):,}')
    print(f'    With CIK/SEDAR: {len(with_filing_id):,}')
    print(f'    Without: {len(without_filing_id):,}')
    
    # Take all with filing IDs first (priority)
    selected = with_filing_id[:target_count]
    
    # Fill remaining from others
    remaining_needed = target_count - len(selected)
    if remaining_needed > 0 and without_filing_id:
        # Randomly sample from remaining
        sample_size = min(remaining_needed, len(without_filing_id))
        selected.extend(random.sample(without_filing_id, sample_size))
    
    print(f'    Selected: {len(selected):,} ({len([c for c in selected if c.get("cik") or c.get("sedar_id")]):,} with filing IDs)')
    
    return selected

def run_stratified_sampling():
    """Run complete stratified sampling"""
    
    print('='*60)
    print('STRATIFIED SAMPLING FOR 20K+ DEEP TECH COMPANIES')
    print('='*60)
    
    all_selected = []
    sector_breakdown = {}
    
    for sector, target in SECTOR_TARGETS.items():
        print(f'\nFetching {sector} companies...')
        companies = fetch_sector_companies(sector, limit=target * 3)  # Fetch 3x for better selection
        
        if not companies:
            print(f'  ⚠️  No companies found for {sector}')
            continue
        
        # Sample from this sector
        selected = stratified_sample(sector, target, companies)
        all_selected.extend(selected)
        
        sector_breakdown[sector] = {
            'target': target,
            'selected': len(selected),
            'with_filing_ids': len([c for c in selected if c.get('cik') or c.get('sedar_id')])
        }
    
    print('\n' + '='*60)
    print('SAMPLING COMPLETE')
    print('='*60)
    print(f'\nTotal selected: {len(all_selected):,}')
    print(f'Companies with filing IDs: {len([c for c in all_selected if c.get("cik") or c.get("sedar_id")]):,}')
    
    # Save selected company IDs
    selected_ids = [c['id'] for c in all_selected]
    
    with open('backups/selected_companies_20k.json', 'w') as f:
        json.dump({
            'total_selected': len(all_selected),
            'sector_breakdown': sector_breakdown,
            'company_ids': selected_ids
        }, f, indent=2)
    
    print(f'\n✅ Saved to: backups/selected_companies_20k.json')
    
    # Also save full company details for reference
    with open('backups/selected_companies_details.json', 'w') as f:
        json.dump(all_selected, f, indent=2)
    
    print(f'✅ Details saved to: backups/selected_companies_details.json')
    
    return all_selected, sector_breakdown

if __name__ == "__main__":
    random.seed(42)  # Reproducible sampling
    selected, breakdown = run_stratified_sampling()
    
    print(f'\n\n📊 SECTOR BREAKDOWN:')
    for sector, stats in breakdown.items():
        pct_with_filing = (stats['with_filing_ids'] / stats['selected'] * 100) if stats['selected'] > 0 else 0
        print(f'  {sector}: {stats["selected"]:,} companies ({pct_with_filing:.1f}% with filing IDs)')
