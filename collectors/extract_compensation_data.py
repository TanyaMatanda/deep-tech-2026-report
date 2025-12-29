"""
ISS/OECD Executive Compensation Data Extractor
Parses SEC DEF 14A proxy circulars to extract comprehensive compensation data.

Based on ISS Pay-for-Performance methodology and OECD Principle VI.D.
"""

import os
import re
import requests
import time
from datetime import datetime
from bs4 import BeautifulSoup
from supabase import create_client, Client, ClientOptions
import toml
import logging
from typing import Dict, List, Optional, Tuple
import pandas as pd

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('compensation_extraction.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

# Supabase Configuration
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
    except:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")

if not url or not key:
    logger.error("❌ Supabase credentials not found")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

HEADERS = {'User-Agent': 'RiskAnchor Governance Research research@riskanchor.com'}

# ============================================
# PERFORMANCE METRICS TAXONOMY
# ============================================

# ISS-tracked performance metrics (standardized)
PERFORMANCE_METRICS = {
    # Financial Metrics
    'revenue': ['revenue', 'sales', 'total revenue', 'net sales'],
    'ebitda': ['ebitda', 'adjusted ebitda', 'operating ebitda'],
    'eps': ['eps', 'earnings per share', 'diluted eps', 'adjusted eps'],
    'net_income': ['net income', 'net profit', 'net earnings'],
    'operating_income': ['operating income', 'operating profit', 'ebit'],
    'free_cash_flow': ['free cash flow', 'fcf', 'operating cash flow'],
    'roic': ['roic', 'return on invested capital'],
    'roa': ['roa', 'return on assets'],
    'roe': ['roe', 'return on equity'],
    'gross_margin': ['gross margin', 'gross profit margin'],
    
    # Market Metrics
    'tsr': ['tsr', 'total shareholder return', 'total return', 'stock price'],
    'relative_tsr': ['relative tsr', 'rtsr', 'tsr vs', 'tsr percentile'],
    'market_cap': ['market capitalization', 'market cap'],
    
    # Operational Metrics
    'customer_growth': ['customer growth', 'new customers', 'user growth'],
    'market_share': ['market share', 'share of market'],
    'product_launches': ['product launches', 'new products'],
    
    # Strategic/Qualitative
    'strategic_goals': ['strategic objectives', 'strategic goals', 'strategic plan'],
    'innovation': ['innovation', 'r&d milestones', 'pipeline'],
    'individual_performance': ['individual objectives', 'personal goals'],
    
    # ESG Metrics
    'safety': ['safety', 'ltir', 'trir', 'recordable incidents'],
    'diversity': ['diversity', 'dei', 'inclusion', 'women in leadership'],
    'sustainability': ['sustainability', 'emissions', 'carbon', 'esg'],
}

def normalize_metric_name(raw_metric: str) -> str:
    """Convert company-specific metric names to standardized taxonomy."""
    raw_lower = raw_metric.lower().strip()
    
    for standard_name, variants in PERFORMANCE_METRICS.items():
        for variant in variants:
            if variant in raw_lower:
                return standard_name
    
    # If no match, return cleaned raw metric
    return raw_lower

# ============================================
# SUMMARY COMPENSATION TABLE (SCT) EXTRACTION
# ============================================

def extract_summary_compensation_table(html_content: str, company_id: str, year: int) -> List[Dict]:
    """
    Extract Summary Compensation Table (SCT) from proxy statement.
    
    Returns list of dicts with NEO compensation data.
    """
    soup = BeautifulSoup(html_content, 'html.parser')
    
    # Find SCT table - common patterns
    sct_patterns = [
        'summary compensation table',
        'summary of compensation',
        'executive compensation summary'
    ]
    
    sct_data = []
    
    # Strategy 1: Find table by heading
    for pattern in sct_patterns:
        # Look for table caption or preceding header
        for text_elem in soup.find_all(string=re.compile(pattern, re.IGNORECASE)):
            # Find next table after this heading
            table = text_elem.find_next('table')
            if table:
                logger.info(f"Found SCT table for pattern: {pattern}")
                sct_data = parse_sct_table(table, company_id, year)
                if sct_data:
                    return sct_data
    
    logger.warning(f"SCT table not found for company {company_id}")
    return []

def parse_sct_table(table, company_id: str, year: int) -> List[Dict]:
    """Parse HTML table into structured compensation data."""
    data = []
    
    # Extract headers
    headers = []
    header_row = table.find('tr')
    if header_row:
        headers = [th.get_text(strip=True).lower() for th in header_row.find_all(['th', 'td'])]
    
    # Map common column variations to standard names
    column_map = {
        'name': ['name', 'executive', 'officer'],
        'role': ['position', 'title', 'principal position'],
        'year': ['year', 'fiscal year'],
        'salary': ['salary', 'base salary'],
        'bonus': ['bonus', 'annual bonus', 'cash bonus'],
        'stock_awards': ['stock awards', 'stock', 'restricted stock'],
        'option_awards': ['option awards', 'options', 'stock options'],
        'non_equity_incentive': ['non-equity incentive', 'annual incentive', 'incentive plan'],
        'pension': ['change in pension', 'pension', 'deferred compensation'],
        'all_other': ['all other', 'other compensation'],
        'total': ['total', 'total compensation']
    }
    
    # Identify column indices
    col_indices = {}
    for standard_col, variants in column_map.items():
        for i, header in enumerate(headers):
            if any(variant in header for variant in variants):
                col_indices[standard_col] = i
                break
    
    logger.info(f"SCT column mapping: {col_indices}")
    
    # Extract data rows
    for row in table.find_all('tr')[1:]:  # Skip header
        cells = row.find_all('td')
        if len(cells) < 3:
            continue
        
        try:
            # Extract name and role
            name = cells[col_indices.get('name', 0)].get_text(strip=True) if 'name' in col_indices else None
            role = cells[col_indices.get('role', 1)].get_text(strip=True) if 'role' in col_indices else None
            
            if not name or len(name) < 3:
                continue
            
            # Extract compensation amounts (remove $ and ,)
            def clean_amount(idx):
                if idx is None or idx >= len(cells):
                    return None
                text = cells[idx].get_text(strip=True)
                text = text.replace('$', '').replace(',', '').strip()
                # Handle dash or blank as zero
                if text in ['—', '-', ''] or text.isalpha():
                    return 0
                try:
                    return int(float(text))
                except:
                    return None
            
            comp_data = {
                'company_id': company_id,
                'name': name,
                'role': role,
                'fiscal_year': year,
                'base_salary': clean_amount(col_indices.get('salary')),
                'bonus': clean_amount(col_indices.get('bonus')),
                'stock_awards': clean_amount(col_indices.get('stock_awards')),
                'option_awards': clean_amount(col_indices.get('option_awards')),
                'non_equity_incentive': clean_amount(col_indices.get('non_equity_incentive')),
                'change_in_pension_value': clean_amount(col_indices.get('pension')),
                'all_other_compensation': clean_amount(col_indices.get('all_other')),
                'total_compensation': clean_amount(col_indices.get('total'))
            }
            
            # Validate that we got some real data
            if comp_data['total_compensation'] and comp_data['total_compensation'] > 0:
                data.append(comp_data)
                logger.info(f"Extracted SCT data for {name} ({role}): ${comp_data['total_compensation']:,}")
        
        except Exception as e:
            logger.error(f"Error parsing SCT row: {e}")
            continue
    
    return data

# ============================================
# STI PERFORMANCE METRICS EXTRACTION
# ============================================

def extract_sti_metrics(html_content: str, company_id: str, year: int) -> List[Dict]:
    """
    Extract Short-Term Incentive (STI) performance metrics from CD&A section.
    
    Looks for annual bonus metrics, weights, targets, and actual results.
    """
    soup = BeautifulSoup(html_content, 'html.parser')
    
    # Find CD&A (Compensation Discussion & Analysis) section
    cda_patterns = [
        'compensation discussion and analysis',
        'compensation discussion',
        'annual incentive',
        'short-term incentive',
        'performance metrics'
    ]
    
    metrics = []
    
    # Search for performance metrics disclosure
    text = soup.get_text(separator=' ', strip=True).lower()
    
    # Pattern: Look for tables with "metric", "weight", "target"
    for table in soup.find_all('table'):
        table_text = table.get_text(separator=' ', strip=True).lower()
        
        # Check if this is a performance metrics table
        if not any(keyword in table_text for keyword in ['metric', 'weight', 'target', 'performance', 'goal']):
            continue
        
        logger.info(f"Found potential STI metrics table")
        
        # Parse table
        rows = table.find_all('tr')
        if len(rows) < 2:
            continue
        
        # Extract headers
        headers = [th.get_text(strip=True).lower() for th in rows[0].find_all(['th', 'td'])]
        
        # Identify columns
        metric_col = next((i for i, h in enumerate(headers) if 'metric' in h or 'measure' in h), 0)
        weight_col = next((i for i, h in enumerate(headers) if 'weight' in h or '%' in h), None)
        target_col = next((i for i, h in enumerate(headers) if 'target' in h), None)
        actual_col = next((i for i, h in enumerate(headers) if 'actual' in h or 'result' in h), None)
        
        for row in rows[1:]:
            cells = row.find_all('td')
            if len(cells) < 2:
                continue
            
            try:
                metric_name = cells[metric_col].get_text(strip=True)
                
                if len(metric_name) < 3 or metric_name.lower() in ['total', 'total weight']:
                    continue
                
                # Extract weight
                weight = None
                if weight_col is not None and weight_col < len(cells):
                    weight_text = cells[weight_col].get_text(strip=True).replace('%', '').strip()
                    try:
                        weight = float(weight_text)
                    except:
                        pass
                
                # Extract target (if numeric)
                target = None
                if target_col is not None and target_col < len(cells):
                    target_text = cells[target_col].get_text(strip=True)
                    target_text = target_text.replace('$', '').replace(',', '').replace('M', '').replace('B', '').strip()
                    try:
                        target = float(target_text)
                    except:
                        target = target_text  # Store as text if not numeric
                
                metric_data = {
                    'company_id': company_id,
                    'fiscal_year': year,
                    'metric_name': metric_name,
                    'metric_name_normalized': normalize_metric_name(metric_name),
                    'weight_percent': weight,
                    'target_value': target
                }
                
                metrics.append(metric_data)
                logger.info(f"Extracted STI metric: {metric_name} ({weight}%)")
            
            except Exception as e:
                logger.error(f"Error parsing STI metric row: {e}")
                continue
    
    return metrics

# ============================================
# PEER GROUP EXTRACTION
# ============================================

def extract_peer_group(html_content: str, company_id: str, year: int) -> List[str]:
    """Extract compensation peer group companies from proxy."""
    soup = BeautifulSoup(html_content, 'html.parser')
    
    peers = []
    
    # Search for peer group disclosure
    text = soup.get_text(separator='\\n', strip=True)
    
    # Pattern: "peer group consists of:" followed by list
    peer_patterns = [
        r'peer group.*?(?:consists of|includes|comprises).*?:(.*?)(?:\n\n|table|audit|governance)',
        r'compensation peer group.*?:(.*?)(?:\n\n|table)',
        r'comparator group.*?:(.*?)(?:\n\n|table)'
    ]
    
    for pattern in peer_patterns:
        match = re.search(pattern, text, re.IGNORECASE | re.DOTALL)
        if match:
            peer_text = match.group(1)
            
            # Extract company names (look for capitalized multi-word phrases)
            # Common patterns: "Adobe Inc.", "Intel Corporation", "NVIDIA Corporation"
            potential_peers = re.findall(r'\b([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*(?:\s+(?:Inc|Corp|Corporation|Ltd|LLC|Technologies|Systems|Software|Group))?\.?)', peer_text)
            
            for peer in potential_peers:
                peer = peer.strip()
                if len(peer) > 3 and peer not in peers:
                    peers.append(peer)
                    logger.info(f"Found peer: {peer}")
    
    return peers

# ============================================
# SAY-ON-PAY VOTE EXTRACTION
# ============================================

def extract_say_on_pay_vote(html_content: str, company_id: str, year: int) -> Optional[Dict]:
    """Extract say-on-pay voting results."""
    soup = BeautifulSoup(html_content, 'html.parser')
    
    text = soup.get_text(separator=' ', strip=True).lower()
    
    # Look for voting results table on executive compensation
    # Pattern: "approve executive compensation" or "say-on-pay"
    
    vote_patterns = [
        r'(?:approve|advisory vote).*?(?:executive compensation|named executive officer).*?votes?\s+for[:\s]+([0-9,]+).*?votes?\s+against[:\s]+([0-9,]+)',
        r'say-on-pay.*?for[:\s]+([0-9,]+).*?against[:\s]+([0-9,]+)'
    ]
    
    for pattern in vote_patterns:
        match = re.search(pattern, text, re.IGNORECASE | re.DOTALL)
        if match:
            votes_for = int(match.group(1).replace(',', ''))
            votes_against = int(match.group(2).replace(',', ''))
            
            total_votes = votes_for + votes_against
            approval_pct = (votes_for / total_votes * 100) if total_votes > 0 else 0
            
            logger.info(f"Say-on-Pay: {approval_pct:.1f}% approval")
            
            return {
                'company_id': company_id,
                'fiscal_year': year,
                'votes_for': votes_for,
                'votes_against': votes_against,
                'approval_percentage': round(approval_pct, 2)
            }
    
    return None

# ============================================
# MAIN EXTRACTION ORCHESTRATOR
# ============================================

def get_document_url(index_url: str) -> Optional[str]:
    """Resolve actual document URL from SEC index page."""
    try:
        response = requests.get(index_url, headers=HEADERS, timeout=10)
        if response.status_code != 200:
            return None
        
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Look for the primary document (usually def14a.htm or similar)
        # Strategy 1: Find table with 'tableFile' class
        table = soup.find('table', class_='tableFile')
        if table:
            for row in table.find_all('tr')[1:]:  # Skip header
                cells = row.find_all('td')
                if len(cells) >= 3:
                    # Column 2 usually has 'Type', column 3 has the link
                    doc_type = cells[1].get_text(strip=True) if len(cells) > 1 else ''
                    if 'DEF 14A' in doc_type.upper() or cells[2].find('a'):
                        link = cells[2].find('a')
                        if link:
                            href = link.get('href')
                            if href and href.endswith(('.htm', '.html')) and 'index.htm' not in href:
                                # Resolve full URL
                                if href.startswith('/'):
                                    return f"https://www.sec.gov{href}"
                                else:
                                    # Relative to index page
                                    base_url = '/'.join(index_url.split('/')[:-1])
                                    return f"{base_url}/{href}"
        
        # Strategy 2: Look for any .htm/.html link that isn't index.htm
        for link in soup.find_all('a'):
            href = link.get('href')
            if href and href.endswith(('.htm', '.html')) and 'index.htm' not in href.lower():
                if href.startswith('/'):
                    return f"https://www.sec.gov{href}"
                else:
                    base_url = '/'.join(index_url.split('/')[:-1])
                    return f"{base_url}/{href}"
        
        return None
    except Exception as e:
        logger.error(f"Error resolving document URL: {e}")
        return None

def process_company_proxy(company_id: str, ticker: str, year: int, filing_url: str) -> Dict:
    """
    Main extraction function for a single company's proxy statement.
    
    Returns dict with all extracted compensation data.
    """
    logger.info(f"\\n{'='*60}")
    logger.info(f"Processing {ticker} ({year}) - {filing_url}")
    logger.info(f"{'='*60}")
    
    # If filing_url is an index page, resolve to actual document
    if 'index.htm' in filing_url.lower():
        logger.info(f"Resolving document URL from index page...")
        doc_url = get_document_url(filing_url)
        if not doc_url:
            logger.error(f"Could not resolve document URL from {filing_url}")
            return {}
        logger.info(f"Resolved to: {doc_url}")
        filing_url = doc_url
    
    # Fetch proxy document
    try:
        response = requests.get(filing_url, headers=HEADERS, timeout=30)
        if response.status_code != 200:
            logger.error(f"Failed to fetch proxy: HTTP {response.status_code}")
            return {}
        
        html_content = response.text
        
    except Exception as e:
        logger.error(f"Error fetching proxy: {e}")
        return {}
    
    # Extract all components
    results = {
        'company_id': company_id,
        'ticker': ticker,
        'fiscal_year': year,
        'sct_data': extract_summary_compensation_table(html_content, company_id, year),
        'sti_metrics': extract_sti_metrics(html_content, company_id, year),
        'peer_group': extract_peer_group(html_content, company_id, year),
        'say_on_pay': extract_say_on_pay_vote(html_content, company_id, year)
    }
    
    # Summary
    logger.info(f"\\nExtraction Summary for {ticker}:")
    logger.info(f"  - NEOs extracted: {len(results['sct_data'])}")
    logger.info(f"  - STI metrics: {len(results['sti_metrics'])}")
    logger.info(f"  - Peer companies: {len(results['peer_group'])}")
    logger.info(f"  - Say-on-Pay: {'Yes' if results['say_on_pay'] else 'No'}")
    
    return results

def save_compensation_data_to_db(results: Dict):
    """Save extracted compensation data to database."""
    
    # 1. Save SCT data (link to existing or create people)
    for neo_data in results.get('sct_data', []):
        try:
            # Find or create person
            person = supabase.table('people').select('id').eq('full_name', neo_data['name']).execute()
            
            if person.data:
                person_id = person.data[0]['id']
            else:
                # Create person
                new_person = supabase.table('people').insert({
                    'full_name': neo_data['name'],
                    'current_title': neo_data['role']
                }).execute()
                person_id = new_person.data[0]['id']
            
            # Upsert executive compensation
            comp_record = {
                'company_id': neo_data['company_id'],
                'person_id': person_id,
                'fiscal_year': neo_data['fiscal_year'],
                'role': neo_data['role'],
                'base_salary': neo_data['base_salary'],
                'bonus': neo_data['bonus'],
                'stock_awards': neo_data['stock_awards'],
                'option_awards': neo_data['option_awards'],
                'non_equity_incentive': neo_data['non_equity_incentive'],
                'change_in_pension_value': neo_data['change_in_pension_value'],
                'all_other_compensation': neo_data['all_other_compensation'],
                'total_compensation': neo_data['total_compensation']
            }
            
            supabase.table('executive_compensation_annual').upsert(
                comp_record,
                on_conflict='company_id,person_id,fiscal_year'
            ).execute()
            
            logger.info(f"✅ Saved compensation for {neo_data['name']}")
        
        except Exception as e:
            logger.error(f"Error saving SCT data: {e}")
    
    # 2. Save Say-on-Pay vote
    if results.get('say_on_pay'):
        try:
            supabase.table('say_on_pay_votes').upsert(
                results['say_on_pay'],
                on_conflict='company_id,fiscal_year'
            ).execute()
            logger.info(f"✅ Saved say-on-pay vote")
        except Exception as e:
            logger.error(f"Error saving say-on-pay: {e}")

# ============================================
# BATCH PROCESSING
# ============================================

def run_compensation_extraction(limit: int = 10):
    """Run compensation extraction for companies with DEF 14A filings."""
    
    logger.info(f"🚀 Starting Compensation Extraction (Limit: {limit})")
    
    # Get companies with recent DEF 14A filings
    filings = supabase.table('sec_filings') \
        .select('company_id, filing_url, filing_date, companies(company_name, ticker_symbol)') \
        .eq('filing_type', 'DEF 14A') \
        .order('filing_date', desc=True) \
        .limit(limit) \
        .execute()
    
    for filing in filings.data:
        company = filing['companies']
        if not company:
            continue
        
        # Extract year from filing date
        year = int(filing['filing_date'][:4]) if filing.get('filing_date') else 2024
        
        # Process
        results = process_company_proxy(
            company_id=filing['company_id'],
            ticker=company['ticker_symbol'],
            year=year,
            filing_url=filing['filing_url']
        )
        
        # Save to database
        if results:
            save_compensation_data_to_db(results)
        
        # Rate limiting
        time.sleep(2)
    
    logger.info(f"\\n✅ Compensation extraction complete!")

if __name__ == "__main__":
    # Test mode: Extract for specific company
    import sys
    
    if len(sys.argv) > 1 and sys.argv[1] == '--test':
        # Test with NVIDIA
        test_company_id = 'YOUR_NVIDIA_COMPANY_ID'  # Replace with actual UUID
        test_url = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001045810&type=DEF%2014A"
        
        results = process_company_proxy(
            company_id=test_company_id,
            ticker='NVDA',
            year=2024,
            filing_url=test_url
        )
        
        print("\\nTest Results:")
        print(f"NEOs: {len(results.get('sct_data', []))}")
        print(f"STI Metrics: {len(results.get('sti_metrics', []))}")
    
    else:
        # Production run
        run_compensation_extraction(limit=50)
