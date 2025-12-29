#!/usr/bin/env python3
"""
Phase 1: Reclassify Existing Companies
Applies proper sector classification to the 1,000 companies from Google Patents
"""

import os
from supabase import create_client, Client, ClientOptions
import toml
import pandas as pd

# SEC EDGAR sector keywords (from 2_sec_edgar_collector.py)
SECTOR_KEYWORDS = {
    'Advanced Computing and AI': ['artificial intelligence', 'machine learning', 'neural network', 'deep learning', 'computer vision', 'nlp', 'generative ai', 'cloud computing', 'big data', 'data analytics'],
    'Semi Conductors and AI': ['semiconductor', 'chip', 'processor', 'gpu', 'integrated circuit', 'wafer', 'fabless', 'foundry', 'microchip', 'transistor'],
    'Autonomous Systems': ['autonomous', 'self-driving', 'lidar', 'robotics', 'drone', 'uav', 'unmanned', 'automation', 'robot'],
    'Energy and Climate': ['renewable', 'solar', 'wind', 'battery', 'hydrogen', 'energy storage', 'clean tech', 'carbon capture', 'electric vehicle', 'ev', 'grid'],
    'Biotechnology': ['biotechnology', 'biotech', 'genomics', 'gene editing', 'crispr', 'therapeutics', 'pharmaceutical', 'drug discovery', 'clinical stage', 'bioscience'],
    'Advanced Materials': ['advanced materials', 'nanotechnology', 'graphene', 'composite', 'alloy', 'polymer', 'biomaterial', 'superconductor'],
    'Quantum and Photonics': ['quantum', 'photonics', 'laser', 'optic', 'qubit', 'superposition', 'entanglement', 'light-based'],
    'Space and Aerospace': ['space', 'satellite', 'rocket', 'aerospace', 'launch vehicle', 'orbit', 'propulsion', 'aviation'],
    'Cybersecurity Cryptography': ['cybersecurity', 'encryption', 'cryptography', 'network security', 'info sec', 'data protection', 'firewall', 'zero trust'],
    'Cross Domain Enablement': ['technology', 'software', 'platform', 'digital', 'systems', 'solutions', 'internet', 'communications', 'network', 'mobile']
}

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

def classify_company(name):
    """
    Classify company into Deep Tech sector based on name
    Returns: (sector, tags_array)
    """
    name_lower = name.lower()
    
    # Check specific sectors first (priority over Cross Domain)
    for sector, keywords in SECTOR_KEYWORDS.items():
        if sector == 'Cross Domain Enablement': 
            continue
        if any(k in name_lower for k in keywords):
            # Build technology_tags array
            tags = ['patents', 'innovation']
            # Add sector-specific tags
            for kw in keywords:
                if kw in name_lower:
                    tags.append(kw)
                    break
            return sector, list(set(tags))[:5]  # Max 5 tags
    
    # Check Cross Domain last
    if any(k in name_lower for k in SECTOR_KEYWORDS['Cross Domain Enablement']):
        return 'Cross Domain Enablement', ['patents', 'innovation', 'technology']
    
    return 'Advanced Technology', ['patents', 'innovation']

def main():
    print("=" * 70)
    print("PHASE 1: RECLASSIFY EXISTING COMPANIES")
    print("=" * 70)
    print()
    
    # Fetch all companies
    print("📥 Fetching companies from database...")
    res = supabase.table("companies").select("id, company_name, primary_sector, technology_tags").execute()
    
    if not res.data:
        print("❌ No companies found.")
        return
    
    companies = res.data
    print(f"✓ Found {len(companies):,} companies\n")
    
    # Classify and update
    print("🔍 Reclassifying companies...")
    updated_count = 0
    sector_counts = {}
    
    for i, company in enumerate(companies):
        if (i + 1) % 100 == 0:
            print(f"  Progress: {i+1}/{len(companies)}")
        
        name = company['company_name']
        new_sector, new_tags = classify_company(name)
        
        # Track sector distribution
        sector_counts[new_sector] = sector_counts.get(new_sector, 0) + 1
        
        # Update if different from current
        current_sector = company.get('primary_sector', '')
        if current_sector != new_sector:
            try:
                supabase.table("companies").update({
                    "primary_sector": new_sector,
                    "technology_tags": new_tags
                }).eq("id", company['id']).execute()
                updated_count += 1
            except Exception as e:
                print(f"  ⚠️ Error updating {name}: {e}")
    
    print(f"\n✅ Reclassification complete!")
    print(f"  - Updated: {updated_count:,} companies")
    print(f"  - Unchanged: {len(companies) - updated_count:,} companies")
    
    print(f"\n📊 SECTOR DISTRIBUTION:")
    for sector, count in sorted(sector_counts.items(), key=lambda x: x[1], reverse=True):
        pct = (count / len(companies)) * 100
        print(f"  {sector:40s}: {count:5,} ({pct:5.1f}%)")
    
    # Export sector breakdowns
    print(f"\n💾 Exporting sector CSVs...")
    df = pd.DataFrame(companies)
    
    # Classify all
    df['new_sector'] = df['company_name'].apply(lambda n: classify_company(n)[0])
    
    # Export AI companies
    ai_companies = df[df['new_sector'].isin(['Advanced Computing and AI', 'Semi Conductors and AI'])]
    if len(ai_companies) > 0:
        ai_companies[['company_name', 'new_sector']].to_csv('ai_companies_reclassified.csv', index=False)
        print(f"  ✓ ai_companies_reclassified.csv ({len(ai_companies):,} companies)")
    
    # Export Quantum
    quantum_companies = df[df['new_sector'] == 'Quantum and Photonics']
    if len(quantum_companies) > 0:
        quantum_companies[['company_name', 'new_sector']].to_csv('quantum_companies_reclassified.csv', index=False)
        print(f"  ✓ quantum_companies_reclassified.csv ({len(quantum_companies):,} companies)")
    
    # Export Biotech
    biotech_companies = df[df['new_sector'] == 'Biotechnology']
    if len(biotech_companies) > 0:
        biotech_companies[['company_name', 'new_sector']].to_csv('biotech_companies_reclassified.csv', index=False)
        print(f"  ✓ biotech_companies_reclassified.csv ({len(biotech_companies):,} companies)")
    
    print("\n" + "=" * 70)
    print("✅ PHASE 1 COMPLETE")
    print("=" * 70)

if __name__ == "__main__":
    main()
