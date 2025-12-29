import os
import toml
import pandas as pd
from supabase import create_client, ClientOptions

def get_top_women_boards():
    try:
        secrets = toml.load('dashboard/.streamlit/secrets.toml')
        url = secrets['SUPABASE_URL']
        key = secrets['SUPABASE_KEY']
    except:
        url = os.getenv('SUPABASE_URL')
        key = os.getenv('SUPABASE_KEY')

    options = ClientOptions(schema='vendor_governance')
    supabase = create_client(url, key, options=options)
    
    # Get board data
    print("Fetching board data...")
    res = supabase.table('board_composition_annual').select('company_id, women_directors, total_directors, fiscal_year').execute()
    df = pd.DataFrame(res.data)
    
    # Get recent only
    df = df.sort_values('fiscal_year', ascending=False).drop_duplicates('company_id')
    
    # Calculate %
    df = df[df['total_directors'] > 2] # Filter out tiny boards (e.g. 1 person) for meaningful stats
    df['women_pct'] = (df['women_directors'] / df['total_directors']) * 100
    
    # Get top 10
    top = df.sort_values('women_pct', ascending=False).head(10)
    
    # Get company names
    company_ids = top['company_id'].tolist()
    res_comp = supabase.table('companies').select('id, company_name, primary_sector').in_('id', company_ids).execute()
    comp_df = pd.DataFrame(res_comp.data)
    
    # Merge
    final = pd.merge(top, comp_df, left_on='company_id', right_on='id')
    
    print("\nTOP 10 BOARDS FOR WOMEN REPRESENTATION:")
    print(final[['company_name', 'women_pct', 'primary_sector']].to_string(index=False))

if __name__ == "__main__":
    get_top_women_boards()
