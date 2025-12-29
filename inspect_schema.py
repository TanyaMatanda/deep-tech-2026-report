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

# Regulatory
print("--- REGULATORY ---")
reg_cols = ['penalty_amount', 'penalty_amount_usd', 'fine_amount', 'violation_type', 'enforcement_action', 'regulator_name', 'agency']
for col in reg_cols:
    try:
        supabase.table('regulatory_enforcement').select(col).limit(1).execute()
        print(f"Column found: {col}")
    except:
        pass

# Turnover Check 2
print("--- TURNOVER 2 ---")
turn_cols_2 = ['person_id', 'executive_id', 'company_id']
for col in turn_cols_2:
    try:
        supabase.table('executive_turnover').select(col).limit(1).execute()
        print(f"Column found: {col}")
    except:
        pass
