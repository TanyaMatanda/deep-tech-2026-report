"""
SEC Filing Parser - UPDATED for 2024 SEC Edgar API
Uses modern data.sec.gov JSON API instead of HTML scraping
"""

import re
import requests
import time
from typing import Dict, Optional, List
from bs4 import BeautifulSoup
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class SECFilingParser:
    """Parse SEC filings (DEF 14A, 10-K) for governance and risk factors"""
    
    SEC_BASE = "https://www.sec.gov"
    SEC_DATA_BASE = "https://data.sec.gov"
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
    
    def fetch_filing(self, cik: str, form_type: str, years_back: int = 1) -> Optional[str]:
        """Fetch most recent filing of given type for CIK using modern SEC API"""
        self.rate_limit()
        
        # Pad CIK to 10 digits
        cik_padded = cik.zfill(10)
        cik_no_padding = str(int(cik))
        
        try:
            # Step 1: Get submission history from new JSON API
            submissions_url = f"{self.SEC_DATA_BASE}/submissions/CIK{cik_padded}.json"
            response = requests.get(submissions_url, headers=self.HEADERS, timeout=10)
            response.raise_for_status()
            
            data = response.json()
            
            # Step 2: Find most recent filing of requested type
            filings = data.get('filings', {}).get('recent', {})
            if not filings:
                logger.warning(f"No recent filings found for CIK {cik}")
                return None
            
            # filings is a dict with parallel arrays
            forms = filings.get('form', [])
            accession_numbers = filings.get('accessionNumber', [])
            filing_dates = filings.get('filingDate', [])
            primary_documents = filings.get('primaryDocument', [])
            
            # Find the first match for the form type
            target_index = None
            for i, form in enumerate(forms):
                if form == form_type:
                    target_index = i
                    break
            
            if target_index is None:
                logger.warning(f"No {form_type} found for CIK {cik}")
                return None
            
            # Step 3: Construct filing URL using primaryDocument
            accession = accession_numbers[target_index].replace('-', '')
            filing_date = filing_dates[target_index]
            primary_doc = primary_documents[target_index]
            
            # Format: https://www.sec.gov/Archives/edgar/data/CIK/ACCESSION/PRIMARY_DOC.htm
            doc_url = f"{self.SEC_BASE}/Archives/edgar/data/{cik_no_padding}/{accession}/{primary_doc}"
            
            self.rate_limit()
            
            doc_response = requests.get(doc_url, headers=self.HEADERS, timeout=15)
            if doc_response.status_code == 200:
                logger.info(f"✓ Found {form_type} filing for CIK {cik} (Date: {filing_date})")
                return doc_response.text
            else:
                logger.warning(f"Could not retrieve {form_type} from {doc_url} (Status: {doc_response.status_code})")
                return None
            
        except Exception as e:
            logger.error(f"Error fetching filing for CIK {cik}: {e}")
            return None
    
    def clean_text(self, text: str) -> str:
        """Remove HTML tags and clean whitespace"""
        if not text:
            return ""
        
        # Remove HTML tags
        soup = BeautifulSoup(text, 'html.parser')
        text = soup.get_text()
        
        # Clean whitespace
        text = re.sub(r'\s+', ' ', text)
        return text.strip()
    
    # ===== GOVERNANCE FACTORS =====
    
    def extract_board_independence(self, filing_text: str) -> Dict[str, Optional[float]]:
        """Extract board independence percentage and counts"""
        patterns = [
            r'(\d+)\s+of\s+(?:our\s+)?(\d+)\s+directors?\s+(?:are|is)\s+independent',
            r'(\d+)\s+independent\s+directors?.*?of\s+(?:a\s+)?total\s+of\s+(\d+)',
            r'board.*?(\d+)%.*?independent',
            r'independent:\s*(\d+)\s+of\s+(\d+)',
        ]
        
        for pattern in patterns:
            match = re.search(pattern, filing_text, re.IGNORECASE)
            if match:
                if len(match.groups()) == 2:
                    independent = int(match.group(1))
                    total = int(match.group(2))
                    if total > 0 and independent <= total:
                        return {
                            'board_independence_pct': round((independent / total) * 100, 2),
                            'independent_directors': independent,
                            'total_directors': total
                        }
                elif '%' in pattern:
                    pct = float(match.group(1))
                    if 0 <= pct <= 100:
                        return {
                            'board_independence_pct': pct,
                            'independent_directors': None,
                            'total_directors': None
                        }
        
        return {
            'board_independence_pct': None,
            'independent_directors': None,
            'total_directors': None
        }
    
    def extract_split_chair_ceo(self, filing_text: str) -> Optional[bool]:
        """Check if Chair and CEO roles are split"""
        patterns = [
            r'independent\s+(?:non-executive\s+)?chair(?:man|person)?',
            r'separate(?:d)?\s+(?:the\s+)?roles?\s+of\s+(?:the\s+)?chair(?:man)?\s+and\s+(?:chief\s+executive|ceo)',
            r'chair(?:man|person)?\s+is\s+(?:not\s+)?(?:also\s+)?(?:our\s+)?(?:chief\s+executive|ceo)',
        ]
        
        for pattern in patterns:
            if re.search(pattern, filing_text, re.IGNORECASE):
                # If we find "independent chair" or "separate roles", it's split
                if 'independent' in pattern or 'separate' in pattern:
                    return True
        
        # Check for "CEO and Chairman" (combined role)
        if re.search(r'(?:chief\s+executive|ceo)\s+and\s+chair(?:man|person)', filing_text, re.IGNORECASE):
            return False
        
        return None
    
    def extract_board_diversity(self, filing_text: str) -> Optional[float]:
        """Extract board diversity percentage (gender/racial)"""
        # Clean text first if not already done (though extract_all_factors does it)
        # We assume filing_text is cleaned or mostly cleaned
        
        patterns = [
            # Explicit percentage: "33% of our Board nominees are women"
            r'(\d+(?:\.\d+)?)%\s+of\s+(?:our\s+)?(?:board|directors|nominees)\s+(?:are|identify\s+as)\s+(?:women|female)',
            r'(\d+(?:\.\d+)?)%\s+(?:women|female)\s+directors',
            
            # Count: "3 of 9 directors are women"
            r'(\d+)\s+of\s+(?:our\s+)?(\d+)\s+directors?\s+(?:are|identify\s+as)\s+(?:women|female)',
            
            # Matrix style: "Total Number of Directors X ... Female Y"
            r'total\s+number\s+of\s+directors.*?(\d+).*?female\s+(\d+)',
            r'total\s+number\s+of\s+directors.*?(\d+).*?women\s+(\d+)',
            
            # Existing patterns (refined)
            r'board.*?(\d+)%.*?(?:diverse|women|female|underrepresented)',
            r'diversity.*?(\d+)\s+of\s+(\d+)',
        ]
        
        for pattern in patterns:
            match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
            if match:
                groups = match.groups()
                
                # Case 1: Percentage found directly
                if '%' in pattern or (len(groups) == 1 and re.search(r'^\d+(\.\d+)?$', groups[0])):
                    try:
                        pct = float(groups[0])
                        if 5 <= pct <= 100: # Sanity check: >5% to avoid "2%" errors
                            return pct
                    except ValueError:
                        continue
                        
                # Case 2: "X of Y" or "Total Y ... Female X"
                elif len(groups) == 2:
                    try:
                        # Check which group is total vs count based on pattern structure
                        # Pattern 3: val1 of val2 -> val1 is count, val2 is total
                        # Pattern 4 & 5: total val1 ... female val2 -> val1 is total, val2 is count
                        # Pattern 6 & 7: board ... val1% ... or diversity ... val1 of val2 -> val1 is count, val2 is total
                        
                        val1 = float(groups[0])
                        val2 = float(groups[1])
                        
                        if 'total' in pattern.lower(): # Patterns 4, 5
                            total = val1
                            count = val2
                        else: # Patterns 3, 6, 7
                            count = val1
                            total = val2
                            
                        if total > 0 and count <= total:
                            return round((count / total) * 100, 2)
                    except ValueError:
                        continue
        
        return None
    
    def extract_overboarding_count(self, filing_text: str) -> int:
        """Count directors serving on >4 public boards"""
        # Look for director bios mentioning multiple board seats
        overboarded = 0
        
        # Pattern: "serves on X public company boards" or "director of X companies"
        patterns = [
            r'serves?\s+on\s+(?:the\s+boards?\s+of\s+)?(\d+)\s+(?:other\s+)?public\s+compan(?:y|ies)',
            r'director\s+of\s+(\d+)\s+(?:other\s+)?public\s+compan(?:y|ies)',
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, filing_text, re.IGNORECASE)
            for count in matches:
                if int(count) >= 4:
                    overboarded += 1
        
        return overboarded
    
    # ===== COMPENSATION FACTORS =====
    
    def extract_say_on_pay(self, filing_text: str) -> Optional[float]:
        """Extract say-on-pay vote support percentage"""
        patterns = [
            r'say[- ]on[- ]pay.*?(\d+\.?\d*)%\s+(?:voted\s+)?(?:in\s+)?favor',
            r'advisory\s+vote.*?compensation.*?(\d+\.?\d*)%',
            r'executive\s+compensation.*?approved.*?(\d+\.?\d*)%',
        ]
        
        for pattern in patterns:
            match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
            if match:
                pct = float(match.group(1))
                if 0 <= pct <= 100:
                    return round(pct, 2)
        
        return None
    
    def extract_ceo_pay_ratio(self, filing_text: str) -> Optional[int]:
        """Extract CEO pay ratio (e.g., 250:1)"""
        patterns = [
            r'ceo\s+pay\s+ratio.*?(\d+):1',
            r'ratio.*?(\d+)\s+to\s+1',
            r'median.*?employee.*?(\d+):1',
        ]
        
        for pattern in patterns:
            match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
            if match:
                ratio = int(match.group(1))
                if 1 <= ratio <= 10000:  # Sanity check
                    return ratio
        
        return None
    
    def has_clawback_policy(self, filing_text: str) -> bool:
        """Check for clawback/recoupment policy"""
        keywords = ['clawback', 'recoupment', 'dodd-frank.*compensation.*recovery']
        
        for keyword in keywords:
            if re.search(keyword, filing_text, re.IGNORECASE):
                return True
        
        return False
    
    # ===== AI GOVERNANCE FACTORS =====
    
    def has_ai_ethics_board(self, filing_text: str) -> bool:
        """Check for AI Ethics Committee or similar"""
        patterns = [
            r'ai\s+ethics\s+(?:board|committee)',
            r'artificial\s+intelligence\s+(?:oversight|governance|ethics)',
            r'responsible\s+ai\s+committee',
            r'technology\s+ethics\s+(?:board|committee)',
        ]
        
        for pattern in patterns:
            if re.search(pattern, filing_text, re.IGNORECASE):
                return True
        
        return False
    
    def has_ai_expertise(self, filing_text: str) -> bool:
        """Check for AI/ML expertise in director bios"""
        keywords = [
            'artificial intelligence', 'machine learning', 'deep learning',
            'neural network', 'ai research', 'data science', 'ml engineer'
        ]
        
        for keyword in keywords:
            if re.search(keyword, filing_text, re.IGNORECASE):
                return True
        
        return False
    
    def count_ai_risk_mentions(self, filing_text: str) -> int:
        """Count AI-related risk mentions in Item 1A"""
        # Extract Item 1A section first
        item1a_match = re.search(
            r'ITEM\s+1A\.?\s+RISK\s+FACTORS(.*?)(?:ITEM\s+1B|ITEM\s+2)',
            filing_text,
            re.IGNORECASE | re.DOTALL
        )
        
        if not item1a_match:
            return 0
        
        risk_section = item1a_match.group(1)
        
        ai_keywords = [
            'artificial intelligence', r'\bAI\b', 'machine learning',
            'generative ai', 'algorithm', 'automated decision'
        ]
        
        count = 0
        for keyword in ai_keywords:
            matches = re.findall(keyword, risk_section, re.IGNORECASE)
            count += len(matches)
        
        return count
    
    # ===== CYBERSECURITY FACTORS =====
    
    def has_cyber_oversight(self, filing_text: str) -> bool:
        """Check for explicit cyber oversight"""
        patterns = [
            r'cybersecurity\s+(?:committee|oversight)',
            r'audit\s+committee.*?cybersecurity',
            r'board.*?cybersecurity.*?oversight',
        ]
        
        for pattern in patterns:
            if re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL):
                return True
        
        return False
    
    def extract_ciso_reporting(self, filing_text: str) -> Optional[str]:
        """Extract CISO reporting line"""
        patterns = [
            r'(?:ciso|chief\s+information\s+security\s+officer)\s+reports?\s+to\s+(?:the\s+)?(ceo|cio|board|risk\s+committee)',
        ]
        
        for pattern in patterns:
            match = re.search(pattern, filing_text, re.IGNORECASE)
            if match:
                return match.group(1).upper()
        
        return None
    
    def has_breach_history(self, filing_text: str) -> bool:
        """Check for data breach disclosure"""
        keywords = [
            'data breach', 'cybersecurity incident', 'unauthorized access',
            'security breach', 'cyber attack'
        ]
        
        for keyword in keywords:
            if re.search(keyword, filing_text, re.IGNORECASE):
                return True
        
        return False
    
    # ===== RISK FACTORS =====
    
    def count_risk_factors(self, filing_text: str) -> int:
        """Count total number of risk factors in Item 1A"""
        item1a_match = re.search(
            r'ITEM\s+1A\.?\s+RISK\s+FACTORS(.*?)(?:ITEM\s+1B|ITEM\s+2)',
            filing_text,
            re.IGNORECASE | re.DOTALL
        )
        
        if not item1a_match:
            return 0
        
        risk_section = item1a_match.group(1)
        
        # Count bolded headers or bullet points
        bold_headers = len(re.findall(r'<b>.*?</b>', risk_section, re.IGNORECASE))
        bullet_points = len(re.findall(r'•|&#8226;', risk_section))
        
        return max(bold_headers, bullet_points, 15)  # Minimum 15 as fallback
    
    def count_keyword_mentions(self, filing_text: str, keyword: str) -> int:
        """Count mentions of specific keyword in Item 1A"""
        item1a_match = re.search(
            r'ITEM\s+1A\.?\s+RISK\s+FACTORS(.*?)(?:ITEM\s+1B|ITEM\s+2)',
            filing_text,
            re.IGNORECASE | re.DOTALL
        )
        
        if not item1a_match:
            return 0
        
        risk_section = item1a_match.group(1)
        matches = re.findall(keyword, risk_section, re.IGNORECASE)
        
        return len(matches)
    
    # ===== FINANCIAL METRICS =====
    
    def extract_revenue_growth(self, filing_text: str) -> Optional[float]:
        """Extract YoY revenue growth percentage"""
        patterns = [
            r'revenue.*?(?:increased|grew).*?(\d+\.?\d*)%',
            r'(\d+\.?\d*)%.*?revenue.*?growth',
        ]
        
        for pattern in patterns:
            match = re.search(pattern, filing_text, re.IGNORECASE)
            if match:
                growth = float(match.group(1))
                if -50 <= growth <= 500:  # Sanity check
                    return round(growth, 2)
        
        return None
    
    # ===== COMPENSATION ENHANCEMENTS =====
    
    def extract_stip_ltip_combined(self, filing_text: str) -> Dict:
        """Extract combined STIP and LTIP information"""
        comp_data = {}
        
        # STIP (Short-Term Incentive Plan)
        stip_patterns = [
            r'(?:short[- ]term|annual)\s+(?:incentive|bonus).*?(\d+)%.*?target',
            r'target\s+(?:annual\s+)?bonus.*?(\d+)%',
        ]
        for pattern in stip_patterns:
            match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
            if match:
                comp_data['stip_target_pct'] = float(match.group(1))
                break
        
        # LTIP (Long-Term Incentive Plan)
        ltip_patterns = [
            r'(?:long[- ]term|equity)\s+incentive.*?(\d+)%.*?target',
            r'equity\s+award.*?(\d+)%.*?total.*?compensation',
        ]
        for pattern in ltip_patterns:
            match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
            if match:
                comp_data['ltip_target_pct'] = float(match.group(1))
                break
        
        # Perquisites value
        perq_match = re.search(
            r'(?:perquisites|all\s+other\s+compensation).*?\$\s?([\d,]+)',
            filing_text,
            re.IGNORECASE | re.DOTALL
        )
        if perq_match:
            value_str = perq_match.group(1).replace(',', '')
            try:
                comp_data['perquisites_value'] = int(value_str)
            except:
                pass
        
        return comp_data
    
    # ===== ENHANCED GOVERNANCE FACTORS =====
    
    def extract_chair_info(self, filing_text: str) -> Dict:
        """Extract Board Chair gender and independence"""
        info = {
            'women_board_chair': False,
            'independent_board_chair': False,
            'independent_women_board_chair': False
        }
        
        # 1. Identify Chair Name
        # Pattern: "Name... serves as (Independent) Chair"
        # Relaxed pattern to catch "Chairman of the Board: [Name]" or "[Name], Chairman"
        chair_patterns = [
            r'([A-Z][a-z]+(?:\s[A-Z][a-z]+)+)\s+(?:serves|acts)\s+as\s+(?:our\s+)?(Independent\s+)?Chair(?:man|person| of the Board)',
            r'Chair(?:man|person| of the Board)\s*:?\s*([A-Z][a-z]+(?:\s[A-Z][a-z]+)+)',
            r'([A-Z][a-z]+(?:\s[A-Z][a-z]+)+)\s*,\s*(?:Independent\s+)?Chair(?:man|person)'
        ]
        
        match = None
        for pattern in chair_patterns:
            match = re.search(pattern, filing_text, re.IGNORECASE)
            if match:
                break
        
        if match:
            # Group handling depends on pattern, but usually name is the one with multiple words
            groups = match.groups()
            name = next((g for g in groups if g and len(g.split()) >= 2), "Unknown")
            is_independent = bool(re.search(r'Independent', match.group(0), re.IGNORECASE))
            
            info['independent_board_chair'] = is_independent
            
            # Gender Inference (Heuristic)
            # Check for pronouns near the name in a small window
            # This is a simple approximation.
            window = filing_text[match.start():match.end()+500]
            if re.search(r'\b(she|her|hers|Ms\.|Mrs\.)\b', window, re.IGNORECASE):
                info['women_board_chair'] = True
                if is_independent:
                    info['independent_women_board_chair'] = True
            elif re.search(r'\b(he|him|his|Mr\.)\b', window, re.IGNORECASE):
                info['women_board_chair'] = False
        
        return info

    def extract_shareholder_proposals(self, filing_text: str) -> List[Dict]:
        """Extract shareholder proposals from Item 4"""
        proposals = []
        
        # Find "Shareholder Proposal" sections
        # Pattern: "Proposal [X]: [Title]"
        pattern = r'Proposal\s+(\d+)\s*[:\-]\s*(.*?)(?:\n|$)'
        matches = re.finditer(pattern, filing_text, re.IGNORECASE)
        
        for match in matches:
            number = match.group(1)
            title = match.group(2).strip()
            
            # Filter out management proposals
            if any(x in title.lower() for x in ['election of directors', 'ratification', 'approval of', 'say-on-pay', 'advisory vote']):
                continue
                
            # It's likely a shareholder proposal
            proposals.append({
                'proposal_number': number,
                'proposal_description': title,
                'category': self._categorize_proposal(title)
            })
            
        return proposals

    def _categorize_proposal(self, title: str) -> str:
        title = title.lower()
        if any(x in title for x in ['climate', 'emission', 'environmental', 'plastic']):
            return 'Environmental'
        elif any(x in title for x in ['diversity', 'rights', 'labor', 'political', 'lobbying']):
            return 'Social'
        elif any(x in title for x in ['chair', 'board', 'voting', 'proxy', 'special meeting']):
            return 'Governance'
        else:
            return 'Other'

    # ===== MAIN EXTRACTION METHOD =====
    
    def extract_board_age_and_tenure(self, filing_text: str) -> Dict[str, Optional[float]]:
        """Extract average director age and tenure from biographies"""
        # 1. Locate the director biographies section
        # Heuristic: Find "Election of Directors" or "Director Biographies"
        bio_headers = [
            r'our\s+director\s+nominees',
            r'nominees\s+for\s+director',
            r'director\s+nominees',
            r'election\s+of\s+directors',
            r'board\s+of\s+directors',
            r'director\s+biographies'
        ]
        
        bio_text = filing_text
        best_section = None
        max_ages = 0
        
        for header in bio_headers:
            # Find all occurrences of the header
            matches = list(re.finditer(header, filing_text, re.IGNORECASE))
            for match in matches:
                # Sample the next 50,000 chars
                section_sample = filing_text[match.start():match.start() + 50000]
                age_count = len(re.findall(r'Age[:\s]+(\d{2})', section_sample))
                
                if age_count > max_ages:
                    max_ages = age_count
                    best_section = section_sample
                    logger.info(f"🔍 Found better bio section with '{header}' at index {match.start()} ({age_count} ages)")
            
            # If we found a very good section (>5 ages), we can probably stop
            if max_ages >= 5:
                break
        
        if best_section:
            bio_text = best_section
        
        # 2. Extract Ages
        age_pattern = r'Age[:\s]+(\d{2})'
        ages = re.findall(age_pattern, bio_text)
        logger.info(f"🔍 Found {len(ages)} age matches")
        ages = [int(a) for a in ages if 18 < int(a) < 100] # Sanity check
        
        avg_age = round(sum(ages) / len(ages), 1) if ages else None
        
        # 3. Extract Tenure (Director Since)
        tenure_pattern = r'(?:Director|Member)\s+since[:\s]+(\d{4})'
        start_years = re.findall(tenure_pattern, bio_text, re.IGNORECASE)
        logger.info(f"🔍 Found {len(start_years)} tenure matches")
        
        # Fallback for "Director since [Month] [Year]"
        if not start_years:
            month_year_pattern = r'(?:Director|Member)\s+since[:\s]+(?:[A-Z][a-z]+\s+)?(\d{4})'
            start_years = re.findall(month_year_pattern, bio_text, re.IGNORECASE)
            logger.info(f"🔍 Found {len(start_years)} tenure matches (month-year fallback)")
        
        current_year = 2024 # Target year for this project
        tenures = [current_year - int(y) for y in start_years if 1950 < int(y) <= current_year]
        
        avg_tenure = round(sum(tenures) / len(tenures), 1) if tenures else None
        
        return {
            'avg_director_age': avg_age,
            'avg_director_tenure': avg_tenure
        }

    def extract_all_factors(self, cik: str, company_name: str) -> Dict:
        """Extract all governance and risk factors for a company"""
        logger.info(f"Extracting factors for {company_name} (CIK: {cik})")
        
        factors = {
            'company_id': None,
            'fiscal_year': 2024,
        }
        
        # Fetch DEF 14A (Proxy Statement)
        proxy_filing = self.fetch_filing(cik, 'DEF 14A')
        
        if proxy_filing:
            factors['def14a_url'] = 'Found via new API'
            proxy_text = self.clean_text(proxy_filing)
            
            # Governance factors
            independence = self.extract_board_independence(proxy_text)
            factors.update(independence)
            factors['split_chair_ceo'] = self.extract_split_chair_ceo(proxy_text)
            factors['board_diversity_pct'] = self.extract_board_diversity(proxy_text)
            factors['overboarded_directors_count'] = self.extract_overboarding_count(proxy_text)
            
            # Enhanced Chair Info
            chair_info = self.extract_chair_info(proxy_text)
            factors.update(chair_info)
            
            # Shareholder Proposals
            factors['shareholder_proposals'] = self.extract_shareholder_proposals(proxy_text)
            
            # Compensation factors - ENHANCED
            factors['say_on_pay_support'] = self.extract_say_on_pay(proxy_text)
            factors['ceo_pay_ratio'] = self.extract_ceo_pay_ratio(proxy_text)
            factors['has_clawback_policy'] = self.has_clawback_policy(proxy_text)
            
            # Enhanced compensation details
            comp_details = self.extract_stip_ltip_combined(proxy_text)
            factors.update(comp_details)
            
            # AI Governance
            factors['has_ai_ethics_board'] = self.has_ai_ethics_board(proxy_text)
            factors['board_ai_expertise'] = self.has_ai_expertise(proxy_text)
            
            # Cyber
            factors['cyber_oversight_explicit'] = self.has_cyber_oversight(proxy_text)
            factors['ciso_reporting_line'] = self.extract_ciso_reporting(proxy_text)
            
            # Age and Tenure
            age_tenure = self.extract_board_age_and_tenure(proxy_text)
            factors.update(age_tenure)
        else:
            factors['def14a_url'] = 'Not found'
        
        # Fetch 10-K (Annual Report)
        annual_filing = self.fetch_filing(cik, '10-K')
        
        if annual_filing:
            factors['10k_url'] = 'Found via new API'
            annual_text = self.clean_text(annual_filing)
            
            # Risk factors
            factors['risk_factor_count'] = self.count_risk_factors(annual_filing)
            factors['ai_risk_mentions'] = self.count_ai_risk_mentions(annual_text)
            factors['climate_risk_mentions'] = self.count_keyword_mentions(annual_text, 'climate change')
            factors['supply_chain_risk_mentions'] = self.count_keyword_mentions(annual_text, 'supply chain')
            
            # Extract detailed risk factors (Top 5 by keyword)
            # This is a simplified extraction for the 'company_risk_factors' table
            factors['detailed_risks'] = []
            if factors['ai_risk_mentions'] > 0:
                factors['detailed_risks'].append({
                    'category': 'AI',
                    'title': 'Artificial Intelligence Risks',
                    'description': 'Risks related to AI adoption, regulation, or competition.',
                    'ai_related': True
                })
            if factors['climate_risk_mentions'] > 0:
                factors['detailed_risks'].append({
                    'category': 'Environmental',
                    'title': 'Climate Change Risks',
                    'description': 'Risks related to climate change regulations or physical impacts.',
                    'climate_related': True
                })
            
            # Cyber breach history
            factors['breach_history'] = self.has_breach_history(annual_text)
            
            # Financial metrics
            factors['revenue_growth'] = self.extract_revenue_growth(annual_text)
        else:
            factors['10k_url'] = 'Not found'
        
        return factors
