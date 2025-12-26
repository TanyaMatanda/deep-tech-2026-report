#!/usr/bin/env python3
"""
Generate professional_analytics.json from Supabase database
Calculates statistics for all CEO compensation records across sectors
"""

import os
import json
import toml
import numpy as np
from supabase import create_client, ClientOptions

def load_config():
    """Load Supabase credentials"""
    try:
        secrets = toml.load(".streamlit/secrets.toml")
        return secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
    except Exception as e:
        print(f"Error loading config: {e}")
        return None, None

def calculate_stats(values):
    """Calculate statistical measures for a list of values"""
    if not values or len(values) == 0:
        return {
            "mean": 0,
            "median": 0,
            "p25": 0,
            "p75": 0,
            "min": 0,
            "max": 0,
            "stdev": 0
        }
    
    arr = np.array(values)
    return {
        "mean": float(np.mean(arr)),
        "median": float(np.median(arr)),
        "p25": float(np.percentile(arr, 25)),
        "p75": float(np.percentile(arr, 75)),
        "min": float(np.min(arr)),
        "max": float(np.max(arr)),
        "stdev": float(np.std(arr))
    }

def calculate_equity_mix(record):
    """Calculate equity mix percentage (stock + options) / total * 100"""
    total = record.get('total_compensation', 0) or 0
    if total == 0:
        return 0
    
    stock = record.get('stock_awards', 0) or 0
    options = record.get('option_awards', 0) or 0
    
    # Handle cases where stock awards may be grant-date values that seem too high
    # Cap at 200% to avoid extreme outliers from accounting artifacts
    equity_pct = ((stock + options) / total) * 100
    return min(equity_pct, 200)

def main():
    print("🔄 Generating Professional Analytics Data...")
    print("=" * 60)
    
    # Load credentials
    url, key = load_config()
    if not url or not key:
        print("❌ Failed to load credentials")
        return
    
    # Connect to database (vendor_governance schema)
    print("📊 Connecting to Supabase...")
    options = ClientOptions(schema="vendor_governance")
    supabase = create_client(url, key, options=options)
    
    # Query all CEO compensation data
    print("📥 Fetching CEO compensation data...")
    response = supabase.table('executive_compensation_annual').select(
        'company_id, companies(company_name, primary_sector), '
        'total_compensation, base_salary, bonus, stock_awards, option_awards, '
        'non_equity_incentive, change_in_pension_value, all_other_compensation'
    ).eq('role', 'CEO').execute()
    
    print(f"✓ Retrieved {len(response.data)} CEO compensation records")
    
    # Filter out records with zero or null compensation
    records = [r for r in response.data if (r.get('total_compensation') or 0) > 0]
    print(f"✓ Filtered to {len(records)} records with non-zero compensation")
    
    # Map sectors to standardized names for the dashboard
    sector_mapping = {
        'Biotechnology': 'Biotechnology',
        'Technology': 'Technology',
        'Energy & Climate Technology': 'Energy & Climate',
        'Cybersecurity': 'Cybersecurity',
        'Advanced Materials & Manufacturing': 'Advanced Technology',
        'Quantum Computing': 'Advanced Technology',
        'Aerospace & Defense': 'Advanced Technology',
        'Medical Devices & Diagnostics': 'Biotechnology'
    }
    
    # Organize by sector
    sector_data = {}
    for record in records:
        company = record.get('companies')
        if not company:
            continue
        
        sector = company.get('primary_sector', 'Other')
        # Map to dashboard sector names
        dashboard_sector = sector_mapping.get(sector, 'Other')
        
        if dashboard_sector == 'Other':
            continue
        
        if dashboard_sector not in sector_data:
            sector_data[dashboard_sector] = []
        
        sector_data[dashboard_sector].append(record)
    
    print(f"\n📋 Sector Distribution:")
    for sector, recs in sorted(sector_data.items(), key=lambda x: len(x[1]), reverse=True):
        print(f"   • {sector}: {len(recs)} companies")
    
    # Calculate sector statistics
    print(f"\n📊 Calculating statistics by sector...")
    sector_stats = {}
    
    for sector, recs in sector_data.items():
        total_comps = [r.get('total_compensation', 0) or 0 for r in recs]
        salaries = [r.get('base_salary', 0) or 0 for r in recs if (r.get('base_salary') or 0) > 0]
        equity_mixes = [calculate_equity_mix(r) for r in recs]
        
        sector_stats[sector] = {
            "count": len(recs),
            "total_comp": calculate_stats(total_comps),
            "equity_mix": calculate_stats(equity_mixes),
            "salary": {
                "mean": float(np.mean(salaries)) if salaries else 0,
                "median": float(np.median(salaries)) if salaries else 0
            }
        }
    
    # Calculate overall statistics
    print(f"\n📊 Calculating overall statistics...")
    all_comps = [r.get('total_compensation', 0) or 0 for r in records]
    all_equity = [calculate_equity_mix(r) for r in records]
    
    overall_stats = calculate_stats(all_comps)
    overall_stats['p10'] = float(np.percentile(all_comps, 10))
    overall_stats['p90'] = float(np.percentile(all_comps, 90))
    
    # Count companies by equity mix threshold
    above_85 = sum(1 for e in all_equity if e >= 85)
    below_50 = sum(1 for e in all_equity if e < 50)
    
    # Build final analytics object
    analytics = {
        "sector_stats": sector_stats,
        "overall": {
            "total_companies": len(records),
            "total_comp": overall_stats,
            "equity_mix": {
                "mean": float(np.mean(all_equity)),
                "median": float(np.median(all_equity)),
                "above_85pct": above_85,
                "below_50pct": below_50
            }
        }
    }
    
    # Save to JSON
    output_file = "professional_analytics.json"
    print(f"\n💾 Saving to {output_file}...")
    with open(output_file, 'w') as f:
        json.dump(analytics, f, indent=2)
    
    print(f"\n✅ Success! Generated analytics for {len(records)} companies")
    print(f"\n📊 Summary Statistics:")
    print(f"   • Total Companies: {len(records)}")
    print(f"   • Median Compensation: ${overall_stats['median']:,.0f}")
    print(f"   • Mean Compensation: ${overall_stats['mean']:,.0f}")
    print(f"   • Median Equity Mix: {float(np.median(all_equity)):.1f}%")
    print(f"   • High Alignment (>85%): {above_85} ({above_85/len(records)*100:.1f}%)")
    print(f"   • Cash-Heavy (<50%): {below_50} ({below_50/len(records)*100:.1f}%)")
    print("=" * 60)

if __name__ == "__main__":
    main()
