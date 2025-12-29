"""
SEDAR+ Browser Automation Extractor
Uses Selenium to access public SEDAR+ records and extract compensation
"""

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import time
import re
from typing import Dict, List, Optional
from supabase import create_client, Client, ClientOptions
import toml
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Supabase setup
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options_db = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options_db)

class SEDARBrowserExtractor:
    """Automated SEDAR+ browser-based extraction"""
    
    SEDAR_SEARCH_URL = "https://www.sedarplus.ca/csa-party/service/create.html?targetAppCode=csa-party&service=searchDocuments&_locale=en"
    
    def __init__(self, headless: bool = True):
        """Initialize browser"""
        chrome_options = Options()
        if headless:
            chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument("--disable-gpu")
        chrome_options.add_argument("user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36")
        
        self.driver = webdriver.Chrome(
            service=Service(ChromeDriverManager().install()),
            options=chrome_options
        )
        self.wait = WebDriverWait(self.driver, 10)
        logger.info("✅ Browser initialized")
    
    def search_company(self, company_name: str) -> bool:
        """Search for company on SEDAR+"""
        try:
            logger.info(f"Searching for: {company_name}")
            
            # Navigate to search page
            self.driver.get(self.SEDAR_SEARCH_URL)
            time.sleep(5)  # Increased wait for page load
            
            # Save screenshot for debugging
            try:
                self.driver.save_screenshot("sedar_search_page.png")
                logger.info("  Screenshot saved: sedar_search_page.png")
            except:
                pass
            
            # Find and fill company name field using placeholder
            try:
                # Try waiting longer
                company_field = WebDriverWait(self.driver, 15).until(
                    EC.presence_of_element_located((By.CSS_SELECTOR, "input[placeholder='Profile name or number']"))
                )
                company_field.clear()
                company_field.send_keys(company_name)
                time.sleep(3)  # Wait for autocomplete
                
                # Click first autocomplete result
                try:
                    autocomplete_item = WebDriverWait(self.driver, 10).until(
                        EC.element_to_be_clickable((By.CSS_SELECTOR, "li.ui-menu-item"))
                    )
                    autocomplete_item.click()
                    logger.info(f"  ✓ Selected company from autocomplete")
                except Exception as e:
                    logger.warning(f"  No autocomplete results: {e}")
                    
            except Exception as e:
                logger.warning(f"Could not find company name field: {e}")
                # Print page source for debugging
                logger.info("Page title: " + self.driver.title)
                return False
            
            # Click search button
            try:
                search_button = WebDriverWait(self.driver, 10).until(
                    EC.element_to_be_clickable((By.CSS_SELECTOR, "button.appSearchButton"))
                )
                search_button.click()
                time.sleep(5)  # Wait for results
                logger.info("  ✓ Search executed")
            except Exception as e:
                logger.warning(f"Could not find search button: {e}")
                return False
            
            return True
            
        except Exception as e:
            logger.error(f"Search error: {e}")
            return False
    
    def download_circular(self) -> Optional[str]:
        """Download most recent Management Information Circular"""
        try:
            # Find document links in results using correct selector
            document_links = self.driver.find_elements(By.CSS_SELECTOR, "a.appDocumentView, a.appResourceLink")
            
            if not document_links:
                logger.warning("No documents found in search results")
                return None
            
            logger.info(f"  Found {len(document_links)} documents")
            
            # Look for Management Information Circular / Proxy Circular
            for link in document_links[:20]:  # Check first 20 documents (increased)
                link_text = link.text.lower()
                try:
                    parent_text = link.find_element(By.XPATH, "./ancestor::tr").text.lower()
                except:
                    parent_text = ""
                
                # Check if it's a management/proxy circular (broader search for Canadian filings)
                keywords = [
                    'management information circular',
                    'proxy circular',
                    'information circular',
                    'management proxy',
                    'annual meeting',  # Added
                    'circular',  # Simpler match
                    'mgt info circular'  # Abbreviated form
                ]
                
                is_circular = any(keyword in link_text or keyword in parent_text for keyword in keywords)
                
                if is_circular:
                    logger.info(f"  ✓ Found potential circular: {link.text[:50]}")
                    
                    # Click to open document
                    link.click()
                    time.sleep(3)
                    
                    # Switch to new window if opened
                    if len(self.driver.window_handles) > 1:
                        self.driver.switch_to.window(self.driver.window_handles[-1])
                        time.sleep(2)
                    
                    # Get HTML content
                    html = self.driver.page_source
                    
                    # Close extra window if opened
                    if len(self.driver.window_handles) > 1:
                        self.driver.close()
                        self.driver.switch_to.window(self.driver.window_handles[0])
                    
                    return html
            
            logger.warning(f"  No management circular found in {len(document_links)} documents")
            # Log first few document types for debugging
            for i, link in enumerate(document_links[:5]):
                logger.info(f"    Doc {i+1}: {link.text[:50]}")
            return None
            
        except Exception as e:
            logger.error(f"Download error: {e}")
            return None
    
    def extract_compensation(self, html: str) -> List[Dict]:
        """Extract compensation from circular HTML"""
        soup = BeautifulSoup(html, 'html.parser')
        results = []
        
        # Look for compensation table
        compensation_keywords = [
            'summary compensation',
            'executive compensation',
            'named executive officer',
            'rémunération',  # French
        ]
        
        for table in soup.find_all('table'):
            table_text = table.get_text().lower()
            
            if not any(kw in table_text for kw in compensation_keywords):
                continue
            
            logger.info("Found compensation table")
            
            rows = table.find_all('tr')
            for row in rows[1:]:  # Skip header
                cells = row.find_all(['td', 'th'])
                
                if len(cells) < 3:
                    continue
                
                name = cells[0].get_text(strip=True)
                
                # Check if looks like name
                if 2 <= len(name.split()) <= 4:
                    # Extract dollar values
                    values = []
                    for cell in cells:
                        text = cell.get_text()
                        nums = re.findall(r'[\d,]+', text)
                        for num in nums:
                            try:
                                val = int(num.replace(',', ''))
                                if val > 10000:
                                    values.append(val)
                            except:
                                pass
                    
                    if values:
                        total = max(values)
                        if total > 50000:  # Threshold
                            results.append({
                                'name': name,
                                'total_compensation': total
                            })
                            logger.info(f"  ✓ {name}: ${total:,}")
        
        return results
    
    def process_company(self, company_id: str, company_name: str) -> Dict:
        """Process single company"""
        logger.info(f"\n{'='*60}")
        logger.info(f"Processing: {company_name}")
        logger.info(f"{'='*60}")
        
        # Search
        if not self.search_company(company_name):
            return {'status': 'search_failed'}
        
        # Download circular
        html = self.download_circular()
        if not html:
            return {'status': 'no_circular'}
        
        # Extract compensation
        neos = self.extract_compensation(html)
        
        #Save to database
        saved = 0
        for neo in neos:
            try:
                # Get/create person
                person = supabase.table('people').select('id').eq('full_name', neo['name']).execute()
                
                if person.data:
                    pid = person.data[0]['id']
                else:
                    new = supabase.table('people').insert({'full_name': neo['name']}).execute()
                    pid = new.data[0]['id']
                
                # Save compensation
                supabase.table('executive_compensation_annual').upsert({
                    'company_id': company_id,
                    'person_id': pid,
                    'fiscal_year': 2024,
                    'total_compensation': neo['total_compensation'],
                    'source': 'SEDAR'
                }, on_conflict='company_id,person_id,fiscal_year').execute()
                
                saved += 1
                logger.info(f"  ✅ Saved {neo['name']}")
                
            except Exception as e:
                logger.error(f"  ❌ Save error: {e}")
        
        return {'neos': neos, 'saved': saved}
    
    def close(self):
        """Close browser"""
        self.driver.quit()
        logger.info("Browser closed")

def run_sedar_extraction(limit: int = 10, headless: bool = False):
    """Run SEDAR browser extraction"""
    
    logger.info(f"🇨🇦 Starting SEDAR Browser Extraction (Limit: {limit})")
    logger.info(f"Headless mode: {headless}\n")
    
    extractor = None
    
    try:
        extractor = SEDARBrowserExtractor(headless=headless)
        
        # Get Canadian companies with stock exchange listings
        companies = supabase.table('companies')\
            .select('id, company_name')\
            .ilike('jurisdiction', '%CA%')\
            .not_.is_('stock_exchange', 'null')\
            .limit(limit)\
            .execute()
        
        logger.info(f"Found {len(companies.data)} Canadian listed companies\n")
        
        total_saved = 0
        for company in companies.data:
            result = extractor.process_company(
                company['id'],
                company['company_name']
            )
            
            total_saved += result.get('saved', 0)
            time.sleep(3)  # Rate limiting
        
        logger.info(f"\n✅ Extraction complete!")
        logger.info(f"Total records saved: {total_saved}")
        
    except Exception as e:
        logger.error(f"Fatal error: {e}")
    
    finally:
        if extractor:
            extractor.close()

if __name__ == "__main__":
    import sys
    
    limit = int(sys.argv[1]) if len(sys.argv) > 1 else 10
    headless = sys.argv[2].lower() == 'true' if len(sys.argv) > 2 else False
    
    logger.warning("\n⚠️  SEDAR+ BROWSER AUTOMATION - EXPERIMENTAL")
    logger.warning("This script uses browser automation to access public SEDAR+ records")
    logger.warning("Field selectors may need updating if SEDAR+ page structure changes\n")
    
    run_sedar_extraction(limit, headless)
