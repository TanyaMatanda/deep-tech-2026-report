import os
from supabase import create_client
import pandas as pd
import toml

# Load secrets
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except:
    # Fallback for local dev if secrets.toml isn't found in CWD
    secrets = toml.load("dashboard/.streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]

supabase = create_client(url, key)

# Fix: Specify schema
try:
    # Try querying with schema explicitly set if the library supports it, 
    # or just try the table name if the user's role has search_path set.
    # Standard supabase-py/postgrest-py pattern:
    print("Querying vendor_governance.ownership_structure...")
    response = supabase.table("ownership_structure").select("*").limit(10).execute() 
    # If this fails, we might need to use the .schema() modifier if available in this version
    # But often the table name alone fails if not in public.
    
    # Let's try the raw postgrest client approach if the above failed in the previous step (which it did)
    # Actually, let's try setting the schema on the query builder
    response = supabase.from_("ownership_structure").select("*").limit(10).execute() # .from_ is alias for .table
    
except Exception as e:
    print(f"Standard query failed: {e}")
    try:
        # Try explicit schema method (common in newer versions)
        print("Attempting .schema('vendor_governance')...")
        response = supabase.schema("vendor_governance").table("ownership_structure").select("*").limit(10).execute()
    except Exception as e2:
        print(f"Schema query failed: {e2}")
        response = None

if response and response.data:
    df_own = pd.DataFrame(response.data)
    print(f"Total Rows Fetched: {len(df_own)}")
    print(df_own[['company_id', 'founder_pct', 'vc_pct', 'public_float_pct']].head())
    
    # Check sums
    cols = ['founder_pct', 'vc_pct', 'institutional_pct', 'public_float_pct', 'strategic_corp_pct', 'govt_univ_pct', 'employee_other_pct']
    # Fill NAs with 0
    df_own[cols] = df_own[cols].fillna(0)
    df_own['total_pct'] = df_own[cols].sum(axis=1)
    
    print("\nOwnership Sums (Should be ~100):")
    print(df_own[['company_id', 'total_pct']].head(10))
    
    # Check for "All Zeros"
    zeros = df_own[df_own['total_pct'] == 0]
    if not zeros.empty:
        print(f"\n⚠️ WARNING: {len(zeros)} rows have 0% total ownership!")
else:
    print("⚠️ No data found in 'ownership_structure' table.")


print("\n--- DIAGNOSTIC: Materialized View Scores ---")
try:
    response = supabase.schema("vendor_governance").table("mv_company_scores").select("*").limit(10).execute()
    if response.data:
        df_mv = pd.DataFrame(response.data)
        print(f"Total Rows Fetched: {len(df_mv)}")
        print(df_mv[['company_name', 'governance_score', 'ownership_archetype', 'jurisdiction']].head())
        
        # Check for NULL scores
        null_scores = df_mv[df_mv['governance_score'].isnull()]
        if not null_scores.empty:
             print(f"\n⚠️ WARNING: {len(null_scores)} rows have NULL governance_score!")
             
        # Check for default jurisdiction
        usa_count = len(df_mv[df_mv['jurisdiction'] == 'USA'])
        print(f"\nJurisdiction 'USA' count in sample: {usa_count}/{len(df_mv)}")
    else:
        print("⚠️ No data found in 'mv_company_scores'.")
except Exception as e:
    print(f"Error querying mv_company_scores: {e}")
