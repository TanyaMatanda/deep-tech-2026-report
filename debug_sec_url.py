
import requests
from bs4 import BeautifulSoup

HEADERS = {'User-Agent': 'Tanya Matanda tanyamatanda@riskanchor.com'}
url = "https://www.sec.gov/Archives/edgar/data/1321655/000132165524000012/0001321655-24-000012-index.htm"

print(f"Fetching {url}...")
resp = requests.get(url, headers=HEADERS)
print(f"Status: {resp.status_code}")

soup = BeautifulSoup(resp.content, 'html.parser')
print(f"Title: {soup.title.string if soup.title else 'No Title'}")

print("\nLinks found:")
for a in soup.find_all('a'):
    href = a.get('href')
    if href:
        print(f" - {href}")
        
print("\nTable classes:")
for table in soup.find_all('table'):
    print(f" - {table.get('class')}")
