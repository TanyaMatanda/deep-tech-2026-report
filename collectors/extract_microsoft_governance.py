"""
Extract Real Governance Data for Microsoft
Demonstrates SEC filing parser capabilities with a real company
"""

import sys
import os
sys.path.append(os.path.dirname(__file__))

from sec_filing_parser import SECFilingParser
from supabase import create_client, ClientOptions
import toml
from datetime import datetime

# Load Supabase credentials
try:
    secrets = toml.load('../dashboard/.streamlit/secrets.toml')
    url = secrets['SUPABASE_URL']
    key = secrets['SUPABASE_KEY']
except:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

if not url or not key:
    print("❌ Error: Supabase credentials not found")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase = create_client(url, key, options=options)

def extract_and_store_microsoft():
    """Extract Microsoft's governance data from latest SEC filings"""
    
    print("=" * 70)
    print("MICROSOFT GOVERNANCE DATA EXTRACTION")
    print("=" * 70)
    
    # Initialize parser
    parser = SECFilingParser()
    
    # Microsoft's CIK
    cik = "0000789019"
    company_name = "Microsoft Corporation"
    
    print(f"\n📊 Extracting governance factors for {company_name} (CIK: {cik})...")
    print(f"⏳ This may take 30-60 seconds due to SEC rate limiting...\n")
    
    # Extract all factors
    factors = parser.extract_all_factors(cik, company_name)
    
    if not factors:
        print("❌ Failed to extract data")
        return None
    
    # Display results
    print("\n" + "=" * 70)
    print("EXTRACTED GOVERNANCE FACTORS")
    print("=" * 70)
    
    print(f"\n📋 DEF 14A Filing URL: {factors.get('def14a_url', 'N/A')}")
    print(f"📋 10-K Filing URL: {factors.get('10k_url', 'N/A')}")
    
    print("\n--- BOARD COMPOSITION ---")
    print(f"   Board Independence:        {factors.get('board_independence_pct', 'N/A')}%")
    print(f"   Split Chair/CEO:           {factors.get('split_chair_ceo', 'N/A')}")
    print(f"   Board Diversity:           {factors.get('board_diversity_pct', 'N/A')}%")
    print(f"   Overboarded Directors:     {factors.get('overboarding_count', 'N/A')}")
    
    print("\n--- COMPENSATION ---")
    print(f"   Say-on-Pay Support:        {factors.get('say_on_pay_support_pct', 'N/A')}%")
    print(f"   CEO Pay Ratio:             {factors.get('ceo_pay_ratio', 'N/A')}:1")
    print(f"   Has Clawback Policy:       {factors.get('has_clawback_policy', 'N/A')}")
    
    print("\n--- AI GOVERNANCE ---")
    print(f"   AI Ethics Board:           {factors.get('has_ai_ethics_board', 'N/A')}")
    print(f"   Board AI Expertise:        {factors.get('board_ai_expertise', 'N/A')}")
    print(f"   AI Risk Mentions:          {factors.get('ai_risk_mentions', 'N/A')}")
    
    print("\n--- CYBERSECURITY ---")
    print(f"   Cyber Oversight:           {factors.get('has_cyber_oversight', 'N/A')}")
    print(f"   CISO Reporting Line:       {factors.get('ciso_reporting_line', 'N/A')}")
    print(f"   Breach History:            {factors.get('has_breach_history', 'N/A')}")
    
    print("\n--- RISK FACTORS ---")
    print(f"   Total Risk Factors:        {factors.get('total_risk_factors', 'N/A')}")
    print(f"   Climate Mentions:          {factors.get('climate_mentions', 'N/A')}")
    print(f"   Revenue Growth (YoY):      {factors.get('revenue_growth_yoy_pct', 'N/A')}%")
    
    print("\n" + "=" * 70)
    
    # Find or create company in database
    print("\n💾 Storing in database...")
    
    # Check if Microsoft exists in companies table
    response = supabase.table('companies')\
        .select('id')\
        .ilike('company_name', '%microsoft%')\
        .eq('ticker_symbol', 'MSFT')\
        .execute()
    
    if response.data:
        company_id = response.data[0]['id']
        print(f"   ✓ Found existing Microsoft record (ID: {company_id})")
    else:
        # Create new company record
        company_data = {
            'company_name': company_name,
            'ticker_symbol': 'MSFT',
            'primary_sector': 'AI & Machine Learning',
            'jurisdiction': 'USA'
        }
        response = supabase.table('companies').insert(company_data).execute()
        company_id = response.data[0]['id']
        print(f"   ✓ Created new Microsoft record (ID: {company_id})")
    
    # Store risk factors data
    risk_data = {
        'company_id': company_id,
        'filing_type': 'DEF 14A & 10-K',
        'filing_date': datetime.now().date().isoformat(),
        'board_independence_pct': factors.get('board_independence_pct'),
        'split_chair_ceo': factors.get('split_chair_ceo'),
        'board_diversity_pct': factors.get('board_diversity_pct'),
        'overboarding_count': factors.get('overboarding_count'),
        'say_on_pay_support_pct': factors.get('say_on_pay_support_pct'),
        'ceo_pay_ratio': factors.get('ceo_pay_ratio'),
        'has_clawback_policy': factors.get('has_clawback_policy'),
        'has_ai_ethics_board': factors.get('has_ai_ethics_board'),
        'board_ai_expertise': factors.get('board_ai_expertise'),
        'ai_risk_mentions': factors.get('ai_risk_mentions'),
        'has_cyber_oversight': factors.get('has_cyber_oversight'),
        'ciso_reporting_line': factors.get('ciso_reporting_line'),
        'has_breach_history': factors.get('has_breach_history'),
        'total_risk_factors': factors.get('total_risk_factors'),
        'climate_risk_mentions': factors.get('climate_mentions'),
        'revenue_growth_yoy_pct': factors.get('revenue_growth_yoy_pct'),
        'extracted_at': datetime.now().isoformat()
    }
    
    # Upsert into company_risk_factors table
    # (if table exists; may need to create it first)
    try:
        response = supabase.table('company_risk_factors').upsert(risk_data).execute()
        print(f"   ✓ Stored governance factors in company_risk_factors table")
    except Exception as e:
        print(f"   ⚠️  Could not store in company_risk_factors table: {e}")
        print(f"   💡 You may need to create the table first")
    
    print("\n✅ Extraction complete!\n")
    
    return factors

if __name__ == "__main__":
    extract_and_store_microsoft()
