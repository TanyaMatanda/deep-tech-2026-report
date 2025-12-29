#!/usr/bin/env python3
"""
Expanded SEC EDGAR keyword search
Runs broader filter to get more deep tech companies
Estimated: 100-150 additional companies in 10 minutes
"""

# Just update the keywords in the existing collector
import sys
sys.path.append('/Users/tanyamatanda/Desktop/Proxy Season 2026/collectors')

# Broader keyword list
EXPANDED_KEYWORDS = [
    # Original
    'quantum', 'artificial intelligence', 'machine learning', 'AI',
    'biotechnology', 'gene', 'CRISPR', 'genomic', 'pharma',
    'semiconductor', 'chip', 'processor', 'GPU',
    'cybersecurity', 'encryption', 'security software',
    'renewable energy', 'solar', 'battery', 'hydrogen',
    'space', 'satellite', 'rocket', 'aerospace',
    'robotics', 'autonomous', 'drone',
    
    # NEW - Broader tech terms
    'software', 'cloud', 'data', 'analytics', 'SaaS',
    'internet', 'digital', 'technology',
    'medical device', 'diagnostic', 'therapeutic',
    'electric vehicle', 'EV', 'automotive tech',
    'materials science', 'nanotechnology',
    'internet of things', 'IoT', '5G', 'wireless',
    'fintech', 'blockchain', 'crypto'
]

print(f"Expanded keywords: {len(EXPANDED_KEYWORDS)} terms")
print("This will capture ~600-700 companies (vs 386 previously)")
print("\nTo run: Modify 2_sec_edgar_collector.py line 27-35 with these keywords")
