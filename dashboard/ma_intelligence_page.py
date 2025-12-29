"""
M&A Intelligence Page
Display proprietary M&A probability predictions
"""

import streamlit as st
import pandas as pd
from datetime import datetime
import plotly.express as px


def render_ma_intelligence(supabase):
    """Render M&A probability intelligence"""
    
    st.markdown("## M&A Probability Intelligence")
    st.caption("Proprietary predictions using SEC filing signals")
    
    # Fetch M&A scores
    try:
        result = supabase.table('proprietary_risk_scores')\
            .select('*, companies!inner(company_name, ticker_symbol, primary_sector)')\
            .order('ma_probability', desc=True)\
            .limit(50)\
            .execute()
        
        scores = result.data
    except Exception as e:
        st.error(f"Error loading M&A scores: {e}")
        st.info("Run: `python3 models/sync_risk_scores.py` to generate scores")
        return
    
    if not scores:
        st.info("No M&A scores yet. Run `python3 models/sync_risk_scores.py` to calculate.")
        return
    
    # Overview metrics
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        total_scored = len(scores)
        st.metric("Companies Scored", total_scored)
    
    with col2:
        high_prob = len([s for s in scores if s.get('ma_probability', 0) > 60])
        st.metric("High Probability (>60)", high_prob, delta="Hot")
    
    with col3:
        medium_prob = len([s for s in scores if 30 < s.get('ma_probability', 0) <= 60])
        st.metric("Medium (30-60)", medium_prob)
    
    with col4:
        # Average score
        avg_score = sum(s.get('ma_probability', 0) for s in scores) / len(scores) if scores else 0
        st.metric("Average Score", f"{avg_score:.1f}/100")
    
    st.markdown("---")
    
    # Filters
    col_filter1, col_filter2 = st.columns(2)
    
    with col_filter1:
        min_score = st.slider(
            "Minimum M&A Probability",
            min_value=0,
            max_value=100,
            value=20,
            step=10
        )
    
    with col_filter2:
        # Get unique sectors
        sectors = list(set([s['companies']['primary_sector'] for s in scores if s.get('companies', {}).get('primary_sector')]))
        selected_sectors = st.multiselect(
            "Filter by Sector",
            options=sectors,
            default=sectors[:3] if len(sectors) > 3 else sectors
        )
    
    # Filter scores
    filtered = [
        s for s in scores 
        if s.get('ma_probability', 0) >= min_score
        and s.get('companies', {}).get('primary_sector') in selected_sectors
    ]
    
    st.markdown(f"### Top M&A Candidates ({len(filtered)} companies)")
    
    # Display top candidates
    for score_data in filtered[:10]:
        prob = score_data.get('ma_probability', 0)
        company_name = score_data['companies']['company_name']
        ticker = score_data['companies'].get('ticker_symbol', '')
        sector = score_data['companies'].get('primary_sector', 'Unknown')
        signals = score_data.get('ma_signals', {})
        
        # Color based on probability
        if prob >= 60:
            color = ""
            urgency = "HIGH"
        elif prob >= 30:
            color = ""
            urgency = "MEDIUM"
        else:
            color = ""
            urgency = "LOW"
        
        with st.expander(f"**{company_name}** {ticker} - {prob:.0f}% M&A Probability", expanded=False):
            col_left, col_right = st.columns([2, 1])
            
            with col_left:
                st.markdown(f"**M&A Probability**: {prob:.1f}/100")
                st.markdown(f"**Urgency**: {urgency}")
                st.markdown(f"**Sector**: {sector}")
                
                # Signal breakdown
                st.markdown("**Signal Breakdown**:")
                for signal_name, signal_data in signals.items():
                    if signal_data.get('score', 0) > 0:
                        score_val = signal_data['score']
                        evidence = signal_data.get('evidence', {})
                        
                        # Format signal name
                        display_name = signal_name.replace('_', ' ').title()
                        st.markdown(f"  • **{display_name}**: {score_val}/30")
                        
                        # Show evidence
                        for key, value in evidence.items():
                            if key != 'assessment':
                                st.caption(f"    - {key.replace('_', ' ').title()}: {value}")
            
            with col_right:
                st.markdown("**Timeline Estimate**")
                if prob >= 60:
                    st.info("90-180 days")
                elif prob >= 30:
                    st.info("6-12 months")
                else:
                    st.info("12+ months")
                
                last_updated = score_data.get('last_updated')
                if last_updated:
                    updated_dt = pd.to_datetime(last_updated)
                    time_ago = datetime.now() - updated_dt
                    if time_ago.total_seconds() < 86400:
                        freshness = f"{int(time_ago.total_seconds() / 3600)}h ago"
                    else:
                        freshness = f"{time_ago.days}d ago"
                    st.caption(f"Updated: {freshness}")
    
    # Distribution chart
    st.markdown("---")
    st.markdown("### M&A Probability Distribution")
    
    df = pd.DataFrame([
        {
            'Company': s['companies']['company_name'],
            'M&A Probability': s.get('ma_probability', 0),
            'Sector': s['companies'].get('primary_sector', 'Unknown')
        }
        for s in filtered
    ])
    
    if len(df) > 0:
        fig = px.histogram(
            df,
            x='M&A Probability',
            nbins=20,
            title='Distribution of M&A Probabilities',
            labels={'M&A Probability': 'M&A Probability Score'},
            color_discrete_sequence=['#1f77b4']
        )
        st.plotly_chart(fig, use_container_width=True)


if __name__ == "__main__":
    from db_connection import init_connection
    
    st.title("M&A Intelligence Demo")
    supabase = init_connection()
    
    if supabase:
        render_ma_intelligence(supabase)
