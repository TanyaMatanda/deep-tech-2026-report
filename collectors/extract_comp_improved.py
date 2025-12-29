"""
Improved SEC Compensation Extractor
Uses text-based extraction (like sec_filing_parser.py) instead of HTML table parsing
Much more reliable for iXBRL format
"""

import re
import requests
import time
import logging
from typing import Dict, List, Optional
from bs4 import BeautifulSoup
from supabase import create_client, Client, ClientOptions
import toml
import os

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Supabase config
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
        url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
    except:
        url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

class ImprovedCompensationExtractor:
    """Extract compensation using robust text-based methods"""
    
    SEC_DATA_BASE = "https://data.sec.gov"
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {
        'User-Agent': 'RiskAnchor Governance Research research@riskanchor.com',
        'Accept-Encoding': 'gzip, deflate'
    }
    
    def __init__(self):
        self.request_count = 0
        self.last_request_time = 0
    
    def rate_limit(self):
        """Enforce SEC 10 requests/second limit"""
        self.request_count += 1
        current_time = time.time()
        elapsed = current_time - self.last_request_time
        
        if elapsed < 0.1:
            time.sleep(0.1 - elapsed)
        
        self.last_request_time = time.time()
    
    def fetch_proxy(self, cik: str) -> Optional[str]:
        """Fetch most recent DEF 14A using SEC JSON API"""
        self.rate_limit()
        
        cik_padded = cik.zfill(10)
        cik_no_padding = str(int(cik))
        
        try:
            submissions_url = f"{self.SEC_DATA_BASE}/submissions/CIK{cik_padded}.json"
            response = requests.get(submissions_url, headers=self.HEADERS, timeout=10)
            response.raise_for_status()
            
            data = response.json()
            filings = data.get('filings', {}).get('recent', {})
            
            if not filings:
                return None
            
            forms = filings.get('form', [])
            accession_numbers = filings.get('accessionNumber', [])
            primary_documents = filings.get('primaryDocument', [])
            
            target_index = None
            for i, form in enumerate(forms):
                if form == 'DEF 14A':
                    target_index = i
                    break
            
            if target_index is None:
                return None
            
            accession = accession_numbers[target_index].replace('-', '')
            primary_doc = primary_documents[target_index]
            
            doc_url = f"{self.SEC_BASE}/Archives/edgar/data/{cik_no_padding}/{accession}/{primary_doc}"
            
            self.rate_limit()
            
            doc_response = requests.get(doc_url, headers=self.HEADERS, timeout=15)
            if doc_response.status_code == 200:
                logger.info(f"✓ Found DEF 14A for CIK {cik}")
                return doc_response.text
            
            return None
            
        except Exception as e:
            logger.error(f"Error fetching proxy for CIK {cik}: {e}")
            return None
    
    def clean_text(self, html: str) -> str:
        """Convert HTML to clean text"""
        soup = BeautifulSoup(html, 'html.parser')
        text = soup.get_text()
        # Clean whitespace
        text = re.sub(r'\s+', ' ', text)
        return text.strip()
    
    def extract_executive_compensation(self, html: str) -> List[Dict]:
        """Extract compensation using text-based regex patterns"""
        clean = self.clean_text(html)
        
        # Strategy: Find "Summary Compensation Table" section
        # Then extract blocks that match Executive Name + Salary pattern
        
        results = []
        
        # Pattern to find NEO sections
        # Look for: Name + Title + Year + Salary + Bonus + Stock etc.
        # Example: "John Doe Chief Executive Officer 2023 $1,000,000 $500,000..."
        
        # First find the SCT section
        sct_match = re.search(
            r'SUMMARY COMPENSATION TABLE(.*?)(?:GRANTS OF PLAN|OUTSTANDING EQUITY|$)',
            clean,
            re.IGNORECASE | re.DOTALL
        )
        
        if not sct_match:
            logger.warning("Could not find Summary Compensation Table section")
            return []
        
        sct_section = sct_match.group(1)
        
        # Pattern for compensation data
        # Matches: Name (2-4 words) + Title + Dollar amounts
        pattern = r'([A-Z][a-z]+(?:\s+[A-Z]\.?)?\s+[A-Z][a-z]+)\s+(?:([A-Za-z\s,&]+?Officer|CEO|CFO|President|EVP|SVP)).*?\$\s?([0-9,]+)'
        
        matches = re.finditer(pattern, sct_section[:50000])  # Limit to first 50K chars
        
        for match in matches:
            name = match.group(1).strip()
            title = match.group(2).strip() if match.group(2) else ''
            
            # Find all dollar amounts after the name
            remaining_text = sct_section[match.end():match.end()+500]
            amounts = re.findall(r'\$\s?([0-9,]+)', remaining_text)
            
            if amounts:
                # Try to parse total compensation (usually the last amount)
                try:
                    total = int(amounts[-1].replace(',', ''))
                    if total > 50000:  # Minimum threshold for executives
                        results.append({
                            'name': name,
                            'title': title,
                            'total_compensation': total
                        })
                        logger.info(f"  ✓ {name} ({title}): ${total:,}")
                except:
                    pass
        
        return results
    
    def process_company(self, company_id: str, cik: str, ticker: str) -> Dict:
        """Process single company"""
        logger.info(f"\n{'='*60}")
        logger.info(f"Processing {ticker} (CIK: {cik})")
        logger.info(f"{'='*60}")
        
        html = self.fetch_proxy(cik)
        if not html:
            logger.warning(f"No proxy found for {ticker}")
            return {}
        
        sct_data = self.extract_executive_compensation(html)
        
        logger.info(f"\nExtracted {len(sct_data)} NEOs for {ticker}")
        
        # Save to database
        for neo in sct_data:
            try:
                person = supabase.table('people').select('id').eq('full_name', neo['name']).execute()
                
                if person.data:
                    person_id = person.data[0]['id']
                else:
                    new_person = supabase.table('people').insert({
                        'full_name': neo['name'],
                        'current_title': neo['title']
                    }).execute()
                    person_id = new_person.data[0]['id']
                
                comp_record = {
                    'company_id': company_id,
                    'person_id': person_id,
                    'fiscal_year': 2024,
                    'role': neo['title'],
                    'total_compensation': neo['total_compensation']
                }
                
                supabase.table('executive_compensation_annual').upsert(
                    comp_record,
                    on_conflict='company_id,person_id,fiscal_year'
                ).execute()
                
                logger.info(f"  ✅ Saved {neo['name']}")
                
            except Exception as e:
                logger.error(f"  ❌ Error saving {neo['name']}: {e}")
        
        return {'sct_data': sct_data}

def run_extraction(limit: int = 50):
    """Run compensation extraction"""
    extractor = ImprovedCompensationExtractor()
    
    logger.info(f"🚀 Starting Improved Compensation Extraction (Limit: {limit})")
    
    companies = supabase.table('companies').select('id, company_name, ticker_symbol, cik').not_.is_('cik', 'null').limit(limit).execute()
    
    logger.info(f"Found {len(companies.data)} companies with CIKs\n")
    
    for company in companies.data:
        if not company.get('cik'):
            continue
        
        try:
            extractor.process_company(
                company_id=company['id'],
                cik=company['cik'],
                ticker=company.get('ticker_symbol', 'Unknown')
            )
            time.sleep(1)
            
        except Exception as e:
            logger.error(f"Error processing {company.get('ticker_symbol')}: {e}")
            continue
    
    logger.info("\n✅ Extraction complete!")

if __name__ == "__main__":
    import sys
    limit = int(sys.argv[1]) if len(sys.argv) > 1 else 50
    run_extraction(limit)
