import streamlit as st
import pandas as pd
import json
import plotly.express as px
import plotly.graph_objects as go
import os
import base64

# Page Config
st.set_page_config(page_title="Deep Tech Governance 2026", layout="wide")

# --- McKinsey-Style Design System ---
MCKINSEY_BLUE = "#051c2c"
MCKINSEY_LIGHT_BLUE = "#0077c8"
MCKINSEY_TEAL = "#00a3e0"
MCKINSEY_GREY = "#b7b7b7"
MCKINSEY_PALETTE = [MCKINSEY_BLUE, MCKINSEY_LIGHT_BLUE, MCKINSEY_TEAL, "#666666", "#999999"]

# Custom CSS
st.markdown("""
<style>
    /* Typography */
    html, body, [class*="css"] {
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        color: #333333;
    }
    h1, h2, h3 {
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-weight: 600;
        color: #051c2c;
        letter-spacing: -0.5px;
    }
    h1 { font-size: 2.5rem !important; margin-bottom: 1rem !important; }
    h2 { font-size: 1.75rem !important; margin-top: 2rem !important; border-bottom: 2px solid #051c2c; padding-bottom: 10px; }
    h3 { font-size: 1.25rem !important; color: #0077c8; text-transform: uppercase; letter-spacing: 1px; margin-top: 1.5rem !important; }
    
    /* Metrics */
    div[data-testid="stMetricValue"] {
        font-family: "Georgia", serif;
        font-size: 2.2rem !important;
        color: #051c2c;
    }
    div[data-testid="stMetricLabel"] {
        font-size: 0.85rem !important;
        color: #666666;
        text-transform: uppercase;
        font-weight: 600;
    }
    
    /* Sidebar */
    section[data-testid="stSidebar"] {
        background-color: #f4f4f4;
        border-right: 1px solid #d9d9d9;
    }
    
    /* Dividers */
    hr {
        margin-top: 2rem;
        margin-bottom: 2rem;
        border-top: 1px solid #d9d9d9;
    }
    
    .main .block-container {
        padding-top: 2rem;
    }
    
    /* Metric Card Styling */
    div[data-testid="metric-container"] {
        background-color: #ffffff;
        padding: 1.5rem;
        border-radius: 4px;
        border: 1px solid #e5e5e5;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
</style>
""", unsafe_allow_html=True)

# Load Data
# Load Data
@st.cache_data(ttl=3600) # Standard caching
def load_data(version="v12.0"):
    # Robust pathing: find data relative to this script
    base_dir = os.path.dirname(os.path.abspath(__file__))
    path = os.path.join(base_dir, "data", "stats.json")
    abs_path = os.path.abspath(path)
    
    with open(path, "r") as f:
        data = json.load(f)
        return data

data = load_data("v12.0")
overall = data['overall']
sectors = pd.DataFrame(data['sectors'])

# Sidebar
st.sidebar.markdown(f"""
<div style="padding: 1rem; background-color: #051c2c; color: white; border-radius: 4px; margin-bottom: 2rem;">
    <h3 style="color: white; margin: 0; font-size: 1.2rem;">DEEP TECH 2026</h3>
    <p style="margin: 0; font-size: 0.8rem; opacity: 0.8;">Governance & Proxy Analysis</p>
</div>
""", unsafe_allow_html=True)

st.sidebar.markdown(f"**Universe:** 101,458 Companies")
st.sidebar.markdown(f"**Source:** Proprietary Analysis")

# Download Report Button
pdf_path = "assets/Deep_Tech_2026_Final_v3.pdf"
html_path = "assets/Deep_Tech_2026_Report.html"

if os.path.exists(pdf_path):
    with open(pdf_path, "rb") as f:
        file_bytes = f.read()
    st.sidebar.download_button(
        label="Download Full Report (PDF)",
        data=file_bytes,
        file_name="Deep_Tech_Proxy_Season_2026_What_Should_You_Know.pdf",
        mime="application/pdf"
    )
elif os.path.exists(html_path):
    with open(html_path, "r") as f:
        file_bytes = f.read()
    st.sidebar.download_button(
        label="Download Full Report (HTML)",
        data=file_bytes,
        file_name="Deep_Tech_2026_Report.html",
        mime="text/html",
        help="Download the report as a clean HTML file. You can Print to PDF from your browser."
    )
else:
    st.sidebar.warning("Report download not available.")

# Navigation
page = st.sidebar.radio("Navigate", [
    "Executive Summary", 
    "Sector Deep Dives",
    "Regulatory Risk Dashboard",  # NEW: Combined Jurisdictional + Company Search
    "Jurisdictional Analysis",     # Keep for backward compatibility
    "Company Search",               # Keep for backward compatibility  
    "Governance Explorer", 
    "Full Report"
])

# --- Main Application ---
if page == "Executive Summary":
    st.title("The State of Governance in Deep Tech")
    st.markdown("<p style='font-size: 1.2rem; color: #666; font-weight: 400; margin-top: -1rem;'>2026 PROXY SEASON OUTLOOK</p>", unsafe_allow_html=True)
    
    # Key Metrics
    col1, col2, col3, col4 = st.columns(4)
    col1.metric("Total Companies", "101,458", help="Total companies in the analysis universe (Report Baseline).")
    col2.metric("Avg Women on Boards", f"{overall['avg_women_pct']}%", delta_color="off")
    col3.metric("Zero Women Boards", f"{overall['pct_zero_women']}%", delta_color="inverse")
    col4.metric("Avg Tech Experts", f"{overall['avg_tech_experts']}")
    
    st.divider()
    
    # Market Context
    st.markdown("""
    <div style="background-color: #f8f9fa; padding: 1.5rem; border-left: 5px solid #051c2c; margin-bottom: 2rem;">
        <h4 style="margin-top: 0; color: #051c2c;">MARKET CONTEXT</h4>
        <p style="margin-bottom: 0;">This analysis covers a universe of <b>101,458 companies</b>. The dataset is <b>""" + str(overall['private_pct']) + """% Private</b> and <b>""" + str(overall['public_pct']) + """% Public</b>. 
        The high concentration of private companies is a key driver of the governance trends observed, particularly in diversity and disclosure levels compared to public benchmarks.</p>
    </div>
    """, unsafe_allow_html=True)

    # 2025 Risk Landscape
    st.markdown("### 2025 Risk Landscape")
    
    # Fetch risk stats for dynamic chart
    from db_connection import init_connection
    supabase = init_connection()
    if supabase:
        try:
            risk_res = supabase.table('company_risk_factors').select('risk_category').execute()
            if risk_res.data:
                risk_counts = pd.DataFrame(risk_res.data)['risk_category'].value_counts().reset_index()
                risk_counts.columns = ['Category', 'Count']
                
                fig_risk = px.bar(
                    risk_counts, x='Category', y='Count',
                    title='Distribution of Disclosed Risks (2025 Proxies)',
                    color='Category',
                    color_discrete_sequence=MCKINSEY_PALETTE
                )
                fig_risk.update_layout(height=300, margin=dict(l=20, r=20, t=40, b=20))
                st.plotly_chart(fig_risk, use_container_width=True)
        except:
            pass

    r_col1, r_col2 = st.columns(2)
    
    with r_col1:
        st.markdown("""
        **AI & Technical Risks**
        *   **AI Governance & Ethics:** Scrutiny of responsible AI frameworks; scarcity of dedicated oversight committees (0.1%).
        *   **Innovation Integrity:** The "Innovation Wash" risk—companies claiming AI status without supporting R&D (patents).
        *   **Technical Feasibility:** High-stakes risks in Quantum (expectation management) and Biotech (clinical trials).
        """)
        
    with r_col2:
        st.markdown("""
        **Operational & Geopolitical Risks**
        *   **Cybersecurity & IP Theft:** Near-universal disclosure of cyber threats as material risks; focus on state-sponsored theft.
        *   **Geopolitical & Supply Chain:** Export controls and trade dynamics, particularly in Semiconductors.
        *   **Regulatory & Compliance:** Increasing pressure in Energy & Climate and Space (defense contracting).
        """)
    
    st.divider()
    
    with st.expander("Definitions & Limitations"):
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
    st.subheader("1. Sector Composition")
    r1c1, r1c2 = st.columns([2, 1])
    
    with r1c1:
        # Treemap of Sector Sizes
        tree_df = sectors[sectors['sector'] != "Cross Domain Enablement"]
        
        fig_tree = px.treemap(
            tree_df, 
            path=['sector'], 
            values='count',
            title="Deep Tech Sub-Sector Composition (Excl. General)",
            color='count',
            color_continuous_scale='Blues'
        )
        fig_tree.update_layout(
            template="plotly_white",
            margin=dict(t=40, l=0, r=0, b=0),
            font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
        )
        st.plotly_chart(fig_tree, use_container_width=True)
        
    with r1c2:
        # Public vs Private Pie
        labels = ['Private', 'Public']
        values = [overall['private_pct'], overall['public_pct']]
        fig_pie = px.pie(
            names=labels, 
            values=values, 
            title="Ownership Structure",
            color_discrete_sequence=[MCKINSEY_BLUE, MCKINSEY_LIGHT_BLUE],
            hole=0.5
        )
        fig_pie.update_layout(
            template="plotly_white",
            showlegend=True,
            legend=dict(orientation="h", yanchor="bottom", y=-0.2, xanchor="center", x=0.5),
            font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
        )
        st.plotly_chart(fig_pie, use_container_width=True)

    st.divider()

    # Row 2: Diversity Analysis
    st.subheader("2. Diversity Analysis")
    r2c1, r2c2 = st.columns(2)
    
    with r2c1:
        # Stacked Bar
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
            color_discrete_map={"0 Women": "#d9d9d9", "1 Woman": "#999999", "2 Women": MCKINSEY_LIGHT_BLUE, "3+ Women": MCKINSEY_BLUE},
            height=400
        )
        fig_div.update_layout(
            template="plotly_white", 
            xaxis_title="% of Companies", 
            yaxis_title=None, 
            legend_title=None,
            font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
        )
        st.plotly_chart(fig_div, use_container_width=True)
        
    with r2c2:
        # Zero Women Bar Chart
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
        fig_zw.update_layout(
            template="plotly_white", 
            xaxis_title="%", 
            yaxis_title=None,
            font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
        )
        st.plotly_chart(fig_zw, use_container_width=True)

    st.divider()

    # Row 3: Technical Expertise
    st.subheader("3. Technical Expertise")
    r3c1, r3c2 = st.columns(2)
    
    with r3c1:
        # Tech Stacked Bar
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
            color_discrete_map={"0-1 Experts": "#d9d9d9", "2-3 Experts": MCKINSEY_TEAL, "4+ Experts": MCKINSEY_BLUE},
            height=400
        )
        fig_tech.update_layout(
            template="plotly_white", 
            xaxis_title="% of Companies", 
            yaxis_title=None, 
            legend_title=None,
            font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
        )
        st.plotly_chart(fig_tech, use_container_width=True)
        
    with r3c2:
        # Scatter
        fig_scat = px.scatter(
            sectors, x="avg_tech_experts", y="avg_women_pct",
            size="count", color="sector",
            title="Correlation: Diversity vs. Technical Expertise",
            labels={"avg_tech_experts": "Avg Tech Experts", "avg_women_pct": "Avg % Women"},
            hover_name="sector",
            color_discrete_sequence=px.colors.qualitative.Prism
        )
        fig_scat.update_layout(
            template="plotly_white",
            font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
        )
        st.plotly_chart(fig_scat, use_container_width=True)

    st.divider()

    # Row 4: Board Structure
    st.subheader("4. Board Structure")
    r4c1, r4c2 = st.columns(2)
    
    with r4c1:
        # Avg Board Size
        if 'avg_board_size' in sectors.columns:
            struct_df = sectors[sectors['avg_board_size'] > 0]
            fig_struct = go.Figure()
            fig_struct.add_trace(go.Bar(
                y=struct_df['sector'], x=struct_df['avg_board_size'],
                name='Avg Board Size', orientation='h', marker_color=MCKINSEY_GREY
            ))
            fig_struct.update_layout(
                title="Average Board Size", 
                template="plotly_white", 
                xaxis_title="Number of Directors",
                font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
            )
            st.plotly_chart(fig_struct, use_container_width=True)
        else:
            st.warning("Board size data not available.")

    with r4c2:
        # AI Oversight Benchmark
        bench_data = pd.DataFrame({
            "Group": ["Fortune 100", "S&P 500", "Deep Tech (Avg)"],
            "AI Oversight %": [40, 30, sectors['ai_oversight_pct'].mean() if 'ai_oversight_pct' in sectors.columns else 5]
        })
        
        fig_bench = px.bar(
            bench_data, x="Group", y="AI Oversight %",
            title="AI Oversight Disclosure vs. Benchmarks",
            color="Group", color_discrete_map={"Fortune 100": "#d9d9d9", "S&P 500": "#999999", "Deep Tech (Avg)": "#ef4444"},
            text_auto='.1f'
        )
        fig_bench.update_layout(
            template="plotly_white", 
            xaxis_title=None, 
            yaxis_title="%",
            font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
        )
        st.plotly_chart(fig_bench, use_container_width=True)

    st.divider()
    
    # Row 5: Effectiveness & Tenure
    st.subheader("5. Effectiveness & Tenure")
    r5c1, r5c2 = st.columns(2)
    
    with r5c1:
        # Avg Director Tenure
        if 'avg_tenure' in sectors.columns:
            tenure_df = sectors[sectors['avg_tenure'] > 0].sort_values('avg_tenure', ascending=True)
            fig_tenure = px.bar(
                tenure_df, x="avg_tenure", y="sector", orientation='h',
                title="Average Director Tenure (Years)",
                color="avg_tenure", color_continuous_scale='Teal',
                text_auto='.1f'
            )
            fig_tenure.update_layout(
                template="plotly_white", 
                xaxis_title="Years", 
                yaxis_title=None,
                font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
            )
            st.plotly_chart(fig_tenure, use_container_width=True)
            
    with r5c2:
        # CEO Duality
        if 'ceo_chair_pct' in sectors.columns:
            duality_df = sectors.sort_values('ceo_chair_pct', ascending=True)
            fig_duality = px.bar(
                duality_df, x="ceo_chair_pct", y="sector", orientation='h',
                title="CEO Duality (% where CEO is Chair)",
                color="ceo_chair_pct", color_continuous_scale='Oranges',
                text_auto='.1f'
            )
            fig_duality.update_layout(
                template="plotly_white", 
                xaxis_title="%", 
                yaxis_title=None,
                font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
            )
            st.plotly_chart(fig_duality, use_container_width=True)

# --- Sector Deep Dives ---
elif page == "Sector Deep Dives":
    st.title("Sector Deep Dives")
    
    selected_sector = st.selectbox("Select Sector", sectors['sector'].unique())
    
    sec_data = sectors[sectors['sector'] == selected_sector].iloc[0]
    
    # Top Level Metrics
    col1, col2, col3, col4 = st.columns(4)
    col1.metric("Sample Size", sec_data['count'])
    col2.metric("Women on Boards", f"{sec_data['avg_women_pct']}%", 
                delta=f"{round(sec_data['avg_women_pct'] - overall['avg_women_pct'], 1)}% vs Avg")
    col3.metric("Tech Experts", sec_data['avg_tech_experts'],
                delta=f"{round(sec_data['avg_tech_experts'] - overall['avg_tech_experts'], 1)} vs Avg")
    col4.metric("Avg Patents", f"{int(sec_data.get('avg_patents', 0))}",
                delta=f"{round(sec_data.get('avg_patents', 0) - overall.get('avg_patents', 0), 1)} vs Avg")

    col5, col6, col7, col8 = st.columns(4)
    col5.metric("Independence", f"{sec_data.get('avg_indep_pct', 'N/A')}%",
                delta=f"{round(sec_data.get('avg_indep_pct', 0) - overall.get('avg_indep_pct', 0), 1)}%" if 'avg_indep_pct' in sec_data else None)
    col6.metric("Gov Score", f"{sec_data.get('avg_gov_score', 'N/A')}",
                 delta=f"{round(sec_data.get('avg_gov_score', 0) - overall.get('avg_gov_score', 0), 1)} vs Avg")
    col7.metric("Avg Age", f"{sec_data.get('avg_age', 'N/A')} yrs")
    col8.metric("AI Oversight", f"{sec_data.get('ai_oversight_pct', 'N/A')}%")
    
    # AI Washing Alert
    if sec_data.get('ai_wash_pct', 0) > 0:
        st.warning(f"**AI Washing Risk:** {sec_data['ai_wash_pct']}% of companies in this sector claim AI status but have **zero patents**.")

    st.divider()
    
    # Comparative Analysis
    st.subheader("Governance & Innovation Footprint")
    
    # Radar Chart
    categories = ['Women %', 'Tech Experts (Scaled)', 'Independence %', 'Gov Score', 'AI Oversight %']
    sec_vals = [
        sec_data['avg_women_pct'], 
        sec_data['avg_tech_experts'] * 10,
        sec_data.get('avg_indep_pct', 0),
        sec_data.get('avg_gov_score', 0),
        sec_data.get('ai_oversight_pct', 0)
    ]
    avg_vals = [
        overall['avg_women_pct'],
        overall['avg_tech_experts'] * 10,
        overall.get('avg_indep_pct', 0),
        overall.get('avg_gov_score', 0),
        overall.get('ai_oversight_pct', 0)
    ]
    
    fig_radar = go.Figure()
    fig_radar.add_trace(go.Scatterpolar(
        r=sec_vals, theta=categories, fill='toself', name=selected_sector, line_color=MCKINSEY_BLUE
    ))
    fig_radar.add_trace(go.Scatterpolar(
        r=avg_vals, theta=categories, fill='toself', name='Deep Tech Average', line_color=MCKINSEY_GREY, opacity=0.5
    ))
    fig_radar.update_layout(
        polar=dict(radialaxis=dict(visible=True, range=[0, 100])),
        showlegend=True,
        template="plotly_white",
        title="Sector Maturity vs Average",
        font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
    )
    
    c1, c2 = st.columns([1, 1])
    with c1:
        st.plotly_chart(fig_radar, use_container_width=True)
    
    with c2:
        # Risk Profile Chart
        risk_dist = sec_data.get('risk_distribution', {})
        if risk_dist:
            risk_df = pd.DataFrame(list(risk_dist.items()), columns=['Category', 'Count']).sort_values('Count', ascending=True)
            fig_risk = px.bar(
                risk_df, x='Count', y='Category', orientation='h',
                title=f"Risk Disclosure Profile: {selected_sector}",
                color='Count', color_continuous_scale='Reds'
            )
            fig_risk.update_layout(template="plotly_white", showlegend=False)
            st.plotly_chart(fig_risk, use_container_width=True)
        else:
            st.info("No detailed risk factor data available for this sector.")

    st.divider()
    
    # Row 2: Innovation & Board Composition
    r2c1, r2c2 = st.columns(2)
    
    with r2c1:
        # Patent Intensity Comparison
        patent_data = []
        for s in sectors.to_dict('records'):
            patent_data.append({"Sector": s['sector'], "Avg Patents": s.get('avg_patents', 0)})
        p_df = pd.DataFrame(patent_data).sort_values("Avg Patents", ascending=True)
        
        fig_patents = px.bar(
            p_df, x="Avg Patents", y="Sector", orientation='h',
            title="Innovation Intensity (Avg Patents per Company)",
            color="Avg Patents", color_continuous_scale='Blues',
            text_auto='.1f'
        )
        # Highlight selected sector
        fig_patents.update_traces(marker_color=[MCKINSEY_TEAL if s == selected_sector else MCKINSEY_GREY for s in p_df['Sector']])
        
        fig_patents.update_layout(template="plotly_white", xaxis_title="Average Patents")
        st.plotly_chart(fig_patents, use_container_width=True)

    with r2c2:
        st.markdown("### Board Composition")
        if 'avg_indep_pct' in sec_data:
            indep = sec_data['avg_indep_pct']
            non_indep = 100 - indep
            
            df_pie = pd.DataFrame({
                "Category": ["Independent", "Non-Independent"],
                "Percentage": [indep, non_indep]
            })
            
            fig_comp = px.pie(
                df_pie,
                names="Category",
                values="Percentage",
                title="Average Board Independence",
                color="Category",
                color_discrete_map={
                    "Independent": MCKINSEY_TEAL,
                    "Non-Independent": MCKINSEY_GREY
                },
                hole=0.6
            )
            fig_comp.update_layout(
                template="plotly_white",
                legend=dict(orientation="h", yanchor="bottom", y=-0.2, xanchor="center", x=0.5),
                font=dict(family="Helvetica Neue, Helvetica, Arial, sans-serif")
            )
            st.plotly_chart(fig_comp, use_container_width=True)
            
    # Insights
    insights = {
        "Semiconductors & AI": "High technical barrier to entry limits traditional director pool. Governance focuses on supply chain and IP protection.",
        "Energy & Climate": "Sector leader in diversity. Regulatory pressure drives higher governance standards.",
        "Biotechnology": "Boards often composed of MDs/PhDs. 'Tech Expert' count may understate medical expertise.",
        "Quantum & Photonics": "Lowest diversity. Niche talent pool creates tension between meritocracy and diversity.",
        "Cross Domain Enablement": "Represents the 'average' Deep Tech company. B2B SaaS tends to have better governance than Consumer Tech.",
        "General Deep Tech": "Broad category encompassing advanced technology companies. Serves as a baseline for the broader deep tech ecosystem."
    }
    st.markdown(f"""
    <div style="background-color: #f8f9fa; padding: 1.5rem; border-left: 5px solid #0077c8; margin-top: 1rem;">
        <h4 style="margin-top: 0; color: #0077c8; font-size: 0.9rem; text-transform: uppercase;">SECTOR CONTEXT</h4>
        <p style="margin-bottom: 0;">{insights.get(selected_sector, 'No specific context available.')}</p>
    </div>
    """, unsafe_allow_html=True)

# --- COMBINED REGULATORY RISK DASHBOARD ---
elif page == "Regulatory Risk Dashboard":
    from combined_regulatory_dashboard import render_regulatory_dashboard
    render_regulatory_dashboard()

# --- Jurisdictional & OECD Analysis ---
elif page == "Jurisdictional Analysis":
    st.title("Jurisdictional & OECD Analysis")
    st.markdown("### Global Governance Benchmarks & Regulatory Roadmap")
    
    # 1. Jurisdictional Comparison
    st.subheader("1. US (SEC) vs. Canada (SEDAR+) Comparison")
    
    comparison_data = {
        "Feature": ["Diversity", "Climate Disclosure", "Cybersecurity", "Supply Chain", "Transparency"],
        "United States (SEC)": [
            "Mandatory disclosure proposal expected Oct 2025.",
            "Rules adopted (Mar 2024) but currently stayed pending litigation.",
            "Mandatory 4-day material incident reporting & annual strategy disclosure.",
            "Sector-specific focus (Conflict Minerals).",
            "Strict Beneficial Ownership Information (BOI) reporting."
        ],
        "Canada (SEDAR+)": [
            "\"Comply or Explain\" model (NI 58-101) for gender diversity.",
            "Mandatory climate rules paused as of April 2025 to support markets.",
            "General risk disclosure requirements; less prescriptive than SEC.",
            "New Forced & Child Labor in Supply Chains Act (Jan 2024).",
            "Federal register for Individuals with Significant Control (25%+)."
        ]
    }
    st.table(pd.DataFrame(comparison_data))
    
    st.divider()
    
    # 2. OECD Principles 2023
    st.subheader("2. G20/OECD Principles of Corporate Governance (2023)")
    
    o1, o2, o3 = st.columns(3)
    with o1:
        st.markdown("""
        <div style="background-color: #ffffff; padding: 1.5rem; border: 1px solid #e5e5e5; border-top: 4px solid #0077c8; height: 100%;">
            <h4 style="color: #0077c8; margin-top: 0;">Sustainability</h4>
            <p style="font-size: 0.9rem;">First-ever chapter dedicated to <b>Sustainability and Resilience</b>. Recommends managing climate risks as core board responsibilities.</p>
        </div>
        """, unsafe_allow_html=True)
    with o2:
        st.markdown("""
        <div style="background-color: #ffffff; padding: 1.5rem; border: 1px solid #e5e5e5; border-top: 4px solid #00a3e0; height: 100%;">
            <h4 style="color: #00a3e0; margin-top: 0;">Digital Risk</h4>
            <p style="font-size: 0.9rem;">Explicit focus on <b>Digital Transformation</b>. Boards must oversee digital security, data privacy, and AI-driven decision making.</p>
        </div>
        """, unsafe_allow_html=True)
    with o3:
        st.markdown("""
        <div style="background-color: #ffffff; padding: 1.5rem; border: 1px solid #e5e5e5; border-top: 4px solid #051c2c; height: 100%;">
            <h4 style="color: #051c2c; margin-top: 0;">Diversity</h4>
            <p style="font-size: 0.9rem;">Strengthened recommendations for <b>Board Diversity</b> (gender and beyond) to enhance decision-making quality.</p>
        </div>
        """, unsafe_allow_html=True)

    st.divider()
    
    # 3. Regulatory Roadmap
    st.subheader("3. Regulatory Roadmap 2025-2026")
    
    roadmap = [
        {"Date": "Feb 2025", "Regulation": "EU AI Act", "Impact": "Prohibitions on manipulative/exploitative AI practices take effect."},
        {"Date": "Aug 2025", "Regulation": "EU AI Act", "Impact": "Governance rules for General-Purpose AI (GPAI) models apply."},
        {"Date": "Oct 2025", "Regulation": "SEC Diversity", "Impact": "Expected proposal for mandatory corporate board diversity disclosures."},
        {"Date": "Jan 2026", "Regulation": "UK SOX", "Impact": "Mandatory board declaration on effectiveness of material controls (UK Corporate Governance Code)."},
        {"Date": "Aug 2026", "Regulation": "EU AI Act", "Impact": "Full applicability for High-Risk AI systems and transparency rules."}
    ]
    
    for item in roadmap:
        with st.expander(f"{item['Date']}: {item['Regulation']}"):
            st.write(item['Impact'])
            st.info("**Strategic Affect:** Companies must audit their AI pipelines and internal control frameworks 6-12 months in advance to avoid non-compliance penalties.")

    st.divider()
    
    # 4. Strategic Impact for Deep Tech
    st.subheader("4. Strategic Impact Analysis")
    st.markdown("""
    For Deep Tech companies, these jurisdictional shifts create a **"Compliance Multiplier"** effect:
    
    *   **Capital Access:** Divergent ESG rules between the US and EU/Canada can complicate cross-border fundraising.
    *   **Talent War:** Stricter diversity mandates in the US (proposed) vs. Canada's "Comply or Explain" may shift where companies choose to HQ their executive teams.
    *   **R&D Velocity:** The EU AI Act's high-risk classification could slow down deployment for medical or infrastructure-focused AI startups.
    """)

# --- Company Search ---
elif page == "Company Search":
    from company_search_page import render_company_search
    render_company_search()
        
# --- Governance Explorer ---
elif page == "Governance Explorer":
    from governance_explorer_page import render_governance_explorer
    render_governance_explorer()

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
