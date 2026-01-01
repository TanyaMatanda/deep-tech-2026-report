#!/usr/bin/env python3
"""
Validation Script for SEC AI Risk Factor Extraction
This script allows other researchers to validate the extraction methodology
by randomly sampling companies and manually verifying the results.
"""

import pandas as pd
import json
import requests
import re
from collections import Counter

HEADERS = {'User-Agent': 'Research Validation tanya@governanceiq.com'}

def get_10k_text(cik: str) -> tuple:
    """Get the actual 10-K filing text for manual validation"""
    cik_padded = str(cik).zfill(10)
    url = f"https://data.sec.gov/submissions/CIK{cik_padded}.json"
    
    try:
        response = requests.get(url, headers=HEADERS, timeout=15)
        if response.status_code != 200:
            return None, None
        
        data = response.json()
        filings = data.get('filings', {}).get('recent', {})
        
        forms = filings.get('form', [])
        accession_numbers = filings.get('accessionNumber', [])
        primary_docs = filings.get('primaryDocument', [])
        
        for i, form in enumerate(forms):
            if form == '10-K':
                accession = accession_numbers[i].replace('-', '')
                doc = primary_docs[i]
                filing_url = f"https://www.sec.gov/Archives/edgar/data/{cik}/{accession}/{doc}"
                
                # Get the filing text
                response = requests.get(filing_url, headers=HEADERS, timeout=30)
                if response.status_code == 200:
                    return filing_url, response.text
                break
        return None, None
    except Exception as e:
        return None, None

def extract_risk_factors(text: str) -> str:
    """Extract Item 1A using the same method as the main script"""
    if not text:
        return ""
    
    patterns = [
        r'(?i)item\s*1a[.\s]*risk\s*factors(.*?)(?:item\s*1b|item\s*2[.\s])',
        r'(?i)RISK\s*FACTORS(.*?)(?:UNRESOLVED\s*STAFF|PROPERTIES)',
    ]
    
    for pattern in patterns:
        match = re.search(pattern, text, re.DOTALL)
        if match:
            risk_text = match.group(1)
            # Clean HTML tags
            risk_text = re.sub(r'<[^>]+>', ' ', risk_text)
            # Clean extra whitespace
            risk_text = re.sub(r'\s+', ' ', risk_text)
            return risk_text[:100000]
    
    return ""

def count_keywords(text: str, keywords: list) -> dict:
    """Count keyword occurrences"""
    text_lower = text.lower()
    counts = {}
    for keyword in keywords:
        count = text_lower.count(keyword)
        if count > 0:
            counts[keyword] = count
    return counts

def validate_company(ticker: str, df: pd.DataFrame):
    """Validate extraction results for a specific company"""
    print("="*70)
    print(f"VALIDATING: {ticker}")
    print("="*70)
    
    # Get company from results
    company_row = df[df['ticker'] == ticker]
    if company_row.empty:
        print(f"❌ Company {ticker} not found in results")
        return
    
    row = company_row.iloc[0]
    cik = row.get('cik') if 'cik' in df.columns else None
    
    if not cik:
        # Try to find CIK from the original data
        orig_df = pd.read_csv('sec_risk_data_v2.csv')
        orig_row = orig_df[orig_df['ticker'] == ticker]
        if not orig_row.empty:
            cik = orig_row.iloc[0]['cik']
    
    if not cik:
        print(f"❌ CIK not found for {ticker}")
        return
    
    print(f"\n📊 REPORTED RESULTS:")
    print(f"  Total AI mentions: {row['total_ai_mentions']}")
    print(f"  Has AI disclosure: {row['has_ai_disclosure']}")
    print(f"  Status: {row['status']}")
    
    # Get actual filing
    print(f"\n🔍 FETCHING ACTUAL 10-K FILING...")
    filing_url, filing_text = get_10k_text(cik)
    
    if not filing_text:
        print(f"❌ Could not retrieve 10-K filing")
        return
    
    print(f"✓ Retrieved filing from: {filing_url}")
    print(f"  Total filing size: {len(filing_text):,} characters")
    
    # Extract Item 1A
    risk_text = extract_risk_factors(filing_text)
    print(f"  Item 1A size: {len(risk_text):,} characters")
    
    if not risk_text:
        print(f"❌ Could not extract Item 1A section")
        return
    
    print(f"✓ Item 1A extracted successfully")
    
    # Show snippet
    print(f"\n📄 ITEM 1A SNIPPET (first 500 chars):")
    print(f"  {risk_text[:500]}...")
    
    # Manually count some keywords
    test_keywords = ['artificial intelligence', 'machine learning', 'llm', 'generative ai', 
                     'hallucination', 'bias', 'gpu', 'nvidia', 'sustainability']
    
    manual_counts = count_keywords(risk_text, test_keywords)
    
    print(f"\n✅ MANUAL VERIFICATION:")
    for kw in test_keywords:
        manual = manual_counts.get(kw, 0)
        reported_col = f"kw_{kw.replace(' ', '_')}"
        reported = row.get(reported_col, 0) if reported_col in df.columns else 'N/A'
        
        if manual > 0 or reported != 'N/A':
            match = "✓" if manual == reported else "❌ MISMATCH"
            print(f"  {kw:<25} Manual: {manual:<3} vs Reported: {reported:<3} {match}")
    
    print()

def main():
    print("="*70)
    print("SEC AI RISK FACTOR EXTRACTION - VALIDATION SCRIPT")
    print("="*70)
    print()
    
    # Load results
    df = pd.read_csv('140x_Problem_Company_Level_Data.csv')
    
    print(f"Loaded {len(df)} companies from results file")
    print()
    
    # Validate a few companies
    print("VALIDATION SAMPLES:")
    print("1. High AI disclosure company (NVDA)")
    print("2. Company with no AI disclosure (AAPL)")
    print()
    
    choice = input("Enter company ticker to validate (or press Enter for NVDA): ").strip().upper()
    if not choice:
        choice = "NVDA"
    
    validate_company(choice, df)
    
    print("\n" + "="*70)
    print("VALIDATION COMPLETE")
    print("="*70)
    print("\nTo validate another company, run this script again.")
    print("For full validation, manually check at least 10 random samples.")

if __name__ == "__main__":
    main()
