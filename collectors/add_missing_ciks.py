"""
CIK Lookup Tool - Add SEC CIKs to companies missing them
Uses SEC company tickers JSON API (100% free)
"""

import requests
import time
import logging
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

class CIKLookup:
    """Look up CIKs for companies using SEC company tickers API"""
    
    SEC_TICKERS_URL = "https://www.sec.gov/files/company_tickers.json"
    HEADERS = {
        'User-Agent': 'RiskAnchor Governance Research research@riskanchor.com',
        'Accept-Encoding': 'gzip, deflate'
    }
    
    def __init__(self):
        self.ticker_map = {}
        self.load_sec_tickers()
    
    def load_sec_tickers(self):
        """Load SEC's complete ticker to CIK mapping"""
        logger.info("📥 Downloading SEC ticker mapping...")
        
        try:
            response = requests.get(self.SEC_TICKERS_URL, headers=self.HEADERS, timeout=30)
            response.raise_for_status()
            
            data = response.json()
            
            # Build ticker -> CIK map
            for entry in data.values():
                ticker = entry.get('ticker', '').upper()
                cik = str(entry.get('cik_str', '')).zfill(10)
                title = entry.get('title', '')
                
                if ticker and cik:
                    self.ticker_map[ticker] = {
                        'cik': cik,
                        'company_name': title
                    }
            
            logger.info(f"✅ Loaded {len(self.ticker_map)} ticker->CIK mappings")
            
        except Exception as e:
            logger.error(f"❌ Error loading SEC tickers: {e}")
    
    def update_company_ciks(self, batch_size: int = 1000):
        """Update CIKs for companies with tickers but missing CIKs"""
        
        logger.info("\n🔍 Finding companies with tickers but no CIK...")
        
        # Get companies with ticker but no CIK
        companies = supabase.table('companies') \
            .select('id, ticker_symbol, company_name') \
            .is_('cik', 'null') \
            .not_.is_('ticker_symbol', 'null') \
            .limit(batch_size) \
            .execute()
        
        logger.info(f"Found {len(companies.data)} companies to update")
        
        updated = 0
        not_found = 0
        
        for company in companies.data:
            ticker = company.get('ticker_symbol', '').upper().strip()
            
            if not ticker:
                continue
            
            # Look up CIK
            if ticker in self.ticker_map:
                cik = self.ticker_map[ticker]['cik']
                sec_name = self.ticker_map[ticker]['company_name']
                
                try:
                    # Update company with CIK
                    supabase.table('companies').update({
                        'cik': cik
                    }).eq('id', company['id']).execute()
                    
                    updated += 1
                    logger.info(f"  ✅ {ticker}: Added CIK {cik}")
                    
                except Exception as e:
                    logger.error(f"  ❌ Error updating {ticker}: {e}")
            else:
                not_found += 1
                if not_found <= 10:  # Only log first 10
                    logger.info(f"  ⚠️  {ticker}: No CIK found in SEC database")
        
        logger.info(f"\n📊 Summary:")
        logger.info(f"  ✅ Updated: {updated}")
        logger.info(f"  ⚠️  Not found: {not_found}")
        logger.info(f"  📈 Success rate: {updated/(updated+not_found)*100:.1f}%")
        
        return updated

def run_cik_lookup(batch_size: int = 5000):
    """Run CIK lookup for all companies"""
    lookup = CIKLookup()
    total_updated = lookup.update_company_ciks(batch_size=batch_size)
    
    logger.info(f"\n✅ CIK lookup complete! Updated {total_updated} companies")
    
    # Show new totals
    with_cik = supabase.table('companies').select('id', count='exact').not_.is_('cik', 'null').execute()
    logger.info(f"📊 Total companies with CIKs now: {with_cik.count}")

if __name__ == "__main__":
    import sys
    batch = int(sys.argv[1]) if len(sys.argv) > 1 else 5000
    run_cik_lookup(batch)
