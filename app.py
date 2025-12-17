import streamlit as st
import pandas as pd
import json
import plotly.express as px
import os

# Page Config
st.set_page_config(
    page_title="Deep Tech 2026 Proxy Season Report",
    page_icon="📊",
    layout="wide"
)

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
    
    # Charts
    c1, c2 = st.columns(2)
    
    with c1:
        st.subheader("Diversity by Sector")
        fig_div = px.bar(
            sectors.sort_values("avg_women_pct", ascending=True),
            x="avg_women_pct",
            y="sector",
            orientation='h',
            title="Average % Women on Boards",
            labels={"avg_women_pct": "% Women", "sector": "Sector"},
            color="avg_women_pct",
            color_continuous_scale="Viridis"
        )
        st.plotly_chart(fig_div, use_container_width=True)
        
    with c2:
        st.subheader("Technical Expertise by Sector")
        fig_tech = px.bar(
            sectors.sort_values("avg_tech_experts", ascending=True),
            x="avg_tech_experts",
            y="sector",
            orientation='h',
            title="Average Tech Experts per Board",
            labels={"avg_tech_experts": "Tech Experts", "sector": "Sector"},
            color="avg_tech_experts",
            color_continuous_scale="Magma"
        )
        st.plotly_chart(fig_tech, use_container_width=True)

# --- Sector Deep Dives ---
elif page == "Sector Deep Dives":
    st.title("Sector Deep Dives")
    
    selected_sector = st.selectbox("Select Sector", sectors['sector'].unique())
    
    sec_data = sectors[sectors['sector'] == selected_sector].iloc[0]
    
    col1, col2, col3 = st.columns(3)
    col1.metric("Sample Size", sec_data['count'])
    col2.metric("Women on Boards", f"{sec_data['avg_women_pct']}%")
    col3.metric("Tech Experts", sec_data['avg_tech_experts'])
    
    st.progress(sec_data['avg_women_pct'] / 50, text=f"Progress to Parity ({sec_data['avg_women_pct']}%)")
    
    st.markdown("### Sector Insights")
    # Hardcoded insights mapping (simplified for demo)
    insights = {
        "Semiconductors & AI": "High technical barrier to entry limits traditional director pool. Governance focuses on supply chain and IP protection.",
        "Energy & Climate": "Sector leader in diversity. Regulatory pressure drives higher governance standards.",
        "Biotechnology": "Boards often composed of MDs/PhDs. 'Tech Expert' count may understate medical expertise.",
        "Quantum & Photonics": "Lowest diversity. Niche talent pool creates tension between meritocracy and diversity.",
        "Cross Domain Enablement": "Represents the 'average' Deep Tech company. B2B SaaS tends to have better governance than Consumer Tech."
    }
    
    st.write(insights.get(selected_sector, "Data available in full report."))

# --- Full Report ---
elif page == "Full Report":
    st.title("Deep Tech 2026 Comprehensive Report")
    
    with open("assets/deep_tech_2026_comprehensive_report.md", "r") as f:
        report_text = f.read()
        
    st.markdown(report_text)
