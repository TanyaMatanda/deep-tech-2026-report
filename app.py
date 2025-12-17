import streamlit as st
import pandas as pd
import json
import plotly.express as px
import plotly.graph_objects as go
import os

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
def load_data():
    with open("data/stats.json", "r") as f:
        return json.load(f)

data = load_data()
overall = data['overall']
sectors = pd.DataFrame(data['sectors'])

# Sidebar
st.sidebar.title("Deep Tech 2026: What Should You Know?")
st.sidebar.info("Analysis of 101,458 Companies")

# Download Report Button
pdf_path = "assets/Deep_Tech_2026_Final_v2.pdf"
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

# ... (skipping unchanged lines) ...

# --- Full Report ---
elif page == "Full Report":
    # Embed the PDF directly so it matches the user's upload exactly
    import base64
    
    pdf_file = "assets/Deep_Tech_2026_Final_v2.pdf"
    
    if os.path.exists(pdf_file):
        with open(pdf_file, "rb") as f:
            base64_pdf = base64.b64encode(f.read()).decode('utf-8')
            
        pdf_display = f'<iframe src="data:application/pdf;base64,{base64_pdf}" width="100%" height="1000px" type="application/pdf"></iframe>'
        st.markdown(pdf_display, unsafe_allow_html=True)
    else:
        st.error("PDF file not found.")
