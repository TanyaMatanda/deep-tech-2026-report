#!/usr/bin/env python3
"""
SBIR/STTR Grant Database Collector
Collects 20,000+ companies that received federal R&D grants
Estimated runtime: 1-2 hours
"""

import requests
import pandas as pd
from datetime import datetime
import json

class SBIRGrantCollector:
    """
    Collects companies from SBIR.gov awards database
    Public data - no API key required
    """
    
    BASE_URL = "https://www.sbir.gov/api/awards.json"
    
    DEEP_TECH_KEYWORDS = [
        'quantum', 'artificial intelligence', 'AI', 'machine learning',
        'biotechnology', 'gene therapy', 'CRISPR', 'genomics',
        'nanotechnology', 'materials science',
        'cybersecurity', 'cryptography',
        'renewable energy', 'solar', 'battery', 'fuel cell',
        'space technology', 'satellite', 'propulsion',
        'robotics', 'autonomous systems', 'drone'
    ]
    
    def fetch_awards(self, year_start=2018, year_end=2024):
        """
        Fetch SBIR/STTR awards from federal database
        """
        print(f"📥 Fetching SBIR/STTR grants ({year_start}-{year_end})...")
        
        all_awards = []
        
        for year in range(year_start, year_end + 1):
            print(f"  📅 Collecting {year} awards...")
            
            params = {
                'year': year,
                'rows': 10000  # Max per request
            }
            
            try:
                response = requests.get(self.BASE_URL, params=params, timeout=30)
                
                if response.status_code == 200:
                    data = response.json()
                    awards = data.get('response', {}).get('docs', [])
                    all_awards.extend(awards)
                    print(f"    ✅ Found {len(awards):,} awards")
                else:
                    print(f"    ⚠️  Failed: {response.status_code}")
            
            except Exception as e:
                print(f"    ❌ Error: {e}")
        
        print(f"\n✅ Total awards collected: {len(all_awards):,}\n")
        return all_awards
    
    def filter_deep_tech(self, awards):
        """
        Filter for deep tech companies based on project description
        """
        print("🔍 Filtering for deep tech projects...")
        
        deep_tech_awards = []
        
        for award in awards:
            abstract = award.get('abstract', '').lower()
            title = award.get('title', '').lower()
            
            # Check if project is deep tech
            if any(keyword in abstract or keyword in title for keyword in self.DEEP_TECH_KEYWORDS):
                deep_tech_awards.append(award)
        
        print(f"✅ Found {len(deep_tech_awards):,} deep tech projects\n")
        return deep_tech_awards
    
    def extract_companies(self, awards):
        """
        Extract unique companies from awards
        """
        print("🏢 Extracting companies...")
        
        companies = {}
        
        for award in awards:
            company_name = award.get('company', '')
            
            if not company_name or company_name == '':
                continue
            
            # Group awards by company
            if company_name not in companies:
                companies[company_name] = {
                    'company_name': company_name,
                    'city': award.get('firmCity', ''),
                    'state': award.get('firmState', ''),
                    'zipcode': award.get('firmZipcode', ''),
                    'total_awards': 0,
                    'total_funding_usd': 0,
                    'first_award_year': award.get('year', 0),
                    'latest_award_year': award.get('year', 0),
                    'award_topics': set(),
                    'agencies': set()
                }
            
            # Update company data
            companies[company_name]['total_awards'] += 1
            companies[company_name]['total_funding_usd'] += float(award.get('amount', 0))
            companies[company_name]['first_award_year'] = min(
                companies[company_name]['first_award_year'], 
                award.get('year', 9999)
            )
            companies[company_name]['latest_award_year'] = max(
                companies[company_name]['latest_award_year'], 
                award.get('year', 0)
            )
            
            # Collect topics
            if 'researchTopic' in award:
                companies[company_name]['award_topics'].add(award['researchTopic'])
            
            # Collect funding agencies
            if 'agency' in award:
                companies[company_name]['agencies'].add(award['agency'])
        
        # Convert sets to lists for export
        for company in companies.values():
            company['award_topics'] = list(company['award_topics'])
            company['agencies'] = list(company['agencies'])
        
        print(f"✅ Extracted {len(companies):,} unique companies\n")
        return list(companies.values())
    
    def classify_sector(self, company):
        """
        Classify company sector based on awarded topics
        """
        topics_str = ' '.join(company.get('award_topics', [])).lower()
        
        if 'quantum' in topics_str:
            return 'Quantum Computing'
        elif any(kw in topics_str for kw in ['artificial intelligence', 'machine learning', 'AI']):
            return 'AI & Machine Learning'
        elif any(kw in topics_str for kw in ['bio', 'gene', 'genomic', 'pharma', 'medical']):
            return 'Biotechnology'
        elif 'cyber' in topics_str or 'security' in topics_str:
            return 'Cybersecurity'
        elif any(kw in topics_str for kw in ['energy', 'solar', 'battery', 'renewable']):
            return 'Energy & Climate'
        elif 'space' in topics_str or 'satellite' in topics_str:
            return 'Space Technology'
        elif 'robot' in topics_str or 'autonomous' in topics_str:
            return 'Robotics'
        else:
            return 'Advanced Technology'
    
    def generate_sql(self, companies, output_file='sbir_companies_insert.sql'):
        """Generate SQL INSERT statements"""
        print(f"📝 Generating SQL...")
        
        with open(output_file, 'w') as f:
            f.write("-- SBIR/STTR Grant Recipients\n")
            f.write(f"-- Total companies: {len(companies):,}\n")
            f.write(f"-- Generated: {datetime.now()}\n\n")
            f.write("SET search_path TO vendor_governance, public;\n\n")
            
            for company in companies:
                name = company['company_name'].replace("'", "''")
                city = company.get('city', '').replace("'", "''")
                state = company.get('state', '')
                sector = self.classify_sector(company)
                
                # Infer incorporation year from first award
                incorp_year = company.get('first_award_year', 2000) - 2  # Assume founded 2 years before first grant
                
                # Technology tags from topics
                topics = company.get('award_topics', [])
                if topics:
                    # Clean topic strings and format as SQL array
                    clean_topics = [t.replace("'", "''") for t in topics[:5]]
                    tags_list = "', '".join(clean_topics)
                    tags_str = f"ARRAY['{tags_list}']"
                else:
                    tags_str = "ARRAY[]::TEXT[]"
                
                f.write(f"-- {name}\n")
                f.write("INSERT INTO companies (\n")
                f.write("    company_name, incorporation_year, headquarters_city, headquarters_state_province,\n")
                f.write("    headquarters_country, primary_sector, technology_tags, listing_type, data_tier\n")
                f.write(f") VALUES (\n")
                f.write(f"    '{name}', {incorp_year}, '{city}', '{state}', 'USA',\n")
                f.write(f"    '{sector}', {tags_str}, 'Private', 3\n")
                f.write(") ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;\n\n")
        
        print(f"✅ SQL generated: {output_file}\n")
    
    def run(self):
        """Main execution"""
        print("=" * 60)
        print("SBIR/STTR GRANT DATABASE COLLECTOR")
        print("=" * 60)
        print()
        
        # Fetch awards
        awards = self.fetch_awards(year_start=2018, year_end=2024)
        
        # Filter for deep tech
        deep_tech_awards = self.filter_deep_tech(awards)
        
        # Extract companies
        companies = self.extract_companies(deep_tech_awards)
        
        # Save to CSV
        df = pd.DataFrame(companies)
        df.to_csv('sbir_deep_tech_companies.csv', index=False)
        print(f"💾 Saved to sbir_deep_tech_companies.csv\n")
        
        # Generate SQL
        self.generate_sql(companies)
        
        print("=" * 60)
        print("✅ COLLECTION COMPLETE!")
        print("=" * 60)
        print(f"📊 Total companies: {len(companies):,}")
        print(f"💰 Total funding tracked: ${sum(c['total_funding_usd'] for c in companies)/1e6:.1f}M")
        
        return companies

def main():
    collector = SBIRGrantCollector()
    collector.run()

if __name__ == "__main__":
    main()
