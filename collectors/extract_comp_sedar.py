"""
SEDAR+ Compensation Scraper for Canadian Companies
Extracts executive compensation from Management Information Circulars
"""

import requests
from bs4 import BeautifulSoup
import time
import re
from typing import Dict, List, Optional
from supabase import create_client, Client, ClientOptions
import toml
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Supabase setup
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

class SEDARCompensationExtractor:
    """Extract compensation from SEDAR+ Management Information Circulars"""
    
    SEDAR_BASE = "https://www.sedarplus.ca"
    SEARCH_URL = f"{SEDAR_BASE}/csa-party/records/document-search.html"
    
    HEADERS = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.5'
    }
    
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update(self.HEADERS)
        self.last_request_time = 0
    
    def rate_limit(self, wait_time: float = 2.0):
        """Rate limiting for respectful scraping"""
        current_time = time.time()
        elapsed = current_time - self.last_request_time
        if elapsed < wait_time:
            time.sleep(wait_time - elapsed)
        self.last_request_time = time.time()
    
    def search_company(self, company_name: str) -> Optional[str]:
        """
        Search SEDAR+ for company and get profile URL
        
        Note: SEDAR+ requires interactive search, no direct API
        This is a placeholder for the actual implementation
        which would need to:
        1. Search by company name
        2. Parse search results
        3. Extract profile URL
        4. Navigate to documents section
        """
        
        logger.info(f"Searching SEDAR+ for: {company_name}")
        
        # TODO: Implement actual SEDAR+ search
        # For now, return None to indicate not implemented
        logger.warning("SEDAR+ search not yet implemented - requires browser automation")
        return None
    
    def fetch_management_circular(self, company_name: str, ticker: str = None) -> Optional[str]:
        """
        Fetch Management Information Circular for a Canadian company
        
        Document types to look for:
        - Management information circular
        - Management proxy circular  
        - Information circular
        """
        
        self.rate_limit()
        
        # Attempt to search
        profile_url = self.search_company(company_name)
        
        if not profile_url:
            return None
        
        # TODO: Implement fetching actual circular document
        return None
    
    def extract_compensation_table(self, html: str) -> List[Dict]:
        """
        Extract compensation from Canadian circular
        
        Similar to US Summary Compensation Table but with Canadian formatting
        May be in English or French
        """
        
        soup = BeautifulSoup(html, 'html.parser')
        results = []
        
        # Look for compensation table keywords
        compensation_keywords = [
            'summary compensation table',
            'executive compensation',
            'named executive officer',
            'rémunération', # French: compensation
            'dirigeants', # French: executives
        ]
        
        for table in soup.find_all('table'):
            table_text = table.get_text().lower()
            
            if not any(keyword in table_text for keyword in compensation_keywords):
                continue
            
            logger.info("Found potential compensation table")
            
            # Parse table structure (similar to US extraction)
            rows = table.find_all('tr')
            
            for row in rows[1:]:  # Skip header
                cells = row.find_all(['td', 'th'])
                
                if len(cells) < 3:
                    continue
                
                # Extract name (first column)
                name_cell = cells[0].get_text(strip=True)
                
                # Check if looks like executive name
                if len(name_cell.split()) >= 2:
                    # Extract compensation values
                    values = []
                    for cell in cells[1:]:
                        text = cell.get_text(strip=True)
                        # Extract numbers
                        numbers = re.findall(r'[\d,]+', text)
                        if numbers:
                            try:
                                val = int(numbers[0].replace(',', ''))
                                if val > 10000:  # Minimum threshold
                                    values.append(val)
                            except:
                                pass
                    
                    if values:
                        # Use max as total compensation estimate
                        total = max(values)
                        results.append({
                            'name': name_cell,
                            'total_compensation': total
                        })
                        logger.info(f"  Extracted: {name_cell} - ${total:,}")
        
        return results
    
    def process_company(self, company_id: str, company_name: str, ticker: str = None) -> Dict:
        """Process single Canadian company"""
        
        logger.info(f"\n{'='*60}")
        logger.info(f"{company_name} ({ticker or 'No ticker'})")
        logger.info(f"{'='*60}")
        
        # Fetch circular
        html = self.fetch_management_circular(company_name, ticker)
        
        if not html:
            logger.warning(f"No circular found for {company_name}")
            return {'status': 'no_filing'}
        
        # Extract compensation
        neos = self.extract_compensation_table(html)
        
        # Save to database
        saved = 0
        for neo in neos:
            try:
                # Check if person exists
                person = supabase.table('people').select('id').eq('full_name', neo['name']).execute()
                
                if person.data:
                    pid = person.data[0]['id']
                else:
                    # Create person
                    new = supabase.table('people').insert({
                        'full_name': neo['name']
                    }).execute()
                    pid = new.data[0]['id']
                
                # Upsert compensation
                supabase.table('executive_compensation_annual').upsert({
                    'company_id': company_id,
                    'person_id': pid,
                    'fiscal_year': 2024,
                    'total_compensation': neo['total_compensation'],
                    'source': 'SEDAR'
                }, on_conflict='company_id,person_id,fiscal_year').execute()
                
                saved += 1
                logger.info(f"  ✅ Saved {neo['name']}")
                
            except Exception as e:
                logger.error(f"  ❌ Error saving {neo.get('name')}: {e}")
        
        return {'neos': neos, 'saved': saved}

def run_canadian_extraction(limit: int = 50):
    """Run SEDAR extraction on Canadian companies"""
    
    extractor = SEDARCompensationExtractor()
    
    logger.info(f"🇨🇦 SEDAR Compensation Extraction (Limit: {limit})")
    
    # Get Canadian deep tech companies
    # Filter for companies with stock exchange listings (more likely to have filings)
    companies = supabase.table('companies')\
        .select('id, company_name, ticker_symbol')\
        .ilike('jurisdiction', '%CA%')\
        .not_.is_('stock_exchange', 'null')\
        .limit(limit)\
        .execute()
    
    logger.info(f"Found {len(companies.data)} Canadian companies with exchange listings\n")
    
    total_saved = 0
    no_filing = 0
    
    for company in companies.data:
        result = extractor.process_company(
            company['id'],
            company['company_name'],
            company.get('ticker_symbol')
        )
        
        if result.get('status') == 'no_filing':
            no_filing += 1
        else:
            total_saved += result.get('saved', 0)
        
        time.sleep(2)  # Rate limiting
    
    logger.info(f"\n✅ Extraction complete!")
    logger.info(f"Total records saved: {total_saved}")
    logger.info(f"Companies without filings: {no_filing}")

if __name__ == "__main__":
    import sys
    limit = int(sys.argv[1]) if len(sys.argv) > 1 else 50
    
    logger.warning("\n⚠️  SEDAR+ SCRAPER - CURRENTLY A PROTOTYPE")
    logger.warning("Search functionality requires browser automation (Selenium/Playwright)")
    logger.warning("This version will not extract data until search is implemented\n")
    
    run_canadian_extraction(limit)
