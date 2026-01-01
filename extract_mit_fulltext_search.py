#!/usr/bin/env python3
"""
SEC EDGAR Full-Text Search with MIT Keywords
Uses the EDGAR full-text search API to find AI risk mentions directly
"""

import requests
import pandas as pd
import json
import time
from datetime import datetime

HEADERS = {
    "User-Agent": "Tanya Matanda tanya@governanceiq.io",
    "Accept": "application/json"
}

# All keywords organized by category
KEYWORDS_BY_CATEGORY = {
    'AI/ML Generic': ['artificial intelligence', 'machine learning', 'deep learning', 'neural network'],
    'LLM/GenAI': ['llm', 'large language model', 'generative ai', 'chatgpt', 'gpt-4', 'gpt-3'],
    'Infrastructure': ['compute capacity', 'gpu', 'data center', 'nvidia', 'cloud computing'],
    'Model Performance': ['hallucination', 'hallucinate', 'model accuracy', 'model failure', 'false positive'],
    'Training Data/IP': ['training data', 'data provenance', 'copyrighted content', 'licensed data'],
    'Bias/Fairness': ['algorithmic bias', 'ai bias', 'fairness', 'discrimination', 'disparate impact'],
    'Regulatory': ['eu ai act', 'ai act', 'ai regulation', 'algorithmic accountability'],
    'MIT4-Malicious Use': ['adversarial attack', 'jailbreak', 'prompt injection', 'ai misuse', 'dual-use'],
    'MIT5-Human Interaction': ['automation bias', 'human oversight', 'overreliance', 'ai manipulation', 'disinformation'],
    'MIT6-Socioeconomic': ['job displacement', 'workforce disruption', 'ai monopoly', 'power concentration'],
    'MIT6-Environmental': ['carbon footprint', 'energy consumption', 'environmental impact', 'data center energy'],
    'MIT7-AI Safety': ['ai alignment', 'goal misalignment', 'autonomous ai', 'agentic ai', 'emergent behavior'],
}

def search_edgar_fulltext(query, form_type="10-K"):
    """Search SEC EDGAR full-text for a specific query"""
    url = "https://efts.sec.gov/LATEST/search-index"
    
    params = {
        "q": f'"{query}"',
        "dateRange": "custom",
        "startdt": "2024-01-01",
        "enddt": "2025-12-31",
        "forms": form_type,
    }
    
    try:
        response = requests.get(url, params=params, headers=HEADERS, timeout=30)
        response.raise_for_status()
        data = response.json()
        
        total_hits = data.get('hits', {}).get('total', {}).get('value', 0)
        return total_hits
        
    except Exception as e:
        print(f"  Error searching for '{query}': {e}")
        return 0

def main():
    print("="*70)
    print("SEC EDGAR Full-Text Search - AI Risk Keyword Analysis")
    print("="*70)
    print(f"Start time: {datetime.now()}")
    print()
    
    results = []
    
    # Search for each keyword
    for category, keywords in KEYWORDS_BY_CATEGORY.items():
        print(f"\n[{category}]")
        
        for keyword in keywords:
            count = search_edgar_fulltext(keyword)
            print(f"  '{keyword}': {count} filings")
            
            results.append({
                'category': category,
                'keyword': keyword,
                'filing_count': count,
                'as_of_date': '2025-12-31',
                'form_type': '10-K'
            })
            
            time.sleep(0.2)  # Rate limiting
    
    # Save results
    print("\n" + "="*70)
    print("Saving results...")
    
    df = pd.DataFrame(results)
    df.to_csv('140x_MIT_Keyword_Results.csv', index=False)
    print("Saved: 140x_MIT_Keyword_Results.csv")
    
    # Create summary by category
    summary = df.groupby('category').agg({
        'filing_count': ['sum', 'max', 'mean']
    }).round(1)
    
    print("\n=== SUMMARY BY CATEGORY ===\n")
    for category in KEYWORDS_BY_CATEGORY.keys():
        cat_data = df[df['category'] == category]
        total = cat_data['filing_count'].sum()
        max_kw = cat_data.loc[cat_data['filing_count'].idxmax(), 'keyword'] if len(cat_data) > 0 and cat_data['filing_count'].max() > 0 else 'N/A'
        max_val = cat_data['filing_count'].max()
        print(f"{category}:")
        print(f"  Total mentions: {total}")
        print(f"  Top keyword: '{max_kw}' ({max_val} filings)")
        print()
    
    # Save summary JSON
    summary_json = {
        'extraction_date': datetime.now().isoformat(),
        'form_type': '10-K',
        'date_range': '2024-01-01 to 2025-12-31',
        'categories': {}
    }
    
    for category in KEYWORDS_BY_CATEGORY.keys():
        cat_data = df[df['category'] == category]
        summary_json['categories'][category] = {
            'total_filings': int(cat_data['filing_count'].sum()),
            'keywords': {
                row['keyword']: row['filing_count'] 
                for _, row in cat_data.iterrows()
            }
        }
    
    with open('140x_MIT_Keyword_Summary.json', 'w') as f:
        json.dump(summary_json, f, indent=2)
    print("Saved: 140x_MIT_Keyword_Summary.json")
    
    print("\n" + "="*70)
    print("EXTRACTION COMPLETE")
    print("="*70)
    print(f"End time: {datetime.now()}")

if __name__ == "__main__":
    main()
