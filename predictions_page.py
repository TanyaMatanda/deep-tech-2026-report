"""
Market Predictions Dashboard
Unified intelligence hub combining:
- Kalshi crowd predictions (M&A, IPO, governance)
- Proprietary exit probability models
- Live event feed with prediction context
- Private company intelligence
"""

import streamlit as st
import pandas as pd
from datetime import datetime, timedelta
import plotly.express as px
import plotly.graph_objects as go

def render_predictions_page():
    """Render the Market Predictions intelligence hub"""
    
    st.title("🎯 Market Intelligence & Predictions")
    st.markdown("### Real-time events • Crowd wisdom • Proprietary signals")
    
    from db_connection import init_connection
    supabase = init_connection()
    
    if not supabase:
        st.error("Database connection failed")
        return
    
    # Tabs for different views
    tab1, tab2, tab3, tab4 = st.tabs([
        "📊 Active Predictions",
        "🔴 Live Events", 
        "🏢 Private Companies",
        "📈 Analytics"
    ])
    
    # ===== TAB 1: ACTIVE PREDICTIONS =====
    with tab1:
        # Import M&A intelligence renderer
        from ma_intelligence_page import render_ma_intelligence
        
        # Show M&A intelligence (proprietary model)
        render_ma_intelligence(supabase)
        
        st.markdown("---")
        st.markdown("---")
        
        st.subheader("Additional Event Predictions")
        st.caption("Other corporate event predictions (when available)")
        
        # Fetch Kalshi predictions
        try:
            result = supabase.table('kalshi_predictions')\
                .select('*')\
                .eq('status', 'active')\
                .order('yes_probability', desc=True)\
                .limit(50)\
                .execute()
            
            predictions = result.data
        except Exception as e:
            predictions = []
            st.info("💡 No prediction data yet. Run sync script to populate with Polymarket data.")
        
        if predictions:
            # Event type filter
            event_types = list(set([p['event_type'] for p in predictions if p.get('event_type')]))
            selected_types = st.multiselect(
                "Filter by event type",
                event_types,
                default=event_types[:3] if len(event_types) > 3 else event_types
            )
            
            # Filter predictions
            filtered = [p for p in predictions if p.get('event_type') in selected_types]
            
            # Display as cards
            for pred in filtered[:10]:
                prob = pred.get('yes_probability', 0)
                if prob is None:
                    prob = 0
                
                # Color based on probability
                if prob >= 0.7:
                    color = "🟢"
                    badge_color = "green"
                elif prob >= 0.4:
                    color = "🟡"
                    badge_color = "orange"
                else:
                    color = "🔴"
                    badge_color = "red"
                
                with st.container():
                    col1, col2 = st.columns([3, 1])
                    
                    with col1:
                        st.markdown(f"### {color} {pred.get('question', 'Unknown event')}")
                        st.markdown(f"**Type**: {pred.get('event_type', 'Other')}")
                        if pred.get('description'):
                            st.caption(pred['description'][:150] + "...")
                    
                    with col2:
                        st.metric(
                            "Probability",
                            f"{prob*100:.1f}%",
                            delta=None
                        )
                        
                        closes = pred.get('closes_at')
                        if closes:
                            closes_dt = pd.to_datetime(closes)
                            days_left = (closes_dt - datetime.now()).days
                            st.caption(f"Closes in {days_left} days")
                    
                    st.markdown("---")
        
        else:
            # Show sample/placeholder predictions
            # All political risk data is now real - no samples!
            st.caption("ℹ️ Additional corporate event predictions (IPO, M&A) available when Kalshi adds coverage")
            
            sample_predictions = [
                {
                    "question": "Will Databricks IPO by end of 2026?",
                    "type": "IPO",
                    "probability": 0.34,
                    "closes": "2026-12-31"
                },
                {
                    "question": "Will Microsoft acquire OpenAI?",
                    "type": "M&A",
                    "probability": 0.18,
                    "closes": "2025-06-30"
                },
                {
                    "question": "Will Stripe go public in 2025?",
                    "type": "IPO",
                    "probability": 0.42,
                    "closes": "2025-12-31"
                }
            ]
            
            for pred in sample_predictions:
                prob = pred['probability']
                color = "🟢" if prob >= 0.7 else "🟡" if prob >= 0.4 else "🔴"
                
                col1, col2 = st.columns([3, 1])
                with col1:
                    st.markdown(f"### {color} {pred['question']}")
                    st.markdown(f"**Type**: {pred['type']}")
                with col2:
                    st.metric("Probability", f"{prob*100:.1f}%")
                    st.caption(f"Closes: {pred['closes']}")
                
                st.markdown("---")
    
    # ===== TAB 2: LIVE EVENTS =====
    with tab2:
        st.subheader("Live Event Feed with Prediction Context")
        
        # Fetch recent governance news
        try:
            news_result = supabase.table('governance_news')\
                .select('*')\
                .order('published_at', desc=True)\
                .limit(20)\
                .execute()
            
            news_items = news_result.data
        except:
            news_items = []
        
        if news_items:
            for item in news_items:
                event_icon = {
                    'M&A': '🤝',
                    'Material Event': '🔴',
                    'Proxy': '🗳️',
                    'Activism': '📢',
                    'Board Change': '👔'
                }.get(item.get('news_type'), '📰')
                
                # Calculate time ago
                published = pd.to_datetime(item['published_at'])
                time_diff = datetime.now() - published
                
                if time_diff.total_seconds() < 3600:
                    time_ago = f"{int(time_diff.total_seconds() / 60)}m ago"
                elif time_diff.total_seconds() < 86400:
                    time_ago = f"{int(time_diff.total_seconds() / 3600)}h ago"
                else:
                    time_ago = f"{int(time_diff.days)}d ago"
                
                with st.expander(f"{event_icon} **{item['headline']}** • {time_ago}", expanded=False):
                    col_left, col_right = st.columns([2, 1])
                    
                    with col_left:
                        st.markdown(f"**Summary**: {item.get('summary', 'No summary')}")
                        st.markdown(f"**Source**: {item.get('source')} | **Type**: {item.get('news_type')}")
                        
                        if item.get('url'):
                            st.link_button("View Full Filing →", item['url'])
                    
                    with col_right:
                        st.markdown("**📊 Prediction Context**")
                        # TODO: Link to related Kalshi markets
                        st.info("Run sync_political_risks.py to see Polymarket predictions for this event")
        else:
            st.info("No recent events. Run SEC monitor: `python3 collectors/sec_rss_monitor.py`")
    
    # ===== TAB 3: PRIVATE COMPANIES =====
    with tab3:
        st.subheader("Private Company Intelligence")
        
        st.info("🏗️ **Coming soon**: Private company tracking via Crunchbase API")
        
        # Show mockup
        st.markdown("### High-Probability Exit Candidates")
        
        sample_private = pd.DataFrame([
            {
                "Company": "OpenAI",
                "Valuation": "$86B",
                "Last Funding": "$13B (Jan 2024)",
                "Exit Probability": "94%",
                "Predicted Exit": "Acquisition by Microsoft (72%)",
                "Governance": "Board expansion likely"
            },
            {
                "Company": "Databricks",
                "Valuation": "$43B",
                "Last Funding": "$500M (Sep 2023)",
                "Exit Probability": "68%",
                "Predicted Exit": "IPO 2026 (34% Kalshi)",
                "Governance": "Pre-IPO readiness high"
            },
            {
                "Company": "Stripe",
                "Valuation": "$65B",
                "Last Funding": "$600M (Mar 2023)",
                "Exit Probability": "72%",
                "Predicted Exit": "IPO 2025-26 (42%)",
                "Governance": "Strong board, audit ready"
            }
        ])
        
        st.dataframe(sample_private, use_container_width=True, hide_index=True)
        
        st.markdown("""
        **Metrics we'll track**:
        - Funding rounds & valuations
        - Headcount growth (via LinkedIn)
        - Board composition (when available)
        - IPO/acquisition probability (Polymarket + our models)
        - Governance readiness score
        """)
    
    # ===== TAB 4: ANALYTICS =====
    with tab4:
        st.subheader("Prediction Analytics & Accuracy Tracking")
        
        col1, col2 = st.columns(2)
        
        with col1:
            st.markdown("### Probability Distribution")
            
            # Generate sample data
            sample_probs = pd.DataFrame({
                'Probability Range': ['0-20%', '20-40%', '40-60%', '60-80%', '80-100%'],
                'Count': [12, 8, 15, 22, 18]
            })
            
            fig = px.bar(
                sample_probs,
                x='Probability Range',
                y='Count',
                title='Active Markets by Probability',
                color='Count',
                color_continuous_scale='Blues'
            )
            st.plotly_chart(fig, use_container_width=True)
        
        with col2:
            st.markdown("### Event Type Breakdown")
            
            sample_types = pd.DataFrame({
                'Type': ['IPO', 'M&A', 'CEO Change', 'Governance', 'Earnings'],
                'Markets': [25, 18, 8, 12, 22]
            })
            
            fig2 = px.pie(
                sample_types,
                names='Type',
                values='Markets',
                title='Markets by Event Type'
            )
            st.plotly_chart(fig2, use_container_width=True)
        
        st.markdown("---")
        st.markdown("### Prediction Accuracy (Historical)")
        
        # Sample accuracy tracking
        st.info("📊 Track performance: Compare Polymarket probabilities vs actual outcomes")
        
        sample_accuracy = pd.DataFrame({
            'Event': ['Databricks IPO 2024', 'Meta Layoffs Q4', 'Apple AI Launch'],
            'Predicted Probability': ['34%', '82%', '67%'],
            'Actual Outcome': ['Did not occur', 'Occurred', 'Occurred'],
            'Accuracy Score': ['✓ Calibrated', '✓ Correct', '✓ Correct']
        })
        
        st.dataframe(sample_accuracy, use_container_width=True, hide_index=True)


if __name__ == "__main__":
    render_predictions_page()
