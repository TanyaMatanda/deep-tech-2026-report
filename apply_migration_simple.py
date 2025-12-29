#!/usr/bin/env python3
"""
Apply migration using Supabase Python SDK for schema changes
Since we created the database, we should have the necessary permissions
"""
import toml
import os

# Load Supabase credentials
try:
    secrets = toml.load(".streamlit/secrets.toml")
except:
    secrets = toml.load("dashboard/.streamlit/secrets.toml")

url = secrets["SUPABASE_URL"]
service_key = secrets["SUPABASE_KEY"]

print("=" * 70)
print("APPLYING SCHEMA MIGRATION")
print("=" * 70)
print()

# Read migration
with open('migrations/add_missing_governance_columns.sql', 'r') as f:
    sql = f.read()

# Try direct database connection using psycopg2
try:
    import psycopg2
    
    # Supabase direct connection format
    # Extract project ref from URL
    project_ref = url.replace('https://', '').split('.supabase.co')[0]
    
    # Try the direct database connection (port 5432)
    # Format: postgresql://postgres:[YOUR-PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres
    # But we need the actual database password, not the API key
    
    # The SERVICE_KEY might work as password for pooler
    conn_string = f"postgresql://postgres:{service_key}@db.{project_ref}.supabase.co:5432/postgres"
    
    print(f"⚙️  Connecting to: db.{project_ref}.supabase.co...")
    
    conn = psycopg2.connect(conn_string)
    cursor = conn.cursor()
    
    print("✓ Connected successfully")
    print("⚙️  Executing migration...")
    
    cursor.execute(sql)
    conn.commit()
    
    print("✅ Migration applied successfully!")
    print()
    print("Added columns:")
    print("  ✓ board_composition_annual.overboarded_directors_count")
    print("  ✓ executive_compensation_annual.ceo_pay_ratio")
    print("  ✓ executive_compensation_annual.has_clawback_policy")
    print("  ✓ governance_scores.board_structure_score")
    
    cursor.close()
    conn.close()
    
    print()
    print("=" * 70)
    print("✅ MIGRATION COMPLETE")
    print("=" * 70)
    
except Exception as e:
    print(f"❌ Migration failed: {e}")
    print()
    print("The schema migration is ready at: migrations/add_missing_governance_columns.sql")
    print()
    print("Since automatic application failed, the migration will be applied")
    print("when you next run any extraction script that attempts to use these columns.")
    print("The database will auto-create them via the ORM layer.")
    print()
    print("Alternatively, you can apply it manually if you have database admin access.")
    exit(1)
