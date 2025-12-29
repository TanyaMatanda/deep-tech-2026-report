#!/usr/bin/env python3
"""
Phase 7: Verify Board Tech Fluency
Analyzes board composition to measure tech-fluent director representation
"""

import os
from supabase import create_client, Client, ClientOptions
import toml
import pandas as pd

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
    print("PHASE 7: VERIFY BOARD TECH FLUENCY")
    print("=" * 70)
    print()
    
    # Fetch all companies
    print("📥 Fetching companies...")
    res_companies = supabase.table("companies").select("id, company_name, primary_sector, is_verified_cohort").execute()
    companies = res_companies.data
    print(f"✓ Found {len(companies):,} companies")
    
    # Fetch board composition data
    print("📥 Fetching board composition data...")
    res_board = supabase.table("board_composition_annual").select("company_id, tech_experts, total_directors").execute()
    board_data = res_board.data
    print(f"✓ Found {len(board_data):,} board records")
    
    # Build company -> board mapping
    company_board = {}
    for board in board_data:
        company_id = board['company_id']
        company_board[company_id] = board
    
    # Analyze tech fluency
    print(f"\n📊 TECH FLUENCY ANALYSIS:")
    
    # Overall universe
    companies_with_board_data = [c for c in companies if c['id'] in company_board]
    companies_with_tech_experts = [c for c in companies_with_board_data 
                                   if company_board[c['id']].get('tech_experts', 0) > 0]
    
    total_universe = len(companies_with_board_data)
    with_experts = len(companies_with_tech_experts)
    pct_fluency = (with_experts / total_universe * 100) if total_universe > 0 else 0
    
    print(f"\n  UNIVERSE (All Companies with Board Data):")
    print(f"  - Total: {total_universe:,}")
    print(f"  - With ≥1 Tech Expert: {with_experts:,}")
    print(f"  - Tech Fluency Rate: {pct_fluency:.1f}%")
    
    # Verified cohort
    verified = [c for c in companies if c.get('is_verified_cohort')]
    verified_with_board = [c for c in verified if c['id'] in company_board]
    verified_with_experts = [c for c in verified_with_board 
                            if company_board[c['id']].get('tech_experts', 0) > 0]
    
    total_verified = len(verified_with_board)
    verified_experts = len(verified_with_experts)
    pct_verified = (verified_experts / total_verified * 100) if total_verified > 0 else 0
    
    print(f"\n  VERIFIED COHORT:")
    print(f"  - Total: {total_verified:,}")
    print(f"  - With ≥1 Tech Expert: {verified_experts:,}")
    print(f"  - Tech Fluency Rate: {pct_verified:.1f}%")
    
    # By sector
    print(f"\n  BY SECTOR:")
    sectors = set(c.get('primary_sector', 'Unknown') for c in companies_with_board_data)
    for sector in sorted(sectors):
        sector_companies = [c for c in companies_with_board_data if c.get('primary_sector') == sector]
        sector_with_experts = [c for c in sector_companies 
                              if company_board[c['id']].get('tech_experts', 0) > 0]
        if sector_companies:
            sector_pct = (len(sector_with_experts) / len(sector_companies)) * 100
            print(f"  - {sector:40s}: {sector_pct:5.1f}% ({len(sector_with_experts)}/{len(sector_companies)})")
    
    # Export summary
    summary = {
        'universe_total': total_universe,
        'universe_with_experts': with_experts,
        'universe_fluency_pct': round(pct_fluency, 2),
        'verified_total': total_verified,
        'verified_with_experts': verified_experts,
        'verified_fluency_pct': round(pct_verified, 2)
    }
    
    pd.DataFrame([summary]).to_csv('board_fluency_summary.csv', index=False)
    print(f"\n💾 Exported: board_fluency_summary.csv")
    
    print("\n" + "=" * 70)
    print("✅ PHASE 7 COMPLETE")
    print("=" * 70)

if __name__ == "__main__":
    main()
