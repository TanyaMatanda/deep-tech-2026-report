import requests
from bs4 import BeautifulSoup
import re

def get_document_url(index_url):
    """
    Parse the SEC index page to find the main HTML document URL.
    """
    headers = {'User-Agent': 'Tanya Matanda tanyamatanda@riskanchor.com'}
    try:
        response = requests.get(index_url, headers=headers)
        if response.status_code != 200:
            print(f"Error fetching index: {response.status_code}")
            return None
            
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Look for the document table
        # The first row with a .htm file is usually the main document
        for row in soup.find_all('tr'):
            links = row.find_all('a')
            for link in links:
                href = link.get('href')
                if href and href.endswith('.htm'):
                    # Handle iXBRL viewer links
                    if '/ix?doc=' in href:
                        # Extract the raw path: /ix?doc=/Archives/... -> /Archives/...
                        raw_path = href.split('/ix?doc=')[1]
                        return f"https://www.sec.gov{raw_path}"
                    
                    # Standard link
                    return f"https://www.sec.gov{href}"
        return None
    except Exception as e:
        print(f"Error parsing index: {e}")
        return None

def parse_filing(url):
    """
    Fetch and parse the filing content.
    """
    headers = {'User-Agent': 'Tanya Matanda tanyamatanda@riskanchor.com'}
    print(f"Fetching filing: {url}")
    
    try:
        response = requests.get(url, headers=headers)
        if response.status_code != 200:
            print(f"Error fetching filing: {response.status_code}")
            return
            
        text = response.text
        soup = BeautifulSoup(text, 'html.parser')
        clean_text = soup.get_text(separator=' ', strip=True)
        
        # 1. Extract CEO Pay Ratio
        # Look for "CEO Pay Ratio" or "Pay Ratio" followed by numbers
        pay_ratio_match = re.search(r'CEO\s+Pay\s+Ratio.*?(\d+)\s*to\s*1', clean_text, re.IGNORECASE | re.DOTALL)
        if pay_ratio_match:
            print(f"✅ CEO Pay Ratio: {pay_ratio_match.group(1)}:1")
        else:
            print("⚠️ CEO Pay Ratio not found (simple regex)")
            
        # 2. Extract Board Size (Count director nominees)
        # Look for "Election of Directors" section and count names? 
        # Easier: Look for "The Board has set the number of directors at X"
        board_size_match = re.search(r'number\s+of\s+directors\s+(?:is|at|to\s+be)\s+(\d+|[a-zA-Z]+)', clean_text, re.IGNORECASE)
        if board_size_match:
            print(f"✅ Board Size Mention: {board_size_match.group(1)}")
            
        # 3. Extract "Artificial Intelligence" mentions
        ai_count = len(re.findall(r'artificial\s+intelligence|AI\s+|machine\s+learning', clean_text, re.IGNORECASE))
        print(f"✅ AI Mentions: {ai_count}")
        
        # 4. Extract "Cybersecurity" mentions
        cyber_count = len(re.findall(r'cybersecurity|cyber\s+risk|information\s+security', clean_text, re.IGNORECASE))
        print(f"✅ Cybersecurity Mentions: {cyber_count}")

        # 5. Extract Proposals
        print("\n🔍 Searching for Proposals...")
        # Pattern: "Proposal [Number]: [Description]" or "Item [Number]. [Description]"
        # We'll look for lines that start with these patterns
        
        # Split by lines to avoid matching across huge blocks
        lines = [line.strip() for line in clean_text.split('\n') if line.strip()]
        
        found_proposals = []
        for line in lines:
            # Regex for "Item 4. Advisory Vote..." or "Proposal 4: Shareholder Proposal..."
            # Limit length to avoid capturing paragraphs
            if len(line) < 200:
                match = re.search(r'^(?:Item|Proposal)\s+(\d+)[\.:]\s+(.+)', line, re.IGNORECASE)
                if match:
                    num = match.group(1)
                    desc = match.group(2)
                    # Filter out common noise
                    if "page" not in desc.lower() and "continue" not in desc.lower():
                        found_proposals.append((num, desc))
                        print(f"   found: Item {num} - {desc}")
        
        if not found_proposals:
            print("⚠️ No structured proposals found in plain text. Trying soup headers...")
            # Try looking for <h5> or <b> tags containing "Proposal"
            for tag in soup.find_all(['h3', 'h4', 'h5', 'b', 'strong']):
                text = tag.get_text(strip=True)
                if re.search(r'^(?:Item|Proposal)\s+\d+', text, re.IGNORECASE):
                     print(f"   found (tag): {text}")

    except Exception as e:
        print(f"Error parsing filing: {e}")

if __name__ == "__main__":
    # VRTX 2024 Proxy (from CSV)
    # Note: The CSV had 2025 dates which might be future dates/estimates or the CSV parser logic was weird?
    # Let's use the URL from the CSV for VRTX (Vertex Pharma)
    # CSV URL: https://www.sec.gov/Archives/edgar/data/875320/000130817924000452/0001308179-24-000452-index.htm
    
    index_url = "https://www.sec.gov/Archives/edgar/data/875320/000130817924000452/0001308179-24-000452-index.htm"
    
    doc_url = get_document_url(index_url)
    if doc_url:
        parse_filing(doc_url)
    else:
        print("Could not find document URL")
