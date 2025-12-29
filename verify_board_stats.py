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

print('--- FETCHING VERIFIED BOARD STATS ---')

targets = ['NVIDIA', 'Moderna', 'IonQ', 'Rocket Lab', 'CrowdStrike']

for t in targets:
    res_c = supabase.table('companies').select('id').ilike('company_name', f'%{t}%').execute()
    if res_c.data:
        cid = res_c.data[0]['id']
        res_b = supabase.table('board_composition_annual').select('women_percentage, avg_director_tenure').eq('company_id', cid).eq('fiscal_year', 2025).execute()
        if res_b.data:
            print(f"{t}: {res_b.data[0]}")
        else:
            print(f"{t}: No Data")
    else:
        print(f"{t}: Not Found")
