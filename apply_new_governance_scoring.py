#!/usr/bin/env python3
"""
Apply New Governance Scoring Function
This script:
1. Applies the new governance scoring function to the database
2. Refreshes the view_company_scores view
3. Verifies the score distribution
"""

import os
import toml
from supabase import create_client, ClientOptions

# Load credentials
secrets = toml.load('dashboard/.streamlit/secrets.toml')
options = ClientOptions(schema='vendor_governance')
supabase = create_client(secrets['SUPABASE_URL'], secrets['SUPABASE_KEY'], options=options)

print("="*60)
print("APPLYING NEW GOVERNANCE SCORING FUNCTION")
print("="*60)

# Read and apply the SQL
print("\n1. Reading SQL file...")
with open('fix_governance_scoring.sql', 'r') as f:
    sql_content = f.read()

print("2. Applying new governance scoring function to Supabase...")

# Split into individual statements and execute
statements = sql_content.split(';')
for i, statement in enumerate(statements):
    statement = statement.strip()
    if statement and not statement.startswith('--'):
        try:
            # Execute through Supabase RPC or direct SQL execution
            # Note: Supabase Python client doesn't have direct SQL execution
            # We'll need to use the SQL Editor manually or use REST API
            print(f"   Statement {i+1}: {statement[:50]}...")
        except Exception as e:
            print(f"   Error: {e}")

print("\n❌ Note: Supabase Python client doesn't support direct SQL execution.")
print("   Please apply the SQL manually via Supabase SQL Editor:")
print(f"   File: /Users/tanyamatanda/Desktop/Proxy Season 2026/fix_governance_scoring.sql")

# Verify score distribution
print("\n" + "="*60)
print("VERIFYING SCORE DISTRIBUTION")
print("="*60)

# Query governance scores from view
print("\n3. Fetching updated governance scores...")
response = supabase.table('view_company_scores').select('governance_score').execute()

if response.data:
    scores = [row['governance_score'] for row in response.data if row['governance_score'] is not None]
    
    print(f"\n✅ Found {len(scores)} companies with governance scores")
    print(f"\nScore Distribution:")
    print(f"  Min:     {min(scores)}")
    print(f"  Q1:      {sorted(scores)[len(scores)//4]}")
    print(f"  Median:  {sorted(scores)[len(scores)//2]}")
    print(f"  Q3:      {sorted(scores)[3*len(scores)//4]}")
    print(f"  Max:     {max(scores)}")
    print(f"  Mean:    {sum(scores)/len(scores):.1f}")
    
    # Distribution buckets
    print(f"\nScore Ranges:")
    print(f"  0-20:    {len([s for s in scores if s <= 20])} companies")
    print(f"  21-40:   {len([s for s in scores if 21 <= s <= 40])} companies")
    print(f"  41-60:   {len([s for s in scores if 41 <= s <= 60])} companies")
    print(f"  61-80:   {len([s for s in scores if 61 <= s <= 80])} companies")
    print(f"  81-100:  {len([s for s in scores if s > 80])} companies")
    
    # Check for old narrow range (indication scoring hasn't been updated)
    narrow_range = len([s for s in scores if 80 <= s <= 100])
    if narrow_range > len(scores) * 0.9:
        print(f"\n⚠️  WARNING: {narrow_range}/{len(scores)} scores are 80-100")
        print("   The new scoring function may not be applied yet.")
        print("   Please run the SQL in Supabase SQL Editor!")
    else:
        print(f"\n✅ Score distribution looks good!")
        print(f"   Wide range indicates new scoring is active.")
else:
    print("❌ No governance scores found")

print("\n" + "="*60)
print("NEXT STEPS")
print("="*60)
print("\n1. Open Supabase Dashboard → SQL Editor")
print("2. Copy/paste contents of: fix_governance_scoring.sql")
print("3. Run the SQL")
print("4. Re-run this script to verify")
print("5. Refresh the Streamlit dashboard at http://localhost:8501")
print("\n" + "="*60)
