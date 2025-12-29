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

print('--- DATA INTEGRITY CHECK ---')

# 1. Count AI Companies (Strict Check)
print('\n1. AI Company Count (Strict "Artificial Intelligence" tag):')
# We have to fetch and filter client-side because array filtering in supabase-py can be tricky with partial matches
res = supabase.table('companies').select('id, company_name, technology_tags').not_.is_('technology_tags', 'null').execute()

ai_count = 0
ai_ids = []
for r in res.data:
    tags = r['technology_tags']
    if isinstance(tags, list):
        # Check for exact or partial match of the specific term
        if any('artificial intelligence' in t.lower() for t in tags if isinstance(t, str)):
            ai_count += 1
            ai_ids.append(r['id'])

print(f"Found {ai_count} companies with 'Artificial Intelligence' tag.")

# 2. Check Governance Score Matching
print('\n2. Governance Score Matching:')
# Get all company IDs
all_company_ids = set(r['id'] for r in res.data)
# Get all governance score company_ids
res_gov = supabase.table('governance_scores').select('company_id, overall_governance_score').execute()
gov_map = {r['company_id']: r['overall_governance_score'] for r in res_gov.data}

matched_count = 0
valid_scores = []
for cid in all_company_ids:
    if cid in gov_map:
        matched_count += 1
        if gov_map[cid] is not None:
            valid_scores.append(gov_map[cid])

print(f"Total Companies: {len(all_company_ids)}")
print(f"Companies with Governance Scores: {matched_count}")
print(f"Match Rate: {matched_count / len(all_company_ids) * 100:.2f}%")
if valid_scores:
    print(f"Average Score: {sum(valid_scores) / len(valid_scores):.2f}")
else:
    print("Average Score: N/A")
