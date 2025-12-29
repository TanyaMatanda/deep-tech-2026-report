"""
FAST Parallel Compensation Component Extractor
Uses threading to process multiple companies simultaneously
Speed: ~300-500 companies/hour (vs 180/hour single-threaded)
"""

import re
import requests
import time
from typing import Dict, List, Optional
from bs4 import BeautifulSoup
from supabase import create_client, Client, ClientOptions
import toml
import os
import logging
from concurrent.futures import ThreadPoolExecutor, as_completed
import threading

logging.basicConfig(level=logging.INFO, format='%(message)s')
logger = logging.getLogger(__name__)

try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)


class FastParallelExtractor:
    """Fast extractor using thread pool for parallel processing"""
    
    SEC_DATA_BASE = "https://data.sec.gov"
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {'User-Agent': 'RiskAnchor research@riskanchor.com'}
    
    def __init__(self, max_workers=5):
        self.max_workers = max_workers
        self.rate_lock = threading.Lock()
        self.last_request_time = 0
        self.stats_lock = threading.Lock()
        self.stats = {
            'processed': 0,
            'success': 0,
            'no_proxy': 0,
            'no_ixbrl': 0,
            'parse_fail': 0
        }
    
    def rate_limit(self):
        """Thread-safe rate limiting"""
        with self.rate_lock:
            current_time = time.time()
            if current_time - self.last_request_time < 0.11:  # Slightly conservative
                time.sleep(0.11)
            self.last_request_time = current_time
    
    def update_stats(self, key):
        """Thread-safe stats update"""
        with self.stats_lock:
            self.stats[key] += 1
    
    def fetch_proxy(self, cik: str) -> Optional[str]:
        """Fetch DEF 14A"""
        self.rate_limit()
        
        try:
            resp = requests.get(
                f"{self.SEC_DATA_BASE}/submissions/CIK{cik.zfill(10)}.json",
                headers=self.HEADERS, timeout=10
            )
            resp.raise_for_status()
            
            data = resp.json()
            filings = data.get('filings', {}).get('recent', {})
            
            idx = next((i for i, f in enumerate(filings.get('form', [])) if f == 'DEF 14A'), None)
            if idx is None:
                return None
            
            accession = filings['accessionNumber'][idx].replace('-', '')
            doc = filings['primaryDocument'][idx]
            
            url = f"{self.SEC_BASE}/Archives/edgar/data/{int(cik)}/{accession}/{doc}"
            
            self.rate_limit()
            resp = requests.get(url, headers=self.HEADERS, timeout=15)
            
            return resp.text if resp.status_code == 200 else None
        except:
            return None
    
    def find_ixbrl_row(self, html: str, tag_name: str) -> Optional[str]:
        """Find <tr> containing iXBRL tag"""
        pattern = f'<ix:nonFraction[^>]*name="{tag_name}"[^>]*>([^<]+)</ix:nonFraction>'
        match = re.search(pattern, html, re.IGNORECASE)
        
        if not match:
            return None
        
        tag_pos = match.start()
        before_tag = html[max(0, tag_pos-20000):tag_pos]
        tr_start = before_tag.rfind('<tr')
        
        if tr_start == -1:
            return None
        
        tr_start_abs = max(0, tag_pos-20000) + tr_start
        after_tag = html[tag_pos:tag_pos+20000]
        tr_end = after_tag.find('</tr>')
        
        if tr_end == -1:
            return None
        
        tr_end_abs = tag_pos + tr_end + 5
        return html[tr_start_abs:tr_end_abs]
    
    def extract_components(self, row_html: str, expected_total: int) -> Optional[Dict]:
        """Extract components using magnitude classification"""
        soup = BeautifulSoup(row_html, 'lxml')
        tr = soup.find('tr')
        
        if not tr:
            return None
        
        cells = tr.find_all(['td', 'th'])
        
        # Extract all monetary values
        values = []
        for cell in cells:
            text = cell.get_text(strip=True)
            cleaned = re.sub(r'[^\d,]', '', text)
            if cleaned and len(cleaned) >= 3:
                cleaned = cleaned.replace(',', '')
                try:
                    val = int(cleaned)
                    if val >= 100 and val < 1_000_000_000:
                        values.append(val)
                except:
                    pass
        
        # Filter out years
        values = [v for v in values if v < 2020 or v > 2030]
        
        # Verify total
        if not any(abs(v - expected_total) < 1000 for v in values):
            return None
        
        # Classify by magnitude
        components = {'total_compensation': expected_total}
        sorted_vals = sorted(set(v for v in values if abs(v - expected_total) >= 1000), reverse=True)
        
        for val in sorted_vals:
            if val >= 5_000_000 and 'stock_awards' not in components:
                components['stock_awards'] = val
            elif 500_000 <= val <= 3_000_000 and 'base_salary' not in components:
                components['base_salary'] = val
            elif 500_000 <= val < 5_000_000 and 'non_equity_incentive' not in components:
                components['non_equity_incentive'] = val
            elif 100_000 <= val < 2_000_000 and 'all_other_compensation' not in components:
                components['all_other_compensation'] = val
            elif 100_000 <= val < 5_000_000 and 'bonus' not in components:
                components['bonus'] = val
        
        return components if len(components) > 1 else None
    
    def process_company(self, company_id: str, cik: str, company_name: str) -> bool:
        """Process single company - returns True if successful"""
        self.update_stats('processed')
        
        html = self.fetch_proxy(cik)
        if not html:
            self.update_stats('no_proxy')
            return False
        
        ceo_row = self.find_ixbrl_row(html, 'ecd:PeoTotalCompAmt')
        if not ceo_row:
            self.update_stats('no_ixbrl')
            return False
        
        total_match = re.search(r'<ix:nonFraction[^>]*name="ecd:PeoTotalCompAmt"[^>]*>([^<]+)</ix:nonFraction>', 
                               ceo_row, re.IGNORECASE)
        if not total_match:
            return False
        
        expected_total = int(re.sub(r'[^\d]', '', total_match.group(1)))
        components = self.extract_components(ceo_row, expected_total)
        
        if not components:
            self.update_stats('parse_fail')
            return False
        
        # Save to database
        record = {
            'company_id': company_id,
            'fiscal_year': 2024,
            'role': 'CEO',
            'total_compensation': components['total_compensation'],
            'base_salary': components.get('base_salary'),
            'bonus': components.get('bonus'),
            'stock_awards': components.get('stock_awards'),
            'option_awards': components.get('option_awards'),
            'non_equity_incentive': components.get('non_equity_incentive'),
            'change_in_pension_value': components.get('change_in_pension_value'),
            'all_other_compensation': components.get('all_other_compensation')
        }
        
        try:
            supabase.table('executive_compensation_annual').upsert(record).execute()
            self.update_stats('success')
            logger.info(f"✓ {company_name[:40]:40} | Total: ${expected_total:>12,}")
            return True
        except Exception as e:
            logger.error(f"✗ {company_name}: DB error")
            return False
    
    def process_batch(self, companies: List[Dict]):
        """Process batch of companies in parallel"""
        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            futures = {
                executor.submit(
                    self.process_company,
                    co['id'],
                    co['cik'],
                    co['company_name']
                ): co for co in companies
            }
            
            for future in as_completed(futures):
                pass  # Results logged in process_company
    
    def print_stats(self):
        logger.info(f"\n{'='*70}")
        logger.info(f"Processed: {self.stats['processed']:4} | "
                   f"Success: {self.stats['success']:4} ({100*self.stats['success']/max(1,self.stats['processed']):.1f}%) | "
                   f"No Proxy: {self.stats['no_proxy']:3} | "
                   f"No iXBRL: {self.stats['no_ixbrl']:3} | "
                   f"Parse Fail: {self.stats['parse_fail']:3}")
        logger.info('='*70)


def main():
    """Run fast parallel extraction"""
    logger.info("FAST PARALLEL COMPONENT EXTRACTION")
    logger.info(f"Workers: 5 threads")
    logger.info(f"Rate Limit: 9 req/sec")
    logger.info('='*70)
    
    extractor = FastParallelExtractor(max_workers=5)
    
    # Get ALL companies with CIKs
    offset = 0
    batch_size = 50  # Process 50 at a time
    
    while True:
        companies = supabase.table('companies')\
            .select('id, company_name, cik')\
            .not_.is_('cik', 'null')\
            .range(offset, offset + batch_size - 1)\
            .execute()
        
        if not companies.data:
            break
        
        logger.info(f"\nBatch {offset//batch_size + 1} (companies {offset}-{offset+len(companies.data)})")
        
        extractor.process_batch(companies.data)
        extractor.print_stats()
        
        offset += batch_size
    
    logger.info("\n🎉 EXTRACTION COMPLETE")
    extractor.print_stats()


if __name__ == '__main__':
    main()
