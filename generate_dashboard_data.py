#!/usr/bin/env python3
"""
Run full IPO readiness analysis and generate static dashboard
"""

import psycopg2
import pandas as pd
import json
from datetime import datetime
import os

# Database connection
def connect_db():
    """Connect to database using .streamlit secrets"""
    secrets_path = "/Users/tanyamatanda/Desktop/Proxy Season 2026/.streamlit/secrets.toml"
    
    if os.path.exists(secrets_path):
        # Parse secrets file
        with open(secrets_path, 'r') as f:
            lines = f.readlines()
            secrets = {}
            for line in lines:
                if '=' in line and not line.strip().startswith('#'):
                    key, value = line.split('=', 1)
                    secrets[key.strip()] = value.strip().strip('"')
        
        conn = psycopg2.connect(
            host=secrets.get('SUPABASE_HOST'),
            database=secrets.get('SUPABASE_DB', 'postgres'),
            user=secrets.get('SUPABASE_USER', 'postgres'),
            password=secrets.get('SUPABASE_PASSWORD')
        )
    else:
        # Try environment variables
        conn = psycopg2.connect(
            host=os.getenv('SUPABASE_HOST'),
            database=os.getenv('SUPABASE_DB', 'postgres'),
            user=os.getenv('SUPABASE_USER', 'postgres'),
            password=os.getenv('SUPABASE_PASSWORD')
        )
    
    return conn

# Main analysis
print("🔗 Connecting to database...")
conn = connect_db()
print("✓ Connected!")

# First, create the IPO readiness view if it doesn't exist
print("\n📊 Creating IPO readiness scoring view...")

create_view_sql = open('create_ipo_view.sql', 'r').read() if os.path.exists('create_ipo_view.sql') else """
-- Simplified version for testing
CREATE OR REPLACE VIEW ipo_readiness_scores AS
SELECT 
    c.id AS company_id,
    c.company_name,
    c.primary_sector,
    c.incorporation_country,
    c.listing_type,
    fm.revenue_usd,
    fm.net_income_usd,
    fm.employee_count,
    
    -- Simple scoring for now
    CASE 
        WHEN fm.revenue_usd >= 100000000 THEN 80
        WHEN fm.revenue_usd >= 50000000 THEN 70
        WHEN fm.revenue_usd >= 20000000 THEN 60
        ELSE 40
    END AS total_ipo_readiness_score,
    
    CASE 
        WHEN fm.revenue_usd >= 100000000 THEN 'IPO-Ready (12-18mo)'
        WHEN fm.revenue_usd >= 50000000 THEN 'Near-Term (18-24mo)'
        ELSE 'Significant Gaps (2-3yr)'
    END AS readiness_tier
    
FROM companies c
LEFT JOIN financial_metrics fm ON c.id = fm.company_id 
    AND fm.fiscal_year = (SELECT MAX(fiscal_year) FROM financial_metrics WHERE company_id = c.id)
WHERE c.listing_type = 'Private' AND c.company_status = 'Active';
"""

with conn.cursor() as cur:
    cur.execute(create_view_sql)
    conn.commit()
print("✓ View created!")

# Pull all IPO readiness data
print("\n📥 Pulling IPO readiness data...")
query = "SELECT * FROM ipo_readiness_scores WHERE total_ipo_readiness_score >= 40 ORDER BY total_ipo_readiness_score DESC LIMIT 1000"
df = pd.read_sql(query, conn)
print(f"✓ Loaded {len(df)} companies")

# Save to JSON for static dashboard
print("\n💾 Saving data for dashboard...")
df_dict = df.to_dict('records')

# Convert to JSON-serializable format
for record in df_dict:
    for key, value in record.items():
        if pd.isna(value):
            record[key] = None
        elif isinstance(value, (pd.Timestamp, datetime)):
            record[key] = value.isoformat()

output = {
    'generated_at': datetime.now().isoformat(),
    'total_companies': len(df),
    'data': df_dict,
    'summary': {
        'ipo_ready': len(df[df['readiness_tier'] == 'IPO-Ready (12-18mo)']),
        'near_term': len(df[df['readiness_tier'] == 'Near-Term (18-24mo)']),
        'significant_gaps': len(df[df['readiness_tier'] == 'Significant Gaps (2-3yr)']),
        'median_revenue': float(df['revenue_usd'].median()) if 'revenue_usd' in df.columns else 0,
        'top_sectors': df['primary_sector'].value_counts().head(10).to_dict() if 'primary_sector' in df.columns else {}
    }
}

with open('ipo_dashboard_data.json', 'w') as f:
    json.dump(output, f, indent=2)

print(f"✓ Saved to ipo_dashboard_data.json")
print(f"\n📊 Summary:")
print(f"   IPO-Ready: {output['summary']['ipo_ready']}")
print(f"   Near-Term: {output['summary']['near_term']}")
print(f"   Median Revenue: ${output['summary']['median_revenue']/1e6:.1f}M")

conn.close()
print("\n✅ Analysis complete!")
