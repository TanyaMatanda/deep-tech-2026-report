#!/usr/bin/env python3
"""
Enhanced Company Reclassification Script
Classifies companies based on 10-K business descriptions (not just names)
"""

import os
import sys
sys.path.append('/Users/tanyamatanda/Desktop/Proxy Season 2026/collectors')

from supabase import create_client, Client, ClientOptions
import toml
from sec_filing_parser import SECFilingParser
import re
import time

# Deep Tech Sector Keywords (same as SEC collector)
SECTOR_KEYWORDS = {
    'Advanced Computing and AI': ['artificial intelligence', 'machine learning', 'neural network', 'deep learning', 'computer vision', 'nlp', 'natural language processing', 'generative ai', 'cloud computing', 'big data', 'data analytics', 'ai', 'ml models'],
    'Semi Conductors and AI': ['semiconductor', 'chip', 'processor', 'gpu', 'integrated circuit', 'wafer', 'fabless', 'foundry', 'microchip', 'transistor', 'silicon'],
    'Autonomous Systems': ['autonomous', 'self-driving', 'lidar', 'robotics', 'drone', 'uav', 'unmanned', 'automation', 'robot', 'autonomous vehicle'],
    'Energy and Climate': ['renewable', 'solar', 'wind', 'battery', 'hydrogen', 'energy storage', 'clean tech', 'carbon capture', 'electric vehicle', 'ev', 'grid', 'clean energy', 'geothermal', 'hydroelectric'],
    'Biotechnology': ['biotechnology', 'biotech', 'genomics', 'gene editing', 'crispr', 'therapeutics', 'pharmaceutical', 'drug discovery', 'clinical stage', 'bioscience', 'gene therapy', 'personalized medicine', 'immunotherapy'],
    'Advanced Materials': ['advanced materials', 'nanotechnology', 'graphene', 'composite', 'alloy', 'polymer', 'biomaterial', 'superconductor', 'metamaterial'],
    'Quantum and Photonics': ['quantum', 'photonics', 'laser', 'optic', 'qubit', 'superposition', 'entanglement', 'light-based', 'quantum computing', 'quantum cryptography'],
    'Space and Aerospace': ['space', 'satellite', 'rocket', 'aerospace', 'launch vehicle', 'orbit', 'propulsion', 'aviation', 'spacecraft', 'launch services'],
    'Cybersecurity Cryptography': ['cybersecurity', 'encryption', 'cryptography', 'network security', 'information security', 'data protection', 'firewall', 'zero trust', 'threat detection'],
    'Cross Domain Enablement': ['technology', 'software', 'platform', 'digital', 'systems', 'solutions', 'internet', 'communications', 'network', 'mobile', 'saas', 'paas']
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

def extract_business_section(filing_text):
    """Extract Item 1 Business section from 10-K"""
    if not filing_text:
        return ""
    
    # Pattern to find Item 1 and Item 1A
    pattern = r'ITEM\s+1[\.:]\s*(?:BUSINESS|Description of Business)(.*?)(?:ITEM\s+1A|ITEM\s+2)'
    match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
    
    if match:
        return match.group(1)[:5000]  # First 5000 chars of business section
    
    # Fallback: just take first 5000 chars
    return filing_text[:5000]

def classify_by_description(description):
    """Classify company based on business description"""
    if not description:
        return 'General Market'
    
    desc_lower = description.lower()
    
    # Score each sector
    sector_scores = {}
    for sector, keywords in SECTOR_KEYWORDS.items():
        if sector == 'Cross Domain Enablement':
            continue  # Check this last
        
        score = sum(1 for kw in keywords if kw in desc_lower)
        if score > 0:
            sector_scores[sector] = score
    
    # Return highest scoring sector
    if sector_scores:
        best_sector = max(sector_scores, key=sector_scores.get)
        # Only classify as deep tech if score >= 2 (multiple keyword matches)
        if sector_scores[best_sector] >= 2:
            return best_sector
    
    # Check Cross Domain last
    cross_score = sum(1 for kw in SECTOR_KEYWORDS['Cross Domain Enablement'] if kw in desc_lower)
    if cross_score >= 3:  # Higher threshold for generic tech
        return 'Cross Domain Enablement'
    
    return 'General Market'

def main():
    print("=" * 70)
    print("ENHANCED COMPANY RECLASSIFICATION")
    print("Based on 10-K Business Descriptions")
    print("=" * 70)
    print()
    
    # Get all public companies with CIK
    print("📥 Fetching companies...")
    res = supabase.table("companies").select("id, company_name, cik, primary_sector").eq("listing_type", "Public").not_.is_("cik", "null").execute()
    
    companies = res.data
    print(f"✓ Found {len(companies):,} public companies with CIK")
    
    if len(companies) == 0:
        print("⚠️ No companies with CIK. Run SEC collector first.")
        return
    
    # Initialize parser
    parser = SECFilingParser()
    
    # Process companies
    print(f"\n🔍 Reclassifying companies based on 10-K descriptions...")
    print(f"⏱️  Estimated time: {len(companies) * 0.5 / 60:.1f} minutes\n")
    
    reclassified = 0
    deep_tech_found = 0
    errors = 0
    
    for i, company in enumerate(companies):
        company_id = company['id']
        company_name = company['company_name']
        cik = company['cik']
        current_sector = company.get('primary_sector', 'Unknown')
        
        if (i + 1) % 50 == 0:
            print(f"  Progress: {i+1}/{len(companies)} | Reclassified: {reclassified} | Deep Tech: {deep_tech_found}")
        
        try:
            # Fetch 10-K
            filing_text = parser.fetch_filing(cik, '10-K', years_back=1)
            
            if not filing_text:
                errors += 1
                continue
            
            # Extract business description
            business_desc = extract_business_section(filing_text)
            
            # Classify
            new_sector = classify_by_description(business_desc)
            
            # Update if different
            if new_sector != current_sector:
                supabase.table("companies").update({
                    "primary_sector": new_sector,
                    "technology_tags": [new_sector, 'reclassified_by_10k']
                }).eq("id", company_id).execute()
                
                reclassified += 1
                
                if new_sector != 'General Market':
                    deep_tech_found += 1
            
            # Rate limit
            time.sleep(0.12)  # SEC limit: 10 req/sec
            
        except Exception as e:
            print(f"  ⚠️ Error processing {company_name}: {e}")
            errors += 1
    
    print(f"\n✅ Reclassification complete!")
    print(f"  - Total processed: {len(companies):,}")
    print(f"  - Reclassified: {reclassified:,}")
    print(f"  - New deep tech found: {deep_tech_found:,}")
    print(f"  - Errors: {errors:,}")
    
    # Final sector breakdown
    print(f"\n📊 FINAL SECTOR DISTRIBUTION:")
    res_final = supabase.table("companies").select("primary_sector").execute()
    
    from collections import Counter
    sectors = Counter([c.get('primary_sector', 'Unknown') for c in res_final.data])
    
    for sector, count in sorted(sectors.items(), key=lambda x: x[1], reverse=True):
        pct = (count / len(res_final.data)) * 100
        print(f"  {sector:40s}: {count:5,} ({pct:5.1f}%)")
    
    deep_tech_total = sum(count for sector, count in sectors.items() if sector not in ['General Market', 'Unknown'])
    print(f"\n  🎯 Total Deep Tech: {deep_tech_total:,} ({deep_tech_total/len(res_final.data)*100:.1f}%)")
    
    print("\n" + "=" * 70)
    print("✅ ENHANCED RECLASSIFICATION COMPLETE")
    print("=" * 70)

if __name__ == "__main__":
    main()
