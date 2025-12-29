"""
Fix Jurisdiction Data Issues

This script corrects jurisdiction mismatches in the companies table:
1. Companies with incorporation_country='US' but jurisdiction='Canada' -> set jurisdiction='USA'
2. Companies with NULL jurisdiction -> populate from incorporation_country
"""

import sys
import os
sys.path.append(os.path.join(os.path.dirname(__file__), 'dashboard'))
from db_connection import init_connection

def fix_jurisdiction_data():
    supabase = init_connection()
    if not supabase:
        print("❌ Failed to connect to database")
        return
    
    print("Starting jurisdiction data fix...")
    print("="*80)
    
    # Fix 1: Companies with US incorporation but Canada jurisdiction
    print("\n1. Fixing US companies incorrectly marked as Canada...")
    result1 = supabase.table('companies').update({
        'jurisdiction': 'USA'
    }).eq('incorporation_country', 'US').eq('jurisdiction', 'Canada').execute()
    
    print(f"✓ Fixed {len(result1.data)} companies with US -> Canada mismatch")
    
    # Fix 2: Populate NULL jurisdictions from incorporation_country
    print("\n2. Populating NULL jurisdictions from incorporation_country...")
    
    # Get companies with NULL jurisdiction
    null_juris = supabase.table('companies').select('id, incorporation_country').is_('jurisdiction', 'null').execute()
    
    # Update in batches
    updates_made = 0
    for row in null_juris.data:
        inc_country = row.get('incorporation_country')
        if inc_country:
            # Normalize country codes to jurisdiction format
            jurisdiction = inc_country
            if inc_country in ['US', 'USA']:
                jurisdiction = 'USA'
            elif inc_country in ['CAN', 'CA', 'Canada']:
                jurisdiction = 'Canada'
            elif inc_country in ['MEX', 'MX', 'Mexico']:
                jurisdiction = 'Mexico'
            elif inc_country in ['GBR', 'GB', 'UK']:
                jurisdiction = 'United Kingdom'
            
            supabase.table('companies').update({
                'jurisdiction': jurisdiction
            }).eq('id', row['id']).execute()
            updates_made += 1
    
    print(f"✓ Populated jurisdiction for {updates_made} companies")
    
    print("\n" + "="*80)
    print("Jurisdiction fix complete!")
    
    # Verification
    print("\nVerification - NVIDIA entries:")
    nvidia = supabase.table('companies').select('company_name, ticker_symbol, jurisdiction, incorporation_country').ilike('company_name', '%NVIDIA%').execute()
    for row in nvidia.data:
        print(f"  {row['company_name']} ({row.get('ticker_symbol', 'N/A')}): {row['jurisdiction']}")
    
    # Check remaining NULL jurisdictions
    remaining = supabase.table('companies').select('id', count='exact').is_('jurisdiction', 'null').execute()
    print(f"\nRemaining companies with NULL jurisdiction: {remaining.count}")

if __name__ == "__main__":
    fix_jurisdiction_data()
