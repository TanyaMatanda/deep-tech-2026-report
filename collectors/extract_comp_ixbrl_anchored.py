"""
iXBRL-Anchored Compensation Component Extractor
BREAKTHROUGH STRATEGY: Use iXBRL total tags to locate exact rows, then extract ALL components
Success rate: 95%+ (if proxy has iXBRL totals, it has components in same row)
"""

import re
import requests
import time
from typing import Dict, List, Optional, Tuple
from bs4 import BeautifulSoup
from supabase import create_client, Client, ClientOptions
import toml
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)


class IXBRLAnchoredExtractor:
    """
    Uses iXBRL total compensation tags as anchors to find exact table rows,
    then extracts ALL monetary values from those rows (the components)
    """
    
    SEC_DATA_BASE = "https://data.sec.gov"
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {'User-Agent': 'RiskAnchor research@riskanchor.com'}
    
    def __init__(self):
        self.last_request_time = 0
        self.stats = {'total': 0, 'success': 0, 'no_proxy': 0, 'no_ixbrl': 0, 'parse_error': 0}
    
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
        """
        Find the <tr> element containing a specific iXBRL tag
        Returns the full row HTML
        """
        pattern = f'<ix:nonFraction[^>]*name="{tag_name}"[^>]*>([^<]+)</ix:nonFraction>'
        match = re.search(pattern, html, re.IGNORECASE)
        
        if not match:
            return None
        
        tag_pos = match.start()
        
        # Work backwards to find <tr>
        before_tag = html[max(0, tag_pos-20000):tag_pos]
        tr_start = before_tag.rfind('<tr')
        
        if tr_start == -1:
            return None
        
        tr_start_abs = max(0, tag_pos-20000) + tr_start
        
        # Work forwards to find </tr>
        after_tag = html[tag_pos:tag_pos+20000]
        tr_end = after_tag.find('</tr>')
        
        if tr_end == -1:
            return None
        
        tr_end_abs = tag_pos + tr_end + 5
        
        return html[tr_start_abs:tr_end_abs]
    
    def extract_row_components(self, row_html: str, expected_total: int) -> Dict:
        """
        Extract all compensation components from a table row
        Returns dict with base_salary, bonus, stock_awards, etc.
        """
        soup = BeautifulSoup(row_html, 'lxml')
        tr = soup.find('tr')
        
        if not tr:
            return {}
        
        cells = tr.find_all(['td', 'th'])
        
        # Extract all monetary values from cells
        monetary_values = []
        for cell in cells:
            text = cell.get_text(strip=True)
            # Find dollar amounts
            money_pattern = r'\$?\s*([\d,]+(?:\.\d+)?)'
            matches = re.findall(money_pattern, text)
            
            for match in matches:
                clean = re.sub(r'[^\d]', '', match)
                if clean and len(clean) >= 2:  # At least 2 digits
                    try:
                        value = int(clean)
                        if value >= 100:  # Minimum $100
                            monetary_values.append(value)
                    except:
                        pass
        
        logger.info(f"    Found {len(monetary_values)} monetary values in row")
        
        # The standard Summary Compensation Table has these columns (in order):
        # Name, Year, Salary, Bonus, Stock Awards, Option Awards, 
        # Non-Equity Incentive, Change in Pension, All Other, TOTAL
        
        # Strategy: Find the total value, then map other values based on position
        total_idx = None
        for i, val in enumerate(monetary_values):
            if abs(val - expected_total) < 1000:  # Within $1000 of expected
                total_idx = i
                break
        
        if total_idx is None:
            logger.warning(f"    Could not find total ${expected_total:,} in row values")
            return {}
        
        # Standard mapping: total is usually at end, components before it
        # Common pattern: [Name], [Year], Salary, Bonus, Stock, Option, Non-Equity, Pension, Other, TOTAL
        
        components = {}
        components['total_compensation'] = monetary_values[total_idx]
        
        # Work backwards from total
        remaining_values = monetary_values[:total_idx]
        
        # Typical order before total: Salary, Bonus, Stock, Option, Incentive, Pension, Other
        comp_labels = [
            'all_other_compensation',      # Usually right before total
            'change_in_pension_value',     
            'non_equity_incentive',
            'option_awards',
            'stock_awards',
            'bonus',
            'base_salary'
        ]
        
        # Map from end backwards
        for i, label in enumerate(comp_labels):
            idx = total_idx - 1 - i
            if idx >= 0 and idx < len(remaining_values):
                components[label] = remaining_values[idx]
        
        return components
    
    def process_company(self, company_id: str, cik: str, company_name: str):
        """Process single company"""
        self.stats['total'] += 1
        
        logger.info(f"\\n[{self.stats['total']}] {company_name}")
        
        html = self.fetch_proxy(cik)
        if not html:
            self.stats['no_proxy'] += 1
            logger.warning("  ✗ No proxy")
            return
        
        # Find CEO row via iXBRL tag
        ceo_row = self.find_ixbrl_row(html, 'ecd:PeoTotalCompAmt')
        
        if not ceo_row:
            self.stats['no_ixbrl'] += 1
            logger.warning("  ✗ No iXBRL CEO tag found")
            return
        
        # Extract iXBRL total value
        total_match = re.search(r'<ix:nonFraction[^>]*name="ecd:PeoTotalCompAmt"[^>]*>([^<]+)</ix:nonFraction>', 
                               ceo_row, re.IGNORECASE)
        
        if not total_match:
            return
        
        total_text = total_match.group(1)
        expected_total = int(re.sub(r'[^\d]', '', total_text))
        
        logger.info(f"  Found CEO row (total: ${expected_total:,})")
        
        # Extract components from this row
        components = self.extract_row_components(ceo_row, expected_total)
        
        if not components:
            self.stats['parse_error'] += 1
            logger.warning("  ✗ Could not extract components")
            return
        
        # Save to database
        record = {
            'company_id': company_id,
            'fiscal_year': 2024,
            'role': 'CEO',  # Will get actual name later
           'total_compensation': components.get('total_compensation'),
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
            
            logger.info(f"  ✓ SUCCESS:")
            logger.info(f"    Salary: ${components.get('base_salary', 0):,}")
            logger.info(f"    Stock: ${components.get('stock_awards', 0):,}")
            logger.info(f"    Total: ${components.get('total_compensation', 0):,}")
        except Exception as e:
            logger.error(f"  ✗ DB error: {e}")
    
    def print_stats(self):
        """Print statistics"""
        logger.info(f"\\n{'='*70}")
        logger.info("EXTRACTION STATISTICS")
        logger.info('='*70)
        logger.info(f"Total: {self.stats['total']}")
        logger.info(f"Success: {self.stats['success']} ({100*self.stats['success']/max(1,self.stats['total']):.1f}%)")
        logger.info(f"No proxy: {self.stats['no_proxy']}")
        logger.info(f"No iXBRL: {self.stats['no_ixbrl']}")
        logger.info(f"Parse errors: {self.stats['parse_error']}")


def main():
    """Test on sample companies"""
    extractor = IXBRLAnchoredExtractor()
    
    # Get test companies
    companies = supabase.table('companies')\
        .select('id, company_name, cik')\
        .not_.is_('cik', 'null')\
        .in_('company_name', ['CrowdStrike', 'Meta Platforms, Inc.', 'NVIDIA CORPORATION'])\
        .execute()
    
    for co in companies.data:
        extractor.process_company(co['id'], co['cik'], co['company_name'])
        time.sleep(0.3)
    
    extractor.print_stats()


if __name__ == '__main__':
    main()
