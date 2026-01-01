#!/usr/bin/env python3
"""
Extract and Analyze AI Risk Factor Language from SEC 10-K Filings
Fetches actual Item 1A text from SEC EDGAR and does keyword analysis
"""

import pandas as pd
import requests
import re
import json
import time
from collections import Counter, defaultdict
from datetime import datetime
import concurrent.futures

# SEC EDGAR User Agent (required)
HEADERS = {'User-Agent': 'GovernanceIQ Research tanya@governanceiq.com'}

# AI-related keywords to search for
AI_KEYWORDS = {
    'core_ai': ['artificial intelligence', 'machine learning', 'deep learning', 'neural network', 
                'generative ai', 'large language model', 'llm', 'ai model', 'ai system'],
    'ai_tech': ['natural language processing', 'nlp', 'computer vision', 'robotics', 
                'autonomous', 'automation', 'algorithm', 'predictive analytics'],
    'ai_risk': ['hallucination', 'model accuracy', 'bias', 'ai regulation', 'ai governance',
                'ai safety', 'responsible ai', 'explainability', 'ai ethics'],
    'ai_infra': ['gpu', 'nvidia', 'training data', 'compute', 'data center'],
    'ai_regulation': ['eu ai act', 'ai legislation', 'ai compliance', 'algorithmic accountability']
}

def get_10k_filing_url(cik: str) -> dict:
    """Get the most recent 10-K filing URL for a company"""
    cik_padded = str(cik).zfill(10)
    url = f"https://data.sec.gov/submissions/CIK{cik_padded}.json"
    
    try:
        response = requests.get(url, headers=HEADERS, timeout=15)
        if response.status_code != 200:
            return None
        
        data = response.json()
        filings = data.get('filings', {}).get('recent', {})
        
        forms = filings.get('form', [])
        accession_numbers = filings.get('accessionNumber', [])
        primary_docs = filings.get('primaryDocument', [])
        
        for i, form in enumerate(forms):
            if form == '10-K':
                accession = accession_numbers[i].replace('-', '')
                doc = primary_docs[i]
                return {
                    'cik': cik,
                    'accession': accession_numbers[i],
                    'doc': doc,
                    'url': f"https://www.sec.gov/Archives/edgar/data/{cik}/{accession}/{doc}"
                }
        return None
    except:
        return None

def extract_risk_factors(url: str) -> str:
    """Extract Item 1A Risk Factors text from a 10-K filing"""
    try:
        response = requests.get(url, headers=HEADERS, timeout=30)
        if response.status_code != 200:
            return ""
        
        text = response.text
        
        # Try to find Item 1A section
        # Common patterns: "Item 1A", "ITEM 1A", "Item&nbsp;1A"
        patterns = [
            r'(?i)item\s*1a[.\s]*risk\s*factors(.*?)(?:item\s*1b|item\s*2[.\s])',
            r'(?i)RISK\s*FACTORS(.*?)(?:UNRESOLVED\s*STAFF|PROPERTIES)',
        ]
        
        for pattern in patterns:
            match = re.search(pattern, text, re.DOTALL)
            if match:
                risk_text = match.group(1)
                # Clean HTML tags
                risk_text = re.sub(r'<[^>]+>', ' ', risk_text)
                # Clean extra whitespace
                risk_text = re.sub(r'\s+', ' ', risk_text)
                return risk_text[:100000]  # Limit size
        
        return ""
    except Exception as e:
        return ""

def analyze_text_for_ai(text: str) -> dict:
    """Analyze text for AI-related keywords"""
    text_lower = text.lower()
    results = {
        'has_ai_disclosure': False,
        'keyword_counts': {},
        'category_counts': {},
        'ai_sentences': []
    }
    
    total_ai_mentions = 0
    
    for category, keywords in AI_KEYWORDS.items():
        category_count = 0
        for keyword in keywords:
            count = text_lower.count(keyword)
            if count > 0:
                results['keyword_counts'][keyword] = count
                category_count += count
                total_ai_mentions += count
        results['category_counts'][category] = category_count
    
    results['has_ai_disclosure'] = total_ai_mentions > 0
    results['total_ai_mentions'] = total_ai_mentions
    
    # Extract sample sentences containing AI keywords
    sentences = re.split(r'[.!?]', text)
    ai_sentences = []
    for sent in sentences[:500]:  # Check first 500 sentences
        sent_lower = sent.lower()
        for keyword in AI_KEYWORDS['core_ai']:
            if keyword in sent_lower and len(sent) > 50:
                ai_sentences.append(sent.strip()[:300])
                break
        if len(ai_sentences) >= 5:
            break
    results['ai_sentences'] = ai_sentences
    
    return results

def process_company(row):
    """Process a single company"""
    cik = row['cik']
    ticker = row['ticker']
    name = row['name']
    
    filing = get_10k_filing_url(cik)
    if not filing:
        return {
            'ticker': ticker,
            'name': name,
            'status': 'no_filing',
            'has_ai_disclosure': False
        }
    
    risk_text = extract_risk_factors(filing['url'])
    if not risk_text:
        return {
            'ticker': ticker,
            'name': name,
            'status': 'no_risk_section',
            'has_ai_disclosure': False
        }
    
    analysis = analyze_text_for_ai(risk_text)
    
    return {
        'ticker': ticker,
        'name': name,
        'status': 'analyzed',
        'has_ai_disclosure': analysis['has_ai_disclosure'],
        'total_ai_mentions': analysis.get('total_ai_mentions', 0),
        'category_counts': analysis['category_counts'],
        'top_keywords': dict(sorted(analysis['keyword_counts'].items(), key=lambda x: x[1], reverse=True)[:10]),
        'sample_sentences': analysis['ai_sentences'][:3]
    }

def main():
    print("="*70)
    print("SEC 10-K AI RISK FACTOR LANGUAGE ANALYSIS")
    print("Extracting actual risk factor text from 1,000 companies")
    print("="*70)
    
    # Load company data
    df = pd.read_csv('sec_risk_data_v2.csv')
    print(f"\nLoaded {len(df)} companies from database")
    
    # Take first 1000 companies
    df = df.head(1000)
    print(f"Processing {len(df)} companies...")
    
    # Process companies
    results = []
    companies_with_ai = 0
    total_ai_mentions = 0
    keyword_totals = Counter()
    category_totals = Counter()
    
    start_time = time.time()
    
    for i, (_, row) in enumerate(df.iterrows()):
        if i % 50 == 0:
            elapsed = time.time() - start_time
            rate = (i+1) / elapsed if elapsed > 0 else 0
            remaining = (len(df) - i) / rate if rate > 0 else 0
            print(f"  Processing {i+1}/{len(df)}... ({rate:.1f}/sec, ~{remaining:.0f}s remaining)")
        
        result = process_company(row)
        results.append(result)
        
        if result.get('has_ai_disclosure'):
            companies_with_ai += 1
            total_ai_mentions += result.get('total_ai_mentions', 0)
            
            for keyword, count in result.get('top_keywords', {}).items():
                keyword_totals[keyword] += count
            
            for category, count in result.get('category_counts', {}).items():
                category_totals[category] += count
        
        # Rate limit to avoid SEC throttling
        time.sleep(0.15)
    
    elapsed = time.time() - start_time
    
    # Generate summary
    print("\n" + "="*70)
    print("ANALYSIS COMPLETE")
    print("="*70)
    
    analyzed = sum(1 for r in results if r['status'] == 'analyzed')
    print(f"\nCompanies processed: {len(results)}")
    print(f"Successfully analyzed: {analyzed}")
    print(f"Time elapsed: {elapsed:.1f} seconds")
    
    print(f"\n--- AI DISCLOSURE STATISTICS ---")
    print(f"Companies with AI disclosures: {companies_with_ai} ({companies_with_ai/analyzed*100:.1f}%)")
    print(f"Total AI-related mentions: {total_ai_mentions:,}")
    
    print(f"\n--- TOP AI KEYWORDS ACROSS ALL COMPANIES ---")
    for keyword, count in keyword_totals.most_common(20):
        print(f"  '{keyword}': {count} mentions")
    
    print(f"\n--- CATEGORY BREAKDOWN ---")
    for category, count in sorted(category_totals.items(), key=lambda x: x[1], reverse=True):
        print(f"  {category}: {count} mentions")
    
    # Find companies with most AI mentions
    print(f"\n--- TOP 20 COMPANIES BY AI DISCLOSURE DEPTH ---")
    ai_companies = [r for r in results if r.get('total_ai_mentions', 0) > 0]
    ai_companies.sort(key=lambda x: x.get('total_ai_mentions', 0), reverse=True)
    
    for r in ai_companies[:20]:
        print(f"  {r['ticker']}: {r.get('total_ai_mentions', 0)} mentions")
        if r.get('sample_sentences'):
            print(f"    Sample: \"{r['sample_sentences'][0][:100]}...\"")
    
    # Save detailed results
    output = {
        'analysis_date': datetime.now().isoformat(),
        'companies_analyzed': analyzed,
        'companies_with_ai_disclosure': companies_with_ai,
        'ai_disclosure_rate': round(companies_with_ai/analyzed*100, 1) if analyzed > 0 else 0,
        'total_ai_mentions': total_ai_mentions,
        'top_keywords': dict(keyword_totals.most_common(50)),
        'category_breakdown': dict(category_totals),
        'top_disclosing_companies': [
            {
                'ticker': r['ticker'],
                'name': r['name'],
                'mentions': r.get('total_ai_mentions', 0),
                'top_keywords': r.get('top_keywords', {}),
                'sample_language': r.get('sample_sentences', [])
            }
            for r in ai_companies[:50]
        ]
    }
    
    with open('ai_risk_language_detailed.json', 'w') as f:
        json.dump(output, f, indent=2)
    print(f"\n✓ Detailed results saved to ai_risk_language_detailed.json")
    
    # Generate markdown report
    report = f"""# AI Risk Factor Language Analysis
## Actual 10-K Text Extraction Results

**Analysis Date:** {datetime.now().strftime('%Y-%m-%d')}
**Companies Analyzed:** {analyzed:,}
**Processing Time:** {elapsed:.1f} seconds

---

## Key Findings

### AI Disclosure Rate

- **{companies_with_ai}** companies ({companies_with_ai/analyzed*100:.1f}%) include AI-related risk disclosures
- **{total_ai_mentions:,}** total AI-related keyword mentions across all filings

### Most Common AI Keywords in Risk Factors

| Rank | Keyword | Mentions |
|------|---------|----------|
"""
    
    for i, (keyword, count) in enumerate(keyword_totals.most_common(15), 1):
        report += f"| {i} | {keyword} | {count} |\n"
    
    report += f"""
### Category Breakdown

| Category | Total Mentions |
|----------|----------------|
"""
    
    for category, count in sorted(category_totals.items(), key=lambda x: x[1], reverse=True):
        report += f"| {category.replace('_', ' ').title()} | {count} |\n"
    
    report += f"""
---

## Top Companies by AI Disclosure Depth

| Ticker | Company | AI Mentions |
|--------|---------|-------------|
"""
    
    for r in ai_companies[:25]:
        name_short = r['name'][:35] + '...' if len(r['name']) > 35 else r['name']
        report += f"| {r['ticker']} | {name_short} | {r.get('total_ai_mentions', 0)} |\n"
    
    report += """
---

## Sample Disclosure Language

"""
    
    for r in ai_companies[:10]:
        if r.get('sample_sentences'):
            report += f"### {r['ticker']} ({r['name'][:30]})\n\n"
            report += f"> {r['sample_sentences'][0][:300]}...\n\n"
    
    report += """
---

*Analysis based on actual Item 1A (Risk Factors) text extracted from SEC 10-K filings.*
*Generated by GovernanceIQ Research*
"""
    
    with open('AI_Risk_Language_Detailed_Report.md', 'w') as f:
        f.write(report)
    print(f"✓ Report saved to AI_Risk_Language_Detailed_Report.md")

if __name__ == "__main__":
    main()
