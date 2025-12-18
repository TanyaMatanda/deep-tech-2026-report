"""
Governance News Feed - Dashboard Page
Displays real-time governance events from SEC filings and news sources
"""

import streamlit as st
import pandas as pd
from datetime import datetime, timedelta
import plotly.express as px

def render_news_feed_page():
    """Render the governance news feed page"""
    
    st.title("📰 Governance News Feed")
    st.markdown("### Real-Time Corporate Governance Events")
    
    st.info("🔄 **Live data** from SEC filings • Updated every 15 minutes")
    
    # Fetch news data
    from db_connection import init_connection
    supabase = init_connection()
    
    if not supabase:
        st.error("Database connection failed")
        return
    
    # Filters
    st.markdown("---")
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        date_filter = st.selectbox(
            "Time Period",
            ["Last 24h", "Last 7 days", "Last 30 days", "All time"]
        )
    
    with col2:
        type_filter = st.multiselect(
            "Event Type",
            ["Material Event", "Proxy", "M&A", "Activism", "Board Change", "Governance", "Other"],
            default=[]
        )
    
    with col3:
        source_filter = st.multiselect(
            "Source",
            ["SEC", "Reuters", "WSJ", "Bloomberg"],
            default=[]
        )
    
    with col4:
        search_query = st.text_input("Search", placeholder="Keywords...")
    
    # Build query
    query = supabase.table('governance_news').select('*')
    
    # Date filter
    if date_filter == "Last 24h":
        cutoff = datetime.now() - timedelta(days=1)
        query = query.gte('published_at', cutoff.isoformat())
    elif date_filter == "Last 7 days":
        cutoff = datetime.now() - timedelta(days=7)
        query = query.gte('published_at', cutoff.isoformat())
    elif date_filter == "Last 30 days":
        cutoff = datetime.now() - timedelta(days=30)
        query = query.gte('published_at', cutoff.isoformat())
    
    # Execute query
    query = query.order('published_at', desc=True).limit(100)
    
    try:
        result = query.execute()
        news_items = result.data
    except Exception as e:
        st.error(f"Error fetching news: {e}")
        return
    
    if not news_items:
        st.warning("No news items found. The monitor may need to run.")
        st.info("💡 **Tip**: Run `python3 collectors/sec_rss_monitor.py` to collect latest filings")
        return
    
    # Apply client-side filters
    df = pd.DataFrame(news_items)
    
    if type_filter:
        df = df[df['news_type'].isin(type_filter)]
    
    if source_filter:
        df = df[df['source'].isin(source_filter)]
    
    if search_query:
        mask = df['headline'].str.contains(search_query, case=False, na=False) | \
               df['summary'].str.contains(search_query, case=False, na=False)
        df = df[mask]
    
    # Stats
    st.markdown("---")
    stat1, stat2, stat3, stat4 = st.columns(4)
    
    with stat1:
        st.metric("Total Events", len(df))
    
    with stat2:
        if not df.empty:
            latest = pd.to_datetime(df['published_at']).max()
            hours_ago = (datetime.now() - latest).total_seconds() / 3600
            st.metric("Latest Event", f"{hours_ago:.1f}h ago")
        else:
            st.metric("Latest Event", "N/A")
    
    with stat3:
        material_events = len(df[df['news_type'] == 'Material Event'])
        st.metric("Material Events (8-K)", material_events)
    
    with stat4:
        proxies = len(df[df['news_type'] == 'Proxy'])
        st.metric("Proxy Filings", proxies)
    
    # Event type breakdown
    if not df.empty:
        st.markdown("---")
        st.subheader("Event Type Breakdown")
        
        type_counts = df['news_type'].value_counts()
        
        col_chart, col_table = st.columns([2, 1])
        
        with col_chart:
            fig = px.bar(
                x=type_counts.index,
                y=type_counts.values,
                labels={'x': 'Event Type', 'y': 'Count'},
                title='',
                color=type_counts.values,
                color_continuous_scale='Blues'
            )
            fig.update_layout(showlegend=False, height=300)
            st.plotly_chart(fig, use_container_width=True)
        
        with col_table:
            st.dataframe(
                pd.DataFrame({
                    'Type': type_counts.index,
                    'Count': type_counts.values
                }),
                hide_index=True,
                use_container_width=True
            )
    
    # News feed
    st.markdown("---")
    st.subheader(f"📋 News Feed ({len(df)} items)")
    
    # Event type icons
    type_icons = {
        'Material Event': '🔴',
        'M&A': '🤝',
        'Proxy': '🗳️',
        'Activism': '📢',
        'Board Change': '👔',
        'Governance': '⚖️',
        'Other': '📋'
    }
    
    # Display news items
    for idx, item in df.iterrows():
        icon = type_icons.get(item['news_type'], '📋')
        
        # Calculate time ago
        published = pd.to_datetime(item['published_at'])
        time_diff = datetime.now() - published
        
        if time_diff.total_seconds() < 3600:
            time_ago = f"{int(time_diff.total_seconds() / 60)}m ago"
        elif time_diff.total_seconds() < 86400:
            time_ago = f"{int(time_diff.total_seconds() / 3600)}h ago"
        else:
            time_ago = f"{int(time_diff.days)}d ago"
        
        # Create expandable card
        with st.expander(f"{icon} **{item['headline']}** • {time_ago}", expanded=False):
            col_left, col_right = st.columns([3, 1])
            
            with col_left:
                st.markdown(f"**Summary**: {item.get('summary', 'No summary available')}")
                
                if item.get('filing_type'):
                    st.markdown(f"**Filing Type**: `{item['filing_type']}`")
                
                if item.get('sec_accession_number'):
                    st.markdown(f"**Accession**: `{item['sec_accession_number']}`")
            
            with col_right:
                st.markdown(f"**Type**: {item['news_type']}")
                st.markdown(f"**Source**: {item['source']}")
                st.markdown(f"**Published**: {published.strftime('%Y-%m-%d %H:%M')}")
            
            # Link button
            if item.get('url'):
                st.link_button("View Full Filing →", item['url'], use_container_width=True)
    
    # Export
    st.markdown("---")
    if not df.empty:
        csv = df[['headline', 'news_type', 'source', 'published_at', 'url']].to_csv(index=False)
        st.download_button(
            label="📥 Export News Feed (CSV)",
            data=csv,
            file_name=f"governance_news_{datetime.now().strftime('%Y%m%d')}.csv",
            mime="text/csv"
        )


# Add to main app.py navigation
if __name__ == "__main__":
    render_news_feed_page()
