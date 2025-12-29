"""
Political Risk Intelligence
Maps political events from Polymarket to corporate governance impacts

This provides early warning signals for:
- Regulatory changes affecting board oversight
- Antitrust actions impacting M&A
- Policy shifts requiring disclosure changes
- Political events creating operational risks
"""

from typing import Dict, List, Set
import re


class PoliticalRiskMapper:
    """Map political events to corporate impacts"""
    
    # Define which political topics affect which sectors
    RISK_MAPPINGS = {
        'antitrust': {
            'keywords': ['antitrust', 'monopoly', 'break up', 'anti-trust', 'FTC', 'DOJ'],
            'sectors': ['Technology', 'Software', 'Internet Services', 'Cloud Computing'],
            'companies': ['Google', 'Meta', 'Amazon', 'Apple', 'Microsoft'],
            'governance_impact': 'High',
            'impact_areas': [
                'Board oversight requirements',
                'M&A restrictions',
                'Compliance committee mandates',
                'Executive compensation tied to compliance'
            ]
        },
        'ai_regulation': {
            'keywords': ['AI regulation', 'artificial intelligence', 'AI safety', 'AI ethics', 'algorithmic'],
            'sectors': ['Technology', 'Software', 'AI/ML', 'Cloud Computing'],
            'companies': ['OpenAI', 'Anthropic', 'Google', 'Microsoft', 'Meta'],
            'governance_impact': 'High',
            'impact_areas': [
                'AI ethics board required',
                'Model governance disclosure',
                'Risk assessment documentation',
                'Third-party audit requirements'
            ]
        },
        'privacy_regulation': {
            'keywords': ['privacy', 'data protection', 'GDPR', 'consumer data'],
            'sectors': ['Technology', 'Software', 'Social Media', 'Internet Services'],
            'companies': ['Meta', 'Google', 'Apple', 'Amazon'],
            'governance_impact': 'Medium',
            'impact_areas': [
                'Privacy officer required',
                'Data governance policies',
                'Board privacy oversight',
                'Enhanced disclosure requirements'
            ]
        },
        'climate_policy': {
            'keywords': ['climate', 'carbon', 'emissions', 'green new deal', 'ESG'],
            'sectors': ['Energy', 'Transportation', 'Manufacturing', 'Technology'],
            'companies': ['Tesla', 'Rivian', 'ExxonMobil', 'Chevron'],
            'governance_impact': 'Medium',
            'impact_areas': [
                'Sustainability committee required',
                'Climate risk disclosure',
                'Carbon accounting',
                'Transition plan documentation'
            ]
        },
        'trade_tariffs': {
            'keywords': ['tariff', 'trade war', 'China', 'import tax', 'export'],
            'sectors': ['Manufacturing', 'Technology', 'Consumer Goods', 'Automotive'],
            'companies': ['Apple', 'Tesla', 'Nike', 'AMD', 'NVIDIA'],
            'governance_impact': 'High',
            'impact_areas': [
                'Supply chain committee',
                'Geopolitical risk disclosure',
                'Scenario planning requirements',
                'Board strategy oversight'
            ]
        },
        'interest_rates': {
            'keywords': ['Fed', 'interest rate', 'monetary policy', 'inflation'],
            'sectors': ['All'],  # Affects everyone
            'companies': [],  # Broad impact
            'governance_impact': 'Medium',
            'impact_areas': [
                'Valuation impact on compensation',
                'M&A strategy adjustments',
                'Risk committee oversight',
                'Debt covenant compliance'
            ]
        },
        'election_outcomes': {
            'keywords': ['election', 'president', 'senate', 'congress', 'democrat', 'republican'],
            'sectors': ['All'],
            'companies': [],
            'governance_impact': 'Variable',
            'impact_areas': [
                'Policy uncertainty',
                'Regulatory environment shifts',
                'Board composition considerations',
                'Lobbying strategy adjustments'
            ]
        },
        'section_230': {
            'keywords': ['Section 230', 'content moderation', 'platform liability'],
            'sectors': ['Technology', 'Social Media', 'Internet Services'],
            'companies': ['Meta', 'Google', 'Twitter', 'Reddit'],
            'governance_impact': 'High',
            'impact_areas': [
                'Content governance board',
                'Trust & safety oversight',
                'Legal risk disclosure',
                'Moderation policy documentation'
            ]
        }
    }
    
    def classify_political_event(self, question: str, description: str = "") -> List[Dict]:
        """
        Classify a political event and map to corporate impacts
        
        Args:
            question: Market question
            description: Market description
        
        Returns:
            List of risk mappings that apply
        """
        text = f"{question} {description}".lower()
        matches = []
        
        for risk_type, mapping in self.RISK_MAPPINGS.items():
            # Check if any keywords match
            if any(keyword.lower() in text for keyword in mapping['keywords']):
                matches.append({
                    'risk_type': risk_type,
                    'affected_sectors': mapping['sectors'],
                    'affected_companies': mapping['companies'],
                    'governance_impact': mapping['governance_impact'],
                    'impact_areas': mapping['impact_areas']
                })
        
        return matches
    
    def get_affected_companies(self, company_df, risk_mapping: Dict) -> List[str]:
        """
        Get list of companies in database affected by this political risk
        
        Args:
            company_df: DataFrame of companies
            risk_mapping: Risk mapping from classify_political_event
        
        Returns:
            List of company names
        """
        affected = []
        
        # Filter by sector
        if 'All' not in risk_mapping['affected_sectors']:
            sector_companies = company_df[
                company_df['primary_sector'].isin(risk_mapping['affected_sectors'])
            ]['company_name'].tolist()
            affected.extend(sector_companies)
        
        # Add specifically named companies
        for company_name in risk_mapping['affected_companies']:
            # Fuzzy match
            matches = company_df[
                company_df['company_name'].str.contains(company_name, case=False, na=False)
            ]['company_name'].tolist()
            affected.extend(matches)
        
        # Deduplicate
        return list(set(affected))
    
    def calculate_risk_score(self, probability: float, governance_impact: str) -> float:
        """
        Calculate composite risk score
        
        Args:
            probability: Event probability (0-1)
            governance_impact: 'High', 'Medium', 'Low', or 'Variable'
        
        Returns:
            Risk score (0-100)
        """
        impact_weights = {
            'High': 1.0,
            'Medium': 0.6,
            'Low': 0.3,
            'Variable': 0.5
        }
        
        weight = impact_weights.get(governance_impact, 0.5)
        return probability * weight * 100


# Example usage and test data
SAMPLE_POLITICAL_EVENTS = [
    {
        'question': 'Will the FTC block the Microsoft-Activision merger?',
        'probability': 0.35,
        'description': 'Antitrust concerns over gaming market consolidation'
    },
    {
        'question': 'Will Congress pass AI safety regulation by end of 2025?',
        'probability': 0.42,
        'description': 'Comprehensive AI governance framework'
    },
    {
        'question': 'Will tariffs on Chinese imports increase?',
        'probability': 0.68,
        'description': 'Trade policy escalation'
    },
    {
        'question': 'Will Section 230 be reformed?',
        'probability': 0.28,
        'description': 'Changes to platform liability protections'
    }
]


def demo_risk_mapping():
    """Demo the political risk mapper"""
    mapper = PoliticalRiskMapper()
    
    print("=" * 80)
    print("POLITICAL RISK INTELLIGENCE")
    print("=" * 80)
    print()
    
    for event in SAMPLE_POLITICAL_EVENTS:
        print(f"\n📊 {event['question']}")
        print(f"   Probability: {event['probability']*100:.0f}%")
        print()
        
        mappings = mapper.classify_political_event(event['question'], event['description'])
        
        if mappings:
            for mapping in mappings:
                risk_score = mapper.calculate_risk_score(
                    event['probability'],
                    mapping['governance_impact']
                )
                
                print(f"   🎯 Risk Type: {mapping['risk_type'].upper()}")
                print(f"   📈 Risk Score: {risk_score:.0f}/100")
                print(f"   🏢 Affected Sectors: {', '.join(mapping['affected_sectors'][:3])}")
                if mapping['affected_companies']:
                    print(f"   🏭 Key Companies: {', '.join(mapping['affected_companies'][:5])}")
                print(f"   ⚠️  Governance Impacts:")
                for impact in mapping['impact_areas'][:3]:
                    print(f"      - {impact}")
                print()


if __name__ == "__main__":
    demo_risk_mapping()
