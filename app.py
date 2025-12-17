import streamlit as st
import pandas as pd
import json
import plotly.express as px
import plotly.graph_objects as go
import os

# Page Config
st.set_page_config(
    page_title="Deep Tech 2026 Proxy Season Report",
    page_icon="📊",
    layout="wide"
)

# Custom CSS for Professional Look
st.markdown("""
<style>
    .main .block-container {
        padding-top: 2rem;
    }
    h1 {
        color: #0f172a;
    }
    h2 {
        color: #1e293b;
        border-bottom: 2px solid #e2e8f0;
        padding-bottom: 0.5rem;
    }
    h3 {
        color: #334155;
    }
    .stMetric {
        background-color: #f8fafc;
        padding: 1rem;
        border-radius: 0.5rem;
        border: 1px solid #e2e8f0;
    }
</style>
""", unsafe_allow_html=True)

# Load Data
@st.cache_data
def load_data():
    with open("data/stats.json", "r") as f:
        return json.load(f)

data = load_data()
overall = data['overall']
sectors = pd.DataFrame(data['sectors'])

# Sidebar
st.sidebar.title("Deep Tech 2026")
st.sidebar.info("Analysis of 101,458 Companies")

# Download Report Button
pdf_path = "assets/Deep_Tech_2026_Report.pdf"
html_path = "assets/Deep_Tech_2026_Report.html"

if os.path.exists(pdf_path):
    with open(pdf_path, "rb") as f:
        file_bytes = f.read()
    st.sidebar.download_button(
        label="📄 Download Full Report (PDF)",
        data=file_bytes,
        file_name="Deep_Tech_2026_Report.pdf",
        mime="application/pdf"
    )
elif os.path.exists(html_path):
    with open(html_path, "r") as f:
        file_bytes = f.read()
    st.sidebar.download_button(
        label="🌐 Download Full Report (HTML)",
        data=file_bytes,
        file_name="Deep_Tech_2026_Report.html",
        mime="text/html",
        help="Download the report as a clean HTML file. You can Print to PDF from your browser."
    )
else:
    st.sidebar.warning("Report download not available.")

# Navigation
page = st.sidebar.radio("Navigate", ["Executive Summary", "Sector Deep Dives", "Full Report"])

# --- Executive Summary ---
if page == "Executive Summary":
    st.title("The State of Governance in Deep Tech")
    st.markdown("### 2026 Proxy Season Outlook")
    
    # Key Metrics
    col1, col2, col3, col4 = st.columns(4)
    col1.metric("Total Companies", f"{overall['total_companies']:,}")
    col2.metric("Avg Women on Boards", f"{overall['avg_women_pct']}%", delta_color="off")
    col3.metric("Zero Women Boards", f"{overall['pct_zero_women']}%", delta_color="inverse")
    col4.metric("Avg Tech Experts", f"{overall['avg_tech_experts']}")
    
    st.divider()
    
    # Context
    st.info(f"**Context:** This dataset is **{overall['private_pct']}% Private** and **{overall['public_pct']}% Public**. The high percentage of private companies explains the lower diversity figures compared to S&P 500 benchmarks.")
    
    with st.expander("ℹ️ Definitions & Limitations"):
        st.markdown("""
        **Definitions:**
        *   **Diversity:** Measured as the percentage of board directors who are women.
        *   **Technical Expertise:** Directors with explicit backgrounds in STEM, R&D, Engineering, or specialized scientific fields relevant to the company's core technology.
        
        **Limitations:**
        *   **Private Company Data:** 95% of the dataset consists of private companies. Governance data for these entities is disclosure-based and may not fully capture informal advisory structures.
        *   **Lagging Indicators:** Public filings (Proxy Statements) are retrospective. Real-time board changes may not be immediately reflected.
        *   **Sector Classification:** Companies are categorized by their primary revenue-generating activity or core technology focus.
        """)
    
    # Charts
    c1, c2 = st.columns(2)
    
    with c1:
        st.subheader("Diversity Distribution by Sector")
        # Prepare data for stacked bar
        div_data = []
        for _, row in sectors.iterrows():
            buckets = row['diversity_buckets']
            for bucket, val in buckets.items():
                div_data.append({
                    "Sector": row['sector'],
                    "Category": bucket,
                    "Percentage": val
                })
        div_df = pd.DataFrame(div_data)
        
        # Custom sort order for categories
        cat_order = ["0 Women", "1 Woman", "2 Women", "3+ Women"]
        
        fig_div = px.bar(
            div_df,
            x="Percentage",
            y="Sector",
            color="Category",
            orientation='h',
            title="Board Gender Diversity Breakdown",
            category_orders={"Category": cat_order},
            color_discrete_map={
                "0 Women": "#94a3b8",  # Grey
                "1 Woman": "#60a5fa",  # Light Blue
                "2 Women": "#2563eb",  # Blue
                "3+ Women": "#1e3a8a"  # Dark Blue
            },
            height=500
        )
        fig_div.update_layout(legend_title_text='')
        st.plotly_chart(fig_div, use_container_width=True)
        
    with c2:
        st.subheader("Technical Expertise Distribution")
        # Prepare data for stacked bar
        tech_data = []
        for _, row in sectors.iterrows():
            buckets = row['tech_buckets']
            for bucket, val in buckets.items():
                tech_data.append({
                    "Sector": row['sector'],
                    "Category": bucket,
                    "Percentage": val
                })
        tech_df = pd.DataFrame(tech_data)
        
        tech_order = ["0-1 Experts", "2-3 Experts", "4+ Experts"]
        
        fig_tech = px.bar(
            tech_df,
            x="Percentage",
            y="Sector",
            color="Category",
            orientation='h',
            title="Board Technical Expertise Breakdown",
            category_orders={"Category": tech_order},
            color_discrete_map={
                "0-1 Experts": "#fca5a5", # Light Red
                "2-3 Experts": "#fbbf24", # Amber
                "4+ Experts": "#10b981"   # Emerald
            },
            height=500
        )
        fig_tech.update_layout(legend_title_text='')
        st.plotly_chart(fig_tech, use_container_width=True)

# --- Sector Deep Dives ---
elif page == "Sector Deep Dives":
    st.title("Sector Deep Dives")
    
    selected_sector = st.selectbox("Select Sector", sectors['sector'].unique())
    
    sec_data = sectors[sectors['sector'] == selected_sector].iloc[0]
    
    # Top Level Metrics
    col1, col2, col3 = st.columns(3)
    col1.metric("Sample Size", sec_data['count'])
    col2.metric("Women on Boards", f"{sec_data['avg_women_pct']}%", 
                delta=f"{round(sec_data['avg_women_pct'] - overall['avg_women_pct'], 1)}% vs Avg")
    col3.metric("Tech Experts", sec_data['avg_tech_experts'],
                delta=f"{round(sec_data['avg_tech_experts'] - overall['avg_tech_experts'], 1)} vs Avg")
    
    st.divider()
    
    # Comparative Analysis
    st.subheader("Comparative Analysis")
    
    # Radar Chart for comparison
    categories = ['Women %', 'Tech Experts (Scaled)', 'Zero Women % (Inverted)']
    
    # Normalize for radar chart (rough scaling)
    def normalize(val, max_val): return min(val / max_val, 1.0)
    
    # Invert zero women (lower is better) -> 100 - val
    sec_vals = [
        sec_data['avg_women_pct'], 
        sec_data['avg_tech_experts'] * 10, # Scale up to match %
        100 - ((sec_data['diversity_buckets']['0 Women']))
    ]
    
    avg_vals = [
        overall['avg_women_pct'],
        overall['avg_tech_experts'] * 10,
        100 - overall['pct_zero_women']
    ]
    
    fig_radar = go.Figure()
    
    fig_radar.add_trace(go.Scatterpolar(
        r=sec_vals,
        theta=categories,
        fill='toself',
        name=selected_sector,
        line_color='#2563eb'
    ))
    
    fig_radar.add_trace(go.Scatterpolar(
        r=avg_vals,
        theta=categories,
        fill='toself',
        name='Deep Tech Average',
        line_color='#94a3b8',
        opacity=0.5
    ))
    
    fig_radar.update_layout(
        polar=dict(
            radialaxis=dict(
                visible=True,
                range=[0, 100]
            )),
        showlegend=True,
        title="Sector Performance vs Average"
    )
    
    c1, c2 = st.columns([1, 1])
    with c1:
        st.plotly_chart(fig_radar, use_container_width=True)
    
    with c2:
        st.markdown("### Key Insights")
        # Dynamic Insights
        if sec_data['avg_women_pct'] > overall['avg_women_pct']:
            st.success(f"**Leader in Diversity:** {selected_sector} outperforms the industry average in gender diversity.")
        else:
            st.warning(f"**Lagging in Diversity:** {selected_sector} is below the industry average for women on boards.")
            
        if sec_data['avg_tech_experts'] > overall['avg_tech_experts']:
            st.info(f"**High Technical Depth:** Boards in this sector have significantly more technical experts than average.")
            
        # Hardcoded qualitative insights
        insights = {
            "Semiconductors & AI": "High technical barrier to entry limits traditional director pool. Governance focuses on supply chain and IP protection.",
            "Energy & Climate": "Sector leader in diversity. Regulatory pressure drives higher governance standards.",
            "Biotechnology": "Boards often composed of MDs/PhDs. 'Tech Expert' count may understate medical expertise.",
            "Quantum & Photonics": "Lowest diversity. Niche talent pool creates tension between meritocracy and diversity.",
            "Cross Domain Enablement": "Represents the 'average' Deep Tech company. B2B SaaS tends to have better governance than Consumer Tech."
        }
        st.markdown(f"**Sector Context:** {insights.get(selected_sector, 'No specific context available.')}")

# --- Full Report ---
elif page == "Full Report":
    st.title("Deep Tech 2026 Comprehensive Report")
    
    with open("assets/deep_tech_2026_comprehensive_report.md", "r") as f:
        report_text = f.read()
        
    st.markdown(report_text)
