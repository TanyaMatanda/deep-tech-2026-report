import streamlit as st
import pandas as pd
import plotly.graph_objects as go
import plotly.express as px
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

# Try to import supabase, fall back to sample data if not available
USE_DATABASE = False
try:
    from supabase import create_client
    USE_DATABASE = True
except ImportError:
    st.warning("⚠️ Showing sample data. Install supabase-py for full dataset.")

# Load data function with fallback
@st.cache_data(ttl=600)
def load_compensation_data():
    # Try database first if supabase is available
    if USE_DATABASE:
        try:
            url = st.secrets.get("SUPABASE_URL") or os.getenv("SUPABASE_URL")
            key = st.secrets.get("SUPABASE_KEY") or os.getenv("SUPABASE_KEY")
            
            if url and key:
                supabase = create_client(url, key)
                response = supabase.table('executive_compensation_annual').select(
                    'company_id, companies(company_name, sector), fiscal_year, role, '
                    'total_compensation, base_salary, bonus, stock_awards, option_awards, '
                    'non_equity_incentive, change_in_pension, all_other_compensation'
                ).eq('role', 'CEO').order('total_compensation', desc=True).limit(1000).execute()
                
                flattened = []
                for record in response.data:
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
                df = df[df['total'] > 0]
                df['equity_mix'] = ((df['stock'] + df['option']) / df['total'] * 100).fillna(0).clip(0, 100)
                
                if not df.empty:
                    st.success(f"✅ Connected to database: {len(df)} companies loaded")
                    return df
        except Exception as e:
            st.info(f"Database unavailable, using sample data. ({str(e)[:50]}...)")
    
    # Fallback to embedded sample data
    sample_data = [
        {'company': 'CISCO SYSTEMS', 'sector': 'Technology', 'total': 52796930, 'salary': 1385000, 'stock': 45914748, 'option': 0, 'bonus': 0, 'non_equity': 0, 'other': 5497182},
        {'company': 'AMD', 'sector': 'Technology', 'total': 30971764, 'salary': 2062500, 'stock': 18671682, 'option': 0, 'bonus': 0, 'non_equity': 9945000, 'other': 292582},
        {'company': 'Meta Platforms', 'sector': 'Technology', 'total': 27209926, 'salary': 1000000, 'stock': 23627000, 'option': 0, 'bonus': 0, 'non_equity': 0, 'other': 2582926},
        {'company': 'Applied Materials', 'sector': 'Technology', 'total': 27773894, 'salary': 1668000, 'stock': 22116630, 'option': 0, 'bonus': 0, 'non_equity': 3708000, 'other': 281264},
        {'company': 'Bloom Energy', 'sector': 'Energy & Climate', 'total': 44961745, 'salary': 1298695, 'stock': 39968710, 'option': 0, 'bonus': 0, 'non_equity': 3755269, 'other': 0},
        {'company': 'CrowdStrike', 'sector': 'Cybersecurity', 'total': 35195300, 'salary': 837695, 'stock': 148504806, 'option': 0, 'bonus': 0, 'non_equity': 1320000, 'other': 1000000},
        {'company': 'TG THERAPEUTICS', 'sector': 'Biotechnology', 'total': 18800211, 'salary': 2331000, 'stock': 91717000, 'option': 0, 'bonus': 0, 'non_equity': 0, 'other': 207211},
        {'company': 'GE HealthCare', 'sector': 'Advanced Technology', 'total': 19487880, 'salary': 2050000, 'stock': 13412402, 'option': 0, 'bonus': 0, 'non_equity': 4407205, 'other': 0},
        {'company': 'REGENERON', 'sector': 'Biotechnology', 'total': 10102576, 'salary': 1888461, 'stock': 5691012, 'option': 0, 'bonus': 0, 'non_equity': 2271250, 'other': 251853},
        {'company': 'SM Energy Co', 'sector': 'Energy & Climate', 'total': 12240662, 'salary': 770293, 'stock': 11928971, 'option': 0, 'bonus': 0, 'non_equity': 3516638, 'other': 305989},
    ]
    
    df = pd.DataFrame(sample_data)
    df['equity_mix'] = ((df['stock'] + df['option']) / df['total'] * 100).fillna(0).clip(0, 100)
    
    return df

# Header
st.markdown('<h1 class="main-header">Professional Compensation Analytics</h1>', unsafe_allow_html=True)
st.markdown('<p class="subtitle">Institutional-Grade Statistical Analysis | Deep Tech 2025</p>', unsafe_allow_html=True)

# Load data
df = load_compensation_data()

# Sidebar
with st.sidebar:
    st.header("📊 Analytics Filters")
    
    all_sectors = sorted(df['sector'].unique())
    
    selected_sectors = st.multiselect(
        "Select Sectors",
        options=all_sectors,
        default=all_sectors
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

# Filter data
filtered_df = df[
    (df['sector'].isin(selected_sectors)) &
    (df['total'] >= comp_range[0] * 1e6) &
    (df['total'] <= comp_range[1] * 1e6)
]

# Executive Summary
with st.expander("📋 Executive Summary", expanded=True):
    st.markdown(f"""
    This professional analytics dashboard provides institutional-grade statistical analysis of executive compensation 
    across **{len(df):,} deep technology companies**. Analysis reveals **extreme equity dominance** 
    (median {df['equity_mix'].median():.1f}% equity mix) characteristic of high-growth technology sectors.
    
    **Key Finding**: Deep technology sectors converge on high equity mix, reflecting industry-wide recognition 
    that long product cycles (3-10 years) require multi-year equity vesting to prevent short-termism.
    """)

# Investment Framework
st.header("🎯 Investment Screening Framework")
col1, col2 = st.columns(2)

with col1:
    st.markdown("""
    <div class="green-flag">
    <h3>✅ Green Flags</h3>
    <ul>
        <li><strong>Equity ratio >85%</strong>: Aligns with shareholders</li>
        <li><strong>Compressed salaries</strong>: $1-3M in $20M+ packages</li>
        <li><strong>Multi-year vesting</strong>: 3-4 year schedules</li>
    </ul>
    </div>
    """, unsafe_allow_html=True)

with col2:
    st.markdown("""
    <div class="red-flag">
    <h3>🚩 Red Flags</h3>
    <ul>
        <li><strong>Equity <50%</strong>: Cash-heavy misalignment</li>
        <li><strong>Zero equity</strong>: Inappropriate for tech</li>
        <li><strong>High inequality</strong>: Organizational stress</li>
    </ul>
    </div>
    """, unsafe_allow_html=True)

# Charts
st.header("📊 Statistical Distribution")
col1, col2 = st.columns(2)

with col1:
    fig = px.box(filtered_df, y='total', title='Compensation Distribution')
    st.plotly_chart(fig, width='stretch')

with col2:
    fig = px.histogram(filtered_df, x='equity_mix', title='Equity Mix Distribution')
    fig.add_vline(x=85, line_dash="dash", line_color="green")
    st.plotly_chart(fig, width='stretch')

# Sector stats
st.header("🎯 Sector Benchmarking")
sector_stats = filtered_df.groupby('sector').agg({
    'total': ['count', 'mean', 'median'],
    'equity_mix': 'median'
}).round(0)
sector_stats.columns = ['N', 'Mean', 'Median', 'Equity %']
st.dataframe(sector_stats, width='stretch')

# Red flags
cash_heavy = filtered_df[filtered_df['equity_mix'] < 50]
if len(cash_heavy) > 0:
    st.header("🚩 Cash-Heavy Alert")
    st.warning(f"{len(cash_heavy)} companies with <50% equity")
    st.dataframe(cash_heavy[['company', 'sector', 'total', 'equity_mix']].head(10), width='stretch')

# Footer
st.markdown("---")
st.markdown(f"""
**Sample**: {len(df):,} companies | **Source**: SEC DEF 14A filings | **Date**: Dec 2025
""")
