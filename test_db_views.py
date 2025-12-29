import os
import toml
from supabase import create_client, Client, ClientOptions

# Init Client
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
    except:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")

if not url or not key:
    print("❌ Credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

print("🔍 Testing SQL Views...")

# 1. Test Market Summary View
try:
    res = supabase.table("view_market_summary").select("*").execute()
    if res.data:
        print("✅ view_market_summary: Working")
        print(f"   Data: {res.data[0]}")
    else:
        print("⚠️ view_market_summary: Returned NO data (View exists but empty?)")
except Exception as e:
    print(f"❌ view_market_summary: FAILED. {e}")

# 2. Test Sector Performance View
try:
    res = supabase.table("view_sector_performance").select("*").execute()
    if res.data:
        print(f"✅ view_sector_performance: Working ({len(res.data)} rows)")
    else:
        print("⚠️ view_sector_performance: Returned NO data")
except Exception as e:
    print(f"❌ view_sector_performance: FAILED. {e}")
