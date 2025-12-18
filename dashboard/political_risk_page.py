"""
Political Risk Company Linker
Creates visual connections between political events and affected companies
"""

import streamlit as st
import pandas as pd
from typing import List, Dict
import plotly.express as px
import plotly.graph_objects as go


def render_political_risk_intelligence(supabase):
    """Render Political Risk Intelligence with company links"""
    
    st.markdown("## 🚨 Political Risk Intelligence")
    st.caption("Real Polymarket prediction markets mapped to corporate governance impacts")
    
    # Fetch political risk events
    try:
        result = supabase.table('kalshi_predictions')\
            .select('*')\
            .order('yes_probability', desc=True)\
            .limit(50)\
            .execute()
        
        risks = result.data
    except Exception as e:
        st.error(f"Error loading political risks: {e}")
        return
    
    # Filter to current/relevant events only
    if min_probability > 0:
        risks = [r for r in risks if (r.get('yes_probability') or 0) >= min_probability]
    
    # Filter out obviously stale events (2023 dates in questions)
    current_risks = []
    for risk in risks:
        question = risk.get('question', '').lower()
        # Skip if mentions 2023 or earlier  
        if '2023' in question or '2022' in question or 'march 31' in question or 'february' in question:
            continue
        current_risks.append(risk)
    
    risks = current_risks
    
    if not risks:
        st.warning("⚠️ All political events are historical. Run sync to get current data.")
        return
    
    # Group by risk category
    risk_categories = {}
    for risk in risks:
        event_type = risk.get('event_type', 'Other')
        if event_type not in risk_categories:
            risk_categories[event_type] = []
        risk_categories[event_type].append(risk)
    
    # Overview metrics
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        st.metric("Total Risks Tracked", len(risks))
    
    with col2:
        high_prob = len([r for r in risks if (r.get('yes_probability') or 0) > 0.6])
        st.metric("High Probability (>60%)", high_prob, delta="⚠️ Urgent")
    
    with col3:
        risk_types = len(risk_categories)
        st.metric("Risk Categories", risk_types)
    
    with col4:
        # Count affected companies from supporting_evidence
        total_affected = 0
        for risk in risks:
            evidence = risk.get('supporting_evidence', {})
            if isinstance(evidence, dict):
                companies = evidence.get('affected_companies', [])
                total_affected += len(companies)
        st.metric("Companies Affected", total_affected)
    
    st.markdown("---")
    
    # Filter controls
    col_filter1, col_filter2 = st.columns(2)
    
    with col_filter1:
        selected_categories = st.multiselect(
            "Filter by Risk Type",
            options=list(risk_categories.keys()),
            default=list(risk_categories.keys())[:3]
        )
    
    with col_filter2:
        min_probability = st.slider(
            "Minimum Probability",
            min_value=0,
            max_value=100,
            value=0,
            step=10,
            format="%d%%"
        ) / 100
    
    # Display risks with company connections
    st.markdown("### Political Events → Corporate Impact")
    
    for category in selected_categories:
        category_risks = risk_categories.get(category, [])
        
        # Filter by probability
        category_risks = [r for r in category_risks if (r.get('yes_probability') or 0) >= min_probability]
        
        if not category_risks:
            continue
        
        st.markdown(f"#### {category.replace('_', ' ').title()} ({len(category_risks)} events)")
        
        for risk in category_risks[:5]:  # Show top 5 per category
            prob = risk.get('yes_probability', 0.5)
            question = risk.get('question', 'Unknown event')
            evidence = risk.get('supporting_evidence', {})
            
            # Color based on probability
            if prob >= 0.7:
                prob_color = "🔴"
                urgency = "HIGH"
            elif prob >= 0.5:
                prob_color = "🟡"
                urgency = "MEDIUM"
            else:
                prob_color = "🟢"
                urgency = "LOW"
            
            with st.expander(f"{prob_color} **{question}** ({prob*100:.0f}%)", expanded=False):
                col_left, col_right = st.columns([2, 1])
                
                with col_left:
                    st.markdown(f"**Probability**: {prob*100:.1f}%")
                    st.markdown(f"**Urgency**: {urgency}")
                    
                    if isinstance(evidence, dict):
                        risk_score = evidence.get('risk_score', 0)
                        st.markdown(f"**Risk Score**: {risk_score:.0f}/100")
                        
                        # Affected sectors
                        sectors = evidence.get('affected_sectors', [])
                        if sectors and sectors != ['All']:
                            st.markdown(f"**Affected Sectors**: {', '.join(sectors[:5])}")
                        
                        # Governance impacts
                        impacts = evidence.get('governance_impacts', [])
                        if impacts:
                            st.markdown("**Required Governance Actions**:")
                            for impact in impacts[:3]:
                                st.markdown(f"  • {impact}")
                
                with col_right:
                    st.markdown("**🏢 Affected Companies**")
                    
                    if isinstance(evidence, dict):
                        companies = evidence.get('affected_companies', [])
                        if companies:
                            for company in companies[:10]:
                                st.caption(f"• {company}")
                            if len(companies) > 10:
                                st.caption(f"... +{len(companies)-10} more")
                        else:
                            st.caption("All companies in affected sectors")
                    else:
                        st.caption("Analyzing company impact...")
        
        st.markdown("---")
    
    # Summary chart
    st.markdown("### Risk Distribution")
    
    col_chart1, col_chart2 = st.columns(2)
    
    with col_chart1:
        # Probability distribution
        prob_ranges = {
            '0-20%': 0,
            '20-40%': 0,
            '40-60%': 0,
            '60-80%': 0,
            '80-100%': 0
        }
        
        for risk in risks:
            prob = (risk.get('yes_probability') or 0) * 100
            if prob < 20:
                prob_ranges['0-20%'] += 1
            elif prob < 40:
                prob_ranges['20-40%'] += 1
            elif prob < 60:
                prob_ranges['40-60%'] += 1
            elif prob < 80:
                prob_ranges['60-80%'] += 1
            else:
                prob_ranges['80-100%'] += 1
        
        fig = px.bar(
            x=list(prob_ranges.keys()),
            y=list(prob_ranges.values()),
            labels={'x': 'Probability Range', 'y': 'Number of Events'},
            title='Events by Probability'
        )
        st.plotly_chart(fig, use_container_width=True)
    
    with col_chart2:
        # Risk type distribution
        type_counts = {k: len(v) for k, v in risk_categories.items()}
        
        fig2 = px.pie(
            names=list(type_counts.keys()),
            values=list(type_counts.values()),
            title='Events by Type'
        )
        st.plotly_chart(fig2, use_container_width=True)


if __name__ == "__main__":
    from db_connection import init_connection
    
    st.title("Political Risk Intelligence Demo")
    supabase = init_connection()
    
    if supabase:
        render_political_risk_intelligence(supabase)
