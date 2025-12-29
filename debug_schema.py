import os
import toml
from supabase import create_client, ClientOptions

try:
    secrets = toml.load('dashboard/.streamlit/secrets.toml')
    url = secrets['SUPABASE_URL']
    key = secrets['SUPABASE_KEY']
except:
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_KEY')

options = ClientOptions(schema='vendor_governance')
supabase = create_client(url, key, options=options)

print('--- DEBUGGING SCHEMA ---')

# 1. Check Governance Scores Columns
print('\n1. Governance Scores Table Structure:')
try:
    res = supabase.table('governance_scores').select('*').limit(1).execute()
    if res.data:
        print(f"Columns: {list(res.data[0].keys())}")
    else:
        print('Table is empty')
except Exception as e:
    print(f"Error fetching governance scores: {e}")

# 2. Check Technology Tags Format
print('\n2. Technology Tags Sample:')
try:
    res_tags = supabase.table('companies').select('company_name, technology_tags').not_.is_('technology_tags', 'null').limit(5).execute()
    for r in res_tags.data:
        print(f"{r['company_name']}: {r['technology_tags']} (Type: {type(r['technology_tags'])})")
except Exception as e:
    print(f"Error fetching tags: {e}")
