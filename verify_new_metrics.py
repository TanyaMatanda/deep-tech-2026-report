
import os
import toml
from supabase import create_client, ClientOptions
import pandas as pd

# 1. Setup Supabase
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
    except:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")

if not url:
    print("❌ Credentials not found")
    exit(1)

supabase = create_client(url, key, options=ClientOptions(schema='vendor_governance'))

print("==========================================")
print("VERIFYING NEW GOVERNANCE METRICS")
print("==========================================")

# 1. Check Board Chair Gender
print("\n1. Board Chair Gender (board_composition_annual)")
res = supabase.table('board_composition_annual')\
    .select('company_id, women_percentage, women_board_chair, independent_women_board_chair, independent_board_chair')\
    .eq('fiscal_year', 2024)\
    .execute()

df_board = pd.DataFrame(res.data)
if not df_board.empty:
    print(f"   Total Records: {len(df_board)}")
    print(f"   Women Chairs: {df_board['women_board_chair'].sum()} ({df_board['women_board_chair'].mean()*100:.1f}%)")
    print(f"   Indep. Women Chairs: {df_board['independent_women_board_chair'].sum()}")
    print(f"   Indep. Chairs: {df_board['independent_board_chair'].sum()}")
else:
    print("   ⚠️ No board data found")

print("\n1b. Women Percentage Stats")
if not df_board.empty and 'women_percentage' in df_board.columns:
    print(df_board['women_percentage'].describe())
else:
    print("   ⚠️ women_percentage column missing or empty")

# 2. Check Risk Factors
print("\n2. Risk Factors (company_risk_factors)")
res_risk = supabase.table('company_risk_factors').select('*', count='exact').execute()
print(f"   Total Risk Factors: {res_risk.count}")
if res_risk.data:
    print("   Sample Categories:")
    df_risk = pd.DataFrame(res_risk.data)
    print(df_risk['risk_category'].value_counts().head())

# 3. Check Shareholder Proposals
print("\n3. Shareholder Proposals (shareholder_proposals)")
res_prop = supabase.table('shareholder_proposals').select('*', count='exact').execute()
print(f"   Total Proposals: {res_prop.count}")
if res_prop.data:
    print("   Sample Categories:")
    df_prop = pd.DataFrame(res_prop.data)
    print(df_prop['category'].value_counts().head())

print("\n==========================================")
