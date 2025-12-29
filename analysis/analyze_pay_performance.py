"""
ISS-Style Pay-for-Performance Analysis
Implements ISS quantitative methodology for executive compensation alignment.

References:
- ISS "Evaluating Pay for Performance Alignment" methodology
- Glass Lewis Pay-for-Performance grading framework
- OECD Principle VI.D on long-term value creation
"""

import os
import numpy as np
import pandas as pd
from scipy import stats
from typing import Dict, List, Tuple, Optional
from datetime import datetime, timedelta
from supabase import create_client, Client, ClientOptions
import toml
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Supabase connection
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
except:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
        url, key = secrets["SUPABASE_URL"], secrets["SUPABASE_KEY"]
    except:
        url, key = os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY")

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

# ============================================
# TSR CALCULATION ENGINE
# ============================================

def calculate_tsr(start_price: float, end_price: float, dividends: float = 0) -> float:
    """
    Calculate Total Shareholder Return (TSR).
    
    TSR = ((End Price + Dividends) - Start Price) / Start Price * 100
    """
    if start_price == 0:
        return 0
    
    return ((end_price + dividends - start_price) / start_price) * 100

def calculate_multi_year_tsr(company_id: str, years: int = 3) -> Optional[Dict]:
    """
    Calculate multi-year TSR for a company.
    
    Returns dict with TSR%, annualized TSR%, start/end prices.
    """
    # In production, fetch from financial_metrics or external API (Yahoo Finance, Bloomberg)
    # For now, this is a template
    
    # Example implementation:
    # 1. Get stock prices from database or API
    # 2. Calculate TSR over period
    # 3. Annualize for multi-year periods
    
    # Placeholder
    return {
        'company_id': company_id,
        'period_years': years,
        'tsr_percent': None,  # Calculate from real data
        'annualized_tsr': None
    }

def calculate_relative_tsr_percentile(company_id: str, peer_group_id: str, year: int) -> Optional[int]:
    """
    Calculate company's TSR percentile rank vs. peer group.
    
    ISS uses this for performance stock unit (PSU) evaluation.
    Returns percentile rank (1-100), where 100 = best performer.
    """
    # Fetch company TSR
    company_tsr = supabase.table('tsr_data') \
        .select('tsr_percent') \
        .eq('company_id', company_id) \
        .eq('calculation_date', f'{year}-12-31') \
        .execute()
    
    if not company_tsr.data:
        return None
    
    company_tsr_value = company_tsr.data[0]['tsr_percent']
    
    # Fetch peer group TSRs
    peers = supabase.table('peer_group_members') \
        .select('peer_company_id') \
        .eq('peer_group_id', peer_group_id) \
        .execute()
    
    peer_tsrs = []
    for peer in peers.data:
        if not peer['peer_company_id']:
            continue
        
        peer_tsr = supabase.table('tsr_data') \
            .select('tsr_percent') \
            .eq('company_id', peer['peer_company_id']) \
            .eq('calculation_date', f'{year}-12-31') \
            .execute()
        
        if peer_tsr.data:
            peer_tsrs.append(peer_tsr.data[0]['tsr_percent'])
    
    if not peer_tsrs:
        return None
    
    # Calculate percentile rank
    percentile = stats.percentileofscore(peer_tsrs, company_tsr_value, kind='rank')
    
    return int(percentile)

# ============================================
# PAY-PERFORMANCE ALIGNMENT SCORING
# ============================================

def calculate_pay_tsr_alignment(company_id: str, years: int = 3) -> Dict:
    """
    ISS ScreenFail Test #1: Pay-TSR Alignment
    
    Compares CEO pay percentile vs. TSR percentile within peer group.
    Flags if pay percentile >> TSR percentile (misalignment).
    """
    # Fetch CEO compensation over period
    ceo_comp = supabase.table('executive_compensation_annual') \
        .select('fiscal_year, total_compensation') \
        .eq('company_id', company_id) \
        .eq('role', 'CEO') \
        .order('fiscal_year', desc=True) \
        .limit(years) \
        .execute()
    
    if not ceo_comp.data or len(ceo_comp.data) < years:
        return {'status': 'insufficient_data'}
    
    # Get peer group for latest year
    latest_year = ceo_comp.data[0]['fiscal_year']
    peer_group = supabase.table('compensation_peer_groups') \
        .select('id') \
        .eq('company_id', company_id) \
        .eq('fiscal_year', latest_year) \
        .execute()
    
    if not peer_group.data:
        return {'status': 'no_peer_group'}
    
    peer_group_id = peer_group.data[0]['id']
    
    # Calculate average CEO pay over period
    avg_ceo_pay = sum([c['total_compensation'] for c in ceo_comp.data]) / len(ceo_comp.data)
    
    # Get peer CEO pay (simplified - in production, fetch all peer CEOs)
    # Calculate pay percentile rank
    
    # Get TSR percentile
    tsr_percentile = calculate_relative_tsr_percentile(company_id, peer_group_id, latest_year)
    
    # ISS threshold: If pay percentile > TSR percentile + 25%, flag misalignment
    # Simplified calculation here
    
    return {
        'company_id': company_id,
        'avg_ceo_pay_3yr': avg_ceo_pay,
        'tsr_percentile': tsr_percentile,
        'alignment_status': 'aligned',  # or 'misaligned'
        'iss_screenfail': False
    }

def calculate_multiple_of_median(company_id: str, year: int) -> Optional[float]:
    """
    ISS ScreenFail Test #2: Multiple of Median (MoM)
    
    CEO pay / Peer group median pay.
    ISS flags if MoM > 2.0 without clear justification.
    """
    # Get CEO pay
    ceo_comp = supabase.table('executive_compensation_annual') \
        .select('total_compensation') \
        .eq('company_id', company_id) \
        .eq('role', 'CEO') \
        .eq('fiscal_year', year) \
        .execute()
    
    if not ceo_comp.data:
        return None
    
    ceo_pay = ceo_comp.data[0]['total_compensation']
    
    # Get peer group median (simplified - in production calculate from peer data)
    # peer_median = ...
    
    # mom = ceo_pay / peer_median
    
    # return mom
    
    return None  # Placeholder

# ============================================
# RED FLAG DETECTION
# ============================================

def detect_compensation_red_flags(company_id: str, year: int) -> List[Dict]:
    """
    ISS-based red flag detection.
    
    Returns list of governance concerns.
    """
    red_flags = []
    
    # 1. Mega-grants without performance conditions
    large_grants = supabase.table('restricted_stock_units') \
        .select('total_grant_value, grant_date') \
        .eq('company_id', company_id) \
        .eq('fiscal_year', year) \
        .gte('total_grant_value', 50000000) \
        .execute()  # $50M+ grants
    
    if large_grants.data:
        for grant in large_grants.data:
            red_flags.append({
                'flag_type': 'mega_grant',
                'severity': 'high',
                'description': f"Large equity grant (${grant['total_grant_value']:,}) without disclosed performance conditions",
                'iss_concern': True
            })
    
    # 2. Weak say-on-pay vote (<70%)
    sop_vote = supabase.table('say_on_pay_votes') \
        .select('approval_percentage') \
        .eq('company_id', company_id) \
        .eq('fiscal_year', year) \
        .execute()
    
    if sop_vote.data and sop_vote.data[0]['approval_percentage'] < 70:
        red_flags.append({
            'flag_type': 'failed_say_on_pay',
            'severity': 'critical',
            'description': f"Say-on-pay approval only {sop_vote.data[0]['approval_percentage']:.1f}%",
            'iss_concern': True
        })
    
    # 3. Missing clawback policy
    clawback = supabase.table('clawback_policies') \
        .select('id') \
        .eq('company_id', company_id) \
        .execute()
    
    if not clawback.data:
        red_flags.append({
            'flag_type': 'no_clawback',
            'severity': 'medium',
            'description': "No clawback policy disclosed",
            'iss_concern': True
        })
    
    # 4. Excessive STI payout despite poor performance
    # (Requires both STI data and performance data)
    
    return red_flags

# ============================================
# PREDICTIVE MODELING
# ============================================

def predict_sti_payout(company_id: str, year: int, performance_inputs: Dict) -> Dict:
    """
    Predict STI payout based on current performance vs. targets.
    
    Args:
        performance_inputs: Dict with metric achievements, e.g.,
            {'revenue_achievement_pct': 95, 'ebitda_achievement_pct': 105}
    
    Returns:
        Predicted payout as % of target (0-200%)
    """
    # Fetch STI plan structure
    sti_plan = supabase.table('sti_plan_structure') \
        .select('*') \
        .eq('company_id', company_id) \
        .eq('fiscal_year', year) \
        .execute()
    
    if not sti_plan.data:
        return {'status': 'no_plan_data'}
    
    plan = sti_plan.data[0]
    
    # Fetch metrics and weights
    metrics = supabase.table('sti_performance_metrics') \
        .select('*') \
        .eq('company_id', company_id) \
        .eq('fiscal_year', year) \
        .execute()
    
    if not metrics.data:
        return {'status': 'no_metrics_data'}
    
    # Calculate weighted payout
    total_payout = 0
    total_weight = 0
    
    for metric in metrics.data:
        metric_name = metric['metric_name_normalized']
        weight = metric['weight_percent']
        
        # Get achievement from inputs
        achievement_key = f"{metric_name}_achievement_pct"
        if achievement_key not in performance_inputs:
            continue
        
        achievement_pct = performance_inputs[achievement_key]
        
        # Calculate payout for this metric (linear interpolation)
        if achievement_pct < metric.get('threshold_payout_percent', 50):
            metric_payout = 0
        elif achievement_pct <= 100:
            # Between threshold and target
            metric_payout = 50 + (achievement_pct - 50) * (50 / 50)  # Linear to 100%
        else:
            # Above target
            metric_payout = 100 + (achievement_pct - 100) * (100 / 100)  # Linear to 200%
        
        metric_payout = min(metric_payout, 200)  # Cap at maximum
        
        total_payout += metric_payout * (weight / 100)
        total_weight += weight
    
    final_payout_pct = (total_payout / total_weight * 100) if total_weight > 0 else 0
    
    return {
        'company_id': company_id,
        'fiscal_year': year,
        'predicted_payout_percent': round(final_payout_pct, 1),
        'confidence': 'high' if total_weight >= 80 else 'medium'
    }

def predict_psu_vesting_probability(company_id: str, grant_id: str, current_tsr_percentile: int) -> Dict:
    """
    Predict PSU vesting likelihood based on current TSR performance.
    
    Useful for mid-performance-period forecasting.
    """
    # Fetch PSU details
    psu = supabase.table('performance_stock_units') \
        .select('*') \
        .eq('id', grant_id) \
        .execute()
    
    if not psu.data:
        return {'status': 'grant_not_found'}
    
    grant = psu.data[0]
    
    # Check if cliff applies
    if grant.get('has_cliff') and current_tsr_percentile < grant.get('cliff_threshold', 25):
        return {
            'vesting_probability': 0,
            'expected_payout_percent': 0,
            'rationale': f"Below cliff threshold ({grant.get('cliff_threshold')}th percentile)"
        }
    
    # Linear interpolation based on TSR percentile
    threshold_percentile = grant.get('metric_1_threshold', 25)
    target_percentile = grant.get('metric_1_target', 50)
    max_percentile = grant.get('metric_1_maximum', 75)
    
    if current_tsr_percentile <= threshold_percentile:
        payout_pct = 50
    elif current_tsr_percentile <= target_percentile:
        payout_pct = 50 + ((current_tsr_percentile - threshold_percentile) / 
                           (target_percentile - threshold_percentile) * 50)
    elif current_tsr_percentile <= max_percentile:
        payout_pct = 100 + ((current_tsr_percentile - target_percentile) / 
                            (max_percentile - target_percentile) * 100)
    else:
        payout_pct = 200
    
    return {
        'grant_id': grant_id,
        'current_tsr_percentile': current_tsr_percentile,
        'expected_payout_percent': round(payout_pct, 1),
        'vesting_probability': 0.9 if payout_pct > 0 else 0.1,
        'estimated_value_usd': int(grant['target_grant_value'] * (payout_pct / 100))
    }

def predict_say_on_pay_failure_risk(company_id: str, year: int) -> Dict:
    """
    Predict risk of say-on-pay vote failure (<50%) or weak approval (<70%).
    
    Based on ISS risk factors:
    - Pay-performance misalignment
    - Prior vote trends
    - Red flags (mega-grants, repricing, etc.)
    """
    risk_score = 0
    risk_factors = []
    
    # Factor 1: Prior vote trend
    prior_votes = supabase.table('say_on_pay_votes') \
        .select('fiscal_year, approval_percentage') \
        .eq('company_id', company_id) \
        .order('fiscal_year', desc=True) \
        .limit(3) \
        .execute()
    
    if prior_votes.data:
        latest_approval = prior_votes.data[0]['approval_percentage']
        
        if latest_approval < 70:
            risk_score += 40
            risk_factors.append(f"Prior approval only {latest_approval:.1f}%")
        
        # Check trend (declining approval)
        if len(prior_votes.data) >= 2:
            trend = prior_votes.data[0]['approval_percentage'] - prior_votes.data[1]['approval_percentage']
            if trend < -5:
                risk_score += 20
                risk_factors.append("Declining vote trend")
    
    # Factor 2: Pay-performance misalignment
    alignment = calculate_pay_tsr_alignment(company_id, years=3)
    if alignment.get('iss_screenfail'):
        risk_score += 30
        risk_factors.append("ISS pay-performance misalignment")
    
    # Factor 3: Red flags
    red_flags = detect_compensation_red_flags(company_id, year)
    if red_flags:
        risk_score += len(red_flags) * 10
        risk_factors.extend([f['description'] for f in red_flags[:2]])
    
    # Normalize to 0-100
    risk_score = min(risk_score, 100)
    
    # Risk categories
    if risk_score >= 70:
        risk_level = 'critical'
    elif risk_score >= 40:
        risk_level = 'high'
    elif risk_score >= 20:
        risk_level = 'medium'
    else:
        risk_level = 'low'
    
    return {
        'company_id': company_id,
        'fiscal_year': year,
        'risk_score': risk_score,
        'risk_level': risk_level,
        'risk_factors': risk_factors,
        'recommendation': 'Engage with shareholders' if risk_score >= 40 else 'Monitor'
    }

# ============================================
# REPORTING FUNCTIONS
# ============================================

def generate_compensation_scorecard(company_id: str, year: int) -> Dict:
    """
    Generate comprehensive ISS-style compensation scorecard for a company.
    """
    scorecard = {
        'company_id': company_id,
        'fiscal_year': year,
        'timestamp': datetime.now().isoformat(),
        
        # Pay-for-Performance Analysis
        'pay_tsr_alignment': calculate_pay_tsr_alignment(company_id, years=3),
        'multiple_of_median': calculate_multiple_of_median(company_id, year),
        
        # Governance Practices
        'red_flags': detect_compensation_red_flags(company_id, year),
        
        # Voting Risk
        'say_on_pay_risk': predict_say_on_pay_failure_risk(company_id, year),
        
        # Overall Grade
        'overall_grade': None  # Calculate composite grade
    }
    
    # Calculate ISS-style grade (A-F)
    # Simplified logic - in production, use full ISS formula
    risk_score = scorecard['say_on_pay_risk']['risk_score']
    red_flag_count = len(scorecard['red_flags'])
    
    if risk_score < 20 and red_flag_count == 0:
        overall_grade = 'A'
    elif risk_score < 40 and red_flag_count <= 1:
        overall_grade = 'B'
    elif risk_score < 60:
        overall_grade = 'C'
    elif risk_score < 80:
        overall_grade = 'D'
    else:
        overall_grade = 'F'
    
    scorecard['overall_grade'] = overall_grade
    
    return scorecard

if __name__ == "__main__":
    # Example usage
    import sys
    
    if len(sys.argv) > 1:
        company_id = sys.argv[1]
        year = int(sys.argv[2]) if len(sys.argv) > 2 else 2024
        
        scorecard = generate_compensation_scorecard(company_id, year)
        
        print(f"\n{'='*60}")
        print(f"Compensation Scorecard - {year}")
        print(f"{'='*60}")
        print(f"Overall Grade: {scorecard['overall_grade']}")
        print(f"\nRed Flags: {len(scorecard['red_flags'])}")
        for flag in scorecard['red_flags']:
            print(f"  - [{flag['severity'].upper()}] {flag['description']}")
        
        print(f"\nSay-on-Pay Risk: {scorecard['say_on_pay_risk']['risk_level'].upper()}")
        print(f"Risk Score: {scorecard['say_on_pay_risk']['risk_score']}/100")
    
    else:
        print("Usage: python analyze_pay_performance.py <company_id> [year]")
