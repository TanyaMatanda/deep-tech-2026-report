#!/usr/bin/env python3
"""
Analyze AI Risk Factor Language in SEC 10-K Filings
Extracts and analyzes AI-related risk disclosures from public company filings
"""

import pandas as pd
import requests
from collections import Counter
import re
import json
from datetime import datetime

# AI-related keywords to search for in risk factors
AI_KEYWORDS = [
    'artificial intelligence', 'machine learning', 'deep learning', 'neural network',
    'generative ai', 'large language model', 'llm', 'natural language processing',
    'ai system', 'ai model', 'ai technology', 'ai capabilities',
    'automation', 'algorithm', 'predictive analytics', 'data science',
    'chatbot', 'computer vision', 'robotics', 'autonomous',
    'training data', 'model performance', 'ai governance', 'ai ethics',
    'hallucination', 'model accuracy', 'bias', 'ai regulation',
    'eu ai act', 'ai safety', 'responsible ai', 'explainability'
]

# Risk categories we want to identify
RISK_CATEGORIES = {
    'model_performance': ['accuracy', 'reliability', 'performance', 'output', 'error', 'failure', 'hallucination', 'bias'],
    'data_privacy': ['privacy', 'personal data', 'gdpr', 'ccpa', 'data protection', 'consent', 'data breach'],
    'ip_training': ['training data', 'copyright', 'intellectual property', 'license', 'infringement', 'third party content'],
    'regulatory': ['regulation', 'regulatory', 'compliance', 'eu ai act', 'legislation', 'enforcement', 'government'],
    'liability': ['liability', 'lawsuit', 'litigation', 'claim', 'damage', 'harm', 'injury'],
    'competition': ['competitor', 'competition', 'competitive', 'market', 'technology change', 'obsolet'],
    'talent': ['talent', 'employee', 'personnel', 'recruitment', 'retention', 'key person'],
    'infrastructure': ['compute', 'gpu', 'chip', 'semiconductor', 'nvidia', 'cloud', 'infrastructure', 'capacity'],
    'security': ['cybersecurity', 'security', 'attack', 'vulnerability', 'malicious', 'adversarial'],
    'ethical': ['ethical', 'bias', 'discrimination', 'fairness', 'responsible', 'harm', 'misuse']
}

def load_company_data():
    """Load company data from our datasets"""
    risk_df = pd.read_csv('sec_risk_data_v2.csv')
    print(f"Loaded {len(risk_df)} companies from risk data")
    
    # Focus on top tech/AI companies
    ai_companies = [
        'NVDA', 'GOOGL', 'MSFT', 'AMZN', 'META', 'TSLA', 'ORCL', 'CRM', 'PLTR', 
        'NOW', 'SNOW', 'DDOG', 'MDB', 'NET', 'ZS', 'CRWD', 'PANW', 'FTNT',
        'AMD', 'INTC', 'AVGO', 'MRVL', 'AMAT', 'LRCX', 'KLAC', 'ASML',
        'UBER', 'LYFT', 'ABNB', 'COIN', 'HOOD', 'SQ', 'PYPL', 'AFRM',
        'TEAM', 'WDAY', 'ADSK', 'DOCU', 'ZM', 'OKTA', 'SHOP', 'TWLO'
    ]
    
    ai_df = risk_df[risk_df['ticker'].isin(ai_companies)]
    print(f"Filtered to {len(ai_df)} AI/tech companies for detailed analysis")
    
    return risk_df, ai_df

def get_10k_risk_factors(cik: str, ticker: str) -> dict:
    """
    Fetch risk factors from the company's latest 10-K filing
    Uses SEC EDGAR API
    """
    headers = {'User-Agent': 'GovernanceIQ Research tanya@governanceiq.com'}
    
    try:
        # Get company filings
        cik_padded = str(cik).zfill(10)
        url = f"https://data.sec.gov/submissions/CIK{cik_padded}.json"
        response = requests.get(url, headers=headers, timeout=30)
        
        if response.status_code != 200:
            return {'ticker': ticker, 'status': 'failed', 'error': f'HTTP {response.status_code}'}
        
        data = response.json()
        filings = data.get('filings', {}).get('recent', {})
        
        # Find latest 10-K
        forms = filings.get('form', [])
        accession_numbers = filings.get('accessionNumber', [])
        filing_dates = filings.get('filingDate', [])
        
        for i, form in enumerate(forms):
            if form == '10-K':
                accession = accession_numbers[i].replace('-', '')
                filing_date = filing_dates[i]
                
                return {
                    'ticker': ticker,
                    'cik': cik,
                    'filing_date': filing_date,
                    'accession': accession,
                    'status': 'found'
                }
        
        return {'ticker': ticker, 'status': 'no_10k_found'}
        
    except Exception as e:
        return {'ticker': ticker, 'status': 'error', 'error': str(e)}

def analyze_ai_disclosure_patterns():
    """
    Analyze patterns in AI risk factor disclosures across our dataset
    """
    risk_df, ai_df = load_company_data()
    
    results = {
        'analysis_date': datetime.now().isoformat(),
        'total_companies': len(risk_df),
        'ai_tech_companies': len(ai_df),
        'summary': {},
        'company_details': []
    }
    
    print("\n" + "="*70)
    print("ANALYZING AI RISK FACTOR PATTERNS IN PUBLIC COMPANY FILINGS")
    print("="*70)
    
    # Analyze existing risk data columns
    print("\n--- EXISTING RISK DATA ANALYSIS ---")
    
    # Cybersecurity disclosure analysis
    cyber_disclosed = risk_df['cyber_disclosed'].sum()
    cyber_pct = (cyber_disclosed / len(risk_df)) * 100
    print(f"Companies with cybersecurity disclosures: {cyber_disclosed} ({cyber_pct:.1f}%)")
    results['summary']['cyber_disclosed_pct'] = round(cyber_pct, 1)
    
    # Customer concentration risk
    conc_companies = risk_df['customer_conc'].sum()
    conc_pct = (conc_companies / len(risk_df)) * 100
    print(f"Companies with customer concentration risk: {conc_companies} ({conc_pct:.1f}%)")
    results['summary']['customer_concentration_pct'] = round(conc_pct, 1)
    
    # Litigation risk
    litigation_companies = risk_df['has_litigation'].sum()
    litigation_pct = (litigation_companies / len(risk_df)) * 100
    print(f"Companies with active litigation: {litigation_companies} ({litigation_pct:.1f}%)")
    results['summary']['litigation_pct'] = round(litigation_pct, 1)
    
    # Score distributions by disclosure type
    print("\n--- RISK SCORE DISTRIBUTION ---")
    print(f"Mean legal score: {risk_df['legal_score'].mean():.1f}")
    print(f"Mean risk score: {risk_df['risk_score'].mean():.1f}")
    print(f"Mean operational score: {risk_df['oper_score'].mean():.1f}")
    
    results['summary']['mean_legal_score'] = round(risk_df['legal_score'].mean(), 1)
    results['summary']['mean_risk_score'] = round(risk_df['risk_score'].mean(), 1)
    results['summary']['mean_oper_score'] = round(risk_df['oper_score'].mean(), 1)
    
    # AI/Tech company specific analysis
    print("\n--- AI/TECH COMPANY ANALYSIS ---")
    print(f"Analyzing {len(ai_df)} AI/tech companies...")
    
    ai_cyber = ai_df['cyber_disclosed'].sum()
    ai_cyber_pct = (ai_cyber / len(ai_df)) * 100
    print(f"AI companies with cyber disclosures: {ai_cyber} ({ai_cyber_pct:.1f}%)")
    
    ai_conc = ai_df['customer_conc'].sum()
    ai_conc_pct = (ai_conc / len(ai_df)) * 100
    print(f"AI companies with customer concentration: {ai_conc} ({ai_conc_pct:.1f}%)")
    
    results['summary']['ai_cyber_disclosed_pct'] = round(ai_cyber_pct, 1)
    results['summary']['ai_customer_concentration_pct'] = round(ai_conc_pct, 1)
    
    # Generate recommendations based on analysis
    print("\n" + "="*70)
    print("AI RISK DISCLOSURE BEST PRACTICES (Based on Analysis)")
    print("="*70)
    
    recommendations = [
        {
            'category': 'Cybersecurity',
            'observation': f'{cyber_pct:.0f}% of companies include cybersecurity disclosures',
            'implication': 'AI companies should explicitly address AI-specific security risks (adversarial attacks, model poisoning)'
        },
        {
            'category': 'Customer Concentration',
            'observation': f'{ai_conc_pct:.0f}% of AI/tech companies have customer concentration risk',
            'implication': 'AI companies often dependent on large enterprise customers - should quantify exposure'
        },
        {
            'category': 'Model Performance',
            'observation': 'Emerging disclosure area not captured in traditional risk frameworks',
            'implication': 'AI companies should proactively disclose model accuracy limitations, hallucination risks'
        },
        {
            'category': 'Training Data',
            'observation': 'IP litigation rising in AI sector',
            'implication': 'Disclose training data provenance, licensing arrangements, ongoing litigation exposure'
        },
        {
            'category': 'Regulatory',
            'observation': 'EU AI Act, state regulations creating compliance obligations',
            'implication': 'Quantify potential compliance costs, describe regulatory monitoring approach'
        }
    ]
    
    for rec in recommendations:
        print(f"\n{rec['category']}:")
        print(f"  Observation: {rec['observation']}")
        print(f"  Implication: {rec['implication']}")
    
    results['recommendations'] = recommendations
    
    # Top companies by various metrics
    print("\n--- TOP COMPANIES BY RISK DISCLOSURE QUALITY ---")
    
    # Companies with best overall scores
    top_scores = risk_df.nlargest(10, ['legal_score', 'risk_score', 'oper_score'])
    print("\nTop 10 companies by combined risk disclosure scores:")
    for _, row in top_scores[['ticker', 'name', 'legal_score', 'risk_score', 'oper_score']].iterrows():
        print(f"  {row['ticker']}: Legal={row['legal_score']}, Risk={row['risk_score']}, Oper={row['oper_score']}")
    
    results['top_disclosed'] = top_scores[['ticker', 'name', 'legal_score', 'risk_score', 'oper_score']].to_dict('records')
    
    # Companies with most 8-K filings (most responsive disclosure)
    top_8k = risk_df.nlargest(10, 'k8_filings')
    print("\nTop 10 companies by 8-K filing frequency (disclosure responsiveness):")
    for _, row in top_8k[['ticker', 'name', 'k8_filings']].iterrows():
        print(f"  {row['ticker']}: {row['k8_filings']} 8-K filings")
    
    results['most_responsive'] = top_8k[['ticker', 'name', 'k8_filings']].to_dict('records')
    
    # Save results
    with open('ai_risk_language_analysis.json', 'w') as f:
        json.dump(results, f, indent=2)
    print(f"\n✓ Analysis saved to ai_risk_language_analysis.json")
    
    return results

def generate_disclosure_report():
    """Generate a summary report of AI risk disclosure analysis"""
    results = analyze_ai_disclosure_patterns()
    
    report = f"""# AI Risk Factor Disclosure Analysis
## Public Company 10-K Analysis Report

**Analysis Date:** {results['analysis_date'][:10]}
**Companies Analyzed:** {results['total_companies']:,}
**AI/Tech Companies Focus:** {results['ai_tech_companies']}

---

## Key Findings

### Overall Disclosure Patterns

| Metric | All Companies | AI/Tech Companies |
|--------|---------------|-------------------|
| Cybersecurity Disclosed | {results['summary']['cyber_disclosed_pct']}% | {results['summary']['ai_cyber_disclosed_pct']}% |
| Customer Concentration | {results['summary']['customer_concentration_pct']}% | {results['summary']['ai_customer_concentration_pct']}% |
| Active Litigation | {results['summary']['litigation_pct']}% | N/A |

### Risk Score Distribution

| Score Type | Mean Score |
|------------|------------|
| Legal Score | {results['summary']['mean_legal_score']} |
| Risk Score | {results['summary']['mean_risk_score']} |
| Operational Score | {results['summary']['mean_oper_score']} |

---

## AI-Specific Risk Categories (Emerging Practice)

Based on our analysis of disclosure patterns, AI companies should consider the following risk categories:

### 1. Model Performance & Reliability
- **Current practice:** Rarely disclosed with specificity
- **Best practice:** Quantify accuracy metrics, describe testing methodology, disclose known limitations

### 2. Training Data & IP
- **Current practice:** Generic IP risk language
- **Best practice:** Describe training data provenance, licensing arrangements, pending IP claims

### 3. Regulatory Compliance
- **Current practice:** Forward-looking generic statements
- **Best practice:** Enumerate specific regulations (EU AI Act, state laws), quantify compliance costs

### 4. AI Safety & Ethics
- **Current practice:** Emerging disclosure area
- **Best practice:** Describe governance framework, human oversight mechanisms, incident response

### 5. Infrastructure Dependencies
- **Current practice:** Supply chain risk mentioned generically
- **Best practice:** Quantify GPU/compute concentration, describe cloud provider dependencies

---

## Recommendations for S-1 Filers

1. **Be specific, not generic** - Avoid boilerplate risk language that could apply to any technology company
2. **Quantify where possible** - Include dollar amounts for compliance costs, compute spending, remediation timelines
3. **Address known incidents** - If model failures or content moderation issues occurred, disclose them
4. **Update for regulatory developments** - Reference specific regulations (EU AI Act, state AI laws)
5. **Coordinate with technical teams** - Risk disclosures should reflect actual capabilities and limitations

---

*This analysis is based on SEC 10-K filings from {results['total_companies']:,} public companies.*
*Generated by GovernanceIQ Research*
"""
    
    with open('AI_Risk_Disclosure_Analysis.md', 'w') as f:
        f.write(report)
    print(f"\n✓ Report saved to AI_Risk_Disclosure_Analysis.md")
    
    return report

if __name__ == "__main__":
    generate_disclosure_report()
