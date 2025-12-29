"""
Kalshi API Client
Integrates with Kalshi prediction markets to track corporate event predictions

API Docs: https://docs.kalshi.com
"""

import requests
import time
from typing import Dict, List, Optional
import logging
import os
from datetime import datetime

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class KalshiClient:
    """Client for Kalshi prediction market API"""
    
    BASE_URL = "https://trading-api.kalshi.com/trade-api/v2"
    DEMO_URL = "https://demo-api.kalshi.co/trade-api/v2"  # Sandbox for testing
    
    def __init__(self, email: str = None, password: str = None, use_demo: bool = False):
        """
        Initialize Kalshi client
        
        Args:
            email: Kalshi account email (or use KALSHI_EMAIL env var)
            password: Kalshi account password (or use KALSHI_PASSWORD env var)
            use_demo: Use demo/sandbox environment for testing
        """
        self.base_url = self.DEMO_URL if use_demo else self.BASE_URL
        self.email = email or os.getenv("KALSHI_EMAIL")
        self.password = password or os.getenv("KALSHI_PASSWORD")
        self.token = None
        self.token_expires_at = None
        
        if not self.email or not self.password:
            logger.warning("⚠️  Kalshi credentials not provided. Set KALSHI_EMAIL and KALSHI_PASSWORD env vars.")
    
    def login(self) -> bool:
        """Authenticate with Kalshi to get access token"""
        try:
            response = requests.post(
                f"{self.base_url}/login",
                json={
                    "email": self.email,
                    "password": self.password
                }
            )
            response.raise_for_status()
            
            data = response.json()
            self.token = data['token']
            # Token expires in 30 minutes
            self.token_expires_at = time.time() + (30 * 60)
            
            logger.info("✓ Authenticated with Kalshi")
            return True
            
        except Exception as e:
            logger.error(f"Failed to authenticate with Kalshi: {e}")
            return False
    
    def ensure_authenticated(self):
        """Ensure we have a valid token, refresh if needed"""
        if not self.token or time.time() >= self.token_expires_at - 60:
            logger.info("Token expired or missing, re-authenticating...")
            self.login()
    
    def _get_headers(self) -> Dict:
        """Get headers with authentication token"""
        self.ensure_authenticated()
        return {
            "Authorization": f"Bearer {self.token}",
            "Content-Type": "application/json"
        }
    
    def get_events(self, status: str = "open", limit: int = 100) -> List[Dict]:
        """
        Get list of events (top-level grouping of markets)
        
        Args:
            status: 'open', 'closed', or 'all'
            limit: Max number of events to return
        
        Returns:
            List of event objects
        """
        try:
            # Public endpoint - no auth required
            response = requests.get(
                f"{self.base_url}/events",
                params={
                    "status": status,
                    "limit": limit
                }
            )
            response.raise_for_status()
            
            data = response.json()
            return data.get('events', [])
            
        except Exception as e:
            logger.error(f"Error fetching events: {e}")
            return []
    
    def search_markets(self, query: str = None, series_ticker: str = None, 
                      status: str = "open", limit: int = 100) -> List[Dict]:
        """
        Search for markets
        
        Args:
            query: Search query (e.g., "IPO", "acquisition", company name)
            series_ticker: Filter by series (e.g., "TECH-IPOS")
            status: 'open', 'closed', or 'all'
            limit: Max results
        
        Returns:
            List of market objects
        """
        params = {
            "status": status,
            "limit": limit
        }
        
        if series_ticker:
            params["series_ticker"] = series_ticker
        
        try:
            # Public endpoint
            response = requests.get(
                f"{self.base_url}/markets",
                params=params
            )
            response.raise_for_status()
            
            markets = response.json().get('markets', [])
            
            # Client-side filtering if query provided
            if query:
                query_lower = query.lower()
                markets = [
                    m for m in markets 
                    if query_lower in m.get('title', '').lower() or 
                       query_lower in m.get('subtitle', '').lower()
                ]
            
            return markets
            
        except Exception as e:
            logger.error(f"Error searching markets: {e}")
            return []
    
    def get_market(self, ticker: str) -> Optional[Dict]:
        """
        Get detailed market data
        
        Args:
            ticker: Market ticker symbol
        
        Returns:
            Market object with full details
        """
        try:
            response = requests.get(f"{self.base_url}/markets/{ticker}")
            response.raise_for_status()
            
            return response.json().get('market')
            
        except Exception as e:
            logger.error(f"Error fetching market {ticker}: {e}")
            return None
    
    def get_market_orderbook(self, ticker: str) -> Optional[Dict]:
        """
        Get current orderbook (bids/asks) for a market
        
        Args:
            ticker: Market ticker
        
        Returns:
            Orderbook with yes/no prices and depth
        """
        try:
            response = requests.get(f"{self.base_url}/markets/{ticker}/orderbook")
            response.raise_for_status()
            
            return response.json().get('orderbook')
            
        except Exception as e:
            logger.error(f"Error fetching orderbook for {ticker}: {e}")
            return None
    
    def get_corporate_markets(self) -> List[Dict]:
        """
        Get markets related to corporate events (M&A, IPOs, etc.)
        
        Returns:
            List of relevant markets
        """
        corporate_keywords = [
            "IPO", "acquisition", "merger", "CEO", "earnings",
            "stock", "company", "corporate", "board"
        ]
        
        all_markets = []
        
        for keyword in corporate_keywords:
            markets = self.search_markets(query=keyword, status="open", limit=50)
            all_markets.extend(markets)
        
        # Deduplicate by ticker
        seen = set()
        unique_markets = []
        for m in all_markets:
            ticker = m.get('ticker')
            if ticker and ticker not in seen:
                seen.add(ticker)
                unique_markets.append(m)
        
        logger.info(f"Found {len(unique_markets)} corporate-related markets")
        return unique_markets
    
    def classify_market(self, market: Dict) -> str:
        """
        Classify market into event type
        
        Args:
            market: Market object from API
        
        Returns:
            Event type: 'M&A', 'IPO', 'CEO_Change', 'Earnings', 'Governance', 'Other'
        """
        title = market.get('title', '').lower()
        subtitle = market.get('subtitle', '').lower()
        text = f"{title} {subtitle}"
        
        if any(word in text for word in ['ipo', 'go public', 'list on']):
            return 'IPO'
        elif any(word in text for word in ['acquire', 'acquisition', 'merge', 'merger', 'takeover']):
            return 'M&A'
        elif any(word in text for word in ['ceo', 'chief executive', 'resign', 'step down']):
            return 'CEO_Change'
        elif any(word in text for word in ['earnings', 'revenue', 'profit', 'eps']):
            return 'Earnings'
        elif any(word in text for word in ['board', 'governance', 'proxy', 'shareholder vote']):
            return 'Governance'
        else:
            return 'Other'


def demo_kalshi_markets():
    """Demo: Fetch and display Kalshi corporate markets"""
    client = KalshiClient(use_demo=False)  # Use production to see real markets
    
    print("=" * 80)
    print("KALSHI CORPORATE EVENT MARKETS")
    print("=" * 80)
    print()
    
    # Search for IPO markets
    print("🚀 IPO Markets:")
    ipo_markets = client.search_markets(query="IPO", status="open", limit=10)
    
    for market in ipo_markets[:5]:
        print(f"\n  • {market.get('title')}")
        print(f"    Ticker: {market.get('ticker')}")
        print(f"    Closes: {market.get('close_time', 'N/A')}")
        
        # Get orderbook for current probability
        orderbook = client.get_market_orderbook(market.get('ticker'))
        if orderbook:
            yes_bid = orderbook.get('yes', [{}])[0].get('price', 0) if orderbook.get('yes') else 0
            yes_prob = yes_bid / 100  # Prices are in cents
            print(f"    Probability: {yes_prob:.1%}")
    
    print("\n" + "=" * 80)
    print(f"Total markets found: {len(ipo_markets)}")
    print("=" * 80)


if __name__ == "__main__":
    demo_kalshi_markets()
