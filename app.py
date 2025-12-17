import streamlit as st
import pandas as pd
import json
import plotly.express as px
import plotly.graph_objects as go
import os
import base64

# Page Config
st.set_page_config(
    page_title="Deep Tech Proxy Season 2026: What Should You Know?",
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
# Load Data
@st.cache_data(ttl=60) # Force refresh every 60 seconds to prevent stale data
def load_data(version="v2"):
    with open("data/stats.json", "r") as f:
        return json.load(f)

data = load_data("v4") # Bump version to bust cache
overall = data['overall']
sectors = pd.DataFrame(data['sectors'])

# Sidebar
st.sidebar.title("Deep Tech 2026: What Should You Know?")
st.sidebar.info("Analysis of 101,458 Companies")

# Download Report Button
pdf_path = "assets/Deep_Tech_2026_Final_v3.pdf"
html_path = "assets/Deep_Tech_2026_Report.html"

if os.path.exists(pdf_path):
    with open(pdf_path, "rb") as f:
        file_bytes = f.read()
    st.sidebar.download_button(
        label="📄 Download Full Report (PDF)",
        data=file_bytes,
        file_name="Deep_Tech_Proxy_Season_2026_What_Should_You_Know.pdf",
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
# st.write(f"Debug: Current page is {page}")

# --- Executive Summary ---
if page == "Executive Summary":
    st.title("The State of Governance in Deep Tech")
    st.markdown("### 2026 Proxy Season Outlook")
    
    # Key Metrics
    col1, col2, col3, col4 = st.columns(4)
    col1.metric("Total Companies", "101,458", help="Total companies in the analysis universe (Report Baseline).")
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
    
    # --- Charts Section ---
    
    # Row 1: Composition & Structure
    st.subheader("1. Sector Composition & Structure")
    r1c1, r1c2 = st.columns([2, 1])
    
    with r1c1:
        # Treemap of Sector Sizes
        # Filter out the massive "Cross Domain Enablement" bucket to show detail in others
        tree_df = sectors[sectors['sector'] != "Cross Domain Enablement"]
        
        fig_tree = px.treemap(
            tree_df, 
            path=['sector'], 
            values='count',
            title="Deep Tech Sub-Sector Composition (Excl. General Enablement)",
            color='count',
            color_continuous_scale='Blues'
        )
        st.plotly_chart(fig_tree, use_container_width=True)
        
    with r1c2:
        # Public vs Private Pie
        labels = ['Private', 'Public']
        values = [overall['private_pct'], overall['public_pct']]
        fig_pie = px.pie(
            names=labels, 
            values=values, 
            title="Public vs. Private Split",
            color_discrete_sequence=['#1e3a8a', '#60a5fa'],
            hole=0.4
        )
        st.plotly_chart(fig_pie, use_container_width=True)

    st.divider()

    # Row 2: Diversity Deep Dive
    st.subheader("2. Diversity Analysis")
    r2c1, r2c2 = st.columns(2)
    
    with r2c1:
        # Stacked Bar (Existing)
        div_data = []
        for _, row in sectors.iterrows():
            buckets = row['diversity_buckets']
            for bucket, val in buckets.items():
                div_data.append({"Sector": row['sector'], "Category": bucket, "Percentage": val})
        div_df = pd.DataFrame(div_data)
        cat_order = ["0 Women", "1 Woman", "2 Women", "3+ Women"]
        
        fig_div = px.bar(
            div_df, x="Percentage", y="Sector", color="Category", orientation='h',
            title="Board Gender Diversity Distribution",
            category_orders={"Category": cat_order},
            color_discrete_map={"0 Women": "#94a3b8", "1 Woman": "#60a5fa", "2 Women": "#2563eb", "3+ Women": "#1e3a8a"},
            height=400
        )
        st.plotly_chart(fig_div, use_container_width=True)
        
    with r2c2:
        # Zero Women Bar Chart (Sorted)
        # Calculate zero women pct from buckets if not explicitly in stats, or use what we have
        # We have diversity_buckets['0 Women']
        zero_women_data = []
        for _, row in sectors.iterrows():
            zero_women_data.append({
                "Sector": row['sector'],
                "Zero Women %": row['diversity_buckets']['0 Women']
            })
        zw_df = pd.DataFrame(zero_women_data).sort_values("Zero Women %", ascending=True)
        
        fig_zw = px.bar(
            zw_df, x="Zero Women %", y="Sector", orientation='h',
            title="Percentage of Boards with Zero Women",
            color="Zero Women %", color_continuous_scale='Reds',
            text_auto='.1f'
        )
        st.plotly_chart(fig_zw, use_container_width=True)

    st.divider()

    # Row 3: Technical Expertise & Governance
    st.subheader("3. Technical Expertise & Governance Quality")
    r3c1, r3c2 = st.columns(2)
    
    with r3c1:
        # Tech Stacked Bar (Existing)
        tech_data = []
        for _, row in sectors.iterrows():
            buckets = row['tech_buckets']
            for bucket, val in buckets.items():
                tech_data.append({"Sector": row['sector'], "Category": bucket, "Percentage": val})
        tech_df = pd.DataFrame(tech_data)
        tech_order = ["0-1 Experts", "2-3 Experts", "4+ Experts"]
        
        fig_tech = px.bar(
            tech_df, x="Percentage", y="Sector", color="Category", orientation='h',
            title="Technical Expertise Distribution",
            category_orders={"Category": tech_order},
            color_discrete_map={"0-1 Experts": "#fca5a5", "2-3 Experts": "#fbbf24", "4+ Experts": "#10b981"},
            height=400
        )
        st.plotly_chart(fig_tech, use_container_width=True)
        
    with r3c2:
        # Scatter: Women % vs Tech Experts
        fig_scat = px.scatter(
            sectors, x="avg_tech_experts", y="avg_women_pct",
            size="count", color="sector",
            title="Correlation: Diversity vs. Technical Expertise",
            labels={"avg_tech_experts": "Avg Tech Experts", "avg_women_pct": "Avg % Women"},
            hover_name="sector"
        )
        st.plotly_chart(fig_scat, use_container_width=True)

    st.divider()

    # Row 4: Board Structure & Oversight
    st.subheader("4. Board Structure & Oversight")
    r4c1, r4c2 = st.columns(2)
    
    with r4c1:
        # Avg Board Size & Independence
        # Check if column exists (defensive coding)
        if 'avg_board_size' in sectors.columns:
            # Filter out 0 values
            struct_df = sectors[sectors['avg_board_size'] > 0]
            
            # Normalize for chart
            fig_struct = go.Figure()
            fig_struct.add_trace(go.Bar(
                y=struct_df['sector'], x=struct_df['avg_board_size'],
                name='Avg Board Size', orientation='h', marker_color='#64748b'
            ))
        else:
            st.warning("Board size data not available.")
            struct_df = pd.DataFrame() # Empty for independence check
            fig_struct = go.Figure()
        # Check if we have independence data (might be missing if old json)
        if 'avg_indep_pct' in struct_df.columns:
             fig_struct.add_trace(go.Bar(
                y=struct_df['sector'], x=struct_df['avg_indep_pct'] / 10, # Scale down to match size roughly? No, use secondary axis or separate
                name='Independence % (Scaled / 10)', orientation='h', marker_color='#0ea5e9', visible='legendonly'
            ))
        
        fig_struct.update_layout(title="Average Board Size by Sector", barmode='group')
        st.plotly_chart(fig_struct, use_container_width=True)

    with r4c2:
        # AI Oversight Benchmark
        # Hardcoded benchmark data
        bench_data = pd.DataFrame({
            "Group": ["Fortune 100", "S&P 500", "Deep Tech (Avg)"],
            "AI Oversight %": [40, 30, sectors['ai_oversight_pct'].mean() if 'ai_oversight_pct' in sectors.columns else 5] # Fallback if missing
        })
        
        fig_bench = px.bar(
            bench_data, x="Group", y="AI Oversight %",
            title="AI Oversight Disclosure vs. Benchmarks",
            color="Group", color_discrete_map={"Fortune 100": "#cbd5e1", "S&P 500": "#94a3b8", "Deep Tech (Avg)": "#ef4444"},
            text_auto='.1f'
        )
        st.plotly_chart(fig_bench, use_container_width=True)

    st.divider()
    
    # Row 5: Board Effectiveness & Tenure
    st.subheader("5. Board Effectiveness & Tenure")
    r5c1, r5c2 = st.columns(2)
    
    with r5c1:
        # Avg Director Tenure
        if 'avg_tenure' in sectors.columns:
            # Filter out 0 values
            tenure_df = sectors[sectors['avg_tenure'] > 0].sort_values('avg_tenure', ascending=True)
            
            fig_tenure = px.bar(
                tenure_df, x="avg_tenure", y="sector", orientation='h',
                title="Average Director Tenure (Years)",
                color="avg_tenure", color_continuous_scale='Teal',
                text_auto='.1f'
            )
            st.plotly_chart(fig_tenure, use_container_width=True)
        else:
            st.info("Tenure data not available.")
            
    with r5c2:
        # CEO Duality (CEO is Chair)
        if 'ceo_chair_pct' in sectors.columns:
            duality_df = sectors.sort_values('ceo_chair_pct', ascending=True)
            
            fig_duality = px.bar(
                duality_df, x="ceo_chair_pct", y="sector", orientation='h',
                title="CEO Duality (% where CEO is Chair)",
                color="ceo_chair_pct", color_continuous_scale='Oranges',
                text_auto='.1f'
            )
            st.plotly_chart(fig_duality, use_container_width=True)
        else:
            st.info("CEO Duality data not available.")

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
    # Embed the PDF directly so it matches the user's upload exactly
    
    pdf_file = "assets/Deep_Tech_2026_Final_v3.pdf"
    
    if os.path.exists(pdf_file):
        with open(pdf_file, "rb") as f:
            base64_pdf = base64.b64encode(f.read()).decode('utf-8')
        
        # Add a direct download link in the main area as a backup
        st.markdown(f'<a href="data:application/pdf;base64,{base64_pdf}" download="Deep_Tech_Proxy_Season_2026_What_Should_You_Know.pdf" style="display: inline-block; padding: 10px 20px; background-color: #2563eb; color: white; text-decoration: none; border-radius: 5px; margin-bottom: 20px;">📥 Download PDF Report</a>', unsafe_allow_html=True)
        
        st.caption(f"Viewing: {os.path.basename(pdf_file)} ({len(base64_pdf)} bytes)")
            
        # Use <object> tag which is the standard for embedding PDFs
        pdf_display = f'<object data="data:application/pdf;base64,{base64_pdf}" type="application/pdf" width="100%" height="1000px"><p>Your browser does not support embedded PDFs. Please use the download button above.</p></object>'
        st.markdown(pdf_display, unsafe_allow_html=True)
    else:
        st.error("PDF file not found.")
