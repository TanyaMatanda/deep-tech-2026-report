
import requests
from bs4 import BeautifulSoup

def debug_feed():
    url = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&SIC=2834&owner=include&count=10&output=atom"
    headers = {'User-Agent': 'RiskAnchor contact@riskanchor.com'}
    
    print(f"Fetching {url}...")
    response = requests.get(url, headers=headers)
    
    print(f"Status: {response.status_code}")
    print("\nRaw Content (First 2000 chars):")
    print(response.text[:2000])
    
    soup = BeautifulSoup(response.content, 'xml')
    entries = soup.find_all('entry')
    print(f"\nEntries Found: {len(entries)}")
    
    for i, entry in enumerate(entries):
        print(f"\n--- Entry {i} ---")
        print(f"Title: {entry.find('title').text}")
        print(f"Summary: {entry.find('summary').text[:100]}...")

if __name__ == "__main__":
    debug_feed()
