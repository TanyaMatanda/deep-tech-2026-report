import os
import sys
sys.path.append('collectors')
from sec_filing_parser import SECFilingParser

def analyze_proxy(cik):
    parser = SECFilingParser()
    print(f"📥 Fetching proxy for CIK {cik}...")
    text = parser.fetch_filing(cik, 'DEF 14A')
    if not text:
        print("❌ Filing not found")
        return
    
    clean_text = parser.clean_text(text)
    headers = ['Director Biographies', 'Nominees for Director', 'Election of Directors', 'Director Nominees', 'Board of Directors']
    
    # Find where Age patterns are located
    print("\n🔍 Locating Age patterns in entire text:")
    age_pattern = r'Age[:\s]+(\d{2})'
    for match in re.finditer(age_pattern, clean_text):
        print(f"✅ Found Age at index {match.start()}: {clean_text[match.start():match.start()+50]}")
        if match.start() > 100000: break # Just a few

if __name__ == "__main__":
    import re
    analyze_proxy('0000789019') # Microsoft
