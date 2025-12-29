import os
import re
import requests
import time
from bs4 import BeautifulSoup
from supabase import create_client, Client, ClientOptions

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

HEADERS = {'User-Agent': 'RiskAnchor Governance Research research@riskanchor.com'}

def init_connection():
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def get_document_text(url):
    try:
        # If it's an index page, find the document
        if "index.htm" in url or "Archives/edgar/data" in url and not url.endswith(".txt"):
             response = requests.get(url, headers=HEADERS, timeout=10)
             if response.status_code != 200: return None
             soup = BeautifulSoup(response.content, 'html.parser')
             for link in soup.find_all('a'):
                href = link.get('href')
                if href and href.endswith('.htm') and 'index.htm' not in href:
                     if '/ix?doc=' in href:
                        href = href.split('/ix?doc=')[1]
                     if href.startswith('/'):
                        url = f"https://www.sec.gov{href}"
                     else:
                        url = f"https://www.sec.gov/{href}"
                     break
        
        print(f"   Fetching doc: {url}")
        resp = requests.get(url, headers=HEADERS, timeout=15)
        soup = BeautifulSoup(resp.content, 'html.parser')
        text = soup.get_text(separator='\n', strip=True)
        return text
    except Exception as e:
        print(f"   ❌ Error fetching document: {e}")
        return None

def analyze_governance(text):
    data = {
        "total_directors": 0,
        "independent_directors": 0,
        "women_directors": 0,
        "has_ai_oversight": False,
        "ai_committee_name": None,
        "tech_experts": 0
    }
    
    # 1. Board Size & Independence
    # Look for "X independent directors" or count names in a table
    # Heuristic: Search for "Director Independence" section
    
    # Simple regex for "X of Y directors are independent"
    match = re.search(r'(\d+)\s+of\s+our\s+(\d+)\s+directors\s+are\s+independent', text, re.IGNORECASE)
    if match:
        data["independent_directors"] = int(match.group(1))
        data["total_directors"] = int(match.group(2))
    else:
        # Fallback: Count occurrences of "Independent Director" in a list? Too risky.
        # Let's default to a safe guess if we find "majority of independent directors"
        if "majority of our directors are independent" in text.lower():
             # We need a total count. Let's count "Director" occurrences in the "Nominees" section
             pass

    # 2. Gender Diversity
    # Count "Ms." or "Mrs." or "she/her" in Director bios
    # This is rough but works for a first pass
    women_count = len(re.findall(r'\b(Ms\.|Mrs\.|She\s|Her\s)\b', text))
    # Normalize: This counts pronouns, so divide by average pronouns per bio (say 5)? 
    # Better: Count unique names associated with Ms.?
    # Let's just look for "Ms. [Name]" pattern
    women_names = re.findall(r'Ms\.\s+([A-Z][a-z]+)', text)
    data["women_directors"] = len(set(women_names))
    
    # 3. AI Governance
    if "Artificial Intelligence" in text or "AI" in text:
        # Check context
        if "Technology Committee" in text or "Science and Technology Committee" in text:
            data["has_ai_oversight"] = True
            data["ai_committee_name"] = "Technology Committee" # Guess
        if "AI ethics" in text.lower() or "responsible AI" in text.lower():
             pass # Could set a flag
             
    # 4. Tech Experts
    # Look for "Cybersecurity" or "Technology" in director skills matrix
    tech_keywords = ["Cybersecurity", "Information Security", "Technology", "Software", "Digital"]
    tech_mentions = 0
    for kw in tech_keywords:
        tech_mentions += text.count(kw)
    
    # Heuristic: If high mentions, assume some experts
    if tech_mentions > 5:
        data["tech_experts"] = max(1, tech_mentions // 10) # Very rough guess

    return data

def process_filings(limit=20):
    client = init_connection()
    print(f"🚀 Starting Real Data Extraction (Limit: {limit})...")
    
    # Get filings
    # We need companies that have a DEF 14A filing
    res = client.table('sec_filings').select('company_id, filing_url, companies(ticker_symbol)').eq('filing_type', 'DEF 14A').limit(limit).execute()
    
    for row in res.data:
        company = row['companies']
        if not company: continue
        ticker = company['ticker_symbol']
        cid = row['company_id']
        url = row['filing_url']
        
        print(f"Processing {ticker}...")
        text = get_document_text(url)
        if not text: continue
        
        gov_data = analyze_governance(text)
        print(f"   Data: {gov_data}")
        
        # Update DB
        # 1. Board Composition
        update_data = {
            "company_id": cid,
            "fiscal_year": 2025, # Assuming current proxy
            "total_directors": gov_data["total_directors"] if gov_data["total_directors"] > 0 else None,
            "independent_directors": gov_data["independent_directors"] if gov_data["independent_directors"] > 0 else None,
            "women_directors": gov_data["women_directors"],
            "women_percentage": (gov_data["women_directors"] / gov_data["total_directors"] * 100) if gov_data["total_directors"] > 0 else 0,
            "tech_experts": gov_data["tech_experts"],
            "has_ai_oversight_committee": gov_data["has_ai_oversight"]
        }
        
        # Remove None values to avoid overwriting existing data with nulls if we failed to extract
        clean_update = {k: v for k, v in update_data.items() if v is not None}
        
        try:
            client.table("board_composition_annual").upsert(clean_update, on_conflict="company_id, fiscal_year").execute()
            print("   ✅ Updated Board Composition")
        except Exception as e:
            print(f"   ⚠️ Update failed: {e}")
            
        # 2. AI Columns (Try to update if they exist)
        if gov_data["has_ai_oversight"]:
            try:
                client.table("companies").update({"has_ai_ethics_board": True}).eq("id", cid).execute()
                print("   ✅ Updated Company AI Flags")
            except:
                pass # Column might not exist

if __name__ == "__main__":
    process_filings(limit=50)
