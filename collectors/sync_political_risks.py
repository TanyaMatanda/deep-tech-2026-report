"""
Enhanced Political Risk Sync
Now includes actual company matching based on sectors
"""

import sys
import os
sys.path.append(os.path.dirname(__file__))

from polymarket_client import PolymarketClient
from political_risk_mapper import PoliticalRiskMapper
from supabase import create_client, ClientOptions
import toml
from datetime import datetime
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class EnhancedPoliticalRiskSync:
    """Sync political risk events with company connections"""
    
    def __init__(self):
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
        
        # Clients
        self.polymarket = PolymarketClient()
        self.mapper = PoliticalRiskMapper()
        
        logger.info("✓ Initialized Enhanced Political Risk Sync")
    
    def get_companies_by_sector(self, sectors: list) -> list:
        """Get company names matching given sectors"""
        if 'All' in sectors:
            # Return top companies across all sectors
            result = self.supabase.table('companies')\
                .select('company_name, primary_sector')\
                .limit(50)\
                .execute()
        else:
            # Get companies in specific sectors
            result = self.supabase.table('companies')\
                .select('company_name, primary_sector')\
                .in_('primary_sector', sectors)\
                .limit(100)\
                .execute()
        
        return [c['company_name'] for c in result.data]
    
    def fetch_political_markets(self) -> list:
        """Fetch political events from Polymarket"""
        return self.polymarket.get_political_markets()
    
    def sync_to_database(self):
        """Sync political risks with company connections"""
        markets = self.fetch_political_markets()
        
        synced = 0
        for market in markets:
            question = market.get('question', '')
            description = market.get('description', '')
            
            # Classify and map to risks
            risk_mappings = self.mapper.classify_political_event(question, description)
            
            if not risk_mappings:
                continue
            
            # Store in database with company links
            for mapping in risk_mappings:
                try:
                    prob = 0.5
                    risk_score = self.mapper.calculate_risk_score(
                        prob,
                        mapping['governance_impact']
                    )
                    
                    # Get actual companies from database
                    affected_companies = self.get_companies_by_sector(
                        mapping['affected_sectors']
                    )
                    
                    data = {
                        'market_ticker': market.get('condition_id'),
                        'event_type': f"Political_{mapping['risk_type']}",
                        'question': question,
                        'description': description,
                        'yes_probability': prob,
                        'status': 'active' if market.get('active') else 'closed',
                        'tags': [mapping['risk_type']] + mapping['affected_sectors'][:3],
                        'supporting_evidence': {
                            'affected_sectors': mapping['affected_sectors'],
                            'affected_companies': affected_companies[:20],  # Top 20
                            'total_companies_affected': len(affected_companies),
                            'governance_impacts': mapping['impact_areas'],
                            'risk_score': risk_score
                        },
                        'last_updated': datetime.now().isoformat()
                    }
                    
                    self.supabase.table('kalshi_predictions')\
                        .upsert(data, on_conflict='market_ticker')\
                        .execute()
                    
                    synced += 1
                    logger.info(f"✓ Synced: {question[:60]}... ({len(affected_companies)} companies)")
                    
                except Exception as e:
                    logger.error(f"Error syncing market: {e}")
        
        logger.info(f"\n✅ Sync complete: {synced} political risk events with company links")
        return synced


def main():
    """Run enhanced political risk sync"""
    sync = EnhancedPoliticalRiskSync()
    sync.sync_to_database()


if __name__ == "__main__":
    main()
