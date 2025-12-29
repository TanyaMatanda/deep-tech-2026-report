"""
Data Freshness Widget
Shows "Last Updated" timestamps for data credibility
"""

import streamlit as st
from datetime import datetime, timedelta
import pandas as pd


def render_data_freshness(supabase):
    """Display data freshness indicators"""
    
    st.markdown("### Data Freshness")
    
    try:
        # Check latest governance data update
        gov_result = supabase.table('company_risk_factors')\
            .select('fiscal_year')\
            .order('fiscal_year', desc=True)\
            .limit(1)\
            .execute()
        
        if gov_result.data:
            latest_year = gov_result.data[0]['fiscal_year']
            st.caption(f"**Governance Data**: FY{latest_year} (SEC filings)")
        
        # Check latest political risk update
        poly_result = supabase.table('kalshi_predictions')\
            .select('last_updated')\
            .order('last_updated', desc=True)\
            .limit(1)\
            .execute()
        
        if poly_result.data:
            last_update = pd.to_datetime(poly_result.data[0]['last_updated'])
            time_ago = datetime.now() - last_update
            if time_ago.total_seconds() < 3600:
                freshness = f"{int(time_ago.total_seconds() / 60)}m ago"
                color = ""
            elif time_ago.total_seconds() < 86400:
                freshness = f"{int(time_ago.total_seconds() / 3600)}h ago"
                color = ""
            elif time_ago.days < 7:
                freshness = f"{time_ago.days}d ago"
                color = ""
            else:
                freshness = f"{time_ago.days}d ago"
                color = ""
            
            st.caption(f"**Political Risks**: Updated {freshness}")
        
        # Check latest news
        news_result = supabase.table('governance_news')\
            .select('published_at')\
            .order('published_at', desc=True)\
            .limit(1)\
            .execute()
        
        if news_result.data:
            latest_news = pd.to_datetime(news_result.data[0]['published_at'])
            time_ago = datetime.now() - latest_news
            
            if time_ago.total_seconds() < 3600:
                news_fresh = f"{int(time_ago.total_seconds() / 60)}m ago"
            elif time_ago.total_seconds() < 86400:
                news_fresh = f"{int(time_ago.total_seconds() / 3600)}h ago"
            else:
                news_fresh = f"{time_ago.days}d ago"
            
            st.caption(f"**Latest News**: {news_fresh}")
        
    except Exception as e:
        st.caption(f"Data freshness: Unable to determine ({e})")


def add_last_updated_badge(timestamp: str, label: str = "Updated") -> None:
    """Add a compact last updated badge"""
    try:
        dt = pd.to_datetime(timestamp)
        time_ago = datetime.now() - dt
        
        if time_ago.total_seconds() < 3600:
            text = f"{int(time_ago.total_seconds() / 60)}m ago"
        elif time_ago.total_seconds() < 86400:
            text = f"{int(time_ago.total_seconds() / 3600)}h ago"
        elif time_ago.days < 7:
            text = f"{time_ago.days}d ago"
        else:
            text = dt.strftime("%Y-%m-%d")
        
        st.caption(f"{label}: {text}")
    except:
        pass


if __name__ == "__main__":
    from db_connection import init_connection
    
    st.title("Data Freshness Demo")
    supabase = init_connection()
    
    if supabase:
        render_data_freshness(supabase)
