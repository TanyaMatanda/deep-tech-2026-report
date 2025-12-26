#!/usr/bin/env python3
"""
Generate sector-specific compensation tables for the Sector Analysis Dashboard
Queries top 10 companies per sector with full component breakdown
"""

import os
import json
import toml
from supabase import create_client, ClientOptions

def load_config():
    """Load Supabase credentials"""
    try:
        secrets = toml.load(".streamlit/secrets.toml")
        return secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
    except Exception as e:
        print(f"Error loading config: {e}")
        return None, None

def main():
    print("🔄 Generating Sector Analysis Data...")
    print("=" * 60)
    
    # Load credentials
    url, key = load_config()
    if not url or not key:
        print("❌ Failed to load credentials")
        return
    
    # Connect to database
    print("📊 Connecting to Supabase...")
    options = ClientOptions(schema="vendor_governance")
    supabase = create_client(url, key, options=options)
    
    # Query CEO compensation data with company info
    print("📥 Fetching CEO compensation data by sector...")
    response = supabase.table('executive_compensation_annual').select(
        'company_id, companies(company_name, primary_sector), '
        'total_compensation, base_salary, bonus, stock_awards, option_awards, '
        'non_equity_incentive, change_in_pension_value, all_other_compensation'
    ).eq('role', 'CEO').order('total_compensation', desc=True).execute()
    
    print(f"✓ Retrieved {len(response.data)} CEO compensation records")
    
    # Organize by sector
    sector_data = {}
    sector_mapping = {
        'Biotechnology': 'Biotechnology',
        'Technology': 'Technology',
        'Energy & Climate Technology': 'Energy & Climate',
        'Cybersecurity': 'Cybersecurity',
        'Advanced Materials & Manufacturing': 'Advanced Materials'
    }
    
    for record in response.data:
        # Skip zero compensation
        if not (record.get('total_compensation') or 0) > 0:
            continue
            
        company = record.get('companies')
        if not company:
            continue
        
        sector = company.get('primary_sector', 'Other')
        dashboard_sector = sector_mapping.get(sector, 'Other')
        
        if dashboard_sector == 'Other':
            continue
        
        if dashboard_sector not in sector_data:
            sector_data[dashboard_sector] = []
        
        # Format the record
        total = record.get('total_compensation', 0) or 0
        salary = record.get('base_salary', 0) or 0
        bonus = record.get('bonus', 0) or 0
        stock = record.get('stock_awards', 0) or 0
        options = record.get('option_awards', 0) or 0
        non_equity = record.get('non_equity_incentive', 0) or 0
        pension = record.get('change_in_pension_value', 0) or 0
        other = record.get('all_other_compensation', 0) or 0
        
        sector_data[dashboard_sector].append({
            'company': company.get('company_name'),
            'total': total,
            'salary': salary,
            'bonus': bonus,
            'stock': stock,
            'options': options,
            'non_equity': non_equity,
            'pension': pension,
            'other': other
        })
    
    # Get top 10 for each sector
    sector_tables = {}
    for sector, companies in sector_data.items():
        sector_tables[sector] = companies[:10]
    
    print(f"\n📋 Sector Distribution (Top 10 per sector):")
    for sector, companies in sorted(sector_tables.items(), key=lambda x: len(x[1]), reverse=True):
        print(f"   • {sector}: {len(companies)} companies")
    
    # Save to JSON
    output_file = "sector_top10_tables.json"
    print(f"\n💾 Saving to {output_file}...")
    with open(output_file, 'w') as f:
        json.dump(sector_tables, f, indent=2)
    
    print(f"\n✅ Success! Generated top 10 tables for {len(sector_tables)} sectors")
    print("=" * 60)

if __name__ == "__main__":
    main()
