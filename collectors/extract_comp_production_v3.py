"""
iXBRL-Anchored Compensation Component Extractor v3
PRODUCTION VERSION: Magnitude-based component classification
Success rate target: 85%+
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

logging.basicConfig(level=logging.INFO, format='%(message)s')
logger = logging.getLogger(__name__)

try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)


class ProductionComponentExtractor:
    """Production extractor using iXBRL anchoring + magnitude classification"""
    
    SEC_DATA_BASE = "https://data.sec.gov"
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {'User-Agent': 'RiskAnchor research@riskanchor.com'}
    
    def __init__(self):
        self.last_request_time = 0
        self.stats = {
            'processed': 0,
            'success': 0,
            'no_proxy': 0,
            'no_ixbrl': 0,
            'parse_fail': 0
        }
    
    def rate_limit(self):
        current_time = time.time()
        if current_time - self.last_request_time < 0.1:
            time.sleep(0.1)
        self.last_request_time = current_time
    
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
        
        # Find <tr> backwards
        before_tag = html[max(0, tag_pos-20000):tag_pos]
        tr_start = before_tag.rfind('<tr')
        
        if tr_start == -1:
            return None
        
        tr_start_abs = max(0, tag_pos-20000) + tr_start
        
        # Find </tr> forwards
        after_tag = html[tag_pos:tag_pos+20000]
        tr_end = after_tag.find('</tr>')
        
        if tr_end == -1:
            return None
        
        tr_end_abs = tag_pos + tr_end + 5
        
        return html[tr_start_abs:tr_end_abs]
    
    def extract_components(self, row_html: str, expected_total: int) -> Optional[Dict]:
        """
        Extract components using magnitude-based classification
        Based on discovered CrowdStrike structure:
        - Salary: $500K-$3M
        - Stock: $10M-$100M+ (largest component)
        - Non-Equity Incentive: $500K-$5M
        - All Other: $100K-$2M (smallest)
        """
        soup = BeautifulSoup(row_html, 'lxml')
        tr = soup.find('tr')
        
        if not tr:
            return None
        
        cells = tr.find_all(['td', 'th'])
        
        # Extract all monetary values
        values = []
        for cell in cells:
            text = cell.get_text(strip=True)
            # Remove formatting, find numbers
            cleaned = re.sub(r'[^\d,]', '', text)
            if cleaned and len(cleaned) >= 3:
                cleaned = cleaned.replace(',', '')
                try:
                    val = int(cleaned)
                    if val >= 100 and val < 1_000_000_000:  # $100 to $1B range
                        values.append(val)
                except:
                    pass
        
        # Filter out year values (2023, 2024, 2025)
        values = [v for v in values if v < 2020 or v > 2030]
        
        logger.info(f"    {len(values)} monetary values (excluding years)")
        
        # Verify total exists
        total_found = any(abs(v - expected_total) < 1000 for v in values)
        if not total_found:
            logger.warning(f"    Total ${expected_total:,} not in row")
            return None
        
        # Classify components by magnitude
        components = {'total_compensation': expected_total}
        
        # Sort by value to classify
        sorted_vals = sorted(set(v for v in values if abs(v - expected_total) >= 1000), reverse=True)
        
        for val in sorted_vals:
            # Stock awards: typically largest, >$5M
            if val >= 5_000_000 and 'stock_awards' not in components:
                components['stock_awards'] = val
                logger.info(f"      Stock: ${val:,}")
            
            # Salary: $500K-$3M range
            elif 500_000 <= val <= 3_000_000 and 'base_salary' not in components:
                components['base_salary'] = val
                logger.info(f"      Salary: ${val:,}")
            
            # Non-equity incentive: $500K-$5M
            elif 500_000 <= val < 5_000_000 and 'non_equity_incentive' not in components:
                components['non_equity_incentive'] = val
                logger.info(f"      Non-Equity: ${val:,}")
            
            # All other comp: usually $100K-$2M
            elif 100_000 <= val < 2_000_000 and 'all_other_compensation' not in components:
                components['all_other_compensation'] = val
                logger.info(f"      Other: ${val:,}")
            
            # Bonus: remaining mid-range value
            elif 100_000 <= val < 5_000_000 and 'bonus' not in components:
                components['bonus'] = val
                logger.info(f"      Bonus: ${val:,}")
        
        return components if len(components) > 1 else None
    
    def process_company(self, company_id: str, cik: str, company_name: str):
        """Process single company"""
        self.stats['processed'] += 1
        
        logger.info(f"\n[{self.stats['processed']}] {company_name}")
        
        html = self.fetch_proxy(cik)
        if not html:
            self.stats['no_proxy'] += 1
            logger.warning("  ✗ No proxy")
            return
        
        # Find CEO row
        ceo_row = self.find_ixbrl_row(html, 'ecd:PeoTotalCompAmt')
        
        if not ceo_row:
            self.stats['no_ixbrl'] += 1
            logger.warning("  ✗ No iXBRL tag")
            return
        
        # Get total from iXBRL
        total_match = re.search(r'<ix:nonFraction[^>]*name="ecd:PeoTotalCompAmt"[^>]*>([^<]+)</ix:nonFraction>', 
                               ceo_row, re.IGNORECASE)
        
        if not total_match:
            return
        
        total_text = total_match.group(1)
        expected_total = int(re.sub(r'[^\d]', '', total_text))
        
        logger.info(f"  CEO Total: ${expected_total:,}")
        
        # Extract components
        components = self.extract_components(ceo_row, expected_total)
        
        if not components:
            self.stats['parse_fail'] += 1
            logger.warning("  ✗ Parse failed")
            return
        
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
            self.stats['success'] += 1
            logger.info(f"  ✓ SAVED")
        except Exception as e:
            logger.error(f"  ✗ DB error: {e}")
    
    def print_stats(self):
        logger.info(f"\n{'='*70}")
        logger.info("STATISTICS")
        logger.info('='*70)
        logger.info(f"Processed: {self.stats['processed']}")
        logger.info(f"Success: {self.stats['success']} ({100*self.stats['success']/max(1,self.stats['processed']):.1f}%)")
        logger.info(f"No proxy: {self.stats['no_proxy']}")
        logger.info(f"No iXBRL: {self.stats['no_ixbrl']}")
        logger.info(f"Parse fail: {self.stats['parse_fail']}")


def main():
    """Run extraction on all companies"""
    extractor = ProductionComponentExtractor()
    
    # Get ALL companies with CIKs
    offset = 0
    while True:
        companies = supabase.table('companies')\
            .select('id, company_name, cik')\
            .not_.is_('cik', 'null')\
            .range(offset, offset + 99)\
            .execute()
        
        if not companies.data:
            break
        
        for co in companies.data:
            extractor.process_company(co['id'], co['cik'], co['company_name'])
        
        offset += 100
        
        # Print interim stats every 100 companies
        if offset % 100 == 0:
            extractor.print_stats()
    
    extractor.print_stats()


if __name__ == '__main__':
    main()
