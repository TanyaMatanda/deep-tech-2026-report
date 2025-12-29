"""
Direct XBRL Parsing for Compensation Extraction
Extracts data from iXBRL tags embedded in SEC proxies
100% free, works for all iXBRL filings
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
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

class XBRLCompensationExtractor:
    """Extract compensation from iXBRL tags"""
    
    SEC_DATA_BASE = "https://data.sec.gov"
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {
        'User-Agent': 'RiskAnchor research@riskanchor.com'
    }
    
    def __init__(self):
        self.last_request_time = 0
    
    def rate_limit(self):
        current_time = time.time()
        elapsed = current_time - self.last_request_time
        if elapsed < 0.1:
            time.sleep(0.1 - elapsed)
        self.last_request_time = time.time()
    
    def fetch_proxy(self, cik: str) -> Optional[str]:
        """Fetch DEF 14A"""
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
            accessions = filings.get('accessionNumber', [])
            docs = filings.get('primaryDocument', [])
            
            idx = next((i for i, f in enumerate(forms) if f == 'DEF 14A'), None)
            
            if idx is None:
                return None
            
            accession = accessions[idx].replace('-', '')
            doc = docs[idx]
            
            url = f"{self.SEC_BASE}/Archives/edgar/data/{cik_no_padding}/{accession}/{doc}"
            
            self.rate_limit()
            
            resp = requests.get(url, headers=self.HEADERS, timeout=15)
            if resp.status_code == 200:
                logger.info(f"✓ Found proxy for CIK {cik}")
                return resp.text
            
            return None
        except Exception as e:
            logger.error(f"Error: {e}")
            return None
    
    def extract_xbrl_compensation(self, html: str) -> List[Dict]:
        """Extract compensation from iX BRL tags"""
        
        soup = BeautifulSoup(html, 'lxml')
        results = []
        
        # Find all iXBRL contexts (one per executive per year)
        # Look for ix:nonFraction or ix:nonNumeric tags
        
        # Strategy: Find Summary Compensation Table section first
        # Then extract executive names and associated XBRL values
        
        # Find executive names in context IDs
        contexts = soup.find_all(attrs={'contextref': True})
        
        executive_data = {}
        
        for elem in contexts:
            context_id = elem.get('contextref', '')
            
            # Look for compensation-related XBRL elements
            name_attr = elem.get('name', '')
            
            if any(comp_term in name_attr.lower() for comp_term in [
                'compensation', 'salary', 'bonus', 'stock', 'option', 'incentive'
            ]):
                # Try to extract value
                value_text = elem.get_text(strip=True)
                
                # Remove commas and convert to number
                try:
                    value = int(re.sub(r'[^\d]', '', value_text))
                    
                    # Store by context
                    if context_id not in executive_data:
                        executive_data[context_id] = {}
                    
                    executive_data[context_id][name_attr] = value
                    
                except:
                    pass
        
        # Fallback: Use simpler table-based extraction with XBRL awareness
        # Find tables that contain both executive names AND iXBRL tags
        
        for table in soup.find_all('table'):
            table_html = str(table)
            
            # Must contain compensation keywords AND XBRL tags
            has_comp = 'summary compensation' in table_html.lower() or 'executive compensation' in table_html.lower()
            has_xbrl = 'ix:' in table_html or 'contextref' in table_html
            
            if not (has_comp or has_xbrl):
                continue
            
            logger.info("Found table with potential XBRL data")
            
            # Extract rows
            rows = table.find_all('tr')
            
            for row in rows:
                cells = row.find_all(['td', 'th'])
                
                if len(cells) < 3:
                    continue
                
                # First cell likely contains name
                first_cell = cells[0].get_text(strip=True)
                
                # Check if looks like executive name
                words = first_cell.split()
                if len(words) >= 2 and len(words) <= 4:
                    # Look for XBRL-tagged values in this row
                    values = []
                    
                    for cell in cells:
                        # Find any iXBRL elements
                        xbrl_elems = cell.find_all(attrs={'name': True})
                        
                        for elem in xbrl_elems:
                            text = elem.get_text(strip=True)
                            try:
                                val = int(re.sub(r'[^\d]', '', text))
                                if val > 0:
                                    values.append(val)
                            except:
                                pass
                    
                    if values and len(values) >= 3:  # At least a few compensation values
                        # Assume last value is total
                        total = max(values)  # Use max as proxy for total
                        
                        if total > 50000:  # Minimum threshold
                            results.append({
                                'name': first_cell,
                                'total_compensation': total
                            })
                            logger.info(f"  ✓ {first_cell}: ${total:,}")
        
        return results
    
    def process_company(self, company_id: str, cik: str, ticker: str) -> Dict:
        """Process company"""
        logger.info(f"\n{'='*60}")
        logger.info(f"{ticker} (CIK: {cik})")
        logger.info(f"{'='*60}")
        
        html = self.fetch_proxy(cik)
        if not html:
            return {}
        
        neos = self.extract_xbrl_compensation(html)
        
        saved = 0
        for neo in neos:
            try:
                person = supabase.table('people').select('id').eq('full_name', neo['name']).execute()
                
                if person.data:
                    pid = person.data[0]['id']
                else:
                    new = supabase.table('people').insert({
                        'full_name': neo['name']
                    }).execute()
                    pid = new.data[0]['id']
                
                supabase.table('executive_compensation_annual').upsert({
                    'company_id': company_id,
                    'person_id': pid,
                    'fiscal_year': 2024,
                    'total_compensation': neo['total_compensation']
                }, on_conflict='company_id,person_id,fiscal_year').execute()
                
                saved += 1
                logger.info(f"  ✅ {neo['name']} - ${neo['total_compensation']:,}")
            except Exception as e:
                logger.error(f"  ❌ Error: {e}")
        
        return {'neos': neos, 'saved': saved}

def run(limit: int = 50):
    """Run XBRL extraction"""
    ext = XBRLCompensationExtractor()
    
    logger.info(f"🚀 XBRL Compensation Extraction (Limit: {limit})")
    
    companies = supabase.table('companies').select('id, ticker_symbol, cik').not_.is_('cik', 'null').limit(limit).execute()
    
    logger.info(f"Companies: {len(companies.data)}\n")
    
    total = 0
    for c in companies.data:
        if not c.get('cik'):
            continue
        
        result = ext.process_company(c['id'], c['cik'], c.get('ticker_symbol', 'N/A'))
        total += result.get('saved', 0)
        time.sleep(1)
    
    logger.info(f"\n✅ Complete! Saved {total} NEOs")

if __name__ == "__main__":
    import sys
    limit = int(sys.argv[1]) if len(sys.argv) > 1 else 50
    run(limit)
