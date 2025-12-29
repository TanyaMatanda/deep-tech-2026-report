"""
Kalshi Market Sync Collector
Syncs prediction markets from Kalshi to database for tracking

Run periodically (e.g., hourly) to keep market data fresh
"""

import os
import sys
sys.path.append(os.path.dirname(__file__))

from kalshi_client import KalshiClient
from supabase import create_client, ClientOptions
import toml
from datetime import datetime
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class KalshiMarketSync:
    """Sync Kalshi markets to database"""
    
    def __init__(self):
        """Initialize with Supabase and Kalshi clients"""
        # Supabase
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
        
        # Kalshi
        self.kalshi = KalshiClient()
        
        logger.info("✓ Initialized Kalshi Market Sync")
    
    def find_company_by_name(self, company_name: str):
        """Try to match company name to database"""
        try:
            # Simple name matching
            result = self.supabase.table('companies')\
                .select('id, company_name, ticker_symbol')\
                .ilike('company_name', f'%{company_name}%')\
                .limit(1)\
                .execute()
            
            if result.data:
                return result.data[0]
            return None
        except Exception as e:
            logger.warning(f"Error finding company {company_name}: {e}")
            return None
    
    def sync_market(self, market: dict) -> bool:
        """Sync single market to database"""
        try:
            ticker = market.get('ticker')
            if not ticker:
                return False
            
            # Classify event type
            event_type = self.kalshi.classify_market(market)
            
            # Try to extract company name from title
            title = market.get('title', '')
            company_id = None
            
            # Simple extraction - look for known company names
            # This is basic - could be enhanced with NER
            for word in title.split():
                company = self.find_company_by_name(word)
                if company:
                    company_id = company['id']
                    break
            
            # Get current price/probability
            orderbook = self.kalshi.get_market_orderbook(ticker)
            yes_price = None
            no_price = None
            
            if orderbook:
                # Get best bid prices
                yes_bids = orderbook.get('yes', [])
                no_bids = orderbook.get('no', [])
                
                if yes_bids:
                    yes_price = yes_bids[0].get('price', 0) / 100  # Convert cents to decimal
                if no_bids:
                    no_price = no_bids[0].get('price', 0) / 100
            
            # Prepare market data
            market_data = {
                'market_ticker': ticker,
                'event_ticker': market.get('event_ticker'),
                'series_ticker': market.get('series_ticker'),
                'event_type': event_type,
                'question': title,
                'description': market.get('subtitle', ''),
                'yes_price': yes_price,
                'no_price': no_price,
                'yes_probability': yes_price if yes_price else None,
                'status': market.get('status', 'active'),
                'closes_at': market.get('close_time'),
                'company_id': company_id,
                'last_updated': datetime.now().isoformat()
            }
            
            # Upsert (insert or update)
            result = self.supabase.table('kalshi_predictions')\
                .upsert(market_data, on_conflict='market_ticker')\
                .execute()
            
            logger.info(f"✓ Synced market: {title[:60]}...")
            
            # Store price snapshot in history
            if yes_price is not None:
                price_snapshot = {
                    'market_ticker': ticker,
                    'yes_price': yes_price,
                    'no_price': no_price if no_price else (1 - yes_price),
                    'snapshot_at': datetime.now().isoformat()
                }
                
                self.supabase.table('kalshi_price_history')\
                    .insert(price_snapshot)\
                    .execute()
            
            return True
            
        except Exception as e:
            logger.error(f"Error syncing market {market.get('ticker')}: {e}")
            return False
    
    def sync_all_markets(self) -> dict:
        """Sync all corporate event markets"""
        logger.info("=" * 70)
        logger.info("KALSHI MARKET SYNC")
        logger.info("=" * 70)
        
        # Get corporate markets
        markets = self.kalshi.get_corporate_markets()
        
        synced = 0
        failed = 0
        
        for market in markets:
            if self.sync_market(market):
                synced += 1
            else:
                failed += 1
        
        stats = {
            'markets_found': len(markets),
            'synced': synced,
            'failed': failed
        }
        
        logger.info(f"\n✅ Sync complete:")
        logger.info(f"   Found: {len(markets)} markets")
        logger.info(f"   Synced: {synced}")
        logger.info(f"   Failed: {failed}")
        logger.info("=" * 70 + "\n")
        
        return stats


def main():
    """Run market sync"""
    sync = KalshiMarketSync()
    sync.sync_all_markets()


if __name__ == "__main__":
    main()
