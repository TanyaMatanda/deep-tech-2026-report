# Data Collection Strategy & Scraping Cadence
## Deep Tech Governance Database - Operational Implementation

---

## I. Data Collection Cadence by Source

### **Daily Collection (Tier 1: Public Companies)**

**Target:** 500 public deep tech companies  
**Time Investment:** 30 minutes/day (automated)  
**Run Time:** 6:00 AM EST (after overnight SEC filings posted)

```bash
# Cron job: Daily at 6 AM
0 6 * * * /usr/bin/python3 /path/to/daily_sec_scraper.py >> /var/log/deep_tech_scraper.log 2>&1
```

**Data Sources & Fields:**

| **Field** | **Source** | **Where to Find** | **Parsing Method** |
|-----------|-----------|------------------|-------------------|
| **Proxy filings (DEF 14A)** | SEC EDGAR | `https://www.sec.gov/cgi-bin/browse-edgar` | RSS feed + API |
| **8-K current events** | SEC EDGAR | Same | API |
| **13D/13G ownership** | SEC EDGAR | Same | API |
| **Voting results** | 8-K Item 5.07 | Proxy voting results section | Regex parsing |

**Automated Script:**

```python
# daily_sec_scraper.py

import requests
from datetime import datetime, timedelta
from supabase import create_client
import re

SUPABASE_URL = "https://your-project.supabase.co"
SUPABASE_KEY = "your-anon-key"
supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

class DailySECScraper:
    """
    Daily scraper for public companies (Tier 1)
    """
    
    SEC_BASE = "https://www.sec.gov"
    HEADERS = {
        'User-Agent': 'YourName your.email@example.com',
        'Accept-Encoding': 'gzip, deflate'
    }
    
    def __init__(self):
        self.watch_list = self.get_tier1_companies()
    
    def get_tier1_companies(self):
        """
        Get list of Tier 1 companies (public) from Supabase
        """
        response = supabase.table('companies').select('id, cik, company_name').eq('data_tier', 1).execute()
        return response.data
    
    def check_daily_filings(self):
        """
        Download today's daily index and check for our companies
        """
        today = datetime.now()
        quarter = f"QTR{(today.month - 1) // 3 + 1}"
        
        url = f"{self.SEC_BASE}/Archives/edgar/daily-index/{today.year}/{quarter}/master.{today.strftime('%Y%m%d')}.idx"
        
        response = requests.get(url, headers=self.HEADERS)
        
        if response.status_code == 200:
            return self.parse_daily_index(response.text)
        return []
    
    def parse_daily_index(self, index_text):
        """
        Parse the SEC daily index file
        """
        filings = []
        lines = index_text.split('\n')[11:]  # Skip header
        
        for line in lines:
            if '|' in line:
                parts = line.split('|')
                if len(parts) >= 5:
                    cik, company, form_type, date_filed, filename = parts[:5]
                    
                    # Check if this company is in our watch list
                    if cik.strip() in [c['cik'] for c in self.watch_list]:
                        if form_type.strip() in ['DEF 14A', '8-K', '13D', '13F', '10-K', '10-Q']:
                            filings.append({
                                'cik': cik.strip(),
                                'company': company.strip(),
                                'form_type': form_type.strip(),
                                'filing_url': f"{self.SEC_BASE}/Archives/{filename.strip()}"
                            })
        
        return filings
    
    def download_and_parse_filing(self, filing):
        """
        Download filing and extract relevant data
        """
        response = requests.get(filing['filing_url'], headers=self.HEADERS)
        
        if filing['form_type'] == 'DEF 14A':
            return self.parse_proxy_statement(response.text, filing['cik'])
        elif filing['form_type'] == '10-K':
            return self.parse_10k(response.text, filing['cik'])
        # ... additional parsers
    
    def parse_proxy_statement(self, filing_text, cik):
        """
        Extract governance data from DEF 14A
        Data to extract:
        - Board composition
        - Executive compensation
        - Shareholder proposals
        - Say-on-pay results
        """
        governance_data = {}
        
        # Extract board size
        board_size_match = re.search(r'(\d+)\s+directors?', filing_text, re.IGNORECASE)
        if board_size_match:
            governance_data['board_size'] = int(board_size_match.group(1))
        
        # Extract independent director count
        indep_match = re.search(r'(\d+)\s+.*independent\s+directors?', filing_text, re.IGNORECASE)
        if indep_match:
            governance_data['independent_directors'] = int(indep_match.group(1))
        
        # Extract say-on-pay vote results (from previous year's results in this proxy)
        say_on_pay_match = re.search(r'say[- ]on[- ]pay.*?(\d+\.?\d*)\s*%', filing_text, re.IGNORECASE)
        if say_on_pay_match:
            governance_data['say_on_pay_pct'] = float(say_on_pay_match.group(1))
        
        # Check for AI governance mentions (new for RiskAnchor)
        ai_keywords = ['artificial intelligence', 'AI governance', 'AI oversight', 'machine learning governance']
        governance_data['ai_governance_mentioned'] = any(keyword.lower() in filing_text.lower() for keyword in ai_keywords)
        
        return governance_data
    
    def parse_10k(self, filing_text, cik):
        """
        Extract operational data from 10-K
        Data to extract:
        - Lines of business (Item 1 - Business)
        - Revenue segmentation (Item 8 - Financial Statements)
        - Jurisdictions of operation
        - Regulatory compliance
        """
        operational_data = {}
        
        # Extract Item 1 - Business Description
        item1_match = re.search(
            r'ITEM\s+1\.?\s+BUSINESS(.*?)ITEM\s+1[AB]',
            filing_text,
            re.DOTALL | re.IGNORECASE
        )
        
        if item1_match:
            business_section = item1_match.group(1)
            
            # Extract jurisdictions
            jurisdiction_patterns = [
                r'operate[sd]?\s+in\s+([\w\s,]+)',
                r'presence\s+in\s+([\w\s,]+)',
                r'operations\s+in\s+([\w\s,]+)'
            ]
            
            for pattern in jurisdiction_patterns:
                match = re.search(pattern, business_section, re.IGNORECASE)
                if match:
                    operational_data['operational_jurisdictions'] = match.group(1)
                    break
            
            # Extract regulatory bodies
            reg_matches = re.findall(
                r'(FDA|SEC|EPA|DOE|FCC|NIST|Health Canada|CNBV)',
                business_section,
                re.IGNORECASE
            )
            if reg_matches:
                operational_data['regulatory_bodies'] = list(set(reg_matches))
        
        # Extract revenue segments (Note: This often requires parsing HTML tables)
        # Revenue by segment usually in "Note X - Segment Information"
        segment_match = re.search(
            r'SEGMENT\s+INFORMATION(.*?)(?:Note \d+|ITEM)',
            filing_text,
            re.DOTALL | re.IGNORECASE
        )
        
        if segment_match:
            # This typically needs pandas.read_html() for table extraction
            operational_data['has_segment_data'] = True
        
        return operational_data
    
    def save_to_database(self, company_id, data_type, data):
        """
        Save parsed data to Supabase
        """
        if data_type == 'governance':
            supabase.table('board_composition_annual').upsert({
                'company_id': company_id,
                'fiscal_year': datetime.now().year,
                'total_directors': data.get('board_size'),
                'independent_directors': data.get('independent_directors'),
                'has_ai_oversight_committee': data.get('ai_governance_mentioned', False)
            }).execute()
        
        elif data_type == 'operational':
            supabase.table('companies').update({
                'operational_jurisdictions': data.get('operational_jurisdictions', []),
                'applicable_regulations': data.get('regulatory_bodies', [])
            }).eq('id', company_id).execute()
    
    def run(self):
        """
        Main execution: Check for new filings and process
        """
        print(f"[{datetime.now()}] Starting daily SEC scraper...")
        
        new_filings = self.check_daily_filings()
        print(f"Found {len(new_filings)} new filings from watch list companies")
        
        for filing in new_filings:
            print(f"Processing {filing['form_type']} for {filing['company']}")
            
            try:
                data = self.download_and_parse_filing(filing)
                
                # Get company_id from CIK
                company = supabase.table('companies').select('id').eq('cik', filing['cik']).execute()
                if company.data:
                    company_id = company.data[0]['id']
                    
                    if filing['form_type'] == 'DEF 14A':
                        self.save_to_database(company_id, 'governance', data)
                    elif filing['form_type'] == '10-K':
                        self.save_to_database(company_id, 'operational', data)
            
            except Exception as e:
                print(f"Error processing {filing['company']}: {e}")
        
        # Log scraping job
        supabase.table('scraping_jobs').insert({
            'job_type': 'sec_edgar_daily',
            'records_processed': len(new_filings),
            'status': 'Completed'
        }).execute()
        
        print(f"[{datetime.now()}] Daily scraper complete.")

if __name__ == "__main__":
    scraper = DailySECScraper()
    scraper.run()
```

---

### **Weekly Collection (Tier 2: Late-Stage Private)**

**Target:** 5,000 late-stage private companies  
**Time Investment:** 2-3 hours/week (semi-automated)  
**Run Time:** Sunday 8:00 AM EST

```bash
# Cron job: Weekly on Sunday
0 8 * * 0 /usr/bin/python3 /path/to/weekly_enrichment.py
```

**Data Sources & Fields:**

| **Field** | **Source** | **Where to Find** | **Method** |
|-----------|-----------|------------------|-----------|
| **Incorporation date** | Company website "About" page | Footer, Press releases | Scraping |
| **Incorporation jurisdiction** | Delaware Division of Corporations (free search) | https://icis.corp.delaware.gov | API/scraping |
| **Lines of business** | Company website, Press releases | Products/Services page | NLP classification |
| **Funding rounds** | Crunchbase free tier (200/day limit) | Company profile | API |
| **Leadership** | LinkedIn company pages | "People" tab | Scraping |

**Automated Script:**

```python
# weekly_enrichment.py

from selenium import webdriver
from selenium.webdriver.common.by import By
import time

class WeeklyEnrichment:
    """
    Weekly enrichment for Tier 2 companies
    Focus: Operational data not in SEC filings
    """
    
    def __init__(self):
        self.driver = webdriver.Chrome()  # Or use headless mode
    
    def get_incorporation_data_delaware(self, company_name):
        """
        Scrape Delaware Division of Corporations
        HIGHLY useful: ~60% of deep tech companies incorporate in Delaware
        """
        url = "https://icis.corp.delaware.gov/Ecorp/EntitySearch/NameSearch.aspx"
        
        self.driver.get(url)
        
        # Find search box and enter company name
        search_box = self.driver.find_element(By.ID, "ctl00_ContentPlaceHolder1_frmEntityName")
        search_box.send_keys(company_name)
        
        # Submit search
        search_button = self.driver.find_element(By.ID, "ctl00_ContentPlaceHolder1_btnSubmit")
        search_button.click()
        
        time.sleep(2)
        
        # Parse results
        try:
            # Look for incorporation date in results table
            date_element = self.driver.find_element(By.XPATH, "//td[contains(text(), 'Incorporation Date')]/following-sibling::td")
            incorporation_date = date_element.text
            
            # Get file number (for tracking)
            file_number = self.driver.find_element(By.XPATH, "//td[contains(text(), 'File Number')]/following-sibling::td").text
            
            return {
                'incorporation_date': incorporation_date,
                'incorporation_jurisdiction': 'Delaware',
                'delaware_file_number': file_number
            }
        except:
            return None
    
    def scrape_company_website(self, url):
        """
        Scrape company website for operational data
        """
        self.driver.get(url)
        time.sleep(3)
        
        data = {}
        
        # Look for "About" or "Company" page
        try:
            about_link = self.driver.find_element(By.LINK_TEXT, "About")
            about_link.click()
            time.sleep(2)
            
            page_text = self.driver.find_element(By.TAG_NAME, "body").text
            
            # Extract incorporation year (common pattern: "Founded in 2018")
            import re
            founded_match = re.search(r'founded\s+in\s+(\d{4})', page_text, re.IGNORECASE)
            if founded_match:
                data['incorporation_year'] = int(founded_match.group(1))
            
            # Extract lines of business (look for product/service descriptions)
            if "quantum" in page_text.lower():
                data['lines_of_business'] = ['Quantum Computing']
            if "drug discovery" in page_text.lower():
                if 'lines_of_business' in data:
                    data['lines_of_business'].append('Drug Discovery')
                else:
                    data['lines_of_business'] = ['Drug Discovery']
        
        except:
            pass
        
        return data
    
    def run_weekly_batch(self):
        """
        Process 200 companies per week (limit due to rate limits)
        """
        # Get 200 Tier 2 companies needing enrichment
        companies = supabase.table('companies') \\
            .select('id, company_name, website_url') \\
            .eq('data_tier', 2) \\
            .is_('incorporation_date', None) \\
            .limit(200) \\
            .execute()
        
        for company in companies.data:
            print(f"Enriching: {company['company_name']}")
            
            # 1. Check Delaware incorporation
            de_data = self.get_incorporation_data_delaware(company['company_name'])
            
            # 2. Scrape company website
            if company['website_url']:
                website_data = self.scrape_company_website(company['website_url'])
            
            # 3. Update database
            update_data = {**de_data, **website_data} if de_data and website_data else {}
            if update_data:
                supabase.table('companies').update(update_data).eq('id', company['id']).execute()
        
        self.driver.quit()

if __name__ == "__main__":
    enricher = WeeklyEnrichment()
    enricher.run_weekly_batch()
```

---

### **Monthly Collection (Tier 3 & 4: Early-Stage + Stealth)**

**Target:** 70,000 companies (40K early-stage + 30K stealth)  
**Time Investment:** 10 hours/month (batch processing)  
**Run Time:** 1st of each month

```bash
# Cron job: Monthly on 1st day
0 0 1 * * /usr/bin/python3 /path/to/monthly_bulk_import.py
```

**Data Sources:**

| **Data Type** | **Source** | **API/Tool** | **Coverage** |
|--------------|-----------|-------------|-------------|
| **Company lists** | Government grants (SBIR/STTR) | https://www.sbir.gov | ~50,000 awards/year |
| **University spinouts** | University tech transfer offices | Web scraping (MIT, Stanford, etc.) | ~500/year |
| **Patent-based discovery** | Google Patents BigQuery | SQL queries | Unlimited |
| **Basic company info** | OpenVC, AngelList | Free API | ~20,000 startups |

**Patent-Based Company Discovery:**

```sql
-- Google Patents BigQuery Query
-- Find NEW quantum computing companies (filed patents in last 12 months)

SELECT DISTINCT
    assignee_harmonized AS company_name,
    COUNT(*) AS patent_count,
    MIN(filing_date) AS first_patent,
    MAX(filing_date) AS latest_patent
FROM `patents-public-data.patents.publications`
WHERE 
    filing_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 12 MONTH)
    AND country_code IN ('US', 'CA')
    AND (
        LOWER(title_localized) LIKE '%quantum%'
        OR LOWER(title_localized) LIKE '%qubit%'
        OR LOWER(abstract_localized) LIKE '%quantum computing%'
    )
    AND assignee_harmonized IS NOT NULL
GROUP BY assignee_harmonized
HAVING patent_count >= 3
ORDER BY latest_patent DESC;
```

---

## II. Data Collection Priority Matrix

| **Tier** | **Companies** | **Update Frequency** | **Data Richness** | **Time/Week** |
|----------|--------------|---------------------|------------------|---------------|
| **Tier 1 (Public)** | 500 | Daily | 95% complete | 30 min (automated) |
| **Tier 2 (Late-Stage)** | 5,000 | Weekly | 70% complete | 2-3 hours (semi-auto) |
| **Tier 3 (Early-Stage)** | 40,000 | Monthly | 50% complete | 8 hours (batch) |
| **Tier 4 (Stealth)** | 30,000 | Quarterly | 25% complete | 2 hours (passive) |

---

## III. Where to Find Each Data Field

### **Incorporation Data**

| **Field** | **USA** | **Canada** | **Mexico** |
|-----------|---------|-----------|-----------|
| **Incorporation date** | Delaware Div. of Corps (free) | Federal Corporations Database (free) | Registro Público de Comercio |
| **Incorporation month/year** | Same | Same | Same |
| **Jurisdiction** | Certificate of Incorporation (in 10-K Exhibit 3.1) | Articles of Incorporation | Acta Constitutiva |

**Free Tools:**
- Delaware: https://icis.corp.delaware.gov (no API, scrape)
- Canada: https://www.ic.gc.ca/app/scr/cc/Corporations (no API, scrape)  
- California: https://businesssearch.sos.ca.gov (API available)

### **Operational Jurisdictions**

**Source:** 10-K Item 1 (Business) + Item 2 (Properties)

**Example parsing:**
```python
# From IonQ 10-K:
"We have operations in College Park, Maryland (headquarters), 
Seattle, Washington, and a liaison office in Basel, Switzerland."

# Extract:
operational_jurisdictions = ['Maryland', 'Washington', 'Switzerland']
```

### **Governing Laws & Regulations**

**Source:** 10-K Item 1 (Business) + Item 1A (Risk Factors)

**Common patterns to extract:**

```python
regulatory_patterns = {
    'FDA': r'FDA|Food and Drug Administration|21 CFR',
    'SEC': r'SEC|Securities and Exchange Commission|Regulation S-K',
    'NIST': r'NIST|National Institute of Standards',
    'ITAR': r'ITAR|International Traffic in Arms',
    'EU AI Act': r'EU AI Act|Artificial Intelligence Act',
    'GDPR': r'GDPR|General Data Protection Regulation'
}

for reg, pattern in regulatory_patterns.items():
    if re.search(pattern, filing_text, re.IGNORECASE):
        applicable_regulations.append(reg)
```

### **Lines of Business & Revenue Segmentation**

**Source:** 10-K Item 8 (Financial Statements) → "Note X: Segment Information"

**Example from typical deep tech 10-K:**

```
Revenue by Segment:
  Hardware Systems:     $45M (60%)
  Software Licenses:    $20M (27%)
  Professional Services: $10M (13%)
  Total:                $75M
```

**Extract to database:**

| **business_line_name** | **revenue_usd** | **revenue_percentage** | **department_ownership** |
|-----------------------|----------------|---------------------|------------------------|
| Hardware Systems | 45,000,000 | 60.00 | R&D / Manufacturing |
| Software Licenses | 20,000,000 | 26.67 | Engineering |
| Professional Services | 10,000,000 | 13.33 | Customer Success |

**Department Attribution Logic:**
- Hardware → R&D/Manufacturing
- Software → Engineering
- Services → Sales/Customer Success
- Licensing → Legal/IP

---

## IV. Complete Implementation Timeline

### **Week 1: Foundation**
- [ ] Set up Supabase project
- [ ] Run `database_schema.sql` to create tables
- [ ] Manually input first 50 companies (Tier 1 quantum + AI leaders)
- [ ] Test SEC EDGAR API with 5 sample filings

### **Week 2-3: Automation**
- [ ] Deploy `daily_sec_scraper.py` on cloud instance (AWS EC2 free tier or Render.com)
- [ ] Set up cron jobs
- [ ] Test weekly enrichment script
- [ ] Build incorporation data scraper (Delaware focus)

### **Week 4: Validation**
- [ ] Manually verify 20 company profiles (data quality check)
- [ ] Calculate first governance scores
- [ ] Generate test RiskAnchor vendor report (top 10 AI companies)

### **Month 2: Scale**
- [ ] Reach 500 Tier 1 companies
- [ ] Reach 1,000 Tier 2 companies
- [ ] Patent-based discovery: Add 5,000 more companies from Google Patents

### **Month 3: Production**
- [ ] Full 75,000 company database
- [ ] API endpoints live
- [ ] First RiskAnchor integration test

---

## Next Immediate Actions

I've created:
1. ✅ Complete database schema (`database_schema.sql`)
2. ✅ Daily SEC scraper (Python code above)
3. ✅ Weekly enrichment strategy
4. ✅ Data field source mapping

**Would you like me to:**
1. Set up a Supabase project (I can guide you through the web UI)
2. Deploy the scraping scripts to a free cloud service (Render.com / Railway)
3. Create the first 50 company profiles manually (I can start with quantum firms)
4. Build the RiskAnchor API integration sample code

Which should we tackle next?
