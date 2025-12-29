"""
Canadian SEDAR+ Compensation Extractor
Extracts executive compensation from Management Information Circulars (MICs)
Free - uses SEDAR+ public API
"""

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

class CanadianCompensationExtractor:
    """Extract compensation from Canadian SEDAR+ filings"""
    
    SEDAR_API = "https://www.sedarplus.ca/csa-party/records"
    HEADERS = {
        'User-Agent': 'RiskAnchor Governance Research research@riskanchor.com'
    }
    
    def __init__(self):
        self.request_count = 0
    
    def rate_limit(self):
        """Be respectful to SEDAR"""
        time.sleep(0.5)
    
    def search_company(self, company_name: str) -> Optional[str]:
        """Search for company in SEDAR+ and return SEDAR ID"""
        self.rate_limit()
        
        try:
            # SEDAR+ API search
            params = {
                'q': company_name,
                'category': 'company'
            }
            
            response = requests.get(
                self.SEDAR_API,
                params=params,
                headers=self.HEADERS,
                timeout=10
            )
            
            if response.status_code == 200:
                data = response.json()
                # Parse response for SEDAR ID
                # Note: SEDAR+ API structure may vary
                if data and len(data) > 0:
                    return data[0].get('id')
            
            return None
            
        except Exception as e:
            logger.error(f"Error searching SEDAR for {company_name}: {e}")
            return None
    
    def extract_compensation_from_mic(self, html: str) -> List[Dict]:
        """Extract Summary Compensation Table from Management Information Circular"""
        soup = BeautifulSoup(html, 'html.parser')
        results = []
        
        # Canadian MICs use similar structure to US DEF 14A
        # Look for "Summary Compensation Table" or "Compensation of Executive Officers"
        
        for table in soup.find_all('table'):
            table_text = table.get_text().lower()
            
            if 'summary compensation' not in table_text and 'executive compensation' not in table_text:
                continue
            
            logger.info("Found compensation table in MIC")
            
            # Similar parsing logic to US SCT
            rows = table.find_all('tr')
            if len(rows) < 2:
                continue
            
            # Extract compensation data
            # (Implementation similar to US extractor)
            
        return results
    
    def process_canadian_company(self, company_id: str, company_name: str, ticker: str) -> Dict:
        """Process single Canadian company"""
        logger.info(f"\n{'='*60}")
        logger.info(f"Processing {ticker} (Canadian)")
        logger.info(f"{'='*60}")
        
        # Search SEDAR for company
        sedar_id = self.search_company(company_name)
        
        if not sedar_id:
            logger.warning(f"Company {ticker} not found in SEDAR")
            return {}
        
        logger.info(f"Found SEDAR ID: {sedar_id}")
        
        # Fetch Management Information Circular
        # (Implementation depends on SEDAR+ API structure)
        
        return {'message': 'SEDAR+ integration in progress'}

def run_canadian_extraction(limit: int = 100):
    """Run extraction for Canadian companies"""
    extractor = CanadianCompensationExtractor()
    
    logger.info(f"🇨🇦 Starting Canadian Compensation Extraction (Limit: {limit})")
    
    # Get Canadian companies (from TSX/TSXV)
    companies = supabase.table('companies') \
        .select('id, company_name, ticker_symbol, country') \
        .eq('country', 'Canada') \
        .limit(limit) \
        .execute()
    
    logger.info(f"Found {len(companies.data)} Canadian companies\n")
    
    for company in companies.data:
        try:
            extractor.process_canadian_company(
                company_id=company['id'],
                company_name=company['company_name'],
                ticker=company.get('ticker_symbol', 'Unknown')
            )
            time.sleep(1)
            
        except Exception as e:
            logger.error(f"Error processing {company.get('ticker_symbol')}: {e}")
            continue
    
    logger.info("\n✅ Canadian extraction complete!")

if __name__ == "__main__":
    import sys
    limit = int(sys.argv[1]) if len(sys.argv) > 1 else 100
    
    logger.info("⚠️  Note: SEDAR+ API integration requires additional setup")
    logger.info("Canadian filings are in development - using placeholder for now")
    
    # run_canadian_extraction(limit)
