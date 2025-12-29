"""
SEC Compensation Data Extractor
Uses SEC data.sec.gov JSON API (same approach as sec_filing_parser.py)
100% free, works for all 5K companies
"""

import re
import requests
import time
from typing import Dict, Optional, List
from bs4 import BeautifulSoup
import logging
from supabase import create_client, Client, ClientOptions
import toml
import os

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Supabase configuration
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

class CompensationExtractor:
    """Extract executive compensation using SEC JSON API"""
    
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
        
        if elapsed < 0.1:  # Less than 100ms since last request
            time.sleep(0.1 - elapsed)
        
        self.last_request_time = time.time()
    
    def fetch_proxy(self, cik: str) -> Optional[str]:
        """Fetch most recent DEF 14A using SEC JSON API"""
        self.rate_limit()
        
        cik_padded = cik.zfill(10)
        cik_no_padding = str(int(cik))
        
        try:
            # Get submission history from JSON API
            submissions_url = f"{self.SEC_DATA_BASE}/submissions/CIK{cik_padded}.json"
            response = requests.get(submissions_url, headers=self.HEADERS, timeout=10)
            response.raise_for_status()
            
            data = response.json()
            filings = data.get('filings', {}).get('recent', {})
            
            if not filings:
                return None
            
            # Find DEF 14A
            forms = filings.get('form', [])
            accession_numbers = filings.get('accessionNumber', [])
            filing_dates = filings.get('filingDate', [])
            primary_documents = filings.get('primaryDocument', [])
            
            target_index = None
            for i, form in enumerate(forms):
                if form == 'DEF 14A':
                    target_index = i
                    break
            
            if target_index is None:
                return None
            
            # Construct filing URL
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
    
    def extract_summary_compensation_table(self, html: str) -> List[Dict]:
        """Extract NEO compensation from Summary Compensation Table"""
        soup = BeautifulSoup(html, 'html.parser')
        results = []
        
        # Strategy: Find table with highest "compensation score"
        best_table = None
        best_score = 0
        
        for table in soup.find_all('table'):
            score = 0
            table_text = table.get_text().lower()
            
            # Scoring heuristics
            if 'summary compensation' in table_text:
                score += 100
            if 'executive compensation' in table_text:
                score += 50
            
            # Look for compensation-related column headers
            headers_text = ' '.join([th.get_text().lower() for th in table.find_all('th')])
            if 'salary' in headers_text:
                score += 20
            if 'bonus' in headers_text:
                score += 20
            if 'stock award' in headers_text or 'stock' in headers_text:
                score += 20
            if 'total compensation' in headers_text or 'total' in headers_text:
                score += 30
            
            # Check for dollar amounts (strong indicator)
            dollar_count = table_text.count('$')
            if dollar_count > 10:
                score += min(dollar_count, 50)
            
            # Check for executive-like names (capitalized words)
            rows = table.find_all('tr')
            name_like_count = 0
            for row in rows[:15]:  # Check first 15 rows
                first_cell = row.find(['td', 'th'])
                if first_cell:
                    text = first_cell.get_text(strip=True)
                    # Name-like: 2-4 capitalized words
                    words = text.split()
                    if len(words) >= 2 and len(words) <= 4:
                        if any(w[0].isupper() for w in words if len(w) > 0):
                            name_like_count += 1
            
            if name_like_count >= 3:  # At least 3 executive names
                score += 40
            
            # Must have reasonable number of rows (not TOC)
            if len(rows) > 5 and len(rows) < 100:
                score += 10
            
            if score > best_score:
                best_score = score
                best_table = table
        
        if not best_table:
            logger.warning("No suitable compensation table found")
            return []
        
        logger.info(f"Found best SCT candidate (score: {best_score})")
        
        # Extract data from best table
        rows = best_table.find_all('tr')
        if len(rows) < 2:
            return []
        
        # Find header row (row with most column headers)
        header_row_idx = 0
        max_headers = 0
        for i, row in enumerate(rows[:5]):  # Check first 5 rows
            headers = [cell.get_text(strip=True).lower() for cell in row.find_all(['th', 'td'])]
            header_count = sum(1 for h in headers if any(kw in h for kw in ['name', 'salary', 'bonus', 'stock', 'total', 'year']))
            if header_count > max_headers:
                max_headers = header_count
                header_row_idx = i
        
        headers = [cell.get_text(strip=True).lower() for cell in rows[header_row_idx].find_all(['th', 'td'])]
        
        # Map columns
        name_col = next((i for i, h in enumerate(headers) if 'name' in h), 0)
        title_col = next((i for i, h in enumerate(headers) if 'position' in h or 'title' in h or 'occupation' in h), None)
        if title_col is None:
            title_col = 1 if len(headers) > 1 else 0
        
        year_col = next((i for i, h in enumerate(headers) if 'year' in h), None)
        salary_col = next((i for i, h in enumerate(headers) if 'salary' in h), None)
        bonus_col = next((i for i, h in enumerate(headers) if 'bonus' in h and 'non' not in h), None)
        stock_col = next((i for i, h in enumerate(headers) if 'stock award' in h or ('stock' in h and 'option' not in h)), None)
        option_col = next((i for i, h in enumerate(headers) if 'option' in h), None)
        non_equity_col = next((i for i, h in enumerate(headers) if 'non-equity' in h or 'non equity' in h or ('incentive plan' in h and 'equity' not in h)), None)
        other_col = next((i for i, h in enumerate(headers) if 'all other' in h or 'other comp' in h), None)
        total_col = next((i for i, h in enumerate(headers) if 'total' in h and 'compensation' in h), None)
        if total_col is None:
            total_col = next((i for i, h in enumerate(headers) if 'total' in h), None)
        
        # Extract data rows (skip header)
        for row in rows[header_row_idx + 1:]:
            cells = row.find_all('td')
            if len(cells) < 3:
                continue
            
            def clean_num(idx):
                if idx is None or idx >= len(cells):
                    return None
                text = cells[idx].get_text(strip=True)
                # Remove $ , and convert to number
                text = re.sub(r'[^\d.]', '', text)
                if not text or text == '.':
                    return 0
                try:
                    return int(float(text))
                except:
                    return None
            
            name = cells[name_col].get_text(strip=True) if name_col < len(cells) else ''
            # Filter out non-names
            if len(name) < 3 or name.lower() in ['total', 'average', 'median']:
                continue
            
            # Must have at least 2 words (first + last name)
            words = name.split()
            if len(words) < 2:
                continue
            
            title = cells[title_col].get_text(strip=True) if title_col and title_col < len(cells) else ''
            
            total = clean_num(total_col)
            
            # Must have positive total compensation
            if not total or total <= 0:
                continue
            
            compensation = {
                'name': name,
                'title': title,
                'base_salary': clean_num(salary_col),
                'bonus': clean_num(bonus_col),
                'stock_awards': clean_num(stock_col),
                'option_awards': clean_num(option_col),
                'non_equity_incentive': clean_num(non_equity_col),
                'all_other_compensation': clean_num(other_col),
                'total_compensation': total
            }
            
            results.append(compensation)
            logger.info(f"  ✓ {name} ({title}): ${total:,}")
        
        return results
    
    def process_company(self, company_id: str, cik: str, ticker: str) -> Dict:
        """Process single company's compensation data"""
        logger.info(f"\n{'='*60}")
        logger.info(f"Processing {ticker} (CIK: {cik})")
        logger.info(f"{'='*60}")
        
        # Fetch proxy
        proxy_html = self.fetch_proxy(cik)
        if not proxy_html:
            logger.warning(f"No proxy found for {ticker}")
            return {}
        
        # Extract compensation
        sct_data = self.extract_summary_compensation_table(proxy_html)
        
        logger.info(f"\nExtracted {len(sct_data)} NEOs for {ticker}")
        
        # Save to database
        for neo in sct_data:
            try:
                # Find or create person
                person = supabase.table('people').select('id').eq('full_name', neo['name']).execute()
                
                if person.data:
                    person_id = person.data[0]['id']
                else:
                    new_person = supabase.table('people').insert({
                        'full_name': neo['name'],
                        'current_title': neo['title']
                    }).execute()
                    person_id = new_person.data[0]['id']
                
                # Upsert compensation
                comp_record = {
                    'company_id': company_id,
                    'person_id': person_id,
                    'fiscal_year': 2024,
                    'role': neo['title'],
                    'base_salary': neo['base_salary'],
                    'bonus': neo['bonus'],
                    'stock_awards': neo['stock_awards'],
                    'option_awards': neo['option_awards'],
                    'non_equity_incentive': neo['non_equity_incentive'],
                    'all_other_compensation': neo['all_other_compensation'],
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
    """Run compensation extraction for companies"""
    extractor = CompensationExtractor()
    
    logger.info(f"🚀 Starting SEC API Compensation Extraction (Limit: {limit})")
    
    # Get companies with CIKs
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
            time.sleep(1)  # Be nice to SEC
            
        except Exception as e:
            logger.error(f"Error processing {company.get('ticker_symbol')}: {e}")
            continue
    
    logger.info("\n✅ Extraction complete!")

if __name__ == "__main__":
    import sys
    limit = int(sys.argv[1]) if len(sys.argv) > 1 else 50
    run_extraction(limit)
