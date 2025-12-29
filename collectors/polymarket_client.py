"""
Polymarket API Client - FIXED VERSION
Gets real political prediction markets for corporate risk analysis
"""

import requests
from typing import Dict, List
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class PolymarketClient:
    """Client for Polymarket prediction market API"""
    
    CLOB_API = "https://clob.polymarket.com"
    
    def __init__(self):
        self.session = requests.Session()
        logger.info("✓ Initialized Polymarket client")
    
    def get_all_markets(self, limit: int = 500) -> List[Dict]:
        """Get all markets (no filtering)"""
        try:
            response = self.session.get(
                f"{self.CLOB_API}/markets",
                params={'limit': limit}
            )
            response.raise_for_status()
            return response.json().get('data', [])
        except Exception as e:
            logger.error(f"Error fetching markets: {e}")
            return []
    
    def search_markets(self, query: str, exclude_sports: bool = True) -> List[Dict]:
        """
        Search markets by keyword
        
        Args:
            query: Search term
            exclude_sports: Filter out sports markets
        """
        markets = self.get_all_markets(limit=1000)
        query_lower = query.lower()
        results = []
        
        # Sports keywords to exclude
        sports_keywords = ['ncaa', 'nba', 'nfl', 'mlb', 'nhl', 'fifa', 'soccer', 
                          'basketball', 'football', 'baseball', 'hockey']
        
        for m in markets:
            question = str(m.get('question', '')).lower()
            description = str(m.get('description', '')).lower()
            
            # Skip if query not in text
            if query_lower not in question and query_lower not in description:
                continue
            
            # Skip sports if requested
            if exclude_sports:
                if any(sport in question for sport in sports_keywords):
                    continue
            
            results.append(m)
        
        return results
    
    def get_political_markets(self) -> List[Dict]:
        """Get political and regulatory markets (no sports)"""
        all_results = []
        seen_ids = set()
        
        # Political/regulatory keywords likely to have markets
        keywords = [
            'trump', 'biden', 'president', 'election', 'senate',
            'congress', 'regulation', 'fed', 'supreme court',
            'china', 'russia', 'ukraine', 'taiwan'
        ]
        
        for keyword in keywords:
            markets = self.search_markets(keyword, exclude_sports=True)
            for m in markets:
                cid = m.get('condition_id')
                if cid and cid not in seen_ids:
                    seen_ids.add(cid)
                    all_results.append(m)
        
        logger.info(f"Found {len(all_results)} political/regulatory markets")
        return all_results
    
    def classify_market(self, market: Dict) -> str:
        """Classify market into governance-relevant category"""
        question = market.get('question', '').lower()
        desc = market.get('description', '').lower()
        text = f"{question} {desc}"
        
        if any(word in text for word in ['regulation', 'law', 'bill', 'act', 'ftc', 'sec']):
            return 'Regulation'
        elif any(word in text for word in ['election', 'president', 'senate', 'congress']):
            return 'Election'
        elif any(word in text for word in ['china', 'tariff', 'trade', 'sanction']):
            return 'Trade_Policy'
        elif any(word in text for word in ['fed', 'interest rate', 'inflation']):
            return 'Monetary_Policy'
        elif any(word in text for word in ['war', 'conflict', 'military']):
            return 'Geopolitical'
        else:
            return 'Other_Political'


if __name__ == "__main__":
    client = PolymarketClient()
    
    print("\n" + "="*80)
    print("POLYMARKET POLITICAL MARKETS (REAL DATA)")
    print("="*80 + "\n")
    
    markets = client.get_political_markets()
    
    # Group by category
    by_category = {}
    for m in markets:
        cat = client.classify_market(m)
        if cat not in by_category:
            by_category[cat] = []
        by_category[cat].append(m)
    
    # Display
    for category, cat_markets in sorted(by_category.items()):
        print(f"\n{category.upper()} ({len(cat_markets)} markets)")
        print("-" * 80)
        for m in cat_markets[:5]:  # Show first 5 of each category
            print(f"  • {m.get('question', 'N/A')[:75]}")
    
    print(f"\n{'='*80}")
    print(f"Total political markets: {len(markets)}")
    print(f"{'='*80}\n")
