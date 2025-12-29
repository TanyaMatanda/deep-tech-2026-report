import sys
import os
import re
from collectors.sec_filing_parser import SECFilingParser

def debug_diversity(cik, company_name):
    print(f"Debugging diversity extraction for {company_name} (CIK: {cik})")
    parser = SECFilingParser()
    
    # Fetch filing
    text = parser.fetch_filing(cik, 'DEF 14A')
    if not text:
        print("No proxy filing found.")
        return

    print(f"Found filing text.")
    
    if not text:
        print("Could not fetch filing text.")
        return
        
    print(f"Text length (raw): {len(text)}")
    
    # Clean text
    text = parser.clean_text(text)
    print(f"Text length (cleaned): {len(text)}")
    
    # Search for keywords to see context
    keywords = ['diversity', 'women', 'female', 'gender', 'male', 'non-binary', 'part i', 'total number of directors']
    for kw in keywords:
        print(f"\n--- Context for '{kw}' ---")
        matches = list(re.finditer(kw, text, re.IGNORECASE))
        print(f"Found {len(matches)} occurrences.")
        for i, match in enumerate(matches[:3]):
            start = max(0, match.start() - 100)
            end = min(len(text), match.end() + 100)
            print(f"Match {i+1}: ...{text[start:end].replace(chr(10), ' ')}...")

    # Manual trace of patterns
    print("\n--- Pattern Tracing ---")
    patterns = [
        r'(\d+)\s+of\s+(?:our\s+)?(\d+)\s+directors?\s+(?:are|identify\s+as)\s+(?:women|female)',
        r'board.*?(\d+)%.*?(?:diverse|women|female|underrepresented)',
        r'diversity.*?(\d+)\s+of\s+(\d+)',
    ]
    
    for i, pattern in enumerate(patterns):
        match = re.search(pattern, text, re.IGNORECASE)
        if match:
            print(f"Pattern {i+1} MATCHED: {pattern}")
            print(f"Groups: {match.groups()}")
            print(f"Full match: {match.group(0)}")
        else:
            print(f"Pattern {i+1} did not match.")

    # Test current extraction
    result = parser.extract_board_diversity(text)
    print(f"\nCurrent extraction result: {result}")

if __name__ == "__main__":
    # Frontier Communications Parent, Inc.
    debug_diversity("0000020520", "Frontier Communications Parent, Inc.")
