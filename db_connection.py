import os
import streamlit as st
from supabase import create_client, Client, ClientOptions

# Use st.secrets or environment variables
try:
    SUPABASE_URL = st.secrets.get("SUPABASE_URL")
    SUPABASE_KEY = st.secrets.get("SUPABASE_KEY")
except FileNotFoundError:
    SUPABASE_URL = os.getenv("SUPABASE_URL")
    SUPABASE_KEY = os.getenv("SUPABASE_KEY")
except Exception:
    # Fallback for when st.secrets is not available (e.g. script execution)
    SUPABASE_URL = os.getenv("SUPABASE_URL")
    SUPABASE_KEY = os.getenv("SUPABASE_KEY")

@st.cache_resource
def init_connection():
    # Use st.secrets or environment variables
    try:
        url = st.secrets.get("SUPABASE_URL")
        key = st.secrets.get("SUPABASE_KEY")
    except Exception:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")

    if not url or not key:
        # Try one more time with os.getenv just in case st.secrets returned None but didn't raise
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")
        
    if not url or not key:
        st.error("Supabase credentials not found. Please set SUPABASE_URL and SUPABASE_KEY in .streamlit/secrets.toml or environment variables.")
        return None
    
    # Create client with schema option
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    
    return create_client(url, key, options=options)

def get_total_company_count():
    """Get the exact total count of companies in the database."""
    client = init_connection()
    if not client: return 0
    
    # Head=True means we only get the count, not the data
    response = client.table("companies").select("*", count="exact", head=True).execute()
    return response.count

def get_top_companies(limit=2000):
    """Fetch top companies sorted by deal qualification score."""
    client = init_connection()
    if not client: return []
    
    # Order by deal_qualification_score DESC to get the best targets
    response = client.table("view_company_scores")\
        .select("*")\
        .order("deal_qualification_score", desc=True)\
        .limit(limit)\
        .execute()
    return response.data

def get_companies_paginated(page=0, page_size=50, sort_column="deal_qualification_score", sort_desc=True, filters=None):
    """Fetch companies with pagination and server-side filtering."""
    client = init_connection()
    if not client: return []
    
    start = page * page_size
    end = start + page_size - 1
    
    query = client.table("view_company_scores").select("*", count="exact")
    
    # Apply Filters
    if filters:
        if filters.get('sectors'):
            query = query.in_("primary_sector", filters['sectors'])
        if filters.get('sub_sectors'):
            query = query.in_("sub_sector", filters['sub_sectors'])
        if filters.get('jurisdictions'):
            query = query.in_("jurisdiction", filters['jurisdictions'])
        if filters.get('archetypes'):
            query = query.in_("ownership_archetype", filters['archetypes'])
    
    if sort_column:
        query = query.order(sort_column, desc=sort_desc)
        
    response = query.range(start, end).execute()
    return response.data, response.count

def get_full_dataset_csv():
    """Fetch ALL companies for CSV export (handles pagination loop)."""
    client = init_connection()
    if not client: return []
    
    all_data = []
    page_size = 1000
    start = 0
    
    # Safety limit: 100k rows
    while True:
        response = client.table("view_company_scores")\
            .select("*")\
            .range(start, start + page_size - 1)\
            .execute()
            
        data = response.data
        if not data:
            break
            
        all_data.extend(data)
        
        if len(data) < page_size:
            break
            
        start += page_size
        
        if len(all_data) > 100000: # Safety break
            break
            
    return all_data

def update_company_data(company_id, updates):
    """Update company details in the database."""
    client = init_connection()
    if not client: return False, "Database connection failed."
    
    try:
        response = client.table("companies").update(updates).eq("id", company_id).execute()
        if response.data:
            return True, "Update successful!"
        else:
            return False, "Update failed. No data returned."
    except Exception as e:
        return False, f"Error updating company: {str(e)}"

def get_interlocks():
    client = init_connection()
    if not client: return []
    
    response = client.table("view_board_interlocks").select("*").execute()
    return response.data

def run_query(query_func):
    """
    Helper to run a query with the initialized client.
    query_func should be a function that takes the client and returns a response.
    """
    client = init_connection()
    if not client:
        return []
        
    try:
        return query_func(client)
    except Exception as e:
        st.error(f"Query failed: {e}")
        return []

def get_all_companies_with_scores():
    client = init_connection()
    if not client: return []
    
    # Query the view
    response = client.table("view_company_scores").select("*").execute()
    return response.data

def get_sector_stats():
    client = init_connection()
    if not client: return []
    
    # We might need to do aggregation in python if we don't have a view for it
    # Or query companies table
    response = client.table("view_company_scores").select("*").execute()
    return response.data

def get_interlocks():
    client = init_connection()
    if not client: return []
    
    response = client.table("view_board_interlocks").select("*").execute()
    return response.data

def get_innovation_momentum(limit=500, sectors=None):
    """Fetch innovation momentum metrics (CAGR, R&D Efficiency)."""
    client = init_connection()
    if not client: return []
    
    # Query the view (assuming it exists)
    try:
        query = client.table("view_innovation_momentum").select("*")
        
        if sectors:
            query = query.in_("primary_sector", sectors)
            
        response = query.order("patent_cagr_3yr", desc=True)\
            .limit(limit)\
            .execute()
        return response.data
    except Exception as e:
        st.error(f"Error fetching momentum data: {e}")
        return []

def get_financial_resilience(limit=200):
    """Fetch financial resilience metrics (Margins, Valuation)."""
    client = init_connection()
    if not client: return []
    
    try:
        response = client.table("view_financial_resilience")\
            .select("*")\
            .limit(limit)\
            .execute()
        return response.data
    except Exception as e:
        # Don't show error if view doesn't exist yet (user needs to run SQL)
        return []

def get_esg_materiality(limit=200):
    """Fetch ESG materiality metrics (Carbon, Turnover)."""
    client = init_connection()
    if not client: return []
    
    try:
        response = client.table("view_esg_materiality")\
            .select("*")\
            .limit(limit)\
            .execute()
        return response.data
    except Exception as e:
        return []

def get_engagement_flags(limit=200):
    """Fetch engagement flags (Red Flags, Diversity)."""
    client = init_connection()
    if not client: return []
    
    try:
        response = client.table("view_engagement_flags")\
            .select("*")\
            .limit(limit)\
            .execute()
        return response.data
    except Exception as e:
        return []

def get_ownership_data(company_id, year=None):
    """Fetch ownership structure for a company."""
    client = init_connection()
    if not client: return None
    
    query = client.table("ownership_structure").select("*").eq("company_id", company_id)
    
    if year:
        query = query.eq("fiscal_year", year)
    else:
        # Default to latest year if not specified (or handle in logic)
        query = query.order("fiscal_year", desc=True).limit(1)
        
    response = query.execute()
    
    if response.data:
        return response.data[0]
    return None

def get_board_members(company_id):
    """Fetch board members for a specific company."""
    client = init_connection()
    if not client: return []
    
    try:
        # Join company_people with people table
        # We want: Name, Role, Is Independent (if available), Expertise
        response = client.table("company_people")\
            .select("*, people(*)")\
            .eq("company_id", company_id)\
            .eq("is_board_member", True)\
            .execute()
            
        return response.data
    except Exception as e:
        st.error(f"Error fetching board members: {e}")
        return []

def get_market_summary():
    """Fetch pre-calculated market summary stats (1 row)."""
    client = init_connection()
    if not client: return None
    
    try:
        response = client.table("view_market_summary").select("*").single().execute()
        return response.data
    except Exception as e:
        st.error(f"Error fetching market summary: {e}")
        return None

def get_sector_performance():
    """Fetch pre-calculated sector performance stats."""
    client = init_connection()
    if not client: return []
    
    try:
        response = client.table("view_sector_performance").select("*").order("total_patents", desc=True).execute()
        return response.data
    except Exception as e:
        st.error(f"Error fetching sector performance: {e}")
        return []

def get_company_list():
    """Fetch lightweight list of companies for search (ID, Name, Ticker)."""
    client = init_connection()
    if not client: return []
    
    try:
        # Only fetch essential columns for search
        response = client.table("companies").select("id, company_name, ticker_symbol, primary_sector").order("company_name").execute()
        return response.data
    except Exception as e:
        st.error(f"Error fetching company list: {e}")
        return []

def get_company_details(company_id):
    """Fetch full details for a single company from the view."""
    client = init_connection()
    if not client: return None
    
    try:
        response = client.table("view_company_scores").select("*").eq("id", company_id).single().execute()
        return response.data
    except Exception as e:
        st.error(f"Error fetching company details: {e}")
        return None
