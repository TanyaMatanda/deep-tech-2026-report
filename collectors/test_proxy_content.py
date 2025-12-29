"""
Quick test to see what's in Microsoft's proxy filing
"""
import sys
sys.path.append('.')

from sec_filing_parser import SECFilingParser

parser = SECFilingParser()

print("Fetching Microsoft DEF 14A...")
proxy = parser.fetch_filing('0000789019', 'DEF 14A')

if proxy:
    # Get first 5000 chars
    sample = parser.clean_text(proxy)[:5000]
    
    print(f"\n{'='*80}")
    print("SAMPLE OF MICROSOFT PROXY FILING (first 5000 chars)")
    print(f"{'='*80}\n")
    print(sample)
    
    print(f"\n\n{'='*80}")
    print("SEARCHING FOR KEY TERMS")
    print(f"{'='*80}\n")
    
    search_terms = [
        'independent director',
        'board of directors',
        'say on pay',
        'compensation',
        'diversity',
        'CEO',
        'chairman'
    ]
    
    for term in search_terms:
        import re
        matches = re.findall(f'.{{0,50}}{term}.{{0,50}}', sample, re.IGNORECASE)
        if matches:
            print(f"\n✓ Found '{term}':")
            for match in matches[:2]:  # Show first 2
                print(f"  ...{match}...")
        else:
            print(f"\n✗ '{term}' not in first 5000 chars")
            
else:
    print("❌ Could not fetch filing")
