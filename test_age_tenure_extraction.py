import os
import sys
sys.path.append('collectors')
from sec_filing_parser import SECFilingParser

def test_extraction():
    parser = SECFilingParser()
    test_cases = [
        {'name': 'Microsoft', 'cik': '0000789019'},
        {'name': 'NVIDIA', 'cik': '0001045810'}
    ]
    
    for case in test_cases:
        print(f"\n🧪 Testing extraction for {case['name']} (CIK: {case['cik']})...")
        filing_text = parser.fetch_filing(case['cik'], 'DEF 14A')
        if not filing_text:
            print(f"❌ Could not fetch filing for {case['name']}")
            continue
        
        clean_text = parser.clean_text(filing_text)
        results = parser.extract_board_age_and_tenure(clean_text)
        
        print(f"✅ Results: {results}")
        if results['avg_director_age'] and results['avg_director_tenure']:
            print(f"✨ SUCCESS: Extracted both age and tenure.")
        else:
            print(f"⚠️ PARTIAL SUCCESS: One or more metrics missing.")

if __name__ == "__main__":
    test_extraction()
