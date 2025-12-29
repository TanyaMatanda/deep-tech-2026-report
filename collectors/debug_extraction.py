"""
Debug script to test extraction patterns against real Microsoft proxy
"""
import sys
sys.path.append('.')

from sec_filing_parser import SECFilingParser
import re

parser = SECFilingParser()

print("Fetching Microsoft DEF 14A...")
proxy = parser.fetch_filing('0000789019', 'DEF 14A')

if not proxy:
    print("❌ Could not fetch proxy")
    exit(1)

proxy_text = parser.clean_text(proxy)

print(f"\n{'='*80}")
print(f"MICROSOFT PROXY TEXT LENGTH: {len(proxy_text)} characters")
print(f"{'='*80}\n")

# Test specific patterns
test_cases = [
    {
        'name': 'Say-on-Pay',
        'keywords': ['say on pay', 'advisory vote', 'executive compensation', 'compensation program'],
        'sample_length': 200
    },
    {
        'name': 'Split Chair/CEO',
        'keywords': ['chairman', 'independent chair', 'separate roles', 'CEO and chair'],
        'sample_length': 150
    },
    {
        'name': 'Cyber Oversight',
        'keywords': ['cybersecurity', 'information security', 'CISO', 'audit committee'],
        'sample_length': 150
    },
    {
        'name': 'STIP/Annual Bonus',
        'keywords': ['short-term incentive', 'annual bonus', 'STIP', 'target bonus'],
        'sample_length': 150
    },
    {
        'name': 'LTIP/Equity',
        'keywords': ['long-term incentive', 'equity award', 'LTIP', 'performance shares', 'RSU'],
        'sample_length': 150
    },
    {
        'name': 'Perquisites',
        'keywords': ['perquisites', 'all other compensation', 'personal use', 'aircraft'],
        'sample_length': 150
    }
]

for test in test_cases:
    print(f"\n{'='*80}")
    print(f"Testing: {test['name']}")
    print(f"{'='*80}\n")
    
    found_any = False
    for keyword in test['keywords']:
        # Find all matches
        pattern = re.compile(r'.{{0,{}}}{}.{{0,{}}}'.format(
            test['sample_length'], 
            re.escape(keyword), 
            test['sample_length']
        ), re.IGNORECASE | re.DOTALL)
        
        matches = list(pattern.finditer(proxy_text))
        
        if matches:
            found_any = True
            print(f"✓ Found '{keyword}' ({len(matches)} occurrences)")
            # Show first match context
            if len(matches) > 0:
                sample = matches[0].group(0)
                # Clean up whitespace
                sample = re.sub(r'\s+', ' ', sample).strip()
                print(f"  Sample: ...{sample[:test['sample_length']]}...")
            print()
    
    if not found_any:
        print(f"✗ No keywords found for {test['name']}")

# Test actual extraction methods
print(f"\n\n{'='*80}")
print("TESTING EXTRACTION METHODS")
print(f"{'='*80}\n")

results = {
    'Board Independence': parser.extract_board_independence(proxy_text),
    'Say-on-Pay': parser.extract_say_on_pay(proxy_text),
    'Split Chair/CEO': parser.extract_split_chair_ceo(proxy_text),
    'CEO Pay Ratio': parser.extract_ceo_pay_ratio(proxy_text),
    'Cyber Oversight': parser.has_cyber_oversight(proxy_text),
}

# Add new methods
comp_details = parser.extract_stip_ltip_combined(proxy_text)

for key, value in results.items():
    status = "✓" if value is not None and value is not False else "✗"
    print(f"{status} {key}: {value}")

print(f"\n--- Compensation Details ---")
if comp_details:
    for key, value in comp_details.items():
        print(f"✓ {key}: {value}")
else:
    print("✗ No compensation details extracted")
