"""
SEC Filing RSS Monitor
Polls SEC EDGAR RSS feed for latest filings and extracts governance events

Monitors:
- 8-K: Material events (M&A, board changes, exec departures)
- DEF 14A: Proxy statements
- SC 13D/G: Activist positions (>5% ownership)
- DEFA14A: Additional proxy materials
- S-4: Merger registration
"""

import feedparser
import hashlib
import re
import time
from datetime import datetime, timedelta
from typing import Dict, List, Optional
import logging

import os
import sys
sys.path.append(os.path.dirname(__file__))

from supabase import create_client, ClientOptions
import toml

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class SECFilingMonitor:
    """Monitor SEC RSS feed for governance-related filings"""
    
    SEC_RSS_URL = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&CIK=&type=&company=&dateb=&owner=include&start=0&count=100&output=atom"
    
    # Filing types we care about
    GOVERNANCE_FORMS = {
        '8-K': 'Material Event',
        'DEF 14A': 'Proxy Statement',
        'DEFA14A': 'Additional Proxy Materials',
        'SC 13D': 'Activist Position',
        'SC 13G': 'Passive Position',
        'S-4': 'Merger Registration',
        'DEFM14A': 'Merger Proxy'
    }
    
    # 8-K Item classifications
    ITEM_CLASSIFICATIONS = {
        'Item 1.01': 'M&A',  # Entry into Material Definitive Agreement
        'Item 1.02': 'M&A',  # Termination of Material Agreement
        'Item 2.01': 'M&A',  # Completion of Acquisition
        'Item 5.02': 'Board Change',  # Departure/Election of Directors or Officers
        'Item 5.03': 'Governance',  # Amendments to Articles/Bylaws
        'Item 5.07': 'Proxy',  # Submission of Matters to Vote
        'Item 8.01': 'Other',  # Other Events
    }
    
    def __init__(self):
        """Initialize with Supabase connection"""
        try:
            secrets = toml.load('../dashboard/.streamlit/secrets.toml')
            url = secrets['SUPABASE_URL']
            key = secrets['SUPABASE_KEY']
        except:
            url = os.getenv("SUPABASE_URL")
            key = os.getenv("SUPABASE_KEY")
        
        if not url or not key:
            raise ValueError("Supabase credentials not found")
        
        options = ClientOptions(schema='vendor_governance')
        self.supabase = create_client(url, key, options=options)
        logger.info("✓ Connected to Supabase")
    
    def fetch_latest_filings(self) -> List[Dict]:
        """Fetch latest filings from SEC RSS feed"""
        logger.info(f"Fetching latest filings from SEC...")
        
        try:
            # Parse feed with proper User-Agent
            feed = feedparser.parse(
                self.SEC_RSS_URL,
                agent='RiskAnchor Governance Research research@riskanchor.com'
            )
            
            filings = []
            for entry in feed.entries:
                # Parse entry
                title = entry.title  # e.g., "8-K - MICROSOFT CORP (0000789019)"
                
                # Extract form type
                form_match = re.match(r'^([A-Z0-9\s\-/]+)\s+-\s+(.+)\s+\((\d+)\)', title)
                if not form_match:
                    continue
                
                form_type = form_match.group(1).strip()
                company_name = form_match.group(2).strip()
                cik = form_match.group(3).strip()
                
                # Filter for governance forms only
                if form_type not in self.GOVERNANCE_FORMS:
                    continue
                
                # Extract filing URL
                filing_url = entry.link
                
                # Extract accession number from URL
                # Example: https://www.sec.gov/cgi-bin/viewer?action=view&cik=789019&accession_number=0001193125-25-245150
                acc_match = re.search(r'accession_number=([\d\-]+)', filing_url)
                accession_number = acc_match.group(1) if acc_match else None
                
                # Published date - handle both parsed and string formats
                try:
                    if hasattr(entry, 'published_parsed') and entry.published_parsed:
                        published = datetime(*entry.published_parsed[:6])
                    else:
                        # Fallback: parse from string
                        from dateutil import parser as date_parser
                        published = date_parser.parse(entry.published)
                except:
                    # If all else fails, use current time
                    published = datetime.now()
                    logger.warning(f"Could not parse date for {company_name}, using current time")
                
                filings.append({
                    'form_type': form_type,
                    'company_name': company_name,
                    'cik': cik.zfill(10),  # Pad to 10 digits
                    'filing_url': filing_url,
                    'accession_number': accession_number,
                    'published_at': published,
                    'raw_title': title
                })
            
            logger.info(f"✓ Found {len(filings)} governance filings")
            return filings
            
        except Exception as e:
            logger.error(f"Error fetching RSS feed: {e}")
            return []
    
    def find_company_id(self, cik: str, company_name: str) -> Optional[str]:
        """Find company ID in database by CIK or name"""
        try:
            # Try by ticker first (some entries have ticker in name)
            ticker_match = re.search(r'\(([A-Z]{1,5})\)', company_name)
            if ticker_match:
                result = self.supabase.table('companies')\
                    .select('id')\
                    .eq('ticker_symbol', ticker_match.group(1))\
                    .execute()
                if result.data:
                    return result.data[0]['id']
            
            # Try by company name match
            clean_name = company_name.replace(' INC', '').replace(' CORP', '').replace(' LTD', '').strip()
            result = self.supabase.table('companies')\
                .select('id')\
                .ilike('company_name', f'%{clean_name}%')\
                .limit(1)\
                .execute()
            
            if result.data:
                return result.data[0]['id']
            
            return None
            
        except Exception as e:
            logger.warning(f"Error finding company: {e}")
            return None
    
    def classify_filing(self, filing: Dict) -> Dict:
        """Classify filing type and extract key information"""
        form_type = filing['form_type']
        
        # Default classification
        news_type = 'Other'
        headline = f"{form_type} Filing: {filing['company_name']}"
        summary = f"New {self.GOVERNANCE_FORMS.get(form_type, 'filing')} filed with SEC"
        
        if form_type == '8-K':
            # For 8-K, we'd need to fetch the filing to see Item numbers
            # For now, classify generically
            news_type = 'Material Event'
            headline = f"Material Event: {filing['company_name']} files 8-K"
            summary = "Company reported material event. May include M&A, board changes, or other significant developments."
            
        elif form_type in ['DEF 14A', 'DEFM14A']:
            news_type = 'Proxy'
            headline = f"Proxy Statement: {filing['company_name']}"
            summary = "Annual proxy statement filed. Includes board elections, executive compensation, and shareholder proposals."
            
        elif form_type == 'DEFA14A':
            news_type = 'Proxy'
            headline = f"Additional Proxy Materials: {filing['company_name']}"
            summary = "Additional proxy materials filed. May include activist letters or management responses."
            
        elif form_type in ['SC 13D', 'SC 13G']:
            news_type = 'Activism'
            headline = f"Major Ownership Stake: {filing['company_name']}"
            summary = f"Investor disclosed {'activist' if form_type == 'SC 13D' else 'passive'} position exceeding 5% ownership."
            
        elif form_type == 'S-4':
            news_type = 'M&A'
            headline = f"Merger Registration: {filing['company_name']}"
            summary = "Company filed merger/acquisition registration statement."
        
        return {
            'news_type': news_type,
            'headline': headline,
            'summary': summary
        }
    
    def compute_content_hash(self, headline: str, summary: str) -> str:
        """Compute SHA256 hash for deduplication"""
        content = f"{headline}|{summary}"
        return hashlib.sha256(content.encode()).hexdigest()
    
    def store_filing(self, filing: Dict, classification: Dict) -> bool:
        """Store filing as news item in database"""
        try:
            # Find company ID
            company_id = self.find_company_id(filing['cik'], filing['company_name'])
            
            # Compute hash for deduplication
            content_hash = self.compute_content_hash(
                classification['headline'],
                classification['summary']
            )
            
            # Prepare news item
            news_item = {
                'company_id': company_id,
                'headline': classification['headline'],
                'summary': classification['summary'],
                'source': 'SEC',
                'news_type': classification['news_type'],
                'filing_type': filing['form_type'],
                'url': filing['filing_url'],
                'sec_accession_number': filing['accession_number'],
                'published_at': filing['published_at'].isoformat(),
                'content_hash': content_hash,
                'relevance_score': 0.8,  # High relevance for SEC filings
                'sentiment': 'neutral'
            }
            
            # Insert (will skip if duplicate hash exists)
            result = self.supabase.table('governance_news').insert(news_item).execute()
            
            logger.info(f"✓ Stored: {classification['headline'][:60]}...")
            return True
            
        except Exception as e:
            if 'duplicate key' in str(e).lower() or 'unique' in str(e).lower():
                logger.debug(f"Skipping duplicate: {classification['headline'][:40]}...")
                return False
            else:
                logger.error(f"Error storing filing: {e}")
                return False
    
    def run_collection(self) -> Dict:
        """Run one collection cycle"""
        start_time = time.time()
        
        logger.info("=" * 70)
        logger.info("SEC FILING MONITOR - Collection Cycle")
        logger.info("=" * 70)
        
        # Fetch latest filings
        filings = self.fetch_latest_filings()
        
        stored_count = 0
        duplicate_count = 0
        
        for filing in filings:
            # Classify
            classification = self.classify_filing(filing)
            
            # Store
            if self.store_filing(filing, classification):
                stored_count += 1
            else:
                duplicate_count += 1
        
        # Record stats
        duration = time.time() - start_time
        stats = {
            'collection_type': 'SEC_RSS',
            'articles_collected': len(filings),
            'articles_stored': stored_count,
            'articles_duplicates': duplicate_count,
            'run_duration_seconds': round(duration, 2),
            'status': 'success'
        }
        
        try:
            self.supabase.table('news_collection_stats').insert(stats).execute()
        except Exception as e:
            logger.warning(f"Could not store stats: {e}")
        
        logger.info(f"\n✅ Collection complete:")
        logger.info(f"   Collected: {len(filings)} filings")
        logger.info(f"   Stored: {stored_count} new items")
        logger.info(f"   Duplicates: {duplicate_count}")
        logger.info(f"   Duration: {duration:.2f}s")
        logger.info("=" * 70 + "\n")
        
        return stats


def main():
    """Run monitor once"""
    monitor = SECFilingMonitor()
    monitor.run_collection()


if __name__ == "__main__":
    main()
