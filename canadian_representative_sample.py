"""
Canadian Representative Sample Selector
Matches US subsector distribution for comparable dataset
"""

from supabase import create_client, Client, ClientOptions
import toml
import os
import json
import random

# Supabase setup
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

def get_us_sector_distribution():
    """Get actual subsector distribution from extracted US companies"""
    
    print("📊 Analyzing US company extraction...")
    
    # Get all companies with compensation data
    us_records = supabase.table('executive_compensation_annual')\
        .select('company_id')\
        .execute()
    
    unique_company_ids = list(set([r['company_id'] for r in us_records.data]))
    
    print(f"Found {len(unique_company_ids)} US companies with data\n")
    
    # Get their sectors
    sectors = {}
    batch_size = 100
    
    for i in range(0, len(unique_company_ids), batch_size):
        batch = unique_company_ids[i:i+batch_size]
        
        companies = supabase.table('companies')\
            .select('id, primary_sector')\
            .in_('id', batch)\
            .execute()
        
        for c in companies.data:
            sector = c.get('primary_sector', 'Unknown')
            sectors[sector] = sectors.get(sector, 0) + 1
    
    # Sort by count
    sorted_sectors = sorted(sectors.items(), key=lambda x: x[1], reverse=True)
    
    print("US Subsector Distribution:")
    for sector, count in sorted_sectors:
        pct = (count / len(unique_company_ids)) * 100
        print(f"  {sector}: {count} ({pct:.1f}%)")
    
    return dict(sorted_sectors)

def select_canadian_representative_sample(us_distribution, target_total=1000):
    """
    Select Canadian companies matching US distribution
    
    Args:
        us_distribution: Dict of sector -> count from US
        target_total: Total Canadian companies to select
    """
    
    print(f"\n🇨🇦 Selecting {target_total} Canadian companies...\n")
    
    # Calculate target per sector based on US proportions
    total_us = sum(us_distribution.values())
    canadian_targets = {}
    
    for sector, us_count in us_distribution.items():
        proportion = us_count / total_us
        canadian_targets[sector] = int(target_total * proportion)
    
    print("Target Canadian distribution:")
    for sector, target in canadian_targets.items():
        print(f"  {sector}: {target}")
    
    # Select Canadian companies per sector
    selected = []
    
    for sector, target in canadian_targets.items():
        if target == 0:
            continue
        
        # Get Canadian companies in this sector
        # Prioritize those with stock exchange (more likely to have filings)
        canadian = supabase.table('companies')\
            .select('id, company_name, ticker_symbol, stock_exchange')\
            .eq('primary_sector', sector)\
            .ilike('jurisdiction', '%CA%')\
            .limit(target * 3)\
            .execute()
        
        if not canadian.data:
            print(f"  ⚠️  No Canadian companies found in {sector}")
            continue
        
        # Prioritize listed companies
        listed = [c for c in canadian.data if c.get('stock_exchange')]
        unlisted = [c for c in canadian.data if not c.get('stock_exchange')]
        
        # Take from listed first, then unlisted
        sector_selection = listed[:target]
        if len(sector_selection) < target:
            remaining = target - len(sector_selection)
            sector_selection.extend(unlisted[:remaining])
        
        selected.extend(sector_selection)
        
        listed_count = len([c for c in sector_selection if c.get('stock_exchange')])
        print(f"  ✅ {sector}: selected {len(sector_selection)} ({listed_count} listed)")
    
    print(f"\n📊 Total selected: {len(selected)} Canadian companies")
    
    # Save selection
    selected_ids = [c['id'] for c in selected]
    
    with open('backups/canadian_representative_sample.json', 'w') as f:
        json.dump({
            'total_selected': len(selected),
            'target': target_total,
            'us_distribution': us_distribution,
            'canadian_targets': canadian_targets,
            'company_ids': selected_ids,
            'companies': selected
        }, f, indent=2)
    
    print(f"✅ Saved to: backups/canadian_representative_sample.json")
    
    return selected

def main():
    """Run representative sample selection"""
    
    print("="*70)
    print("CANADIAN REPRESENTATIVE SAMPLE SELECTOR")
    print("="*70)
    print()
    
    # Get US distribution
    us_dist = get_us_sector_distribution()
    
    # Select Canadian sample (matching proportions, ~1000 companies)
    canadian_sample = select_canadian_representative_sample(us_dist, target_total=1000)
    
    print(f"\n{'='*70}")
    print("SUMMARY")
    print(f"{'='*70}")
    print(f"US companies analyzed: {sum(us_dist.values())}")
    print(f"Canadian companies selected: {len(canadian_sample)}")
    print(f"Listed on exchanges: {len([c for c in canadian_sample if c.get('stock_exchange')])}")
    print(f"\nEstimated Canadian records (10-15% filing rate):")
    est_low = len(canadian_sample) * 0.10 * 3  # 10%, ~3 execs per company
    est_high = len(canadian_sample) * 0.15 * 3  # 15%
    print(f"  {int(est_low)} - {int(est_high)} executive compensation records")

if __name__ == "__main__":
    random.seed(42)  # Reproducible selection
    main()
