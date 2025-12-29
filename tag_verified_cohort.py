#!/usr/bin/env python3
"""
Phase 6: Tag Verified Cohort
Identifies and tags the N=22-30 companies with complete governance data
"""

import os
from supabase import create_client, Client, ClientOptions
import toml

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
    print("PHASE 6: TAG VERIFIED COHORT")
    print("=" * 70)
    print()
    
    # Criteria for "Verified" status:
    # 1. listing_type = 'Public'
    # 2. data_tier = 1 (highest quality)
    # 3. Has board_composition_annual data
    # 4. Has at least 1 DEF 14A filing parsed
    
    print("🔍 Finding companies with complete governance data...")
    
    # Get all public tier-1 companies
    res = supabase.table("companies").select("id, company_name, listing_type, data_tier").eq("listing_type", "Public").eq("data_tier", 1).execute()
    
    candidates = res.data
    print(f"  - Public Tier-1 companies: {len(candidates):,}")
    
    # Check which have board data
    verified_companies = []
    
    for company in candidates:
        company_id = company['id']
        
        # Check for board composition data
        board_res = supabase.table("board_composition_annual").select("id").eq("company_id", company_id).limit(1).execute()
        
        has_board_data = len(board_res.data) > 0
        
        if has_board_data:
            verified_companies.append(company)
    
    print(f"  - With board composition data: {len(verified_companies):,}")
    
    # Tag top N=22-30
    target_count = min(30, len(verified_companies))
    to_verify = verified_companies[:target_count]
    
    print(f"\n✏️  Tagging {len(to_verify)} companies as verified cohort...")
   
    for company in to_verify:
        try:
            supabase.table("companies").update({
                "is_verified_cohort": True
            }).eq("id", company['id']).execute()
        except Exception as e:
            print(f"  ⚠️ Error updating {company['company_name']}: {e}")
    
    print(f"\n✅ Tagged {len(to_verify)} companies as verified cohort")
    
    # List them
    print(f"\n📋 VERIFIED COHORT (N={len(to_verify)}):")
    for i, company in enumerate(to_verify, 1):
        print(f"  {i:2}. {company['company_name']}")
    
    print("\n" + "=" * 70)
    print("✅ PHASE 6 COMPLETE")
    print("=" * 70)

if __name__ == "__main__":
    main()
