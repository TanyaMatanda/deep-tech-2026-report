#!/usr/bin/env python3
"""
SEC EDGAR Public Company Collector
Fetches real public companies by SIC code from SEC EDGAR.
"""

import requests
from bs4 import BeautifulSoup
import pandas as pd
import time
import os
from supabase import create_client, Client, ClientOptions
import toml

# Configuration
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
    print("❌ Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

class PublicCompanyCollector:
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'RiskAnchor contact@riskanchor.com (Research Project)'
        })
        
    def fetch_by_sic(self, sic_code, sector_name):
        print(f"🔎 Fetching companies for SIC {sic_code} ({sector_name})...")
        
        # Fetch 100 companies per SIC
        url = f"https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&SIC={sic_code}&owner=include&count=100&output=atom"
        
        try:
            response = self.session.get(url)
            if response.status_code != 200:
                print(f"  ❌ Failed to fetch SIC {sic_code}: {response.status_code}")
                return []
                
            soup = BeautifulSoup(response.content, 'xml')
            entries = soup.find_all('entry')
            
            companies = []
            for entry in entries:
                try:
                    # Try to get data from company-info block first
                    company_info = entry.find('company-info')
                    
                    if company_info:
                        name = company_info.find('name').text
                        cik = company_info.find('cik').text
                        # state = company_info.find('state').text if company_info.find('state') else 'USA'
                    else:
                        # Fallback to title and summary
                        name = entry.find('title').text
                        summary = entry.find('summary').text
                        # Summary format: "CIK: 0001234567, State: MA"
                        cik = summary.split('CIK:')[1].split(',')[0].strip()
                    
                    companies.append({
                        'name': name,
                        'cik': cik,
                        'sector': sector_name,
                        'sic': sic_code
                    })
                except Exception as e:
                    # print(f"    ⚠️ Error parsing entry: {e}")
                    continue
            
            # Deduplicate by CIK
            unique_companies = {c['cik']: c for c in companies}.values()
            print(f"  ✅ Found {len(unique_companies)} unique companies")
            return list(unique_companies)
            
        except Exception as e:
            print(f"  ❌ Error parsing SIC {sic_code}: {e}")
            return []

    def save_to_supabase(self, companies):
        print(f"💾 Saving {len(companies)} companies to Supabase...")
        
        for co in companies:
            try:
                # Upsert
                data = {
                    "company_name": co['name'],
                    "cik": co['cik'],
                    "primary_sector": co['sector'],
                    "listing_type": "Public",
                    "incorporation_country": "USA",
                    "data_tier": 1
                }
                
                # Check if exists by CIK
                existing = supabase.table("companies").select("id").eq("cik", co['cik']).execute()
                
                if existing.data:
                    supabase.table("companies").update(data).eq("id", existing.data[0]['id']).execute()
                else:
                    supabase.table("companies").insert(data).execute()
                    
            except Exception as e:
                # Ignore duplicates or errors
                pass
        
        print("✅ Save complete.")

    def run(self):
        # Deep Tech SIC Codes
        sic_codes = {
            '2834': 'Pharmaceutical Preparations',
            '2836': 'Biological Products',
            '3571': 'Electronic Computers',
            '3674': 'Semiconductors',
            '3760': 'Guided Missiles & Space Vehicles',
            '7372': 'Prepackaged Software'
        }
        
        all_companies = []
        
        for sic, sector in sic_codes.items():
            companies = self.fetch_by_sic(sic, sector)
            all_companies.extend(companies)
            time.sleep(0.2) # Rate limit niceness
            
        # Save
        self.save_to_supabase(all_companies)
        print(f"📊 Total Companies Processed: {len(all_companies)}")

if __name__ == "__main__":
    collector = PublicCompanyCollector()
    collector.run()

