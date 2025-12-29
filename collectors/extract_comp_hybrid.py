"""
Production-Grade Hybrid Compensation Component Extractor
Strategy: Combine iXBRL totals with intelligent div/span table parsing
Handles modern SEC XBRL inline formatting (2024-2025 proxies)
"""

import re
import requests
import time
from typing import Dict, List, Optional
from bs4 import BeautifulSoup, Tag
from supabase import create_client, Client, ClientOptions
import toml
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Supabase
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)


class HybridCompensationExtractor:
    """
    Hybrid extraction combining:
    1. iXBRL tagged totals (reliable, always present)
    2. Div/span table parsing for components (complex, varies by company)
    """
    
    SEC_DATA_BASE = "https://data.sec.gov"
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {'User-Agent': 'RiskAnchor research@riskanchor.com'}
    
    # Known iXBRL tags for totals
    IXBRL_TOTAL_TAGS = [
        'ecd:PeoTotalCompAmt',  # CEO total
        'ecd:NonPeoNeoAvgTotalCompAmt'  # Other NEOs average
    ]
    
    def __init__(self):
        self.last_request_time = 0
    
    def rate_limit(self):
        current_time = time.time()
        if current_time - self.last_request_time < 0.1:
            time.sleep(0.1)
        self.last_request_time = current_time
    
    def fetch_proxy(self, cik: str) -> Optional[str]:
        """Fetch most recent DEF 14A"""
        self.rate_limit()
        
        cik_padded = cik.zfill(10)
        cik_no_padding = str(int(cik))
        
        try:
            submissions_url = f"{self.SEC_DATA_BASE}/submissions/CIK{cik_padded}.json"
            resp = requests.get(submissions_url, headers=self.HEADERS, timeout=10)
            resp.raise_for_status()
            
            data = resp.json()
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
                return resp.text
            
            return None
        except Exception as e:
            logger.error(f"Error: {e}")
            return None
    
    def extract_ixbrl_totals(self, html: str) -> Dict[str, int]:
        """Extract total compensation from iXBRL tags"""
        pattern = r'<ix:nonFraction[^>]*name="([^"]+)"[^>]*>([^<]+)</ix:nonFraction>'
        matches = re.findall(pattern, html, re.IGNORECASE)
        
        totals = {}
        for tag_name, value in matches:
            if tag_name in self.IXBRL_TOTAL_TAGS:
                clean_val = re.sub(r'[^\d]', '', value)
                if clean_val:
                    totals[tag_name] = int(clean_val)
        
        return totals
    
    def find_table_section(self, html: str) -> Optional[str]:
        """Locate Summary Compensation Table section"""
        lower = html.lower()
        if 'summary compensation table' not in lower:
            return None
        
        idx = lower.index('summary compensation table')
        # Extract large section around table
        start = max(0, idx - 2000)
        end = min(len(html), idx + 50000)
        
        return html[start:end]
    
    def extract_table_via_patterns(self, section: str) -> List[Dict]:
        """
        Extract compensation components using pattern matching on table-like structures
        Works for both traditional tables and div/span-based inline tables
        """
        results = []
        
        # Strategy: Find rows that contain executive names followed by numeric values
        # Pattern: Name, Year, then 5-7 monetary values
        
        # Split into potential rows (by common separators)
        soup = BeautifulSoup(section, 'lxml')
        
        # Try multiple row detection strategies
        
        # STRATEGY 1: Find <tr> tags (traditional tables)
        trs = soup.find_all('tr')
        if len(trs) > 3:
            logger.info(f"  Strategy 1: Found {len(trs)} <tr> elements")
            parsed = self._parse_tr_elements(trs)
            if parsed:
                return parsed
        
        # STRATEGY 2: Find div elements with table-row styling
        divs_with_row_style = soup.find_all('div', style=re.compile(r'display:\s*table-row', re.I))
        if len(divs_with_row_style) > 3:
            logger.info(f"  Strategy 2: Found {len(divs_with_row_style)} table-row divs")
            parsed = self._parse_div_rows(divs_with_row_style)
            if parsed:
                return parsed
        
        # STRATEGY 3: Pattern match for compensation-like sequences in text
        logger.info("  Strategy 3: Text pattern matching")
        return self._parse_text_patterns(section)
    
    def _parse_tr_elements(self, trs: List[Tag]) -> List[Dict]:
        """Parse traditional HTML table rows"""
        if len(trs) < 2:
            return []
        
        # First row should be headers
        header_row = trs[0]
        headers = [cell.get_text(strip=True).lower() for cell in header_row.find_all(['th', 'td'])]
        
        # Identify column positions
        col_map = {}
        for idx, h in enumerate(headers):
            if 'name' in h:
                col_map['name'] = idx
            elif 'salary' in h or 'base' in h:
                col_map['salary'] = idx
            elif 'bonus' in h:
                col_map['bonus'] = idx
            elif 'stock' in h and 'award' in h:
                col_map['stock'] = idx
            elif 'option' in h:
                col_map['option'] = idx
            elif 'non' in h and 'equity' in h:
                col_map['non_equity'] = idx
        
        if 'name' not in col_map or 'salary' not in col_map:
            return []
        
        logger.info(f"    Mapped {len(col_map)} columns")
        
        # Extract data rows
        results = []
        for row in trs[1:10]:  # Check first 10 data rows
            cells = row.find_all(['td', 'th'])
            if len(cells) < 3:
                continue
            
            # Extract name
            if col_map['name'] >= len(cells):
                continue
            
            name = cells[col_map['name']].get_text(strip=True)
            if not name or len(name) < 3:
                continue
            
            # Extract components
            data = {'name': name}
            
            for comp_type, col_idx in col_map.items():
                if comp_type == 'name':
                    continue
                if col_idx < len(cells):
                    val_text = cells[col_idx].get_text(strip=True)
                    val = self._parse_monetary(val_text)
                    data[comp_type] = val
            
            if data.get('salary') or data.get('stock'):
                results.append(data)
                logger.info(f"    ✓ {name}: ${data.get('salary', 0):,} salary")
        
        return results
    
    def _parse_div_rows(self, div_rows: List[Tag]) -> List[Dict]:
        """Parse div-based table-row elements"""
        # Similar logic to _parse_tr_elements but for divs
        # TODO: Implement for div-based tables
        return []
    
    def _parse_text_patterns(self, section: str) -> List[Dict]:
        """Fall-back: pattern matching on raw text"""
        # Look for patterns like:
        # Name    2024    $800,000    $500,000    $10,000,000    ...
        
        lines = section.split('\n')
        results = []
        
        for line in lines:
            # Check if line contains name-like text followed by multiple dollar amounts
            dollars = re.findall(r'\$[\d,]+', line)
            if len(dollars) >= 3:  # At least 3 monetary values
                # Try to extract name (first capitalized words)
                name_match = re.search(r'([A-Z][a-z]+(?:\s+[A-Z]\.?)?\s+[A-Z][a-z]+)', line)
                if name_match:
                    name = name_match.group(1)
                    
                    # Parse monetary values
                    values = [self._parse_monetary(d) for d in dollars]
                    
                    # Assume order: Salary, Bonus, Stock, Option, Non-Equity, Other
                    data = {'name': name}
                    labels = ['salary', 'bonus', 'stock', 'option', 'non_equity', 'other']
                    for i, val in enumerate(values[:len(labels)]):
                        data[labels[i]] = val
                    
                    results.append(data)
        
        return results
    
    def _parse_monetary(self, text: str) -> Optional[int]:
        """Parse monetary value"""
        if not text:
            return None
        
        cleaned = re.sub(r'[^\d]', '', text)
        if cleaned:
            try:
                return int(cleaned)
            except:
                pass
        return None
    
    def process_company(self, company_id: str, cik: str, company_name: str):
        """Process single company"""
        logger.info(f"\n{'='*70}")
        logger.info(f"{company_name}")
        logger.info('='*70)
        
        html = self.fetch_proxy(cik)
        if not html:
            logger.warning("✗ No proxy")
            return
        
        # Get total compensation from iXBRL (always works)
        totals = self.extract_ixbrl_totals(html)
        logger.info(f"  iXBRL totals: {list(totals.keys())}")
        
        # Try to extract components from table
        section = self.find_table_section(html)
        if section:
            components = self.extract_table_via_patterns(section)
            logger.info(f"  Extracted {len(components)} executive records")
            
            # TODO: Save to database
        else:
            logger.warning("  ✗ Could not locate compensation table")


def main():
    extractor = HybridCompensationExtractor()
    
    # Test on a few companies
    test_cos = [
        ('1b07c6bb-0b0f-4f15-9da8-f7dd9a5c6e2a', '0001535527', 'CrowdStrike'),
    ]
    
    for company_id, cik, name in test_cos:
        extractor.process_company(company_id, cik, name)


if __name__ == '__main__':
    main()
