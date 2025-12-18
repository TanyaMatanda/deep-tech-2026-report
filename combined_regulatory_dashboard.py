"""
Combined Regulatory Risk Dashboard

Merges Jurisdictional Analysis and Company Search into a unified regulatory dashboard.
Shows company-specific compliance obligations, jurisdictional comparisons, and investor risk summary.
"""

import streamlit as st
import pandas as pd
from db_connection import init_connection
from regulations_database import (
    get_regulations_for_company,
    get_jurisdictional_comparison,
    ALL_REGULATIONS
)

# McKinsey-style colors
MCKINSEY_BLUE = "#051c2c"
MCKINSEY_LIGHT_BLUE = "#0077c8"
MCKINSEY_TEAL = "#00a3e0"

def render_regulatory_dashboard():
    """Main rendering function for the combined regulatory risk dashboard"""
    
    st.title("🔍 Regulatory Risk Dashboard")
    st.markdown("### Company-Specific Compliance & Jurisdictional Analysis")
    
    supabase = init_connection()
    if not supabase:
        st.error("Database connection failed")
        return
    
    # ============================================
    # 1. COMPANY SEARCH
    # ============================================
    
    with st.container():
        st.markdown("""
        <div style="background-color: #f8f9fa; padding: 1.5rem; border-radius: 8px; border: 1px solid #e5e5e5; margin-bottom: 1.5rem;">
            <h4 style="margin-top: 0; color: #051c2c;">Search Company</h4>
            <p style="color: #666666; font-size: 0.9rem; margin-bottom: 0;">
                Enter a company name or ticker to view its specific regulatory obligations, applicable laws, and compliance roadmap.
            </p>
        </div>
        """, unsafe_allow_html=True)
        
        # Fetch company list - limit to prevent loading 101K+ companies
        try:
            # Add search filter
            search_term = st.text_input("🔍 Search by company name or ticker", placeholder="e.g., NVIDIA, NVDA", key="company_search")
            
            if search_term and len(search_term) >= 2:
                # Search with ILIKE for case-insensitive partial match
                companies_res = supabase.table('companies').select(
                    'id, company_name, ticker_symbol, primary_sector, jurisdiction, incorporation_country, listing_type'
                ).or_(
                    f"company_name.ilike.%{search_term}%,ticker_symbol.ilike.%{search_term}%"
                ).limit(100).execute()
            else:
                # Default: top public companies only (limits to 500 to prevent loading all 101K companies)
                companies_res = supabase.table('companies').select(
                    'id, company_name, ticker_symbol, primary_sector, jurisdiction, incorporation_country, listing_type'
                ).eq('listing_type', 'Public').limit(500).execute()
            
            if companies_res.data:
                company_df = pd.DataFrame(companies_res.data)
                company_df['display_name'] = (
                    company_df['company_name'] + 
                    " (" + company_df['ticker_symbol'].fillna('Private') + ")"
                )
                
                col1, col2 = st.columns([3, 1])
                
                with col1:
                    selected_display = st.selectbox(
                        "Select a Company to Analyze",
                        options=sorted(company_df['display_name'].tolist()),
                        index=None,
                        placeholder="Type company name above to search...",
                        key="company_select"
                    )
                
                with col2:
                    show_comparison = st.checkbox("Show Jurisdictional Comparison", value=False)
                
                if selected_display:
                    selected_company = company_df[company_df['display_name'] == selected_display].iloc[0]
                    
                    # ============================================
                    # 2. COMPANY PROFILE CARD
                    # ============================================
                    
                    st.divider()
                    render_company_profile(selected_company, supabase)
                    
                    # ============================================
                    # 3. HIGH-PRIORITY REGULATIONS
                    # ============================================
                    
                    st.divider()
                    render_priority_regulations(selected_company, supabase)
                    
                    # ============================================
                    # 4. JURISDICTIONAL COMPARISON (OPTIONAL)
                    # ============================================
                    
                    if show_comparison:
                        st.divider()
                        render_jurisdictional_comparison()
                    
                    # ============================================
                    # 5. COMPLIANCE CALENDAR
                    # ============================================
                    
                    st.divider()
                    render_compliance_calendar(selected_company)
                    
                    # ============================================
                    # 6. INVESTOR RISK SUMMARY
                    # ============================================
                    
                    st.divider()
                    render_investor_summary(selected_company)
                
                else:
                    # Show jurisdictional comparison by default when no company selected
                    st.divider()
                    render_jurisdictional_comparison()
                    
            else:
                st.warning("No company data available.")
                
        except Exception as e:
            st.error(f"Error fetching company data: {e}")

def render_company_profile(company: pd.Series, supabase):
    """Render company profile card"""
    
    st.markdown("### 📋 Company Profile")
    
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        st.metric("Company", company['company_name'])
    with col2:
        jurisdiction = company.get('jurisdiction', company.get('incorporation_country', 'Unknown'))
        st.metric("Jurisdiction", jurisdiction)
    with col3:
        st.metric("Sector", company.get('primary_sector', 'Unknown'))
    with col4:
        st.metric("Type", company.get('listing_type', 'Unknown'))
    
    # Get applicable regulations count
    jurisdiction = company.get('jurisdiction', company.get('incorporation_country', 'USA'))
    sectors = [company.get('primary_sector', '')]
    listing_type = company.get('listing_type', 'Unknown')
    applicable_regs = get_regulations_for_company(jurisdiction, sectors, listing_type)
    high_priority = [r for r in applicable_regs if r.risk_level == "High" and r.status == "Active"]
    
    # Add private company disclaimer if applicable
    if listing_type == 'Private':
        st.info(f"📊 **{len(applicable_regs)} applicable regulations identified** (SEC rules excluded for private companies) | "
                f"**{len(high_priority)} high-priority active** ⚠️")
    else:
        st.info(f"📊 **{len(applicable_regs)} applicable regulations identified** | "
                f"**{len(high_priority)} high-priority active** ⚠️")

def render_priority_regulations(company: pd.Series, supabase):
    """Render high-priority compliance obligations"""
    
    st.markdown("### ⚠️ Compliance Obligations")
    
    # Get applicable regulations
    jurisdiction = company.get('jurisdiction', company.get('incorporation_country', 'USA'))
    sectors = [company.get('primary_sector', '')]
    listing_type = company.get('listing_type', 'Unknown')
    applicable_regs = get_regulations_for_company(jurisdiction, sectors, listing_type)
    
    if not applicable_regs:
        st.info("No specific regulations identified for this company profile.")
        return
    
    # Group by status
    active_regs = [r for r in applicable_regs if r.status == "Active"]
    pending_regs = [r for r in applicable_regs if "Pending" in r.status]
    other_regs = [r for r in applicable_regs if r not in active_regs and r not in pending_regs]
    
    # Render tabs for different regulation types
    tab1, tab2, tab3 = st.tabs(["✅ Active Regulations", "⏳ Pending/Proposed", "ℹ️ All Regulations"])
    
    with tab1:
        if active_regs:
            for reg in active_regs:
                render_regulation_card(reg)
        else:
            st.info("No active regulations identified")
    
    with tab2:
        if pending_regs:
            for reg in pending_regs:
                render_regulation_card(reg)
        else:
            st.info("No pending regulations")
    
    with tab3:
        for reg in applicable_regs:
            render_regulation_card(reg, collapsed=True)

def render_regulation_card(reg, collapsed=False):
    """Render individual regulation card"""
    
    # Risk level colors
    risk_colors = {
        "High": "#dc2626",
        "Medium": "#f59e0b",
        "Low": "#10b981"
    }
    risk_color = risk_colors.get(reg.risk_level, "#6b7280")
    
    # Status badge color
    status_colors = {
        "Active": "#0077c8",
        "Pending": "#f59e0b",
        "Stayed": "#6b7280",
        "Voluntary": "#10b981"
    }
    status_parts = reg.status.split(" ")
    status_color = status_colors.get(status_parts[0], "#6b7280")
    
    with st.expander(f"{'🔴' if reg.risk_level == 'High' else '🟡' if reg.risk_level == 'Medium' else '🟢'} **{reg.name}**", expanded=not collapsed):
        # Status and risk badges
        col1, col2 = st.columns([3, 1])
        with col1:
            st.markdown(f"""
            <span style="background-color: {status_color}20; color: {status_color}; 
                         padding: 4px 12px; border-radius: 12px; font-size: 0.85rem; font-weight: 600;">
                {reg.status}
            </span>
            <span style="background-color: {risk_color}20; color: {risk_color}; 
                         padding: 4px 12px; border-radius: 12px; font-size: 0.85rem; font-weight: 600; margin-left: 8px;">
                {reg.risk_level} Risk
            </span>
            """, unsafe_allow_html=True)
        
        st.markdown("---")
        
        # Requirements
        st.markdown("**📋 Key Requirements:**")
        for req in reg.requirements:
            st.markdown(f"- {req}")
        
        # Impact and Actions
        col1, col2 = st.columns(2)
        
        with col1:
            st.markdown("**📊 Investor Impact:**")
            st.markdown(f"_{reg.investor_impact}_")
        
        with col2:
            st.markdown("**✅ Recommended Actions:**")
            for action in reg.action_items:
                st.markdown(f"- {action}")
        
        # Deadline
        if reg.deadline_type:
            st.info(f"⏰ **Deadline:** {reg.deadline_type} - {reg.deadline_description}")
        
        # Penalties
        with st.expander("⚖️ Penalties for Non-Compliance"):
            st.markdown(reg.penalties)

def render_jurisdictional_comparison():
    """Render USA vs Canada jurisdictional comparison table"""
    
    st.markdown("### 📊 Jurisdictional Comparison: USA vs. Canada")
    st.caption("Comparative analysis of regulatory frameworks for deep tech companies")
    
    comparison = get_jurisdictional_comparison()
    
    # Create DataFrame for display
    comparison_data = []
    for feature, values in comparison.items():
        comparison_data.append({
            "Regulatory Area": feature,
            "🇺🇸 United States": values["USA"],
            "🇨🇦 Canada": values["Canada"]
        })
    
    df = pd.DataFrame(comparison_data)
    
    # Display as table
    st.dataframe(
        df,
        use_container_width=True,
        hide_index=True,
        column_config={
            "Regulatory Area": st.column_config.TextColumn(width="medium"),
            "🇺🇸 United States": st.column_config.TextColumn(width="large"),
            "🇨🇦 Canada": st.column_config.TextColumn(width="large"),
        }
    )
    
    # Key insights
    st.markdown("""
    **🔑 Key Insights:**
    - **Cybersecurity**: USA has more prescriptive requirements (4-day incident reporting)
    - **Climate Disclosure**: Both jurisdictions have paused mandatory rules
    - **Supply Chain Labor**: Canada has federal legislation; USA focused on specific sectors
    - **AI Governance**: Both lack comprehensive federal AI regulation (state/provincial patchwork)
    """)

def render_compliance_calendar(company: pd.Series):
    """Render compliance calendar with upcoming deadlines"""
    
    st.markdown("### 📅 Compliance Calendar")
    
    jurisdiction = company.get('jurisdiction', company.get('incorporation_country', 'USA'))
    sectors = [company.get('primary_sector', '')]
    applicable_regs = get_regulations_for_company(jurisdiction, sectors)
    
    # Filter active regulations with deadlines
    active_with_deadlines = [r for r in applicable_regs if r.status == "Active" and r.deadline_type]
    
    if active_with_deadlines:
        for reg in active_with_deadlines:
            deadline_icon = "🔄" if reg.deadline_type == "Ongoing" else "📆"
            st.markdown(f"**{deadline_icon} {reg.deadline_type}:** {reg.name}")
            st.caption(f"└─ {reg.deadline_description}")
    else:
        st.info("No specific deadlines identified for active regulations")

def render_investor_summary(company: pd.Series):
    """Render investor-focused risk summary"""
    
    st.markdown("### 🎯 Investor Risk Summary")
    
    jurisdiction = company.get('jurisdiction', company.get('incorporation_country', 'USA'))
    sectors = [company.get('primary_sector', '')]
    applicable_regs = get_regulations_for_company(jurisdiction, sectors)
    
    high_risks = [r for r in applicable_regs if r.risk_level == "High" and r.status == "Active"]
    medium_risks = [r for r in applicable_regs if r.risk_level == "Medium" and r.status == "Active"]
    
    col1, col2 = st.columns(2)
    
    with col1:
        st.markdown("**✓ Compliance Strengths:**")
        if company.get('listing_type') == 'Public':
            st.markdown("- Public company disclosure maturity")
        st.markdown(f"- {len(applicable_regs)} regulations identified and mapped")
        
        # Look for voluntary compliance
        voluntary = [r for r in applicable_regs if "Voluntary" in r.status]
        if voluntary:
            st.markdown(f"- {len(voluntary)} voluntary best practices available")
    
    with col2:
        st.markdown("**⚠️ Key Regulatory Risks:**")
        if high_risks:
            for risk in high_risks:
                st.markdown(f"- **{risk.name}**: {risk.investor_impact[:80]}...")
        elif medium_risks:
            for risk in medium_risks[:2]:  # Show top 2 medium risks
                st.markdown(f"- **{risk.name}**: {risk.investor_impact[:80]}...")
        else:
            st.markdown("- Low regulatory risk profile based on available data")

if __name__ == "__main__":
    render_regulatory_dashboard()
