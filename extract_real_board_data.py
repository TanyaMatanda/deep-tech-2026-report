import os
import re
import requests
import time
from bs4 import BeautifulSoup
from supabase import create_client, Client, ClientOptions
import toml

# Configuration
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
    except:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")

if not url or not key:
    print("❌ Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

HEADERS = {'User-Agent': 'RiskAnchor Governance Research research@riskanchor.com'}

def get_document_url(index_url):
    """Extracts the main document URL from an SEC index page."""
    try:
        response = requests.get(index_url, headers=HEADERS, timeout=10)
        if response.status_code != 200: return None
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Look for the 'Document Format Files' table
        table = soup.find('table', class_='tableFile')
        
        # Fallback: Look for any link ending in .htm that isn't index.htm
        if not table:
            # Debug: print start of HTML to see what we got
            print(f"   Debug: No tableFile found. HTML start: {str(soup)[:500]}")
            
        for link in soup.find_all('a'):
            href = link.get('href')
            if href and href.endswith('.htm') and 'index.htm' not in href:
                 if '/ix?doc=' in href:
                    href = href.split('/ix?doc=')[1]
                 if href.startswith('/'):
                    return f"https://www.sec.gov{href}"
                 else:
                    return f"https://www.sec.gov/{href}"
                    
        return None
    except Exception as e:
        print(f"Error parsing index: {e}")
        return None
    except Exception as e:
        print(f"Error parsing index: {e}")
        return None

def extract_directors(text, soup):
    """
    Heuristic extraction of director names.
    Looks for "Election of Directors" section and subsequent names.
    """
    directors = []
    
    # Strategy 1: Look for "Nominees for Director" or "Director Nominees" tables
    # This is very specific and might need adjustment per company
    
    # Simple regex for names following "Director" or in a list
    # This is hard to do generically. 
    # Let's try to find the "Election of Directors" header and then look for capitalized names.
    
    # For now, let's try a very specific pattern for standard proxy statements
    # Often names are in bold in a table row.
    
    # Let's try to find lines that look like names (2-3 words, capitalized) near "Director" keywords
    # This is a "best effort" for a demo.
    
    lines = [line.strip() for line in text.split('\n') if line.strip()]
    
    capture = False
    count = 0
    
    for i, line in enumerate(lines):
        if "election of directors" in line.lower() or "nominees for election" in line.lower():
            capture = True
            continue
            
        if capture:
            # Stop if we hit another section
            if "executive compensation" in line.lower() or "audit committee" in line.lower() or "ratification" in line.lower():
                break
                
            # Heuristic: Name is usually short, capitalized, and might have "Director" or "Age" nearby in the original HTML
            # But here we just have text.
            
            # Let's look for lines that are just names
            # e.g. "Mary Barra"
            # e.g. "Mary Barra"
            if 3 < len(line) < 30 and all(x.isalpha() or x.isspace() or x in ".-," for x in line):
                # Check if it looks like a name (Title Case)
                # Exclude ALL CAPS (likely headers)
                if line.isupper():
                    continue
                    
                if line[0].isupper() and " " in line:
                    # Avoid common false positives
                    bad_words = ["vote", "board", "committee", "director", "company", "shareholder", "meeting", "proxy", "executive", "officer", "governance", "ownership", "securities", "audit", "compensation", "nominee", "election", "ratification", "proposal", "table", "content", "page"]
                    if any(x in line.lower() for x in bad_words):
                        continue
                        
                    directors.append(line)
                    count += 1
                    
            if count > 15: # Safety break
                break
                
    return list(set(directors)) # Deduplicate

def process_companies(limit=5):
    print(f"🚀 Starting Real Board Extraction (Limit: {limit})...")
    
    # Get companies with filings
    response = supabase.table('sec_filings').select('company_id, filing_url, companies(company_name, ticker_symbol)').eq('filing_type', 'DEF 14A').limit(limit).execute()
    
    for row in response.data:
        company = row['companies']
        if not company: continue
        
        ticker = company['ticker_symbol']
        name = company['company_name']
        company_id = row['company_id']
        index_url = row['filing_url']
        
        print(f"Processing {ticker} ({name})...")
        print(f"   Index URL: {index_url}")
        
        doc_url = get_document_url(index_url)
        if not doc_url:
            print(f"   ⚠️ Could not resolve doc URL")
            # Debug: fetch index page and print links
            try:
                r = requests.get(index_url, headers=HEADERS, timeout=10)
                soup = BeautifulSoup(r.content, 'html.parser')
                print(f"   Debug: Found {len(soup.find_all('a'))} links on index page.")
                for a in soup.find_all('a')[:5]:
                    print(f"      - {a.get('href')}")
            except:
                pass
            continue
            
        print(f"   Doc URL: {doc_url}")

        try:
            resp = requests.get(doc_url, headers=HEADERS, timeout=15)
            soup = BeautifulSoup(resp.content, 'html.parser')
            text = soup.get_text(separator='\n', strip=True)
        except:
            print(f"   ❌ Error fetching document")
            continue
            
        directors = extract_directors(text, soup)
        
        if not directors:
            print(f"   ⚠️ No directors found (heuristics failed)")
            # Debug: print snippet
            if "Election of Directors" in text:
                print("   Debug: Found 'Election of Directors' in text.")
                idx = text.find("Election of Directors")
                print(f"   Snippet: {text[idx:idx+200]}...")
            continue
            
        print(f"   ✅ Found {len(directors)} potential directors: {directors[:3]}...")
        
        # Insert into DB
        for d_name in directors:
            # Split name
            parts = d_name.split()
            first = parts[0]
            last = parts[-1]
            
            # Create Person
            p_data = {
                "full_name": d_name,
                "first_name": first,
                "last_name": last,
                "current_title": "Director",
                "expertise_areas": ["Governance"] # Default
            }
            
            try:
                # Check if exists (simple check by name)
                # In production we'd use more sophisticated matching
                p_res = supabase.table("people").select("id").eq("full_name", d_name).execute()
                if p_res.data:
                    person_id = p_res.data[0]['id']
                else:
                    p_res = supabase.table("people").insert(p_data).execute()
                    person_id = p_res.data[0]['id']
                
                # Link
                cp_data = {
                    "company_id": company_id,
                    "person_id": person_id,
                    "role_title": "Director",
                    "role_type": "Director",
                    "is_board_member": True,
                    "is_current": True
                }
                
                supabase.table("company_people").upsert(cp_data, on_conflict="company_id, person_id, role_title, start_date").execute()
                
            except Exception as e:
                # Ignore dupe errors or constraint violations for now
                pass
                
        time.sleep(1)

if __name__ == "__main__":
    process_companies(limit=100)
