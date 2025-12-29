"""
M&A Probability Calculator
Proprietary model using SEC filing patterns to predict acquisition likelihood
"""

import os
import sys
from datetime import datetime, timedelta
from typing import Dict, List, Optional
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class MASignalDetector:
    """Detect M&A signals from SEC filings and governance data"""
    
    # Signal weights (must sum to 100)
    WEIGHTS = {
        '8k_surge': 30,
        'board_changes': 25,
        'special_committee': 20,
        'advisor_hiring': 15,
        'governance_quality': 10
    }
    
    # Known M&A advisors
    MA_ADVISORS = [
        'Goldman Sachs', 'JPMorgan', 'Morgan Stanley', 'Bank of America',
        'Centerview', 'Evercore', 'Lazard', 'Qatalyst', 'Perella Weinberg',
        'Moelis', 'Allen & Company', 'Guggenheim', 'PJT Partners'
    ]
    
    def __init__(self, supabase):
        self.supabase = supabase
        logger.info("✓ Initialized M&A Signal Detector")
    
    def detect_8k_surge(self, company_id: str) -> Dict:
        """
        Detect unusual 8-K filing activity
        Returns: {score: 0-30, evidence: details}
        """
        try:
            # Count 8-Ks in last 90 days
            ninety_days_ago = (datetime.now() - timedelta(days=90)).isoformat()
            
            result = self.supabase.table('governance_news')\
                .select('*', count='exact')\
                .eq('company_id', company_id)\
                .eq('news_type', 'Material Event')\
                .gte('published_at', ninety_days_ago)\
                .execute()
            
            recent_count = result.count or 0
            
            # Typical company files 2-3 8-Ks per quarter
            # >5 in 90 days = potential activity
            if recent_count >= 10:
                score = 30
                level = "Very High"
            elif recent_count >= 7:
                score = 25
                level = "High"
            elif recent_count >= 5:
                score = 20
                level = "Elevated"
            else:
                score = 0
                level = "Normal"
            
            return {
                'score': score,
                'evidence': {
                    'recent_8k_count': recent_count,
                    'activity_level': level,
                    'period_days': 90
                }
            }
            
        except Exception as e:
            logger.error(f"Error detecting 8-K surge: {e}")
            return {'score': 0, 'evidence': {}}
    
    def detect_board_changes(self, company_id: str) -> Dict:
        """
        Detect recent board composition changes
        Returns: {score: 0-25, evidence: details}
        """
        try:
            # Check for new directors in last 180 days
            # (This would require tracking director changes - placeholder for now)
            
            # Get governance data
            result = self.supabase.table('company_risk_factors')\
                .select('board_independence_pct, last_updated')\
                .eq('company_id', company_id)\
                .execute()
            
            if not result.data:
                return {'score': 0, 'evidence': {}}
            
            # Placeholder logic - in production, track board member changes
            # High independence + recent update = potential new directors
            independence = result.data[0].get('board_independence_pct', 0)
            
            if independence and independence > 80:
                score = 15  # High independence suggests professional board
                evidence = {
                    'board_independence': f"{independence}%",
                    'assessment': 'Professional board composition'
                }
            else:
                score = 0
                evidence = {}
            
            return {'score': score, 'evidence': evidence}
            
        except Exception as e:
            logger.error(f"Error detecting board changes: {e}")
            return {'score': 0, 'evidence': {}}
    
    def detect_special_committee(self, company_id: str) -> Dict:
        """
        Check for special committee formation or strategic alternatives
        Returns: {score: 0-20, evidence: details}
        """
        try:
            # Search recent filings for keywords
            keywords = [
                'special committee',
                'strategic alternatives',
                'strategic review',
                'exploring alternatives'
            ]
            
            # Check recent news/filings
            ninety_days_ago = (datetime.now() - timedelta(days=90)).isoformat()
            
            result = self.supabase.table('governance_news')\
                .select('headline, summary')\
                .eq('company_id', company_id)\
                .gte('published_at', ninety_days_ago)\
                .execute()
            
            findings = []
            for item in result.data or []:
                text = f"{item.get('headline', '')} {item.get('summary', '')}".lower()
                for keyword in keywords:
                    if keyword in text:
                        findings.append(keyword)
                        break
            
            if findings:
                score = 20
                evidence = {
                    'keywords_found': findings,
                    'assessment': 'Strategic review underway'
                }
            else:
                score = 0
                evidence = {}
            
            return {'score': score, 'evidence': evidence}
            
        except Exception as e:
            logger.error(f"Error detecting special committee: {e}")
            return {'score': 0, 'evidence': {}}
    
    def detect_advisor_hiring(self, company_id: str) -> Dict:
        """
        Check for M&A advisor engagement  
        Returns: {score: 0-15, evidence: details}
        """
        try:
            # Search for advisor mentions
            ninety_days_ago = (datetime.now() - timedelta(days=90)).isoformat()
            
            result = self.supabase.table('governance_news')\
                .select('headline, summary')\
                .eq('company_id', company_id)\
                .gte('published_at', ninety_days_ago)\
                .execute()
            
            advisors_found = []
            for item in result.data or []:
                text = f"{item.get('headline', '')} {item.get('summary', '')}".lower()
                for advisor in self.MA_ADVISORS:
                    if advisor.lower() in text:
                        advisors_found.append(advisor)
            
            if advisors_found:
                score = 15
                evidence = {
                    'advisors': advisors_found,
                    'assessment': 'M&A advisor engagement detected'
                }
            else:
                score = 0
                evidence = {}
            
            return {'score': score, 'evidence': evidence}
            
        except Exception as e:
            logger.error(f"Error detecting advisor hiring: {e}")
            return {'score': 0, 'evidence': {}}
    
    def assess_governance_quality(self, company_id: str) -> Dict:
        """
        Lower governance quality = higher acquisition appeal
        Returns: {score: 0-10, evidence: details}
        """
        try:
            result = self.supabase.table('company_risk_factors')\
                .select('board_independence_pct, say_on_pay_support')\
                .eq('company_id', company_id)\
                .execute()
            
            if not result.data:
                return {'score': 0, 'evidence': {}}
            
            data = result.data[0]
            independence = data.get('board_independence_pct', 100)
            say_on_pay = data.get('say_on_pay_support', 100)
            
            # Poor governance = attractive target
            score = 0
            issues = []
            
            if independence and independence < 60:
                score += 5
                issues.append('Low board independence')
            
            if say_on_pay and say_on_pay < 70:
                score += 5
                issues.append('Poor say-on-pay support')
            
            evidence = {
                'governance_issues': issues,
                'board_independence': f"{independence}%" if independence else "Unknown",
                'say_on_pay': f"{say_on_pay}%" if say_on_pay else "Unknown"
            }
            
            return {'score': score, 'evidence': evidence}
            
        except Exception as e:
            logger.error(f"Error assessing governance: {e}")
            return {'score': 0, 'evidence': {}}
    
    def calculate_ma_probability(self, company_id: str) -> Dict:
        """
        Calculate overall M&A probability score
        Returns: {score: 0-100, signals: {}, confidence: str}
        """
        logger.info(f"Calculating M&A probability for company {company_id}")
        
        # Detect all signals
        signals = {
            '8k_surge': self.detect_8k_surge(company_id),
            'board_changes': self.detect_board_changes(company_id),
            'special_committee': self.detect_special_committee(company_id),
            'advisor_hiring': self.detect_advisor_hiring(company_id),
            'governance_quality': self.assess_governance_quality(company_id)
        }
        
        # Calculate total score
        total_score = sum(s['score'] for s in signals.values())
        
        # Determine confidence
        signals_triggered = sum(1 for s in signals.values() if s['score'] > 0)
        
        if signals_triggered >= 3:
            confidence = "High"
        elif signals_triggered >= 2:
            confidence = "Medium"
        elif signals_triggered >= 1:
            confidence = "Low"
        else:
            confidence = "Very Low"
        
        return {
            'score': round(total_score, 2),
            'confidence': confidence,
            'signals_triggered': signals_triggered,
            'signals': signals
        }


if __name__ == "__main__":
    from db_connection import init_connection
    import sys
    sys.path.append('dashboard')
    
    supabase = init_connection()
    detector = MASignalDetector(supabase)
    
    # Test with a company
    result = supabase.table('companies').select('id, company_name').limit(1).execute()
    if result.data:
        company = result.data[0]
        print(f"\nTesting M&A probability for: {company['company_name']}")
        score = detector.calculate_ma_probability(company['id'])
        print(f"M&A Probability: {score['score']}/100")
        print(f"Confidence: {score['confidence']}")
        print(f"Signals Triggered: {score['signals_triggered']}/5")
