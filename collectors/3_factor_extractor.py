import os
import sys
from datetime import datetime
from supabase import create_client, Client, ClientOptions
import toml
import logging

# Add parent directory to path for imports
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from collectors.sec_filing_parser import SECFilingParser

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Load secrets
try:
    try:
        secrets = toml.load(".streamlit/secrets.toml")
    except FileNotFoundError:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

if not url or not key:
    logger.error("Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema="vendor_governance")
supabase: Client = create_client(url, key, options=options)

def run(limit: int = None, test_mode: bool = False):
    """
    Extract real governance and risk factors from SEC filings.
    
    Args:
        limit: Max number of companies to process (for testing)
        test_mode: If True, only process first 5 companies
    """
    logger.info("🚀 Starting Real Factor Extraction from SEC filings...")
    
    # Initialize parser
    parser = SECFilingParser()
    
    # Get companies that already have risk factors (to skip them)
    logger.info("📋 Checking which companies already have risk factors...")
    existing = supabase.table('company_risk_factors').select('company_id').execute()
    existing_company_ids = set(record['company_id'] for record in existing.data)
    logger.info(f"   Found {len(existing_company_ids)} companies already processed")
    
    # Fetch companies that are Public and have CIK numbers
    query = supabase.table('companies') \
        .select('id, company_name, cik, primary_sector') \
        .eq('listing_type', 'Public') \
        .not_.is_('cik', 'null')
    
    if limit:
        query = query.limit(limit * 2)  # Get more to account for already-processed
    
    response = query.execute()
    all_companies = response.data
    
    # Filter out companies that already have risk factors
    companies = [c for c in all_companies if c['id'] not in existing_company_ids]
    
    if not companies:
        logger.info("✅ All companies already processed!")
        return
    
    if test_mode:
        companies = companies[:5]
        logger.info(f"🧪 TEST MODE: Processing only {len(companies)} companies")
    else:
        logger.info(f"📊 Processing {len(companies)} new companies (skipping {len(existing_company_ids)} already done)...")

    
    factors_list = []
    success_count = 0
    partial_count = 0
    failed_count = 0
    
    for i, company in enumerate(companies, 1):
        logger.info(f"[{i}/{len(companies)}] Processing: {company['company_name']}")
        
        try:
            # Extract all factors from SEC filings
            factors = parser.extract_all_factors(
                cik=company['cik'],
                company_name=company['company_name']
            )
            
            # Set company_id
            factors['company_id'] = company['id']
            
            # Count how many fields were successfully extracted
            non_null_fields = sum(1 for v in factors.values() if v is not None)
            total_fields = len(factors)
            
            if non_null_fields > 5:  # At least some data extracted
                factors_list.append(factors)
                if non_null_fields > total_fields * 0.5:
                    success_count += 1
                    logger.info(f"  ✅ Extracted {non_null_fields}/{total_fields} fields")
                else:
                    partial_count += 1
                    logger.warning(f"  ⚠️  Partial extraction: {non_null_fields}/{total_fields} fields")
            else:
                failed_count += 1
                logger.warning(f"  ❌ Failed to extract meaningful data")
        
        except Exception as e:
            failed_count += 1
            logger.error(f"  ❌ Error processing {company['company_name']}: {e}")
        
        # Save progress every 50 companies
        if len(factors_list) >= 50:
            save_batch(factors_list)
            factors_list = []
    
    # Save remaining factors
    if factors_list:
        save_batch(factors_list)
    
    # Print summary
    logger.info("\n" + "="*60)
    logger.info("📈 EXTRACTION SUMMARY")
    logger.info("="*60)
    logger.info(f"✅ Successfully extracted: {success_count}")
    logger.info(f"⚠️  Partially extracted:   {partial_count}")
    logger.info(f"❌ Failed:                {failed_count}")
    logger.info(f"📊 Total processed:       {len(companies)}")
    logger.info(f"🎯 Success rate:          {(success_count/len(companies)*100):.1f}%")
    logger.info("="*60)

def save_batch(factors_list):
    """Save a batch of factors to database"""
    if not factors_list:
        return
    
    try:
        supabase.table('company_risk_factors').upsert(
            factors_list, 
            on_conflict='company_id,fiscal_year'
        ).execute()
        logger.info(f"  💾 Saved batch of {len(factors_list)} companies")
    except Exception as e:
        logger.error(f"  ❌ Error saving batch: {e}")
        # Try saving one by one
        for factors in factors_list:
            try:
                supabase.table('company_risk_factors').upsert(
                    factors,
                    on_conflict='company_id,fiscal_year'
                ).execute()
            except Exception as e2:
                logger.error(f"  ❌ Failed to save {factors.get('company_id')}: {e2}")

if __name__ == "__main__":
    import argparse
    
    parser_cli = argparse.ArgumentParser(description='Extract governance & risk factors from SEC filings')
    parser_cli.add_argument('--test', action='store_true', help='Test mode: process only 5 companies')
    parser_cli.add_argument('--limit', type=int, help='Limit number of companies to process')
    
    args = parser_cli.parse_args()
    
    run(limit=args.limit, test_mode=args.test)
