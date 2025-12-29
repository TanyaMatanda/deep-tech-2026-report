"""
Gemini-Powered Compensation Extractor - Updated for new google-genai SDK
Uses Gemini API to intelligently parse iXBRL compensation tables
"""

from google import genai
from google.genai import types
import requests
import time
import json
import logging
from typing import Dict, List, Optional
from supabase import create_client, Client, ClientOptions
import toml
import os

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Configure Gemini with new SDK
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY") or os.getenv("GOOGLE_API_KEY")
if not GEMINI_API_KEY:
    # Try loading from secrets
    try:
        secrets = toml.load(".streamlit/secrets.toml")
        GEMINI_API_KEY = secrets.get("GEMINI_API_KEY") or secrets.get("GOOGLE_API_KEY")
    except:
        pass

if not GEMINI_API_KEY:
    logger.error("❌ GEMINI_API_KEY not found")
    exit(1)

client = genai.Client(api_key=GEMINI_API_KEY)

# Supabase config
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

class GeminiExtractor:
    
    SEC_DATA_BASE = "https://data.sec.gov"
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {
        'User-Agent': 'RiskAnchor research@riskanchor.com'
    }
    
    def __init__(self):
        self.daily_requests = 0
        self.last_request_time = 0
    
    def rate_limit(self):
        """SEC rate limit"""
        current_time = time.time()
        elapsed = current_time - self.last_request_time
        if elapsed < 0.1:
            time.sleep(0.1 - elapsed)
        self.last_request_time = time.time()
    
    def fetch_proxy(self, cik: str) -> Optional[str]:
        """Fetch DEF 14A"""
        self.rate_limit()
        
        cik_padded = cik.zfill(10)
        cik_no_padding = str(int(cik))
        
        try:
            submissions_url = f"{self.SEC_DATA_BASE}/submissions/CIK{cik_padded}.json"
            response = requests.get(submissions_url, headers=self.HEADERS, timeout=10)
            response.raise_for_status()
            
            data = response.json()
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
                logger.info(f"✓ Found proxy for CIK {cik}")
                return resp.text
            
            return None
        except Exception as e:
            logger.error(f"Error: {e}")
            return None
    
    def extract_with_gemini(self, html: str, ticker: str) -> List[Dict]:
        """Extract using Gemini"""
        
        # Truncate if too large
        max_len = 100000
        if len(html) > max_len:
            if 'summary compensation' in html.lower():
                idx = html.lower().index('summary compensation')
                html = html[max(0, idx-5000):idx+50000]
            else:
                html = html[:max_len]
        
        prompt = f"""Extract Summary Compensation Table from this SEC proxy for {ticker}.

Return ONLY valid JSON array with this exact format:
[{{"name": "Full Name", "title": "CEO", "base_salary": 1500000, "bonus": 0, "stock_awards": 15000000, "option_awards": 0, "non_equity_incentive": 1425000, "all_other_compensation": 175000, "total_compensation": 18100000}}]

If no table found, return: []

HTML:
{html[:70000]}"""
        
        try:
            self.daily_requests += 1
            logger.info(f"Calling Gemini ({self.daily_requests}/1500)...")
            
            response = client.models.generate_content(
                model='gemini-2.0-flash',  # Available model
                contents=prompt
            )
            
            text = response.text.strip()
            
            # Clean markdown
            if text.startswith('```'):
                text = text.split('```')[1]
                if text.startswith('json'):
                    text = text[4:]
                text = text.strip()
            
            data = json.loads(text)
            logger.info(f"✓ Extracted {len(data)} NEOs")
            return data
            
        except json.JSONDecodeError as e:
            logger.error(f"JSON error: {e}")
            return []
        except Exception as e:
            logger.error(f"Gemini error: {e}")
            return []
    
    def process_company(self, company_id: str, cik: str, ticker: str) -> Dict:
        """Process company"""
        logger.info(f"\n{'='*60}")
        logger.info(f"{ticker} (CIK: {cik})")
        logger.info(f"{'='*60}")
        
        if self.daily_requests >= 1400:
            logger.warning("⚠️ Near daily limit")
            return {'status': 'rate_limited'}
        
        html = self.fetch_proxy(cik)
        if not html:
            return {}
        
        neos = self.extract_with_gemini(html, ticker)
        
        saved = 0
        for neo in neos:
            try:
                person = supabase.table('people').select('id').eq('full_name', neo['name']).execute()
                
                if person.data:
                    pid = person.data[0]['id']
                else:
                    new = supabase.table('people').insert({
                        'full_name': neo['name'],
                        'current_title': neo.get('title', '')
                    }).execute()
                    pid = new.data[0]['id']
                
                supabase.table('executive_compensation_annual').upsert({
                    'company_id': company_id,
                    'person_id': pid,
                    'fiscal_year': 2024,
                    'role': neo.get('title', ''),
                    'base_salary': neo.get('base_salary'),
                    'bonus': neo.get('bonus'),
                    'stock_awards': neo.get('stock_awards'),
                    'option_awards': neo.get('option_awards'),
                    'non_equity_incentive': neo.get('non_equity_incentive'),
                    'all_other_compensation': neo.get('all_other_compensation'),
                    'total_compensation': neo.get('total_compensation')
                }, on_conflict='company_id,person_id,fiscal_year').execute()
                
                saved += 1
                logger.info(f"  ✅ {neo['name']} - ${neo.get('total_compensation', 0):,}")
            except Exception as e:
                logger.error(f"  ❌ Error: {e}")
        
        return {'neos': neos, 'saved': saved}

def run(limit: int = 50):
    """Run extraction"""
    ext = GeminiExtractor()
    
    logger.info(f"🚀 Gemini Extraction (Limit: {limit})")
    
    companies = supabase.table('companies').select('id, ticker_symbol, cik').not_.is_('cik', 'null').limit(limit).execute()
    
    logger.info(f"Companies: {len(companies.data)}\n")
    
    total = 0
    for c in companies.data:
        if not c.get('cik'):
            continue
        
        result = ext.process_company(c['id'], c['cik'], c.get('ticker_symbol', 'N/A'))
        
        if result.get('status') == 'rate_limited':
            break
        
        total += result.get('saved', 0)
        time.sleep(2)
    
    logger.info(f"\n✅ Complete! Saved {total} NEOs")
    logger.info(f"Gemini requests: {ext.daily_requests}/1500")

if __name__ == "__main__":
    import sys
    limit = int(sys.argv[1]) if len(sys.argv) > 1 else 50
    run(limit)
