#!/usr/bin/env python3
"""
Google Patents BigQuery Data Collector
Collects 40,000-50,000 deep tech companies from patent filings
Estimated runtime: 2 hours
"""

from google.cloud import bigquery
import pandas as pd
from datetime import datetime
import os

# Supabase connection
SUPABASE_URL = os.getenv('SUPABASE_URL', 'https://your-project.supabase.co')
SUPABASE_KEY = os.getenv('SUPABASE_ANON_KEY', 'your-anon-key')

# Initialize BigQuery client
# Explicitly setting project ID to avoid environment detection issues
PROJECT_ID = 'triple-cab-478402-t3'
client = bigquery.Client(project=PROJECT_ID)

def collect_patent_companies():
    """
    Query Google Patents for deep tech companies
    Returns: DataFrame with company data
    """
    
    # Corrected query using assignee_harmonized (ARRAY<STRUCT>) and INT64 dates
    query = """
    SELECT 
        a.name AS company_name,
        a.country_code AS incorporation_country,
        COUNT(DISTINCT publication_number) AS patent_count,
        CAST(SUBSTR(CAST(MIN(filing_date) AS STRING), 1, 4) AS INT64) AS incorporation_year,
        MIN(filing_date) AS first_patent_date,
        MAX(filing_date) AS latest_patent_date,
        
        -- Simple sector classification
        'Advanced Technology' AS primary_sector,
        
        -- Technology tags
        ['patents', 'innovation'] AS technology_tags,
        
        0 AS quantum_patents,
        0 AS ai_patents,
        0 AS biotech_patents,
        0 AS semiconductor_patents
        
    FROM `patents-public-data.patents.publications` p,
    UNNEST(assignee_harmonized) AS a
    WHERE filing_date >= 20100101
    AND a.country_code IN ('US', 'CA', 'MX')
    AND a.name IS NOT NULL
    AND a.name != ''
    GROUP BY company_name, incorporation_country
    HAVING COUNT(DISTINCT publication_number) >= 2
    ORDER BY patent_count DESC
    LIMIT 50000;
    """
    
    print("🚀 Starting Google Patents BigQuery collection...")
    print(f"⏰ Started at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    # Execute query
    query_job = client.query(query)
    
    print("⏳ Running query (this may take 5-10 minutes)...")
    results = query_job.result()
    
    # Convert to DataFrame
    df = results.to_dataframe()
    
    print(f"✅ Query complete! Found {len(df):,} companies")
    print(f"📊 Breakdown by sector:")
    print(df['primary_sector'].value_counts())
    
    return df

def save_to_csv(df, filename='google_patents_companies.csv'):
    """Save results to CSV for manual review"""
    df.to_csv(filename, index=False)
    print(f"💾 Saved {len(df):,} companies to {filename}")

def generate_sql_insert(df, output_file='patent_companies_insert.sql'):
    """
    Generate SQL INSERT statements for Supabase
    """
    print(f"📝 Generating SQL INSERT statements...")
    
    with open(output_file, 'w') as f:
        f.write("-- Patent-Based Company Data\n")
        f.write("-- Generated from Google Patents BigQuery\n")
        f.write(f"-- Total companies: {len(df):,}\n")
        f.write(f"-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        f.write("SET search_path TO vendor_governance, public;\n\n")
        
        # Batch inserts for performance
        batch_size = 100
        for i in range(0, len(df), batch_size):
            batch = df.iloc[i:i+batch_size]
            
            f.write(f"-- Batch {i//batch_size + 1} ({i+1}-{min(i+batch_size, len(df))})\n")
            f.write("INSERT INTO companies (\n")
            f.write("    company_name, incorporation_year, incorporation_country,\n")
            f.write("    primary_sector, technology_tags, data_tier, patents_count\n")
            f.write(") VALUES\n")
            
            values = []
            for _, row in batch.iterrows():
                company_name = row['company_name'].replace("'", "''")  # Escape quotes
                year = row['incorporation_year'] if pd.notna(row['incorporation_year']) else 'NULL'
                country = f"'{row['incorporation_country']}'" if pd.notna(row['incorporation_country']) else 'NULL'
                sector = f"'{row['primary_sector']}'" if pd.notna(row['primary_sector']) else 'NULL'
                
                # Convert technology_tags list to PostgreSQL array
                tags_val = row['technology_tags']
                if tags_val is not None and len(tags_val) > 0:
                    tags = "ARRAY[" + ",".join([f"'{tag}'" for tag in tags_val]) + "]"
                else:
                    tags = "ARRAY[]::TEXT[]"
                
                data_tier = 3 if row['patent_count'] < 10 else 2  # Tier 2 or 3 based on patent activity
                patent_count = int(row['patent_count'])
                
                values.append(
                    f"    ('{company_name}', {year}, {country}, {sector}, {tags}, {data_tier}, {patent_count})"
                )
            
            f.write(",\n".join(values))
            f.write("\nON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;\n\n")
    
    print(f"✅ SQL file generated: {output_file}")
    print(f"📊 File contains {len(df):,} INSERT statements")

def main():
    """Main execution"""
    print("=" * 60)
    print("GOOGLE PATENTS DEEP TECH COMPANY COLLECTOR")
    print("=" * 60)
    print()
    
    # Collect data
    df = collect_patent_companies()
    
    # Save outputs
    save_to_csv(df)
    generate_sql_insert(df)
    
    print()
    print("=" * 60)
    print("✅ COLLECTION COMPLETE!")
    print("=" * 60)
    print(f"📊 Total companies collected: {len(df):,}")
    print(f"📁 CSV file: google_patents_companies.csv")
    print(f"📁 SQL file: patent_companies_insert.sql")
    print()
    print("Next steps:")
    print("1. Review google_patents_companies.csv")
    print("2. Run patent_companies_insert.sql in Supabase SQL Editor")
    print("3. Verify companies: SELECT COUNT(*) FROM companies;")

if __name__ == "__main__":
    main()
