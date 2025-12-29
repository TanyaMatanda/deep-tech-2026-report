#!/usr/bin/env python3
"""
SEC EDGAR Company Collector
Collects 500+ public deep tech companies with full governance data
Estimated runtime: 6-8 hours
"""

import requests
import json
import time
from datetime import datetime, timedelta
import pandas as pd
import re
from bs4 import BeautifulSoup
import os
from supabase import create_client, Client, ClientOptions
import toml

class SECEdgarCollector:
    """
    Collects public company data from SEC EDGAR
    Rate limit: 10 requests per second (SEC requirement)
    """
    
    BASE_URL = "https://www.sec.gov"
    HEADERS = {
        'User-Agent': 'Tanya Matanda tanyamatanda@riskanchor.com',  # REQUIRED by SEC (use your real email)
        'Accept-Encoding': 'gzip, deflate'
    }
    
    # Deep Tech 10 Taxonomy
    SECTOR_KEYWORDS = {
        'Advanced Computing and AI': ['artificial intelligence', 'machine learning', 'neural network', 'deep learning', 'computer vision', 'nlp', 'generative ai', 'cloud computing', 'big data', 'data analytics'],
        'Semi Conductors and AI': ['semiconductor', 'chip', 'processor', 'gpu', 'integrated circuit', 'wafer', 'fabless', 'foundry', 'microchip', 'transistor'],
        'Autonomous Systems': ['autonomous', 'self-driving', 'lidar', 'robotics', 'drone', 'uav', 'unmanned', 'automation', 'robot'],
        'Energy and Climate': ['renewable', 'solar', 'wind', 'battery', 'hydrogen', 'energy storage', 'clean tech', 'carbon capture', 'electric vehicle', 'ev', 'grid'],
        'Biotechnology': ['biotechnology', 'biotech', 'genomics', 'gene editing', 'crispr', 'therapeutics', 'pharmaceutical', 'drug discovery', 'clinical stage', 'bioscience'],
        'Advanced Materials': ['advanced materials', 'nanotechnology', 'graphene', 'composite', 'alloy', 'polymer', 'biomaterial', 'superconductor'],
        'Quantum and Photonics': ['quantum', 'photonics', 'laser', 'optic', 'qubit', 'superposition', 'entanglement', 'light-based'],
        'Space and Aerospace': ['space', 'satellite', 'rocket', 'aerospace', 'launch vehicle', 'orbit', 'propulsion', 'aviation'],
        'Cybersecurity Cryptography': ['cybersecurity', 'encryption', 'cryptography', 'network security', 'info sec', 'data protection', 'firewall', 'zero trust'],
        'Cross Domain Enablement': ['technology', 'software', 'platform', 'digital', 'systems', 'solutions', 'internet', 'communications', 'network', 'mobile']
    }
    
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update(self.HEADERS)
        self.companies = []
        
        # Initialize Supabase
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
                
        if url and key:
            options = ClientOptions(schema='vendor_governance')
            self.supabase: Client = create_client(url, key, options=options)
        else:
            print("⚠️ Supabase credentials not found. SQL generation only.")
            self.supabase = None
    
    def get_company_tickers(self):
        """
        Get all public company tickers from SEC
        Returns: List of companies with CIK, ticker, name
        """
        print("📥 Downloading company tickers from SEC...")
        
        url = "https://www.sec.gov/files/company_tickers.json"
        response = self.session.get(url)
        
        if response.status_code == 200:
            data = response.json()
            companies = []
            
            for idx, company in data.items():
                companies.append({
                    'cik': str(company['cik_str']).zfill(10),
                    'ticker': company['ticker'],
                    'name': company['title']
                })
            
            print(f"✅ Found {len(companies):,} total public companies")
            return companies
        else:
            print(f"❌ Failed to download tickers: {response.status_code}")
            return []
    
    def classify_company(self, name):
        """
        Classify company into one of the Deep Tech 10 sectors based on name
        Returns: Sector name or None
        """
        name_lower = name.lower()
        
        # Check specific sectors first (priority over Cross Domain)
        for sector, keywords in self.SECTOR_KEYWORDS.items():
            if sector == 'Cross Domain Enablement': continue
            if any(k in name_lower for k in keywords):
                return sector
                
        # Check Cross Domain last
        if any(k in name_lower for k in self.SECTOR_KEYWORDS['Cross Domain Enablement']):
            return 'Cross Domain Enablement'
            
        return None

    def filter_deep_tech_companies(self, companies):
        """
        Classify ALL companies (not just deep tech) and assign sector
        """
        print("🔍 Classifying all companies into sectors...")
        
        classified = []
        for company in companies:
            sector = self.classify_company(company['name'])
            
            # Assign sector (either deep tech or General Market)
            if sector:
                company['sector'] = sector
            else:
                company['sector'] = 'General Market'
            
            classified.append(company)
            
        deep_tech_count = sum(1 for c in classified if c['sector'] != 'General Market')
        print(f"✅ Classified {len(classified)} total companies")
        print(f"  - Deep Tech: {deep_tech_count}")
        print(f"  - General Market: {len(classified) - deep_tech_count}")
        return classified
    
    def get_company_filings(self, cik, filing_types=['DEF 14A', '10-K', '20-F', '40-F'], years_back=3):
        """
        Get recent filings for a company
        
        Args:
            cik: Company CIK number
            filing_types: List of filing types to retrieve
            years_back: How many years of historical filings (default: 3)
                       - 3 years: Trend analysis (recommended)
                       - 5 years: Extended historical view
                       - 10 years: Full historical archive
        """
        # Rate limiting: SEC allows 10 requests/second
        time.sleep(0.11)  # 110ms between requests
        
        url = f"{self.BASE_URL}/cgi-bin/browse-edgar"
        params = {
            'action': 'getcompany',
            'CIK': cik,
            'type': '',
            'dateb': '',
            'owner': 'exclude',
            'count': 100,
            'output': 'atom'
        }
        
        try:
            response = self.session.get(url, params=params)
            if response.status_code == 200:
                # Parse ATOM feed
                soup = BeautifulSoup(response.content, 'xml')
                entries = soup.find_all('entry')
                
                filings = []
                cutoff_date = datetime.now() - timedelta(days=years_back*365)
                
                for entry in entries:
                    filing_type = entry.find('filing-type').text if entry.find('filing-type') else ''
                    filing_date_str = entry.find('filing-date').text if entry.find('filing-date') else ''
                    
                    if filing_type in filing_types and filing_date_str:
                        filing_date = datetime.strptime(filing_date_str, '%Y-%m-%d')
                        
                        if filing_date >= cutoff_date:
                            accession = entry.find('accession-number').text if entry.find('accession-number') else ''
                            filing_url = entry.find('filing-href').text if entry.find('filing-href') else ''
                            
                            filings.append({
                                'filing_type': filing_type,
                                'filing_date': filing_date_str,
                                'accession_number': accession,
                                'filing_url': filing_url
                            })
                
                return filings
            else:
                return []
        except Exception as e:
            print(f"⚠️  Error fetching filings for CIK {cik}: {e}")
            return []
    
    def collect_all(self, max_companies=500):
        """
        Main collection method
        """
        print("=" * 60)
        print("SEC EDGAR DEEP TECH COMPANY COLLECTOR")
        print("=" * 60)
        print()
        
        # Get all companies
        all_companies = self.get_company_tickers()
        
        # Filter for deep tech
        deep_tech_companies = self.filter_deep_tech_companies(all_companies)
        
        # Limit to max_companies
        companies_to_process = deep_tech_companies[:max_companies]
        
        print(f"\n📊 Processing {len(companies_to_process)} companies...")
        print(f"⏱️  Estimated time: {len(companies_to_process) * 0.5 / 60:.1f} minutes\n")
        
        results = []
        for i, company in enumerate(companies_to_process, 1):
            if i % 50 == 0:
                print(f"Progress: {i}/{len(companies_to_process)} ({i/len(companies_to_process)*100:.1f}%)")
            
            # Get filings
            filings = self.get_company_filings(company['cik'])
            
            company_data = {
                **company,
                'proxy_filings': [f for f in filings if f['filing_type'] == 'DEF 14A'],
                '10k_filings': [f for f in filings if f['filing_type'] == '10-K']
            }
            
            results.append(company_data)
        
        print(f"\n✅ Collection complete! {len(results)} companies processed\n")
        return results
    
    def save_to_supabase(self, companies):
        if not self.supabase:
            return
            
        print(f"💾 Saving {len(companies)} companies to Supabase...")
        
        for company in companies:
            # Insert Company
            data = {
                "company_name": company['name'],
                "ticker_symbol": company['ticker'],
                "cik": company['cik'],
                "listing_type": "Public",
                "data_tier": 1,
                "incorporation_country": "USA",
                "primary_sector": company.get('sector', 'Unclassified'),
                "technology_tags": [company.get('sector', 'Unclassified'), 'public company']
            }
            
            try:
                # Upsert company
                res = self.supabase.table("companies").upsert(data, on_conflict="company_name, incorporation_jurisdiction").execute()
                if res.data:
                    company_id = res.data[0]['id']
                    
                    # Insert Filings
                    for filing in company.get('proxy_filings', [])[:3]:
                        f_data = {
                            "company_id": company_id,
                            "accession_number": filing['accession_number'],
                            "filing_type": filing['filing_type'],
                            "filing_date": filing['filing_date'],
                            "filing_url": filing['filing_url'],
                            "processing_status": "pending"
                        }
                        self.supabase.table("sec_filings").upsert(f_data, on_conflict="accession_number").execute()
            except Exception as e:
                print(f"Error saving {company['ticker']}: {e}")
                
        print("✅ Saved to Supabase")

    def generate_sql(self, companies, output_file='sec_companies_insert.sql'):
        """Generate SQL INSERT statements"""
        print(f"📝 Generating SQL...")
        
        with open(output_file, 'w') as f:
            f.write("-- SEC EDGAR Public Companies\n")
            f.write(f"-- Total: {len(companies)}\n")
            f.write(f"-- Generated: {datetime.now()}\n\n")
            f.write("SET search_path TO vendor_governance, public;\n\n")
            
            for company in companies:
                name = company['name'].replace("'", "''")
                ticker = company['ticker']
                cik = company['cik']
                
                f.write(f"-- {ticker}: {name}\n")
                f.write("INSERT INTO companies (\n")
                f.write("    company_name, ticker_symbol, cik, listing_type, data_tier\n")
                f.write(f") VALUES (\n")
                f.write(f"    '{name}', '{ticker}', '{cik}', 'Public', 1\n")
                f.write(") ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;\n\n")
                
                # Insert filings
                for filing in company.get('proxy_filings', [])[:3]:  # Last 3 years
                    acc = filing['accession_number'].replace("'", "''")
                    f.write("INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)\n")
                    f.write(f"SELECT id, '{acc}', '{filing['filing_type']}', '{filing['filing_date']}', '{filing['filing_url']}', 'pending'\n")
                    f.write(f"FROM companies WHERE ticker_symbol = '{ticker}'\n")
                    f.write("ON CONFLICT (accession_number) DO NOTHING;\n\n")
        
        print(f"✅ SQL generated: {output_file}")

def main():
    collector = SECEdgarCollector()
    # Limit to 2500 for full ingestion
    companies = collector.collect_all(max_companies=2500)
    
    # Save results
    df = pd.DataFrame(companies)
    df.to_csv('sec_deep_tech_companies.csv', index=False)
    print(f"💾 Saved to sec_deep_tech_companies.csv")
    
    # Save to Supabase
    collector.save_to_supabase(companies)
    
    # Generate SQL
    collector.generate_sql(companies)

if __name__ == "__main__":
    main()
