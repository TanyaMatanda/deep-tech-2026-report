#!/usr/bin/env python3
"""
SEC 10-K Risk Factor Extraction - PRODUCTION VERSION
Uses validated methodology: sec-edgar-downloader + BeautifulSoup + smart Item 1A detection

Author: Tanya Matanda
Date: January 1, 2026
Validated on: Apple Inc. (AAPL) - successfully extracted 6 AI mentions
"""

from sec_edgar_downloader import Downloader
from bs4 import BeautifulSoup
import pandas as pd
import json
import re
import time
from datetime import datetime
import os
from collections import Counter

# AI Keywords organized by category
AI_KEYWORDS = {
    'core_ai': ['artificial intelligence', 'machine learning', 'deep learning', 'neural network', 
                'generative ai', 'large language model', 'llm', 'ai model', 'ai system'],
    'ai_tech': ['natural language processing', 'nlp', 'computer vision', 'robotics', 
                'autonomous', 'automation', 'algorithm', 'predictive analytics'],
    'ai_risk': ['hallucination', 'model accuracy', 'bias', 'ai regulation', 'ai governance',
                'ai safety', 'responsible ai', 'explainability', 'ai ethics'],
    'ai_infra': ['gpu', 'nvidia', 'training data', 'compute', 'data center'],
    'ai_regulation': ['eu ai act', 'ai legislation', 'ai compliance', 'algorithmic accountability'],
    'mit4_malicious': ['adversarial', 'jailbreak', 'prompt injection', 'misuse', 'dual-use', 
                       'weaponiz', 'cyberattack'],
    'mit5_human': ['automation bias', 'human oversight', 'overreliance', 'over-reliance',
                   'human-in-the-loop', 'manipulation', 'disinformation', 'misinformation'],
    'mit6_socio': ['job displacement', 'workforce displacement', 'labor disruption', 
                   'power concentration', 'monopol'],
    'mit6_environ': ['carbon footprint', 'energy consumption', 'environmental impact', 
                     'data center energy', 'sustainability'],
    'mit7_safety': ['ai alignment', 'goal misalignment', 'misalignment', 'agentic', 
                    'ai agent', 'emergent behavior', 'uncontrollable']
}

def extract_item_1a_from_html(html_content: str) -> str:
    """
    Extract Item 1A (Risk Factors) text using BeautifulSoup + smart pattern matching
    
    Key insight: Skip Table of Contents by using the 2nd occurrence of "Item 1A Risk Factors"
    """
    # Parse HTML and extract text
    soup = BeautifulSoup(html_content, 'lxml')
    full_text = soup.get_text(separator=' ', strip=True)
    
    # Find all occurrences of "Item 1A Risk Factors"
    item_1a_matches = list(re.finditer(r'(?i)Item\s+1A[\.\s]*Risk\s+Factors', full_text))
    
    if len(item_1a_matches) == 0:
        return ""
    
    # Use the last occurrence (most likely the actual section, not TOC)
    actual_section = None
    for match in item_1a_matches:
        # Check if this looks like the actual section (not TOC)
        remaining = full_text[match.end():match.end()+500]
        # TOC has many "Item X" references close together
        other_items_nearby = len(re.findall(r'(?i)Item\s+\d', remaining[:200]))
        
        if other_items_nearby <= 1:
            actual_section = match
            break
    
    if not actual_section:
        # Fallback: use the last occurrence
        actual_section = item_1a_matches[-1]
    
    start_pos = actual_section.end()
    
    # Find where Item 1A ends (Item 1B or Item 2)
    end_patterns = [
        r'(?i)Item\s+1B',
        r'(?i)Item\s+2[\.\s]',
    ]
    
    end_pos = len(full_text)
    for pattern in end_patterns:
        match = re.search(pattern, full_text[start_pos:])
        if match:
            end_pos = start_pos + match.start()
            break
    
    risk_text = full_text[start_pos:end_pos].strip()
    
    # Sanity check - Item 1A should be substantial
    if len(risk_text) < 500:
        return ""
    
    return risk_text

def count_keywords(text: str) -> dict:
    """Count all keywords in text"""
    text_lower = text.lower()
    results = {
        'keyword_counts': {},
        'category_totals': {},
        'total_ai_mentions': 0
    }
    
    for category, keywords in AI_KEYWORDS.items():
        category_total = 0
        for keyword in keywords:
            count = text_lower.count(keyword)
            if count > 0:
                results['keyword_counts'][keyword] = count
                category_total += count
        results['category_totals'][category] = category_total
    
    results['total_ai_mentions'] = sum(results['category_totals'].values())
    
    return results

def process_company(ticker: str, cik: str, name: str, downloader: Downloader) -> dict:
    """Process a single company's 10-K"""
    try:
        # Download the 10-K
        downloader.get("10-K", ticker, limit=1, download_details=True)
        time.sleep(0.2)  # Rate limiting
        
        # Find the downloaded file
        import glob
        files = glob.glob(f"sec-edgar-filings/{ticker}/10-K/*/primary-document.html")
        
        if not files:
            return {
                'ticker': ticker,
                'cik': cik,
                'name': name,
                'status': 'no_filing',
                'has_ai_disclosure': False,
                'total_ai_mentions': 0
            }
        
        # Read and extract
        with open(files[0], 'r', encoding='utf-8', errors='ignore') as f:
            html_content = f.read()
        
        risk_text = extract_item_1a_from_html(html_content)
        
        if not risk_text:
            return {
                'ticker': ticker,
                'cik': cik,
                'name': name,
                'status': 'no_risk_section',
                'has_ai_disclosure': False,
                'total_ai_mentions': 0
            }
        
        # Count keywords
        analysis = count_keywords(risk_text)
        
        result = {
            'ticker': ticker,
            'cik': cik,
            'name': name,
            'status': 'analyzed',
            'has_ai_disclosure': analysis['total_ai_mentions'] > 0,
            'total_ai_mentions': analysis['total_ai_mentions'],
            'risk_text_length': len(risk_text)
        }
        
        # Add category counts
        for cat, count in analysis['category_totals'].items():
            result[f'cat_{cat}'] = count
        
        # Add top 10 keywords
        top_keywords = sorted(analysis['keyword_counts'].items(), 
                             key=lambda x: x[1], reverse=True)[:15]
        for kw, count in top_keywords:
            result[f'kw_{kw.replace(" ", "_")}'] = count
        
        return result
        
    except Exception as e:
        return {
            'ticker': ticker,
            'cik': cik,
            'name': name,
            'status': f'error: {str(e)[:100]}',
            'has_ai_disclosure': False,
            'total_ai_mentions': 0
        }

def main():
    print("="*70)
    print("SEC 10-K RISK FACTOR EXTRACTION - FINAL PRODUCTION RUN")
    print("="*70)
    print(f"Start time: {datetime.now()}")
    print()
    
    # Load company list
    companies_df = pd.read_csv('sec_risk_data_v2.csv')
    print(f"Loaded {len(companies_df)} companies")
    
    # Check for existing results to resume
    output_file = 'SEC_AI_Extraction_FINAL.csv'
    processed_tickers = set()
    results = []
    
    if os.path.exists(output_file):
        try:
            existing_df = pd.read_csv(output_file)
            processed_tickers = set(existing_df['ticker'])
            results = existing_df.to_dict('records')
            print(f"RESUMING: Found {len(processed_tickers)} already processed companies")
        except Exception as e:
            print(f"Could not read existing results: {e}")
            
    print()
    
    # Initialize downloader
    dl = Downloader("GovernanceIQ", "tanya@governanceiq.com")
    
    # Process all companies
    start_time = time.time()
    
    for idx, row in companies_df.iterrows():
        ticker = row['ticker']
        
        # Skip if already processed
        if ticker in processed_tickers:
            continue
            
        cik = str(row['cik'])
        name = row['name']
        
        # Calculate progress stats
        processed_count = len(results)
        if processed_count > 0 and processed_count % 10 == 0:
            elapsed = time.time() - start_time
            # Only count new items for rate
            current_session_items = processed_count - len(processed_tickers)
            if current_session_items > 0:
                rate = current_session_items / elapsed
                remaining = (len(companies_df) - processed_count) / rate
                print(f"[{processed_count}/{len(companies_df)}] {ticker} - {rate:.2f} companies/sec (current session), ~{remaining/60:.1f} min remaining")
            else:
                 print(f"[{processed_count}/{len(companies_df)}] {ticker} - Resuming...")

        result = process_company(ticker, cik, name, dl)
        results.append(result)
        
        # Save incrementally every 20 companies
        if len(results) % 20 == 0:
            pd.DataFrame(results).to_csv(output_file, index=False)
            # print(f"  ✓ Checkpoint saved ({len(results)} companies)")
    
    # Save final results
    print("\n" + "="*70)
    print("SAVING FINAL RESULTS")
    print("="*70)
    
    results_df = pd.DataFrame(results)
    results_df.to_csv(output_file, index=False)
    print(f"✓ Saved: SEC_AI_Extraction_FINAL.csv ({len(results_df)} companies)")
    
    # Summary statistics
    summary = {
        'extraction_date': datetime.now().isoformat(),
        'total_companies': len(results),
        'successfully_analyzed': results_df[results_df['status'] == 'analyzed'].shape[0],
        'companies_with_ai': results_df[results_df['has_ai_disclosure'] == True].shape[0],
        'ai_disclosure_rate': round(results_df[results_df['has_ai_disclosure'] == True].shape[0] / 
                                     results_df[results_df['status'] == 'analyzed'].shape[0] * 100, 1),
        'total_ai_mentions': results_df['total_ai_mentions'].sum(),
        'methodology': 'sec-edgar-downloader + BeautifulSoup + smart Item 1A detection'
    }
    
    with open('SEC_AI_Extraction_FINAL_Summary.json', 'w') as f:
        json.dump(summary, f, indent=2)
    
    print(f"✓ Saved: SEC_AI_Extraction_FINAL_Summary.json")
    print()
    print("="*70)
    print("EXTRACTION COMPLETE")
    print("="*70)
    print(f"End time: {datetime.now()}")
    print(f"Total time: {(time.time() - start_time)/60:.1f} minutes")
    print(f"Companies analyzed: {summary['successfully_analyzed']}")
    print(f"AI disclosure rate: {summary['ai_disclosure_rate']}%")

if __name__ == "__main__":
    main()
