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
        
        # New performant search interface
        search_query = st.text_input("Search by Company Name or Ticker", placeholder="e.g. NVIDIA or NVDA", key="comp_search_input")

        # Fetch company list based on search
        selected_company = None
        if search_query:
            try:
                # Search by name or ticker using OR logic
                companies_res = supabase.table('companies').select(
                    'id, company_name, ticker_symbol, primary_sector, jurisdiction, incorporation_country, listing_type'
                ).or_(f"company_name.ilike.%{search_query}%,ticker_symbol.ilike.%{search_query}%")\
                 .limit(50).execute()
                
                if companies_res.data:
                    company_df = pd.DataFrame(companies_res.data)
                    company_df['display_name'] = (
                        company_df['company_name'] + 
                        " (" + company_df['ticker_symbol'].fillna('Private') + ")"
                    )
                    
                    selected_display = st.selectbox(
                        "Select a Company from Results",
                        options=sorted(company_df['display_name'].tolist()),
                        index=0 if len(company_df) == 1 else None,
                        placeholder="Choose a company..."
                    )
                    
                    if selected_display:
                        selected_company = company_df[company_df['display_name'] == selected_display].iloc[0]
                else:
                    st.warning(f"No companies found matching '{search_query}'")
            except Exception as e:
                st.error(f"Error fetching company data: {e}")
        
        if selected_company is not None:
            company_id = selected_company['id']
            company_name = selected_company['company_name']
            
            # Resolve jurisdiction
            jurisdiction = selected_company.get('incorporation_country', 'USA')
            if selected_company.get('jurisdiction') and selected_company['jurisdiction'] != 'Unknown':
                jurisdiction = selected_company['jurisdiction']
                
            sector = selected_company['primary_sector']
            listing_type = selected_company.get('listing_type', 'Both')
            
            st.divider()
            
            # 2. Company Overview Cards
            col1, col2, col3, col4 = st.columns(4)
            with col1:
                st.metric("Jurisdiction", jurisdiction or "Unknown")
            with col2:
                st.metric("Sector", sector or "Unknown")
            with col3:
                st.metric("Ticker", selected_company['ticker_symbol'] or "N/A")
            with col4:
                st.metric("Type", listing_type)
            
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
            
            # 4. Compliance Roadmap (Using unified regulations_database)
            st.subheader("📅 Applicable Laws & Regulations")
            st.caption("Based on jurisdiction, sector, and identified risk profile.")
            
            from regulations_database import get_regulations_for_company
            
            sectors_list = [sector] if sector else []
            regulations = get_regulations_for_company(jurisdiction, sectors_list, listing_type)
            
            if regulations:
                for reg in regulations:
                    # Severity color mapping
                    if reg.severity_score >= 8:
                        sev_color = "#dc2626" # Red
                        sev_label = "Critical"
                    elif reg.severity_score >= 5:
                        sev_color = "#f59e0b" # Orange
                        sev_label = "Significant"
                    else:
                        sev_color = "#10b981" # Green
                        sev_label = "Standard"

                    st.markdown(f"""
                    <div style="background-color: #ffffff; padding: 1.5rem; border: 1px solid #e5e5e5; border-left: 5px solid {sev_color}; margin-bottom: 1rem;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <h4 style="margin: 0; color: #051c2c;">{reg.name}</h4>
                            <span style="background-color: {sev_color}20; color: {sev_color}; padding: 4px 12px; border-radius: 12px; font-size: 0.8rem; font-weight: 600;">{reg.status} | Severity: {reg.severity_score}</span>
                        </div>
                        <p style="margin: 10px 0; font-size: 0.9rem;"><b>Impact:</b> {reg.investor_impact}</p>
                        <p style="margin: 0; font-size: 0.9rem; color: #0077c8;"><b>Requirements:</b> {", ".join(reg.requirements[:2])}...</p>
                    </div>
                    """, unsafe_allow_html=True)
            else:
                st.info("No specific regulatory mappings found for this company profile.")
                    else:
                        st.info("No specific regulatory mappings found for this company profile.")
                else:
                    st.warning("No company data available.")
            except Exception as e:
                st.error(f"Error fetching company data: {e}")

if __name__ == "__main__":
    render_company_search()
