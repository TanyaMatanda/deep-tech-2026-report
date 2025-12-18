"""
Database Statistics Widget
Shows users the full extent of available data
"""

import streamlit as st

def show_database_stats(supabase):
    """Display comprehensive database statistics"""
    
    st.markdown("### 📊 Database Overview")
    
    try:
        # Get total companies
        total_result = supabase.table('companies').select('id', count='exact').limit(1).execute()
        total_companies = total_result.count
        
        # Get public companies (with tickers)
        public_result = supabase.table('companies').select('id', count='exact').not_.is_('ticker_symbol', 'null').limit(1).execute()
        public_companies = public_result.count
        
        # Get companies with governance data
        gov_result = supabase.table('company_risk_factors').select('company_id', count='exact').limit(1).execute()
        companies_with_gov = gov_result.count
        
        # Get news items
        news_result = supabase.table('governance_news').select('id', count='exact').limit(1).execute()
        news_count = news_result.count
        
        # Display stats in columns
        col1, col2, col3, col4 = st.columns(4)
        
        with col1:
            st.metric(
                label="Total Companies",
                value=f"{total_companies:,}",
                help="All companies in database"
            )
        
        with col2:
            st.metric(
                label="Public Companies",
                value=f"{public_companies:,}",
                delta=f"{public_companies/total_companies*100:.1f}%",
                help="Companies with stock tickers"
            )
        
        with col3:
            st.metric(
                label="With Governance Data",
                value=f"{companies_with_gov:,}",
                delta=f"{companies_with_gov/total_companies*100:.1f}%",
                help="Companies with extracted SEC data"
            )
        
        with col4:
            st.metric(
                label="News Items",
                value=f"{news_count:,}",
                help="Tracked governance events"
            )
        
        return {
            'total': total_companies,
            'public': public_companies,
            'with_governance': companies_with_gov,
            'news': news_count
        }
        
    except Exception as e:
        st.error(f"Error fetching database stats: {e}")
        return None


def add_pagination_controls(total_items, items_per_page=100, key="pagination"):
    """
    Add pagination controls for large datasets
    
    Returns: (offset, limit) for database query
    """
    
    total_pages = max(1, (total_items + items_per_page - 1) // items_per_page)
    
    col1, col2, col3, col4 = st.columns([1, 2, 1, 1])
    
    with col1:
        st.write(f"**{total_items:,}** total")
    
    with col2:
        page = st.number_input(
            "Page",
            min_value=1,
            max_value=total_pages,
            value=1,
            key=f"{key}_page",
            help=f"Navigate through {total_pages:,} pages"
        )
    
    with col3:
        items_per_page = st.selectbox(
            "Per page",
            [50, 100, 250, 500, 1000],
            index=1,
            key=f"{key}_per_page"
        )
    
    with col4:
        st.write(f"of {total_pages:,} pages")
    
    offset = (page - 1) * items_per_page
    
    # Show range
    start = offset + 1
    end = min(offset + items_per_page, total_items)
    st.caption(f"Showing {start:,} - {end:,} of {total_items:,}")
    
    return offset, items_per_page


def add_quick_filters(supabase, filter_key="filters"):
    """Add common quick filters across pages"""
    
    col1, col2, col3 = st.columns(3)
    
    with col1:
        company_type = st.selectbox(
            "Company Type",
            ["All", "Public (with ticker)", "Private", "With Governance Data"],
            key=f"{filter_key}_type"
        )
    
    with col2:
        # Get distinct sectors
        try:
            sectors = supabase.rpc('get_distinct_sectors').execute()
            sector_list = ["All"] + [s['sector'] for s in sectors.data if s.get('sector')]
        except:
            sector_list = ["All", "Technology", "Healthcare", "Finance"]
        
        sector = st.selectbox(
            "Sector",
            sector_list,
            key=f"{filter_key}_sector"
        )
    
    with col3:
        # Get distinct jurisdictions
        try:
            jurisdictions = supabase.rpc('get_distinct_jurisdictions').execute()
            jurisdiction_list = ["All"] + [j['jurisdiction'] for j in jurisdictions.data if j.get('jurisdiction')]
        except:
            jurisdiction_list = ["All", "United States", "United Kingdom", "Canada"]
        
        jurisdiction = st.selectbox(
            "Jurisdiction",
            jurisdiction_list,
            key=f"{filter_key}_jurisdiction"
        )
    
    return {
        'company_type': company_type,
        'sector': sector if sector != "All" else None,
        'jurisdiction': jurisdiction if jurisdiction != "All" else None
    }


if __name__ == "__main__":
    # Demo
    from db_connection import init_connection
    
    st.title("Database Stats Demo")
    supabase = init_connection()
    
    if supabase:
        stats = show_database_stats(supabase)
        
        st.markdown("---")
        
        if stats:
            offset, limit = add_pagination_controls(stats['total'])
            st.write(f"Query: OFFSET {offset} LIMIT {limit}")
