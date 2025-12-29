"""
Enhanced Compensation Component Extractor
Parses ALL columns from SEC Summary Compensation Tables
Extracts: Base Salary, Bonus, Stock Awards, Option Awards, Non-Equity Incentive, Other
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

# Supabase
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)


class EnhancedCompensationParser:
    """Enhanced parser for full compensation component breakdown"""
    
    SEC_DATA_BASE = "https://data.sec.gov"
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {'User-Agent': 'RiskAnchor research@riskanchor.com'}
    
    # Common column header patterns
    COLUMN_PATTERNS = {
        'name': [r'name', r'executive'],
        'year': [r'year', r'fiscal\s+year'],
        'base_salary': [r'salary', r'base'],
        'bonus': [r'bonus'],
        'stock_awards': [r'stock\s+award', r'restricted\s+stock'],
        'option_awards': [r'option\s+award'],
        'non_equity_incentive': [r'non[\s-]?equity', r'incentive\s+plan', r'annual\s+incentive'],
        'pension_change': [r'pension', r'nonqualified\s+deferred', r'change\s+in\s+pension'],
        'all_other': [r'all\s+other', r'other\s+comp']
    }
    
    def __init__(self):
        self.last_request_time = 0
    
    def rate_limit(self):
        current_time = time.time()
        if current_time - self.last_request_time < 0.1:
            time.sleep(0.1)
        self.last_request_time = current_time
    
    def fetch_proxy(self, cik: str) -> Optional[str]:
        """Fetch most recent DEF 14A proxy"""
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
            filing_dates = filings.get('filingDate', [])
            
            # Find most recent DEF 14A
            idx = next((i for i, f in enumerate(forms) if f == 'DEF 14A'), None)
            
            if idx is None:
                return None
            
            accession = accessions[idx].replace('-', '')
            doc = docs[idx]
            filing_date = filing_dates[idx]
            
            url = f"{self.SEC_BASE}/Archives/edgar/data/{cik_no_padding}/{accession}/{doc}"
            
            self.rate_limit()
            
            resp = requests.get(url, headers=self.HEADERS, timeout=15)
            if resp.status_code == 200:
                logger.info(f"✓ Downloaded proxy for CIK {cik} (filed: {filing_date}, {len(resp.text)} chars)")
                return resp.text
            
            return None
        except Exception as e:
            logger.error(f"Error fetching proxy: {e}")
            return None
    
    def find_summary_comp_table(self, html: str) -> Optional[BeautifulSoup]:
        """Locate the Summary Compensation Table in HTML"""
        soup = BeautifulSoup(html, 'lxml')
        
        # Strategy: Find section with "Summary Compensation Table" heading
        # then locate the first table after that heading
        
        text_lower = html.lower()
        if 'summary compensation table' not in text_lower:
            logger.warning("  ⚠ 'Summary Compensation Table' heading not found")
            return None
        
        # Find approximate location
        table_idx = text_lower.index('summary compensation table')
        
        # Extract section around table reference
        section = html[max(0, table_idx - 5000):table_idx + 50000]
        section_soup = BeautifulSoup(section, 'lxml')
        
        # Find all tables in this section
        tables = section_soup.find_all('table')
        
        # The Summary Compensation Table is typically the FIRST or SECOND table after the heading
        for table in tables[:3]:
            # Check if this table has compensation-like structure
            rows = table.find_all('tr')
            if len(rows) < 3:  # Too small
                continue
            
            # Check header row for expected columns
            header_row = rows[0]
            headers = [th.get_text(strip=True).lower() for th in header_row.find_all(['th', 'td'])]
            
            # Must have at least: Name, Year, Salary, Total
            has_name = any('name' in h for h in headers)
            has_year = any('year' in h for h in headers)
            has_salary = any('salary' in h or 'base' in h for h in headers)
            
            if has_name and has_salary:
                logger.info(f"  ✓ Found Summary Compensation Table ({len(rows)} rows)")
                return table
        
        logger.warning("  ⚠ Could not identify Summary Compensation Table structure")
        return None
    
    def identify_column_mapping(self, header_row) -> Dict[str, int]:
        """Map compensation components to column indices"""
        
        headers = []
        for idx, cell in enumerate(header_row.find_all(['th', 'td'])):
            text = cell.get_text(strip=True).lower()
            # Clean up whitespace and special chars
            text = re.sub(r'[\\r\\n\\t]+', ' ', text)
            text = re.sub(r'\\s+', ' ', text)
            headers.append((idx, text))
        
        logger.info(f"  Table has {len(headers)} columns")
        
        mapping = {}
        
        # Try to match each column type
        for comp_type, patterns in self.COLUMN_PATTERNS.items():
            for idx, header_text in headers:
                for pattern in patterns:
                    if re.search(pattern, header_text, re.IGNORECASE):
                        mapping[comp_type] = idx
                        logger.info(f"    {comp_type:20} -> Column {idx}: '{header_text[:40]}'")
                        break
                if comp_type in mapping:
                    break
        
        return mapping
    
    def parse_monetary_value(self, text: str) -> Optional[int]:
        """Parse monetary value from table cell text"""
        if not text:
            return None
        
        # Remove common formatting: $, commas, whitespace, parens
        cleaned = re.sub(r'[$,\\s\\(\\)]+', '', text)
        
        # Handle dashes or blanks (means zero or N/A)
        if cleaned in ['—', '-', '', 'N/A', 'n/a']:
            return 0
        
        # Extract numeric portion
        match = re.search(r'\\d+', cleaned)
        if match:
            try:
                return int(match.group())
            except:
                pass
        
        return None
    
    def extract_executive_data(self, row, column_mapping: Dict[str, int]) -> Optional[Dict]:
        """Extract compensation data from a table row"""
        
        cells = row.find_all(['td', 'th'])
        
        if len(cells) < 3:  # Too few cells
            return None
        
        # Extract name (first column usually)
        name_idx = column_mapping.get('name', 0)
        if name_idx >= len(cells):
            return None
        
        name = cells[name_idx].get_text(strip=True)
        
        # Filter out header rows or empty names
        if not name or len(name) < 3 or name.lower() in ['name', 'year']:
            return None
        
        # Extract year to ensure we're in data rows
        year_idx = column_mapping.get('year')
        if year_idx and year_idx < len(cells):
            year_text = cells[year_idx].get_text(strip=True)
            if not re.search(r'20\\d{2}', year_text):  # Must have year like 2023, 2024
                return None
        
        # Extract compensation components
        data = {
            'name': name,
            'base_salary': None,
            'bonus': None,
            'stock_awards': None,
            'option_awards': None,
            'non_equity_incentive': None,
            'pension_change': None,
            'all_other_compensation': None,
            'total_compensation': None
        }
        
        for comp_type in ['base_salary', 'bonus', 'stock_awards', 'option_awards', 
                          'non_equity_incentive', 'pension_change', 'all_other']:
            col_idx = column_mapping.get(comp_type)
            if col_idx and col_idx < len(cells):
                value = self.parse_monetary_value(cells[col_idx].get_text(strip=True))
                # Map 'all_other' to 'all_other_compensation'
                key = 'all_other_compensation' if comp_type == 'all_other' else comp_type
                data[key] = value
        
        # Calculate total if not found directly
        # Most newer proxies have explicit Total column; older ones don't
        components = [v for v in [
            data.get('base_salary'),
            data.get('bonus'),
            data.get('stock_awards'),
            data.get('option_awards'),
            data.get('non_equity_incentive'),
            data.get('pension_change'),
            data.get('all_other_compensation')
        ] if v is not None]
        
        if components:
            data['total_compensation'] = sum(components)
        
        # Only return if we have actual compensation data
        if data['total_compensation'] and data['total_compensation'] > 0:
            return data
        
        return None
    
    def extract_all_executives(self, html: str) -> List[Dict]:
        """Extract all executive compensation records from proxy"""
        
        table = self.find_summary_comp_table(html)
        if not table:
            return []
        
        rows = table.find_all('tr')
        if len(rows) < 2:
            return []
        
        # First row is headers
        header_row = rows[0]
        column_mapping = self.identify_column_mapping(header_row)
        
        if not column_mapping:
            logger.warning("  ⚠ Could not map any compensation columns")
            return []
        
        # Extract data from remaining rows
        results = []
        for row in rows[1:]:
            exec_data = self.extract_executive_data(row, column_mapping)
            if exec_data:
                results.append(exec_data)
                logger.info(f"    ✓ {exec_data['name']}: ${exec_data['total_compensation']:,}")
        
        logger.info(f"  Extracted {len(results)} executives")
        return results
    
    def save_to_database(self, company_id: str, fiscal_year: int, executives: List[Dict]):
        """Save compensation data to Supabase"""
        
        for exec_data in executives:
            record = {
                'company_id': company_id,
                'fiscal_year': fiscal_year,
                'role': exec_data['name'],  # Will store full name in role field
                'total_compensation': exec_data['total_compensation'],
                'base_salary': exec_data['base_salary'],
                'bonus': exec_data['bonus'],
                'stock_awards': exec_data['stock_awards'],
                'option_awards': exec_data['option_awards'],
                'non_equity_incentive': exec_data['non_equity_incentive'],
                'change_in_pension_value': exec_data['pension_change'],
                'all_other_compensation': exec_data['all_other_compensation']
            }
            
            try:
                supabase.table('executive_compensation_annual').upsert(record).execute()
            except Exception as e:
                logger.error(f"    ✗ Database error: {e}")
    
    def process_company(self, company_id: str, cik: str, company_name: str):
        """Process a single company"""
        logger.info(f"\\n{'='*70}")
        logger.info(f"{company_name} (CIK: {cik})")
        logger.info(f"{'='*70}")
        
        html = self.fetch_proxy(cik)
        if not html:
            logger.warning("✗ No proxy found")
            return
        
        executives = self.extract_all_executives(html)
        
        if not executives:
            logger.warning("✗ No compensation data extracted")
            return
        
        # Save to database
        fiscal_year = 2024  # Most recent
        self.save_to_database(company_id, fiscal_year, executives)
        
        logger.info(f"✓ Saved {len(executives)} executives to database")


def main():
    """Main extraction routine"""
    parser = EnhancedCompensationParser()
    
    # Get companies that need component extraction
    companies = supabase.table('companies')\
        .select('id, company_name, cik')\
        .not_.is_('cik', 'null')\
        .limit(10)\
        .execute()
    
    logger.info(f"Processing {len(companies.data)} companies for component extraction\\n")
    
    for company in companies.data:
        parser.process_company(
            company['id'],
            company['cik'],
            company['company_name']
        )
        time.sleep(0.2)  # Rate limiting
    
    logger.info("\\n✓ Component extraction complete!")


if __name__ == '__main__':
    main()
