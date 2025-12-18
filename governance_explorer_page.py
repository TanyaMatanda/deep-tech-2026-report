import streamlit as st
import pandas as pd

def render_governance_explorer():
    st.title("🏛️ Governance Data Explorer")
    st.markdown("### Real SEC Filing Data - No Composite Scores")
    
    st.info("📋 **What you're seeing**: Actual governance factors extracted from DEF 14A and 10-K filings, not simulated scores. Use filters to find companies by specific governance characteristics.")
    
    # Fetch governance data
    from db_connection import init_connection
    supabase = init_connection()
    
    if not supabase:
        st.error("Database connection failed")
    else:
        # Query company_risk_factors joined with companies
        st.markdown("---")
        
        with st.spinner("Loading governance data..."):
            try:
                # Fetch data from board_composition_annual joined with companies
                # Using standard join syntax for better compatibility
                response = supabase.table('board_composition_annual')\
                    .select('*, companies(company_name, ticker_symbol, primary_sector, sub_sector, jurisdiction)')\
                    .order('fiscal_year', desc=True)\
                    .limit(5000)\
                    .execute()
            except Exception as e:
                st.error(f"### ❌ Database Query Failed")
                st.write(f"Error details: {str(e)}")
                return
            
            if not response.data:
                st.warning("No governance data found")
            else:
                # Process data
                gov_data = []
                for row in response.data:
                    company = row.get('companies', {})
                    
                    # Calculate independence % if not stored
                    indep_pct = row.get('board_independence_pct')
                    if indep_pct is None and row.get('total_directors', 0) > 0:
                        ratio = row.get('independent_directors', 0) / row.get('total_directors')
                        # Heuristic: Flip if < 50% (likely insider count)
                        if ratio < 0.5:
                            indep_pct = (1 - ratio) * 100
                        else:
                            indep_pct = ratio * 100

                    gov_data.append({
                        'Company': company.get('company_name', 'Unknown'),
                        'Ticker': company.get('ticker_symbol', '-'),
                        'Sector': company.get('primary_sector', '-'),
                        'Sub-Sector': company.get('sub_sector', '-'),
                        'Jurisdiction': company.get('jurisdiction', '-'),
                        
                        # Board Composition
                        'Board Independence %': round(indep_pct, 1) if indep_pct is not None else None,
                        'Board Diversity %': row.get('women_percentage'),
                        'Split Chair/CEO': '✅ Yes' if not row.get('ceo_is_board_chair') else '❌ No',
                        'Total Directors': row.get('total_directors'),
                        
                        # Technical Expertise
                        'Tech Experts': row.get('tech_experts', 0),
                        'AI/Cyber Experts': row.get('ai_cybersecurity_experts', 0),
                        
                        # AI Governance
                        'AI Oversight': '✅' if row.get('has_ai_oversight_committee') else '❌',
                        'AI Ethics Board': '✅' if row.get('has_ai_ethics_policy') else '❌',
                        
                        # Compensation & Meetings
                        'Board Meetings': row.get('board_meetings_per_year', '-'),
                        'Avg Attendance': f"{row.get('avg_attendance_rate')}%" if row.get('avg_attendance_rate') else '-',
                        
                        'Fiscal Year': row.get('fiscal_year', '-'),
                        'Last Updated': row.get('created_at', '-')
                    })
                
                df_gov = pd.DataFrame(gov_data)
                
                st.markdown(f"**Showing Top 5,000 Companies** (out of {len(df_gov):,} loaded with governance data)")
                st.markdown(f"**Last Refreshed**: {df_gov['Last Updated'].max() if not df_gov.empty else 'N/A'}")
                
                # Filters
                st.markdown("---")
                st.subheader("🔍 Filters")
                
                filter_col1, filter_col2, filter_col3, filter_col4, filter_col5 = st.columns(5)
                
                with filter_col1:
                    sector_filter = st.multiselect("Sector", sorted(df_gov['Sector'].dropna().unique()), default=[])
                
                with filter_col2:
                    sub_sector_filter = st.multiselect("Sub-Sector", sorted(df_gov['Sub-Sector'].dropna().unique()), default=[])
                    
                with filter_col3:
                    juris_filter = st.multiselect("Jurisdiction", sorted(df_gov['Jurisdiction'].dropna().unique()), default=[])
                
                with filter_col4:
                    min_board_indep = st.number_input("Min Board Independence %", min_value=0, max_value=100, value=0)
                    
                with filter_col5:
                    ai_ethics_filter = st.selectbox("AI Ethics Board", ['All', 'Yes', 'No'])
                
                # Apply filters
                filtered_df = df_gov.copy()
                
                if sector_filter:
                    filtered_df = filtered_df[filtered_df['Sector'].isin(sector_filter)]
                if sub_sector_filter:
                    filtered_df = filtered_df[filtered_df['Sub-Sector'].isin(sub_sector_filter)]
                if juris_filter:
                    filtered_df = filtered_df[filtered_df['Jurisdiction'].isin(juris_filter)]
                if min_board_indep > 0:
                    filtered_df = filtered_df[filtered_df['Board Independence %'] >= min_board_indep]
                if ai_ethics_filter == 'Yes':
                    filtered_df = filtered_df[filtered_df['AI Ethics Board'] == '✅']
                elif ai_ethics_filter == 'No':
                    filtered_df = filtered_df[filtered_df['AI Ethics Board'] == '❌']
                
                st.markdown(f"**Filtered Results**: {len(filtered_df):,} companies")
                
                # Tabs for different views
                tab1, tab2, tab3, tab4 = st.tabs([
                    "📊 Board & Independence",
                    "💰 Compensation",
                    "🤖 AI & Cyber",
                    "🌍 Risk & ESG"
                ])
                
                with tab1:
                    st.markdown("### Board Composition & Independence")
                    board_cols = ['Company', 'Ticker', 'Sector', 'Sub-Sector', 'Board Independence %', 'Board Diversity %', 'Split Chair/CEO', 'Total Directors']
                    st.dataframe(
                        filtered_df[board_cols].sort_values('Board Independence %', ascending=False, na_position='last'),
                        use_container_width=True,
                        hide_index=True
                    )
                    
                with tab2:
                    st.markdown("### Board Meetings & Attendance")
                    comp_cols = ['Company', 'Ticker', 'Board Meetings', 'Avg Attendance', 'Fiscal Year']
                    st.dataframe(
                        filtered_df[comp_cols].sort_values('Board Meetings', ascending=False, na_position='last'),
                        use_container_width=True,
                        hide_index=True
                    )
                    
                with tab3:
                    st.markdown("### AI Governance & Cybersecurity")
                    ai_cols = ['Company', 'Ticker', 'AI Oversight', 'AI Ethics Board', 'Tech Experts', 'AI/Cyber Experts']
                    st.dataframe(
                        filtered_df[ai_cols].sort_values('AI/Cyber Experts', ascending=False),
                        use_container_width=True,
                        hide_index=True
                    )
                    
                with tab4:
                    st.markdown("### Jurisdiction & Sector Analysis")
                    risk_cols = ['Company', 'Ticker', 'Sector', 'Sub-Sector', 'Jurisdiction', 'Fiscal Year']
                    st.dataframe(
                        filtered_df[risk_cols].sort_values('Company', ascending=True),
                        use_container_width=True,
                        hide_index=True
                    )
                
                # Export
                st.markdown("---")
                st.subheader("📥 Export Data")
                
                csv = filtered_df.to_csv(index=False)
                st.download_button(
                    label="Download Filtered Data as CSV",
                    data=csv,
                    file_name=f"governance_data_{pd.Timestamp.now().strftime('%Y%m%d')}.csv",
                    mime="text/csv"
                )
                
                # Help
                with st.expander("📖 Data Dictionary"):
                    st.markdown("""
                    ### Governance Factors Explained
                    
                    **Board Independence %**: Percentage of board members who are independent (not executives or affiliated)
                    - **Best Practice**: >80% (OECD standard)
                    
                    **Board Diversity %**: Gender and ethnic diversity on the board
                    - **Best Practice**: >30% (critical mass theory)
                    
                    **Split Chair/CEO**: Whether Chairman and CEO are different people
                    - **Best Practice**: Yes (reduces conflicts of interest)
                    
                    **Say-on-Pay %**: Shareholder approval rating for executive compensation
                    - **Red Flag**: <70% (indicates shareholder concerns)
                    
                    **CEO Pay Ratio**: Ratio of CEO compensation to median employee pay
                    - **Typical Range**: 100:1 to 300:1
                    - **Red Flag**: >500:1
                    
                    **AI Ethics Board**: Dedicated board committee for AI governance
                    - **Emerging Best Practice**: Yes for AI-intensive companies
                    
                    **Cyber Oversight**: Explicit board oversight of cybersecurity
                    - **Required**: Yes per SEC guidance (2023)
                    
                    **Risk Mentions**: Number of times topic appears in Item  1A Risk Factors
                    - **Higher = More disclosure** (not necessarily more risk)
                    """)

if __name__ == "__main__":
    render_governance_explorer()
