#!/usr/bin/env python3
"""
Export all Supabase tables to Excel format
Creates .xlsx files for companies, board data, patents, etc.
"""

import os
import toml
from supabase import create_client, Client, ClientOptions
import pandas as pd
from datetime import datetime

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

def export_table_to_excel(table_name, filename, chunk_size=1000):
    """Export a Supabase table to Excel with pagination"""
    print(f"\n📥 Exporting {table_name}...")
    
    all_data = []
    offset = 0
    
    while True:
        try:
            res = supabase.table(table_name).select("*").range(offset, offset + chunk_size - 1).execute()
            
            if not res.data:
                break
            
            all_data.extend(res.data)
            offset += chunk_size
            
            print(f"  Fetched {len(all_data):,} records...")
            
            if len(res.data) < chunk_size:
                break
        except Exception as e:
            print(f"  ⚠️ Error fetching data: {e}")
            break
    
    if all_data:
        df = pd.DataFrame(all_data)
        df.to_excel(filename, index=False, engine='openpyxl')
        print(f"✅ Exported {len(all_data):,} records to {filename}")
        return len(all_data)
    else:
        print(f"⚠️ No data found for {table_name}")
        return 0

def main():
    print("=" * 70)
    print("DATABASE EXPORT TO EXCEL")
    print("=" * 70)
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print()
    
    # Tables to export
    tables = {
        'companies': 'companies.xlsx',
        'board_composition_annual': 'board_composition.xlsx',
        'patents': 'patents.xlsx',
        'executive_compensation_annual': 'executive_compensation.xlsx',
        'governance_scores': 'governance_scores.xlsx',
        'company_filings': 'company_filings.xlsx'
    }
    
    total_records = 0
    
    for table_name, filename in tables.items():
        count = export_table_to_excel(table_name, filename)
        total_records += count
    
    print(f"\n{'=' * 70}")
    print(f"✅ EXPORT COMPLETE")
    print(f"{'=' * 70}")
    print(f"Total records exported: {total_records:,}")
    print(f"Files created: {len([f for f in tables.values() if os.path.exists(f)])}")
    print()
    print("📁 Excel files created:")
    for filename in tables.values():
        if os.path.exists(filename):
            size = os.path.getsize(filename) / 1024  # KB
            print(f"  ✓ {filename:30s} ({size:,.1f} KB)")

if __name__ == "__main__":
    main()
