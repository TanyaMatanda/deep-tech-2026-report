# Governance Explorer Page Code Snippet
# Insert this after the Company Search page (around line 2189 in app.py)

elif page == "Governance Explorer":
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
            # Fetch data with company names
            response = supabase.table('company_risk_factors')\
                .select('*, companies!inner(company_name, ticker_symbol, primary_sector, jurisdiction)')\
                .limit(1000)\
                .execute()
            
            if not response.data:
                st.warning("No governance data found")
            else:
                # Process data
                gov_data = []
                for row in response.data:
                    company = row.get('companies', {})
                    gov_data.append({
                        'Company': company.get('company_name', 'Unknown'),
                        'Ticker': company.get('ticker_symbol', '-'),
                        'Sector': company.get('primary_sector', '-'),
                        'Jurisdiction': company.get('jurisdiction', '-'),
                        
                        # Board Composition
                        'Board Independence %': row.get('board_independence_pct'),
                        'Board Diversity %': row.get('board_diversity_pct'),
                        'Split Chair/CEO': '✅ Yes' if row.get('split_chair_ceo') else ('❌ No' if row.get('split_chair_ceo') is False else '-'),
                        'Overboarded Directors': row.get('overboarded_directors_count', 0),
                        
                        # Compensation
                        'Say-on-Pay %': row.get('say_on_pay_support'),
                        'CEO Pay Ratio': f"{row.get('ceo_pay_ratio')}:1" if row.get('ceo_pay_ratio') else '-',
                        'Has Clawback': '✅' if row.get('has_clawback_policy') else '❌',
                        
                        # AI Governance
                        'AI Ethics Board': '✅' if row.get('has_ai_ethics_board') else '❌',
                        'Board AI Expertise': '✅' if row.get('board_ai_expertise') else '❌',
                        'AI Risk Mentions': row.get('ai_risk_mentions', 0),
                        
                        # Cybersecurity
                        'Cyber Oversight': '✅' if row.get('cyber_oversight_explicit') else '❌',
                        'Breach History': '✅' if row.get('breach_history') else '❌',
                        
                        # Risk & ESG
                        'Climate Risk Mentions': row.get('climate_risk_mentions', 0),
                        'Supply Chain Risks': row.get('supply_chain_risk_mentions', 0),
                        'Total Risk Factors': row.get('risk_factor_count', 0),
                        
                        'Last Updated': row.get('last_updated', '-'),
                        'Fiscal Year': row.get('fiscal_year', '-')
                    })
                
                df_gov = pd.DataFrame(gov_data)
                
                st.markdown(f"**Total Companies**: {len(df_gov):,} with governance data")
                st.markdown(f"**Last Refreshed**: {df_gov['Last Updated'].max() if not df_gov.empty else 'N/A'}")
                
                # Filters
                st.markdown("---")
                st.subheader("🔍 Filters")
                
                filter_col1, filter_col2, filter_col3, filter_col4 = st.columns(4)
                
                with filter_col1:
                    sector_filter = st.multiselect("Sector", sorted(df_gov['Sector'].dropna().unique()), default=[])
                    
                with filter_col2:
                    juris_filter = st.multiselect("Jurisdiction", sorted(df_gov['Jurisdiction'].dropna().unique()), default=[])
                
                with filter_col3:
                    min_board_indep = st.number_input("Min Board Independence %", min_value=0, max_value=100, value=0)
                    
                with filter_col4:
                    ai_ethics_filter = st.selectbox("AI Ethics Board", ['All', 'Yes', 'No'])
                
                # Apply filters
                filtered_df = df_gov.copy()
                
                if sector_filter:
                    filtered_df = filtered_df[filtered_df['Sector'].isin(sector_filter)]
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
                    "📊 Board Composition",
                    "💰 Compensation",
                    "🤖 AI & Cyber",
                    "🌍 Risk & ESG"
                ])
                
                with tab1:
                    st.markdown("### Board Composition Factors")
                    board_cols = ['Company', 'Ticker', 'Sector', 'Board Independence %', 'Board Diversity %', 'Split Chair/CEO', 'Overboarded Directors']
                    st.dataframe(
                        filtered_df[board_cols].sort_values('Board Independence %', ascending=False, na_position='last'),
                        use_container_width=True,
                        hide_index=True
                    )
                    
                with tab2:
                    st.markdown("### Executive Compensation Factors")
                    comp_cols = ['Company', 'Ticker', 'Say-on-Pay %', 'CEO Pay Ratio', 'Has Clawback']
                    st.dataframe(
                        filtered_df[comp_cols].sort_values('Say-on-Pay %', ascending=False, na_position='last'),
                        use_container_width=True,
                        hide_index=True
                    )
                    
                with tab3:
                    st.markdown("### AI Governance & Cybersecurity")
                    ai_cols = ['Company', 'Ticker', 'AI Ethics Board', 'Board AI Expertise', 'AI Risk Mentions', 'Cyber Oversight', 'Breach History']
                    st.dataframe(
                        filtered_df[ai_cols].sort_values('AI Risk Mentions', ascending=False),
                        use_container_width=True,
                        hide_index=True
                    )
                    
                with tab4:
                    st.markdown("### Risk Factors & ESG")
                    risk_cols = ['Company', 'Ticker', 'Climate Risk Mentions', 'Supply Chain Risks', 'Total Risk Factors']
                    st.dataframe(
                        filtered_df[risk_cols].sort_values('Climate Risk Mentions', ascending=False),
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
                    - **Red Flag**: \u003c70% (indicates shareholder concerns)
                    
                    **CEO Pay Ratio**: Ratio of CEO compensation to median employee pay
                    - **Typical Range**: 100:1 to 300:1
                    - **Red Flag**: \u003e500:1
                    
                    **AI Ethics Board**: Dedicated board committee for AI governance
                    - **Emerging Best Practice**: Yes for AI-intensive companies
                    
                    **Cyber Oversight**: Explicit board oversight of cybersecurity
                    - **Required**: Yes per SEC guidance (2023)
                    
                    **Risk Mentions**: Number of times topic appears in Item  1A Risk Factors
                    - **Higher = More disclosure** (not necessarily more risk)
                    """)
