"""
Proprietary Risk Scores Sync
Calculate and store M&A probabilities for all companies
"""

import sys
import os

# Add paths
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'dashboard'))
sys.path.insert(0, os.path.dirname(__file__))

from ma_probability import MASignalDetector
from datetime import datetime
import logging
import toml
from supabase import create_client, ClientOptions

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def get_supabase():
    """Initialize Supabase connection"""
    try:
        secrets_path = os.path.join(os.path.dirname(__file__), '..', 'dashboard', '.streamlit', 'secrets.toml')
        secrets = toml.load(secrets_path)
        url = secrets['SUPABASE_URL']
        key = secrets['SUPABASE_KEY']
    except:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")
    
    if not url or not key:
        raise ValueError("Supabase credentials not found")
    
    options = ClientOptions(schema='vendor_governance')
    return create_client(url, key, options=options)


def sync_ma_scores(limit: int = 100):
    """Calculate M&A scores for companies and store in database"""
    
    supabase = get_supabase()
    detector = MASignalDetector(supabase)
    
    # Get companies with governance data (higher priority)
    result = supabase.table('company_risk_factors')\
        .select('company_id, companies!inner(company_name)')\
        .limit(limit)\
        .execute()
    
    if not result.data:
        logger.warning("No companies found with governance data")
        return
    
    synced = 0
    for item in result.data:
        try:
            company_id = item['company_id']
            company_name = item['companies']['company_name']
            
            # Calculate M&A probability
            ma_result = detector.calculate_ma_probability(company_id)
            
            # Store in database
            data = {
                'company_id': company_id,
                'score_date': datetime.now().date().isoformat(),
                'ma_probability': ma_result['score'],
                'ma_signals': ma_result['signals'],
                'last_updated': datetime.now().isoformat(),
                'model_version': 'v1.0'
            }
            
            supabase.table('proprietary_risk_scores')\
                .upsert(data, on_conflict='company_id,score_date')\
                .execute()
            
            synced += 1
            if ma_result['score'] > 20:
                logger.info(f"✓ {company_name}: M&A {ma_result['score']:.0f}/100 ({ma_result['confidence']} confidence)")
            
        except Exception as e:
            logger.error(f"Error syncing {company_name}: {e}")
    
    logger.info(f"\n✅ Sync complete: {synced} companies scored")
    return synced


if __name__ == "__main__":
    # Sync top 100 companies
    sync_ma_scores(limit=100)
