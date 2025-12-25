import streamlit as st
import pandas as pd
import plotly.graph_objects as go
import plotly.express as px
from supabase import create_client, Client
import os

# Page configuration
st.set_page_config(
    page_title="Executive Compensation Analytics | Deep Tech 2025",
    page_icon="📊",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Custom CSS
st.markdown("""
<style>
    .main-header {
        font-size: 3rem;
        font-weight: 800;
        background: linear-gradient(135deg, #2DD4BF 0%, #8B5CF6 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-align: center;
        margin-bottom: 0.5rem;
    }
    .subtitle {
        text-align: center;
        color: #94A3B8;
        font-size: 1.25rem;
        margin-bottom: 2rem;
    }
    .green-flag {
        background: rgba(16, 185, 129, 0.1);
        padding: 1rem;
        border-radius: 12px;
        border-left: 4px solid #10B981;
    }
    .red-flag {
        background: rgba(239, 68, 68, 0.1);
        padding: 1rem;
        border-radius: 12px;
        border-left: 4px solid #EF4444;
    }
</style>
""", unsafe_allow_html=True)

# Initialize Supabase connection
@st.cache_resource
def init_connection():
    try:
        url = st.secrets["SUPABASE_URL"]
        key = st.secrets["SUPABASE_KEY"]
    except:
        # Fallback for local development
        url = os.getenv("SUPABASE_URL", "https://mpabbijfgrmqiqnysiwf.supabase.co")
        key = os.getenv("SUPABASE_KEY")
    
    return create_client(url, key)

supabase = init_connection()

# Load data from Supabase
@st.cache_data(ttl=600)
def load_compensation_data():
    response = supabase.table('executive_compensation_annual').select(
        'company_id, companies(company_name, sector), fiscal_year, role, '
        'total_compensation, base_salary, bonus, stock_awards, option_awards, '
        'non_equity_incentive, change_in_pension, all_other_compensation'
    ).eq('role', 'CEO').order('total_compensation', desc=True).execute()
    
    data = response.data
    
    # Flatten the nested structure
    flattened = []
    for record in data:
        company_info = record.get('companies', {})
        flattened.append({
            'company': company_info.get('company_name', 'Unknown'),
            'sector': company_info.get('sector', 'Other'),
            'total': record.get('total_compensation', 0) or 0,
            'salary': record.get('base_salary', 0) or 0,
            'bonus': record.get('bonus', 0) or 0,
            'stock': record.get('stock_awards', 0) or 0,
            'option': record.get('option_awards', 0) or 0,
            'non_equity': record.get('non_equity_incentive', 0) or 0,
            'other': (record.get('change_in_pension', 0) or 0) + (record.get('all_other_compensation', 0) or 0)
        })
    
    df = pd.DataFrame(flattened)
    
    # Calculate equity mix
    df['equity_mix'] = ((df['stock'] + df['option']) / df['total'] * 100).fillna(0)
    df['equity_mix'] = df['equity_mix'].clip(0, 100)  # Cap at 100%
    
    # Remove records with zero/null total compensation
    df = df[df['total'] > 0]
    
    return df

# Header
st.markdown('<h1 class="main-header">Professional Compensation Analytics</h1>', unsafe_allow_html=True)
st.markdown('<p class="subtitle">Institutional-Grade Statistical Analysis | Deep Tech 2025</p>', unsafe_allow_html=True)

# Load data with error handling
try:
    df = load_compensation_data()
    
    if df.empty:
        st.error("No data available. Please check database connection.")
        st.stop()
        
except Exception as e:
    st.error(f"Database connection error: {str(e)}")
    st.info("Please ensure Supabase credentials are properly configured in Streamlit Cloud secrets.")
    st.stop()

# Sidebar
with st.sidebar:
    st.header("📊 Analytics Filters")
    
    # Get unique sectors
    all_sectors = sorted(df['sector'].unique())
    
    selected_sectors = st.multiselect(
        "Select Sectors",
        options=all_sectors,
        default=all_sectors[:5] if len(all_sectors) > 5 else all_sectors
    )
    
    comp_range = st.slider(
        "Total Compensation Range ($M)",
        min_value=0,
        max_value=int(df['total'].max() / 1e6) + 1,
        value=(0, int(df['total'].max() / 1e6) + 1)
    )
    
    st.markdown("---")
    st.markdown("### 📈 Key Metrics")
    st.metric("Total Companies", f"{len(df):,}")
    st.metric("Median Comp", f"${df['total'].median()/1e6:.1f}M")
    st.metric("Median Equity Mix", f"{df['equity_mix'].median():.1f}%")

# Filter data based on selections
filtered_df = df[
    (df['sector'].isin(selected_sectors)) &
    (df['total'] >= comp_range[0] * 1e6) &
    (df['total'] <= comp_range[1] * 1e6)
]

# Executive Summary
with st.expander("📋 Executive Summary", expanded=True):
    st.markdown(f"""
    This professional analytics dashboard provides institutional-grade statistical analysis of executive compensation 
    across **{len(df):,} deep technology companies** spanning multiple sectors. Analysis reveals **extreme equity dominance** 
    (median {df['equity_mix'].median():.1f}% equity mix) characteristic of high-growth technology sectors where multi-year vesting aligns 
    executive incentives with long-term shareholder value creation.
    
    **Key Finding**: Deep technology sectors converge on high equity mix regardless of specific 
    technology focus, reflecting industry-wide recognition that long product development cycles (3-10 years) require 
    multi-year equity vesting to prevent executive short-termism.
    """)

# Investment Framework
st.header("🎯 Investment Screening Framework")
col1, col2 = st.columns(2)

with col1:
    st.markdown("""
    <div class="green-flag">
    <h3>✅ Green Flags</h3>
    <ul>
        <li><strong>Equity ratio >85%</strong>: Forces executives to experience identical outcomes as shareholders</li>
        <li><strong>Compressed base salaries</strong>: $1-3M base in $20M+ packages signals commitment</li>
        <li><strong>Multi-year vesting</strong>: >80% equity requires 3-4 year vesting schedules</li>
    </ul>
    </div>
    """, unsafe_allow_html=True)

with col2:
    st.markdown("""
    <div class="red-flag">
    <h3>🚩 Red Flags</h3>
    <ul>
        <li><strong>Equity ratio <50%</strong>: Cash-heavy structures signal misalignment</li>
        <li><strong>Zero equity compensation</strong>: 100% cash inappropriate for deep tech</li>
        <li><strong>Internal inequality >20x</strong>: Creates organizational stress</li>
    </ul>
    </div>
    """, unsafe_allow_html=True)

# Statistical Distribution
st.header("📊 Statistical Distribution Analysis")

col1, col2 = st.columns(2)

with col1:
    # Compensation distribution
    fig = px.box(filtered_df, y='total', points='all', 
                 title='Total Compensation Distribution',
                 labels={'total': 'Total Compensation ($)'})
    fig.update_layout(height=400)
    st.plotly_chart(fig, width='stretch')

with col2:
    # Equity mix distribution
    fig = px.histogram(filtered_df, x='equity_mix', nbins=20,
                      title='Equity Mix Distribution',
                      labels={'equity_mix': 'Equity Mix %'})
    fig.add_vline(x=85, line_dash="dash", line_color="green", 
                  annotation_text="Strong Alignment Threshold")
    fig.update_layout(height=400)
    st.plotly_chart(fig, width='stretch')

# Sector Benchmarking
st.header("🎯 Sector Benchmarking")

# Calculate sector stats
sector_stats = filtered_df.groupby('sector').agg({
    'total': ['count', 'mean', 'median'],
    'equity_mix': 'median',
    'salary': 'median'
}).round(2)

sector_stats.columns = ['N', 'Mean Comp', 'Median Comp', 'Median Equity Mix', 'Median Salary']
sector_stats = sector_stats.reset_index()

# Sector comparison chart  
fig = go.Figure()
fig.add_trace(go.Bar(
    name='Median Comp',
    x=sector_stats['sector'],
    y=sector_stats['Median Comp'],
    marker_color='#2DD4BF'
))
fig.add_trace(go.Bar(
    name='Mean Comp',
    x=sector_stats['sector'],
    y=sector_stats['Mean Comp'],
    marker_color='#8B5CF6'
))
fig.update_layout(
    title='Sector Compensation Comparison',
    xaxis_title='Sector',
    yaxis_title='Compensation ($)',
    barmode='group',
    height=400
)
st.plotly_chart(fig, width='stretch')

# Sector stats table
st.markdown("### 📈 Cross-Sector Statistical Summary")
st.dataframe(
    sector_stats.style.format({
        'Mean Comp': '${:,.0f}',
        'Median Comp': '${:,.0f}',
        'Median Equity Mix': '{:.1f}%',
        'Median Salary': '${:,.0f}'
    }),
    width='stretch'
)

# Red Flag Companies
st.header("🚩 Red Flag Alert: Cash-Heavy Compensation")

cash_heavy = filtered_df[filtered_df['equity_mix'] < 50].sort_values('total', ascending=False)

if len(cash_heavy) > 0:
    st.warning(f"**{len(cash_heavy)} companies** in current filter exhibit cash-heavy compensation structures (<50% equity).")
    
    st.dataframe(
        cash_heavy[['company', 'sector', 'total', 'equity_mix', 'salary', 'non_equity']].head(20).style.format({
            'total': '${:,.0f}',
            'equity_mix': '{:.1f}%',
            'salary': '${:,.0f}',
            'non_equity': '${:,.0f}'
        }),
        width='stretch'
    )
else:
    st.success("No cash-heavy companies in current filter!")

# Top Companies by Sector
st.header("📑 Top 10 Companies by Sector")

for sector in selected_sectors[:5]:  # Limit to first 5 selected sectors
    sector_df = filtered_df[filtered_df['sector'] == sector].head(10)
    
    if not sector_df.empty:
        with st.expander(f"{sector} - Top 10"):
            st.dataframe(
                sector_df[['company', 'total', 'salary', 'stock', 'option', 'bonus', 'non_equity', 'other', 'equity_mix']].style.format({
                    'total': '${:,.0f}',
                    'salary': '${:,.0f}',
                    'stock': '${:,.0f}',
                    'option': '${:,.0f}',
                    'bonus': '${:,.0f}',
                    'non_equity': '${:,.0f}',
                    'other': '${:,.0f}',
                    'equity_mix': '{:.1f}%'
                }),
                width='stretch'
            )

# Footer
st.markdown("---")
st.markdown(f"""
**Methodology**: Statistical analysis using SEC DEF 14A Summary Compensation Tables  
**Sample**: {len(df):,} CEO compensation records from deep tech companies  
**Analysis Date**: December 25, 2025  
**Data Source**: SEC EDGAR filings (2024-2025 proxy season)
""")
