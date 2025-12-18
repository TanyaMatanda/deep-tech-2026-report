import streamlit as st
import pandas as pd
from db_connection import init_connection

def render_company_search():
    st.title("🔍 Company Risk & Compliance Search")
    st.markdown("### Individual Company Analysis & Regulatory Roadmap")
    
    supabase = init_connection()
    if not supabase:
        st.error("Database connection failed")
        return

    # 1. Search Interface
    with st.container():
        st.markdown("""
        <div style="background-color: #f8f9fa; padding: 2rem; border-radius: 8px; border: 1px solid #e5e5e5; margin-bottom: 2rem;">
            <h4 style="margin-top: 0; color: #051c2c;">Search Company</h4>
            <p style="color: #666666; font-size: 0.9rem;">Enter a company name or ticker to view its specific risk profile and applicable regulations.</p>
        </div>
        """, unsafe_allow_html=True)
        
        # Fetch company list for autocomplete
        try:
            companies_res = supabase.table('companies').select('id, company_name, ticker_symbol, primary_sector, jurisdiction').execute()
            if companies_res.data:
                company_df = pd.DataFrame(companies_res.data)
                company_df['display_name'] = company_df['company_name'] + " (" + company_df['ticker_symbol'].fillna('N/A') + ")"
                
                selected_display = st.selectbox(
                    "Select a Company",
                    options=company_df['display_name'].tolist(),
                    index=None,
                    placeholder="Type to search..."
                )
                
                if selected_display:
                    selected_company = company_df[company_df['display_name'] == selected_display].iloc[0]
                    company_id = selected_company['id']
                    company_name = selected_company['company_name']
                    jurisdiction = selected_company['jurisdiction']
                    sector = selected_company['primary_sector']
                    
                    st.divider()
                    
                    # 2. Company Overview Cards
                    col1, col2, col3 = st.columns(3)
                    with col1:
                        st.metric("Jurisdiction", jurisdiction or "Unknown")
                    with col2:
                        st.metric("Sector", sector or "Unknown")
                    with col3:
                        st.metric("Ticker", selected_company['ticker_symbol'] or "N/A")
                    
                    st.divider()
                    
                    # 3. Risk Factors (from Database)
                    st.subheader("⚠️ Identified Risk Factors")
                    st.caption("Extracted from the latest SEC/SEDAR filings.")
                    
                    risk_res = supabase.table('company_risk_factors')\
                        .select('*')\
                        .eq('company_id', company_id)\
                        .execute()
                    
                    if risk_res.data:
                        for risk in risk_res.data:
                            with st.expander(f"🚩 {risk['risk_category']}: {risk['risk_title']}"):
                                st.write(risk['risk_description'])
                                if risk.get('is_material'):
                                    st.warning("This risk is flagged as **Material** in recent disclosures.")
                    else:
                        st.info("No specific risk factor disclosures found in our database for this company.")
                    
                    st.divider()
                    
                    # 4. Compliance Roadmap (Rule-Based)
                    st.subheader("📅 Applicable Laws & Regulations")
                    st.caption("Based on jurisdiction, sector, and identified risk profile.")
                    
                    regulations = []
                    
                    # Jurisdiction-based rules
                    if jurisdiction == 'USA':
                        regulations.append({
                            "Law": "SEC Cybersecurity Rules",
                            "Status": "Active",
                            "Impact": "Mandatory 4-day material incident reporting and annual strategy disclosure.",
                            "Action": "Ensure CISO reporting lines to Board are formalized."
                        })
                        regulations.append({
                            "Law": "SEC Climate Disclosure",
                            "Status": "Stayed (Pending)",
                            "Impact": "Requirement to disclose Scope 1 & 2 emissions (if material).",
                            "Action": "Monitor legal stay; maintain data readiness for Scope 1/2."
                        })
                    elif jurisdiction == 'Canada':
                        regulations.append({
                            "Law": "Forced & Child Labor Act",
                            "Status": "Active (Jan 2024)",
                            "Impact": "Annual reporting on supply chain labor risks.",
                            "Action": "File annual report by May 31st deadline."
                        })
                        regulations.append({
                            "Law": "Bill C-27 / CPPA",
                            "Status": "Stalled (Jan 2025)",
                            "Impact": "Modernized privacy rules and algorithmic transparency.",
                            "Action": "Align privacy policies with CPPA principles as a best practice."
                        })
                    
                    # Sector-based rules
                    if sector and any(x in sector.lower() for x in ['ai', 'semiconductor', 'autonomous', 'software']):
                        if jurisdiction == 'Canada':
                            regulations.append({
                                "Law": "AIDA (AI & Data Act)",
                                "Status": "Principles Active",
                                "Impact": "Risk-based framework for 'High-Impact' AI systems.",
                                "Action": "Conduct AI impact assessments for all customer-facing models."
                            })
                        
                        regulations.append({
                            "Law": "EU AI Act",
                            "Status": "Phased (2025-2026)",
                            "Impact": "Global reach for any company serving EU citizens. High-risk AI requires strict auditing.",
                            "Action": "Inventory all AI models and classify by EU risk tiers."
                        })
                    
                    if regulations:
                        for reg in regulations:
                            st.markdown(f"""
                            <div style="background-color: #ffffff; padding: 1.5rem; border: 1px solid #e5e5e5; border-left: 5px solid {'#0077c8' if reg['Status'] == 'Active' else '#b7b7b7'}; margin-bottom: 1rem;">
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <h4 style="margin: 0; color: #051c2c;">{reg['Law']}</h4>
                                    <span style="background-color: {'#e1f5fe' if reg['Status'] == 'Active' else '#f5f5f5'}; color: {'#0077c8' if reg['Status'] == 'Active' else '#666666'}; padding: 4px 12px; border-radius: 12px; font-size: 0.8rem; font-weight: 600;">{reg['Status']}</span>
                                </div>
                                <p style="margin: 10px 0; font-size: 0.9rem;"><b>Impact:</b> {reg['Impact']}</p>
                                <p style="margin: 0; font-size: 0.9rem; color: #0077c8;"><b>Recommended Action:</b> {reg['Action']}</p>
                            </div>
                            """, unsafe_allow_html=True)
                    else:
                        st.info("No specific regulatory mappings found for this company profile.")
            else:
                st.warning("No company data available.")
        except Exception as e:
            st.error(f"Error fetching company data: {e}")

if __name__ == "__main__":
    render_company_search()
