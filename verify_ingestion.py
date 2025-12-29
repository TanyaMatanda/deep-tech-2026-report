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

print('--- VERIFYING NVIDIA DATA ---')

# 1. Get NVIDIA ID
res = supabase.table('companies').select('id, company_name, technology_tags').ilike('company_name', '%NVIDIA%').execute()
if not res.data:
    print('NVIDIA not found!')
    exit()

nvidia = res.data[0]
cid = nvidia['id']
print(f"NVIDIA ID: {cid}")
print(f"Tags: {nvidia['technology_tags']}")

# 2. Check Patents
res_pat = supabase.table('patents').select('id', count='exact').eq('company_id', cid).execute()
print(f"Patents Count: {res_pat.count}")

# 3. Check Tech Fluent Directors
# Get people linked to company
res_ppl = supabase.table('company_people').select('person_id').eq('company_id', cid).execute()
pids = [r['person_id'] for r in res_ppl.data]

if pids:
    res_experts = supabase.table('people').select('full_name, expertise_areas').in_('id', pids).execute()
    for p in res_experts.data:
        print(f"Director: {p['full_name']}, Expertise: {p['expertise_areas']}")
else:
    print("No people linked.")
