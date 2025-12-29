"""
IPO Readiness Dashboard
Interactive Streamlit dashboard for analyzing 95K private companies
"""

import streamlit as st
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import psycopg2
import os
from datetime import datetime

# Page config
st.set_page_config(
    page_title="IPO Readiness Dashboard",
    page_icon="📈",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Custom CSS
st.markdown("""
<style>
    .main-header {
        font-size: 2.5rem;
        font-weight: 700;
        color: #1f77b4;
        margin-bottom: 0.5rem;
    }
    .metric-card {
        background-color: #f0f2f6;
        padding: 1rem;
        border-radius: 0.5rem;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .stMetric {
        background-color: white;
        padding: 1rem;
        border-radius: 0.5rem;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
</style>
""", unsafe_allow_html=True)

# Database connection
@st.cache_resource
def get_database_connection():
    """Create database connection with credentials from Streamlit secrets or env vars"""
    try:
        conn = psycopg2.connect(
            host=st.secrets.get("SUPABASE_HOST", os.getenv("SUPABASE_HOST", "localhost")),
            database=st.secrets.get("SUPABASE_DB", os.getenv("SUPABASE_DB", "postgres")),
            user=st.secrets.get("SUPABASE_USER", os.getenv("SUPABASE_USER", "postgres")),
            password=st.secrets.get("SUPABASE_PASSWORD", os.getenv("SUPABASE_PASSWORD", ""))
        )
        return conn
    except Exception as e:
        st.error(f"Database connection failed: {e}")
        return None

# Load data
@st.cache_data(ttl=3600)
def load_ipo_data(min_score=0):
    """Load IPO readiness data from database"""
    conn = get_database_connection()
    if not conn:
        return None
    
    query = f"""
    SELECT * FROM ipo_readiness_scores 
    WHERE total_ipo_readiness_score >= {min_score}
    ORDER BY total_ipo_readiness_score DESC
    """
    
    try:
        df = pd.read_sql(query, conn)
        return df
    except Exception as e:
        st.error(f"Error loading data: {e}")
        return None

# Header
st.markdown('<div class="main-header">📈 IPO Readiness Dashboard</div>', unsafe_allow_html=True)
st.markdown("**Analyzing 95,000+ Private Companies for Public Market Readiness**")
st.markdown("---")

# Sidebar filters
with st.sidebar:
    st.header("🔍 Filters")
    
    min_score = st.slider(
        "Minimum IPO Readiness Score",
        min_value=0,
        max_value=100,
        value=40,
        step=5,
        help="Filter companies by minimum readiness score"
    )
    
    st.markdown("---")
    
    st.markdown("### Score Tiers")
    st.markdown("- **80-100:** IPO-Ready (12-18mo)")
    st.markdown("- **60-79:** Near-Term (18-24mo)")
    st.markdown("- **40-59:** Significant Gaps (2-3yr)")
    st.markdown("- **0-39:** Not Ready (3+yr)")
    
    st.markdown("---")
    
    # Data refresh
    if st.button("🔄 Refresh Data"):
        st.cache_data.clear()
        st.rerun()

# Load data
with st.spinner("Loading IPO readiness data..."):
    df = load_ipo_data(min_score)

if df is None or len(df) == 0:
    st.warning("No data available. Please check database connection and ensure the ipo_readiness_scores view exists.")
    st.stop()

# Additional filters
col1, col2, col3 = st.columns(3)

with col1:
    sectors = ['All'] + sorted(df['primary_sector'].dropna().unique().tolist())
    selected_sector = st.selectbox("Sector", sectors)

with col2:
    countries = ['All'] + sorted(df['incorporation_country'].dropna().unique().tolist())
    selected_country = st.selectbox("Country", countries)

with col3:
    tiers = ['All'] + sorted(df['readiness_tier'].dropna().unique().tolist())
    selected_tier = st.selectbox("Readiness Tier", tiers)

# Apply filters
filtered_df = df.copy()
if selected_sector != 'All':
    filtered_df = filtered_df[filtered_df['primary_sector'] == selected_sector]
if selected_country != 'All':
    filtered_df = filtered_df[filtered_df['incorporation_country'] == selected_country]
if selected_tier != 'All':
    filtered_df = filtered_df[filtered_df['readiness_tier'] == selected_tier]

# Key Metrics Row
st.markdown("### 📊 Key Metrics")
col1, col2, col3, col4, col5 = st.columns(5)

with col1:
    st.metric(
        "Total Companies",
        f"{len(filtered_df):,}",
        delta=f"{len(filtered_df) / len(df) * 100:.1f}% of dataset"
    )

with col2:
    ipo_ready = len(filtered_df[filtered_df['readiness_tier'] == 'IPO-Ready (12-18mo)'])
    st.metric("IPO-Ready", f"{ipo_ready:,}", delta="12-18 months")

with col3:
    avg_score = filtered_df['total_ipo_readiness_score'].mean()
    st.metric("Avg Score", f"{avg_score:.1f}", delta=f"±{filtered_df['total_ipo_readiness_score'].std():.1f}")

with col4:
    median_rev = filtered_df['revenue_usd'].median() / 1e6
    st.metric("Median Revenue", f"${median_rev:.1f}M")

with col5:
    total_patents = filtered_df['patent_count'].sum()
    st.metric("Total Patents", f"{total_patents:,}")

st.markdown("---")

# Main visualizations
tab1, tab2, tab3, tab4 = st.tabs(["📈 Overview", "🏆 Top Companies", "🔬 Deep Dive", "📁 Export"])

with tab1:
    # Row 1: Distribution charts
    col1, col2 = st.columns(2)
    
    with col1:
        st.subheader("Score Distribution")
        fig_hist = px.histogram(
            filtered_df,
            x='total_ipo_readiness_score',
            nbins=30,
            color='readiness_tier',
            title="IPO Readiness Score Distribution",
            labels={'total_ipo_readiness_score': 'IPO Readiness Score'},
            color_discrete_map={
                'IPO-Ready (12-18mo)': '#28a745',
                'Near-Term (18-24mo)': '#ffc107',
                'Significant Gaps (2-3yr)': '#fd7e14',
                'Not Ready (3+yr)': '#dc3545'
            }
        )
        fig_hist.add_vline(x=80, line_dash="dash", line_color="green", annotation_text="IPO-Ready")
        fig_hist.add_vline(x=60, line_dash="dash", line_color="orange", annotation_text="Near-Term")
        st.plotly_chart(fig_hist, use_container_width=True)
    
    with col2:
        st.subheader("Readiness Tier Breakdown")
        tier_counts = filtered_df['readiness_tier'].value_counts()
        fig_pie = px.pie(
            values=tier_counts.values,
            names=tier_counts.index,
            title="Companies by Readiness Tier",
            color=tier_counts.index,
            color_discrete_map={
                'IPO-Ready (12-18mo)': '#28a745',
                'Near-Term (18-24mo)': '#ffc107',
                'Significant Gaps (2-3yr)': '#fd7e14',
                'Not Ready (3+yr)': '#dc3545'
            }
        )
        st.plotly_chart(fig_pie, use_container_width=True)
    
    # Row 2: Sector analysis
    st.subheader("Top Sectors by IPO Readiness")
    col1, col2 = st.columns(2)
    
    with col1:
        sector_counts = filtered_df.groupby('primary_sector').agg({
            'company_name': 'count',
            'total_ipo_readiness_score': 'mean'
        }).rename(columns={'company_name': 'count', 'total_ipo_readiness_score': 'avg_score'})
        sector_counts = sector_counts.sort_values('count', ascending=True).tail(15)
        
        fig_sector = px.bar(
            sector_counts,
            x='count',
            y=sector_counts.index,
            orientation='h',
            title="Top 15 Sectors by Company Count",
            labels={'count': 'Number of Companies', 'index': 'Sector'},
            color='avg_score',
            color_continuous_scale='RdYlGn'
        )
        st.plotly_chart(fig_sector, use_container_width=True)
    
    with col2:
        # Revenue vs Score scatter
        fig_scatter = px.scatter(
            filtered_df,
            x='revenue_usd',
            y='total_ipo_readiness_score',
            color='readiness_tier',
            size='patent_count',
            hover_data=['company_name', 'primary_sector'],
            title="Revenue vs IPO Readiness Score",
            labels={
                'revenue_usd': 'Annual Revenue (USD)',
                'total_ipo_readiness_score': 'IPO Readiness Score'
            },
            color_discrete_map={
                'IPO-Ready (12-18mo)': '#28a745',
                'Near-Term (18-24mo)': '#ffc107',
                'Significant Gaps (2-3yr)': '#fd7e14',
                'Not Ready (3+yr)': '#dc3545'
            }
        )
        fig_scatter.update_xaxes(type='log', title='Annual Revenue (USD, log scale)')
        st.plotly_chart(fig_scatter, use_container_width=True)

with tab2:
    st.subheader("🏆 Top IPO Candidates")
    
    # Top companies table
    display_cols = [
        'company_name', 'primary_sector', 'incorporation_country',
        'revenue_usd', 'total_ipo_readiness_score', 'readiness_tier',
        'target_exchange', 'patent_count'
    ]
    
    top_companies = filtered_df.nlargest(50, 'total_ipo_readiness_score')[display_cols].copy()
    top_companies['revenue_usd'] = top_companies['revenue_usd'].apply(lambda x: f"${x/1e6:.1f}M" if pd.notna(x) else "N/A")
    top_companies.columns = ['Company', 'Sector', 'Country', 'Revenue', 'Score', 'Tier', 'Target Exchange', 'Patents']
    
    st.dataframe(
        top_companies,
        use_container_width=True,
        height=600,
        hide_index=True
    )
    
    # Download button for top companies
    csv = top_companies.to_csv(index=False)
    st.download_button(
        label="📥 Download Top 50 as CSV",
        data=csv,
        file_name=f"top_ipo_candidates_{datetime.now().strftime('%Y%m%d')}.csv",
        mime="text/csv"
    )

with tab3:
    st.subheader("🔬 Component Score Analysis")
    
    # Score component breakdown
    score_components = ['financial_score', 'governance_score', 'legal_score', 
                       'patent_score', 'risk_score', 'operational_score']
    
    component_avg = filtered_df[score_components].mean()
    component_max = pd.Series({
        'financial_score': 30,
        'governance_score': 25,
        'legal_score': 15,
        'patent_score': 10,
        'risk_score': 10,
        'operational_score': 10
    })
    
    # Create radar chart
    fig_radar = go.Figure()
    
    fig_radar.add_trace(go.Scatterpolar(
        r=component_avg.values,
        theta=['Financial', 'Governance', 'Legal', 'IP/Patents', 'Risk', 'Operational'],
        fill='toself',
        name='Average Score'
    ))
    
    fig_radar.add_trace(go.Scatterpolar(
        r=component_max.values,
        theta=['Financial', 'Governance', 'Legal', 'IP/Patents', 'Risk', 'Operational'],
        fill='toself',
        name='Maximum Possible',
        line=dict(dash='dash')
    ))
    
    fig_radar.update_layout(
        polar=dict(radialaxis=dict(visible=True, range=[0, 30])),
        showlegend=True,
        title="Average Component Scores vs Maximum"
    )
    
    st.plotly_chart(fig_radar, use_container_width=True)
    
    # Component correlation heatmap
    st.subheader("Component Correlation Matrix")
    corr_matrix = filtered_df[score_components].corr()
    
    fig_heatmap = px.imshow(
        corr_matrix,
        text_auto='.2f',
        color_continuous_scale='RdBu_r',
        title="Correlation Between Score Components"
    )
    st.plotly_chart(fig_heatmap, use_container_width=True)

with tab4:
    st.subheader("📁 Export Data")
    
    col1, col2 = st.columns(2)
    
    with col1:
        st.markdown("### Full Dataset Export")
        st.info(f"**{len(filtered_df):,}** companies match your current filters")
        
        # CSV export
        csv_full = filtered_df.to_csv(index=False)
        st.download_button(
            label="📥 Download Full Dataset (CSV)",
            data=csv_full,
            file_name=f"ipo_readiness_full_{datetime.now().strftime('%Y%m%d')}.csv",
            mime="text/csv"
        )
    
    with col2:
        st.markdown("### Executive Summary Export")
        st.info("Summary statistics and key insights")
        
        # Create summary report
        summary = f"""
IPO READINESS ANALYSIS SUMMARY
Generated: {datetime.now().strftime('%Y-%m-%d %H:%M')}

OVERVIEW:
- Total Companies Analyzed: {len(filtered_df):,}
- IPO-Ready (12-18mo): {len(filtered_df[filtered_df['readiness_tier'] == 'IPO-Ready (12-18mo)']):,}
- Near-Term (18-24mo): {len(filtered_df[filtered_df['readiness_tier'] == 'Near-Term (18-24mo)']):,}

FINANCIAL METRICS:
- Median Revenue: ${filtered_df['revenue_usd'].median()/1e6:.1f}M
- Median Score: {filtered_df['total_ipo_readiness_score'].median():.1f}

TOP SECTORS:
{filtered_df['primary_sector'].value_counts().head(5).to_string()}

TOP COUNTRIES:
{filtered_df['incorporation_country'].value_counts().head(5).to_string()}
        """
        
        st.download_button(
            label="📥 Download Summary Report (TXT)",
            data=summary,
            file_name=f"ipo_readiness_summary_{datetime.now().strftime('%Y%m%d')}.txt",
            mime="text/plain"
        )

# Footer
st.markdown("---")
st.markdown("""
<div style='text-align: center; color: #666; font-size: 0.9rem;'>
    Built with Streamlit | Data updated: {timestamp} | 
    <a href='https://github.com/yourusername/ipo-readiness-dashboard' target='_blank'>View on GitHub</a>
</div>
""".format(timestamp=datetime.now().strftime('%Y-%m-%d')), unsafe_allow_html=True)
