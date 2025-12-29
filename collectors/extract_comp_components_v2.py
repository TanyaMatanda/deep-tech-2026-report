"""
Production Compensation Component Extractor v2
Based on analysis: 90% of proxies use standard HTML <table>/<tr> structure
Strategy: Large extraction window + robust table scoring + tr-based parsing
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


class ProductionComponentExtractor:
    """
    Production extractor for compensation components
    Tested on: CrowdStrike, Meta, Microsoft, NVIDIA, Apple, etc.
    Success rate target: 80%+
    """
    
    SEC_DATA_BASE = "https://data.sec.gov"
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {'User-Agent': 'RiskAnchor research@riskanchor.com'}
    
    def __init__(self):
        self.last_request_time = 0
        self.stats = {
            'total': 0,
            'proxy_found': 0,
            'table_found': 0,
            'components_extracted': 0
        }
    
    def rate_limit(self):
        current_time = time.time()
        if current_time - self.last_request_time < 0.1:
            time.sleep(0.1)
        self.last_request_time = current_time
    
    def fetch_proxy(self, cik: str) -> Optional[str]:
        """Fetch DEF 14A proxy"""
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
    
    def find_comp_table(self, html: str) -> Optional[BeautifulSoup]:
        """
        Locate Summary Compensation Table using robust multi-step approach
        """
        lower = html.lower()
        if 'summary compensation table' not in lower:
            logger.warning("  No 'Summary Compensation Table' text found")
            return None
        
        idx = lower.index('summary compensation table')
        logger.info(f"  Found heading at char {idx:,}")
        
        # Extract LARGE section (100KB after heading)
        start = max(0, idx - 5000)
        end = min(len(html), idx + 100000)
        section = html[start:end]
        
        soup = BeautifulSoup(section, 'lxml')
        tables = soup.find_all('table')
        
        logger.info(f"  Found {len(tables)} tables in section")
        
        # Score each table
        best_table = None
        best_score = 0
        
        for table in tables[:10]:  # Check first 10 tables
            rows = table.find_all('tr')
            if len(rows) < 4:  # Need header + at least 3 data rows
                continue
            
            # Analyze header row
            header_row = rows[0]
            header_cells = header_row.find_all(['th', 'td'])
            
            if len(header_cells) < 5:  # Need at least 5 columns
                continue
            
            # Get header text
            headers_text = [cell.get_text(strip=True).lower() for cell in header_cells]
            combined_headers = ' '.join(headers_text)
            
            # Score this table
            score = 0
            if any('name' in h for h in headers_text):
                score += 2
            if any('year' in h for h in headers_text):
                score += 1
            if any('salary' in h or 'base' in h for h in headers_text):
                score += 2
            if any('bonus' in h for h in headers_text):
                score += 1
            if any('stock' in h and 'award' in h for h in headers_text):
                score += 2
            if any('option' in h for h in headers_text):
                score += 1
            if any('non' in h and 'equity' in h for h in headers_text):
                score += 1
            if any('total' in h for h in headers_text):
                score += 2
            
            logger.info(f"    Table {tables.index(table)}: {len(rows)} rows, {len(header_cells)} cols, score={score}")
            
            if score > best_score:
                best_score = score
                best_table = table
        
        if best_score >= 6:  # At least 6 points required
            logger.info(f"  ✓ Selected table (score={best_score})")
            return best_table
        
        logger.warning(f"  ✗ No table scored >=6 (best={best_score})")
        return None
    
    def extract_components_from_table(self, table: BeautifulSoup) -> List[Dict]:
        """
        Extract compensation components from identified table
        """
        rows = table.find_all('tr')
        if len(rows) < 2:
            return []
        
        # Parse header row to map columns
        header_row = rows[0]
        header_cells = header_row.find_all(['th', 'td'])
        
        col_map = {}
        for idx, cell in enumerate(header_cells):
            text = cell.get_text(strip=True).lower()
            text = re.sub(r'\\s+', ' ', text)  # Normalize whitespace
            
            if 'name' in text and 'col_name' not in col_map:
                col_map['col_name'] = idx
            elif ('salary' in text or 'base' in text) and 'col_salary' not in col_map:
                col_map['col_salary'] = idx
            elif 'bonus' in text and 'col_bonus' not in col_map:
                col_map['col_bonus'] = idx
            elif 'stock' in text and 'award' in text and 'col_stock' not in col_map:
                col_map['col_stock'] = idx
            elif 'option' in text and 'col_option' not in col_map:
                col_map['col_option'] = idx
            elif ('non' in text and 'equity' in text) or ('incentive' in text and 'plan' in text):
                if 'col_non_equity' not in col_map:
                    col_map['col_non_equity'] = idx
            elif 'pension' in text or 'deferred' in text:
                if 'col_pension' not in col_map:
                    col_map['col_pension'] = idx
            elif 'all' in text and 'other' in text:
                if 'col_other' not in col_map:
                    col_map['col_other'] = idx
            elif 'total' in text and 'col_total' not in col_map:
                col_map['col_total'] = idx
        
        logger.info(f"    Mapped columns: {list(col_map.keys())}")
        
        if 'col_name' not in col_map:
            logger.warning("    No name column found")
            return []
        
        # Extract data rows
        results = []
        for row_idx, row in enumerate(rows[1:15]):  # Check up to 15 data rows
            cells = row.find_all(['td', 'th'])
            
            if len(cells) < len(col_map):
                continue
            
            # Get name
            name_idx = col_map['col_name']
            if name_idx >= len(cells):
                continue
            
            name = cells[name_idx].get_text(strip=True)
            
            # Filter out header rows that repeat
            if not name or len(name) < 3 or name.lower() in ['name', 'year', 'executive']:
                continue
            
            # Extract all components
            record = {'name': name}
            
            for comp_key, col_idx in col_map.items():
                if comp_key == 'col_name':
                    continue
                
                if col_idx < len(cells):
                    value_text = cells[col_idx].get_text(strip=True)
                    value = self._parse_money(value_text)
                    
                    # Map to database field names
                    field_map = {
                        'col_salary': 'base_salary',
                        'col_bonus': 'bonus',
                        'col_stock': 'stock_awards',
                        'col_option': 'option_awards',
                        'col_non_equity': 'non_equity_incentive',
                        'col_pension': 'change_in_pension_value',
                        'col_other': 'all_other_compensation',
                        'col_total': 'total_compensation'
                    }
                    
                    db_field = field_map.get(comp_key)
                    if db_field:
                        record[db_field] = value
            
            # Calculate total if not present
            if 'total_compensation' not in record or record['total_compensation'] is None:
                components = [v for v in [
                    record.get('base_salary'),
                    record.get('bonus'),
                    record.get('stock_awards'),
                    record.get('option_awards'),
                    record.get('non_equity_incentive'),
                    record.get('change_in_pension_value'),
                    record.get('all_other_compensation')
                ] if v is not None and v > 0]
                
                if components:
                    record['total_compensation'] = sum(components)
            
            # Only keep if we have meaningful data
            if record.get('total_compensation') and record['total_compensation'] > 50000:
                results.append(record)
                logger.info(f"      {name}: Total=${record['total_compensation']:,}, "
                           f"Salary=${record.get('base_salary', 0):,}, "
                           f"Stock=${record.get('stock_awards', 0):,}")
        
        return results
    
    def _parse_money(self, text: str) -> Optional[int]:
        """Parse monetary value from text"""
        if not text:
            return None
        
        # Remove formatting
        cleaned = re.sub(r'[$,\\s()]+', '', text)
        
        # Handle dashes/blanks
        if cleaned in ['—', '-', '', 'N/A', 'n/a', '0']:
            return 0
        
        # Extract number
        match = re.search(r'\\d+', cleaned)
        if match:
            try:
                return int(match.group())
            except:
                pass
        
        return None
    
    def save_to_db(self, company_id: str, fiscal_year: int, executives: List[Dict]):
        """Save to database"""
        for exec_data in executives:
            record = {
                'company_id': company_id,
                'fiscal_year': fiscal_year,
                'role': exec_data['name'],
                'total_compensation': exec_data.get('total_compensation'),
                'base_salary': exec_data.get('base_salary'),
                'bonus': exec_data.get('bonus'),
                'stock_awards': exec_data.get('stock_awards'),
                'option_awards': exec_data.get('option_awards'),
                'non_equity_incentive': exec_data.get('non_equity_incentive'),
                'change_in_pension_value': exec_data.get('change_in_pension_value'),
                'all_other_compensation': exec_data.get('all_other_compensation')
            }
            
            try:
                # Upsert: update if exists, insert if not
                supabase.table('executive_compensation_annual').upsert(record).execute()
            except Exception as e:
                logger.error(f"      DB error: {e}")
    
    def process_company(self, company_id: str, cik: str, company_name: str):
        """Process single company"""
        self.stats['total'] += 1
        
        logger.info(f"\\n{'='*70}")
        logger.info(f"[{self.stats['total']}] {company_name}")
        logger.info('='*70)
        
        html = self.fetch_proxy(cik)
        if not html:
            logger.warning("✗ No proxy found")
            return
        
        self.stats['proxy_found'] += 1
        
        table = self.find_comp_table(html)
        if not table:
            logger.warning("✗ Could not identify compensation table")
            return
        
        self.stats['table_found'] += 1
        
        executives = self.extract_components_from_table(table)
        
        if not executives:
            logger.warning("✗ No executives extracted")
            return
        
        self.stats['components_extracted'] += 1
        
        # Save to database
        self.save_to_db(company_id, 2024, executives)
        
        logger.info(f"  ✓ SUCCESS: Saved {len(executives)} executives")
    
    def print_stats(self):
        """Print extraction statistics"""
        logger.info(f"\\n{'='*70}")
        logger.info("EXTRACTION STATISTICS")
        logger.info('='*70)
        logger.info(f"Companies processed: {self.stats['total']}")
        logger.info(f"Proxies found: {self.stats['proxy_found']} ({100*self.stats['proxy_found']/max(1,self.stats['total']):.1f}%)")
        logger.info(f"Tables identified: {self.stats['table_found']} ({100*self.stats['table_found']/max(1,self.stats['proxy_found']):.1f}%)")
        logger.info(f"Components extracted: {self.stats['components_extracted']} ({100*self.stats['components_extracted']/max(1,self.stats['table_found']):.1f}%)")


def main():
    """Test extraction on sample companies"""
    extractor = ProductionComponentExtractor()
    
    # Get sample companies
    companies = supabase.table('companies')\
        .select('id, company_name, cik')\
        .not_.is_('cik', 'null')\
        .limit(5)\
        .execute()
    
    for co in companies.data:
        extractor.process_company(co['id'], co['cik'], co['company_name'])
        time.sleep(0.2)
    
    extractor.print_stats()


if __name__ == '__main__':
    main()
