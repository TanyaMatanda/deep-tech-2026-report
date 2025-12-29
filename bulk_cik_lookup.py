"""
Bulk CIK Lookup for 20K Selected Companies
Uses SEC company tickers JSON + fuzzy name matching
"""

from supabase import create_client, Client, ClientOptions
import toml
import os
import json
import requests
import time
from difflib import SequenceMatcher

# Supabase setup
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

class BulkCIKLookup:
    """Add CIKs to selected companies"""
    
    SEC_TICKERS_URL = "https://www.sec.gov/files/company_tickers.json"
    HEADERS = {'User-Agent': 'RiskAnchor research@riskanchor.com'}
    
    def __init__(self):
        self.ticker_map = {}
        self.name_map = {}
        self.load_sec_data()
    
    def load_sec_data(self):
        """Load SEC ticker and company mappings"""
        print('📥 Downloading SEC company data...')
        
        try:
            response = requests.get(self.SEC_TICKERS_URL, headers=self.HEADERS, timeout=30)
            response.raise_for_status()
            
            data = response.json()
            
            for entry in data.values():
                ticker = entry.get('ticker', '').upper().strip()
                cik = str(entry.get('cik_str', '')).zfill(10)
                title = entry.get('title', '').strip()
                
                if ticker and cik:
                    self.ticker_map[ticker] = cik
                    self.name_map[title.lower()] = cik
            
            print(f'✅ Loaded {len(self.ticker_map)} SEC companies')
            
        except Exception as e:
            print(f'❌ Error loading SEC data: {e}')
    
    def fuzzy_match_name(self, company_name: str, threshold: float = 0.85):
        """Fuzzy match company name to SEC database"""
        if not company_name:
            return None
        
        company_name_lower = company_name.lower()
        
        # Exact match first
        if company_name_lower in self.name_map:
            return self.name_map[company_name_lower]
        
        # Fuzzy match
        best_match = None
        best_ratio = 0
        
        for sec_name, cik in list(self.name_map.items())[:5000]:  # Limit for speed
            ratio = SequenceMatcher(None, company_name_lower, sec_name).ratio()
            if ratio > best_ratio and ratio >= threshold:
                best_ratio = ratio
                best_match = cik
        
        return best_match
    
    def update_company_ciks(self, company_ids: list):
        """Update CIKs for list of company IDs"""
        
        print(f'\n🔍 Processing {len(company_ids):,} companies...\n')
        
        updated_ticker = 0
        updated_name = 0
        not_found = 0
        already_had = 0
        
        # Process in batches
        batch_size = 100
        for i in range(0, len(company_ids), batch_size):
            batch = company_ids[i:i+batch_size]
            
            # Fetch company data
            companies = supabase.table('companies')\
                .select('id, company_name, ticker_symbol, cik')\
                .in_('id', batch)\
                .execute()
            
            for company in companies.data:
                company_id = company['id']
                ticker = (company.get('ticker_symbol') or '').upper().strip()
                name = company.get('company_name', '')
                existing_cik = company.get('cik')
                
                if existing_cik:
                    already_had += 1
                    continue
                
                cik = None
                match_type = None
                
                # Try ticker match first
                if ticker and ticker in self.ticker_map:
                    cik = self.ticker_map[ticker]
                    match_type = 'ticker'
                    updated_ticker += 1
                
                # Try name match
                elif name:
                    cik = self.fuzzy_match_name(name)
                    if cik:
                        match_type = 'name'
                        updated_name += 1
                
                if cik:
                    # Update database
                    try:
                        supabase.table('companies').update({
                            'cik': cik
                        }).eq('id', company_id).execute()
                        
                        if (updated_ticker + updated_name) % 100 == 0:
                            print(f'  Progress: {updated_ticker + updated_name:,} CIKs added')
                        
                    except Exception as e:
                        print(f'  ❌ Error updating {name}: {e}')
                else:
                    not_found += 1
            
            time.sleep(0.1)  # Rate limiting
        
        print('\n' + '='*60)
        print('CIK LOOKUP COMPLETE')
        print('='*60)
        print(f'  ✅ Matched by ticker: {updated_ticker:,}')
        print(f'  ✅ Matched by name: {updated_name:,}')
        print(f'  ℹ️  Already had CIK: {already_had:,}')
        print(f'  ⚠️  Not found: {not_found:,}')
        print(f'  📊 Success rate: {(updated_ticker + updated_name) / (len(company_ids) - already_had) * 100:.1f}%')
        
        return {
            'ticker_matches': updated_ticker,
            'name_matches': updated_name,
            'already_had': already_had,
            'not_found': not_found
        }

def run_bulk_cik_lookup():
    """Run CIK lookup for all selected companies"""
    
    # Load selected company IDs
    with open('backups/selected_companies_20k.json', 'r') as f:
        data = json.load(f)
        company_ids = data['company_ids']
    
    print(f'📋 Loaded {len(company_ids):,} selected companies')
    
    # Run lookup
    lookup = BulkCIKLookup()
    results = lookup.update_company_ciks(company_ids)
    
    # Save results
    with open('backups/cik_lookup_results.json', 'w') as f:
        json.dump(results, f, indent=2)
    
    print(f'\n✅ Results saved to: backups/cik_lookup_results.json')

if __name__ == "__main__":
    run_bulk_cik_lookup()
