#!/usr/bin/env python3
"""Quick test of SEDAR extraction on CGI Inc. (pure Canadian TSX company)"""

import sys
sys.path.insert(0, '/Users/tanyamatanda/Desktop/Proxy Season 2026/collectors')

from extract_comp_sedar_browser import SEDARBrowserExtractor
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Test with CGI Inc - major Canadian tech company
extractor = SEDARBrowserExtractor(headless=False)

try:
    result = extractor.process_company(
        company_id='test_cgi',
        company_name='CGI Inc.'
    )
    
    logger.info(f"\n{'='*60}")
    logger.info("TEST RESULT:")
    logger.info(f"Status: {result}")
    logger.info(f"{'='*60}")
    
finally:
    extractor.close()
