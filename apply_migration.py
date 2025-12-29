#!/usr/bin/env python3
"""
Apply schema migration by directly querying and modifying via Supabase Admin API
"""
import os
import toml
from supabase import create_client, Client

# Load credentials
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]  # This is the service role key with admin access
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

# Use requests to call Supabase's PostgREST admin endpoint directly
import requests

print("=" * 70)
print("APPLYING SCHEMA MIGRATION VIA SUPABASE ADMIN API")
print("=" * 70)
print()

# The SUPABASE_KEY is the service role key which has admin access
# We can use the Supabase Management API or direct SQL via pg_catalog

headers = {
    'apikey': key,
    'Authorization': f'Bearer {key}',
    'Content-Type': 'application/json'
}

# Read migration SQL
with open('migrations/add_missing_governance_columns.sql', 'r') as f:
    migration_sql = f.read()

print("📄 Applying migration:")
print("  - Adding overboarded_directors_count to board_composition_annual")
print("  - Adding ceo_pay_ratio to executive_compensation_annual") 
print("  - Adding has_clawback_policy to executive_compensation_annual")
print("  - Adding board_structure_score to governance_scores")
print()

# For Supabase, we need to use their SQL API endpoint
# The endpoint is: {SUPABASE_URL}/rest/v1/rpc/exec
# But a simpler approach: Use the database REST API to check if we can modify schema

# Actually, let's try using curl to execute via psql
import subprocess

# Get database URL from Supabase URL
project_ref = url.replace('https://', '').split('.')[0]
db_url = f"postgresql://postgres.{project_ref}:{key}@aws-0-us-west-1.pooler.supabase.com:6543/postgres"

print("⚙️  Attempting to connect via PostgreSQL connection pooler...")
try:
    # Try using psql if available
    result = subprocess.run(
        ['psql', db_url, '-f', 'migrations/add_missing_governance_columns.sql'],
        capture_output=True,
        text=True,
        timeout=30
    )
    
    if result.returncode == 0:
        print("✅ Migration applied successfully via psql!")
        print()
        print("Added columns:")
        print("  - board_composition_annual.overboarded_directors_count ✓")
        print("  - executive_compensation_annual.ceo_pay_ratio ✓")
        print("  - executive_compensation_annual.has_clawback_policy ✓")
        print("  - governance_scores.board_structure_score ✓")
    else:
        print(f"⚠️  psql error: {result.stderr}")
        raise Exception("psql failed")
        
except FileNotFoundError:
    print("⚠️  psql not found, trying alternative method...")
    
    # Try psycopg2
    try:
        import psycopg2
        
        print("⚙️  Connecting via psycopg2...")
        conn = psycopg2.connect(
            host=f"aws-0-us-west-1.pooler.supabase.com",
            port=6543,
            database="postgres",
            user=f"postgres.{project_ref}",
            password=key
        )
        
        cursor = conn.cursor()
        cursor.execute(migration_sql)
        conn.commit()
        
        print("✅ Migration applied successfully!")
        print()
        print("Added columns:")
        print("  - board_composition_annual.overboarded_directors_count ✓")
        print("  - executive_compensation_annual.ceo_pay_ratio ✓")
        print("  - executive_compensation_annual.has_clawback_policy ✓")
        print("  - governance_scores.board_structure_score ✓")
        
        cursor.close()
        conn.close()
        
    except ImportError:
        print("⚠️  psycopg2 not installed")
        print()
        print("Installing psycopg2...")
        subprocess.run(['pip3', 'install', 'psycopg2-binary'], check=True)
        print("✓ Installed psycopg2, please run this script again")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        print()
        print("The migration SQL has been created at:")
        print("  migrations/add_missing_governance_columns.sql")
        print()
        print("Since I created your database, I should be able to apply this.")
        print("The error above suggests permission or connection issues.")
        exit(1)

except Exception as e:
    print(f"❌ Unexpected error: {e}")

print()
print("=" * 70)
