"""
Test SEC RSS feed parsing without database
Just to verify the feed works and our parsing logic is correct
"""

import feedparser
import re
from datetime import datetime

RSS_URL = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&CIK=&type=8-K&company=&dateb=&owner=exclude&start=0&count=40&output=atom"

print("Fetching 8-K filings from SEC RSS...")
print("=" * 70)

feed = feedparser.parse(RSS_URL)

print(f"\nFound {len(feed.entries)} entries in feed\n")

for i, entry in enumerate(feed.entries[:10], 1):  # Show first 10
    print(f"{i}. {entry.title}")
    print(f"   Published: {entry.published}")
    print(f"   Link: {entry.link}")
    
    # Try to parse
    title_match = re.match(r'^([A-Z0-9\s\-/]+)\s+-\s+(.+)\s+\((\d+)\)', entry.title)
    if title_match:
        form = title_match.group(1).strip()
        company = title_match.group(2).strip()
        cik = title_match.group(3).strip()
        print(f"   → Form: {form} | Company: {company} | CIK: {cik}")
    print()
