
import requests
from bs4 import BeautifulSoup

HEADERS = {'User-Agent': 'Tanya Matanda tanyamatanda@riskanchor.com'}
cik = "0001321655" # Palantir
url = "https://www.sec.gov/cgi-bin/browse-edgar"
params = {
    'action': 'getcompany',
    'CIK': cik,
    'type': '',
    'dateb': '',
    'owner': 'exclude',
    'count': 20,
    'output': 'atom'
}

print(f"Fetching feed for CIK {cik}...")
resp = requests.get(url, params=params, headers=HEADERS)
print(f"Status: {resp.status_code}")

soup = BeautifulSoup(resp.content, 'xml')
entries = soup.find_all('entry')

print(f"Found {len(entries)} entries.")
for i, entry in enumerate(entries):
    filing_type = entry.find('filing-type').text if entry.find('filing-type') else 'N/A'
    accession = entry.find('accession-number').text if entry.find('accession-number') else 'N/A'
    # Note: typo in collector was accession-nunber? Let's check.
    
    print(f"{i}: Type={filing_type}, Acc={accession}")
