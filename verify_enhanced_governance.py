import requests
import json

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

HEADERS = {
    "apikey": SUPABASE_KEY,
    "Authorization": f"Bearer {SUPABASE_KEY}",
    "Content-Type": "application/json",
    "Content-Profile": "vendor_governance",
    "Accept-Profile": "vendor_governance"
}

def check_table(table_name):
    url = f"{SUPABASE_URL}/rest/v1/{table_name}?select=count"
    headers = HEADERS.copy()
    headers["Prefer"] = "count=exact"
    
    try:
        r = requests.get(url, headers=headers)
        if r.status_code in [200, 206]:
            print(f"✅ Table/View '{table_name}' exists.")
            return True
        elif r.status_code == 404:
            print(f"❌ Table/View '{table_name}' NOT FOUND (404).")
        else:
            print(f"⚠️ Error checking '{table_name}': {r.status_code} - {r.text}")
    except Exception as e:
        print(f"❌ Exception checking '{table_name}': {e}")
    return False

def main():
    print("📊 Verifying Enhanced Governance Schema...")
    print("-" * 30)
    
    tables_to_check = [
        "board_committees",
        "director_education",
        "view_board_interlocks"
    ]
    
    all_exist = True
    for t in tables_to_check:
        if not check_table(t):
            all_exist = False
            
    print("-" * 30)
    
    # Also check if scoring function still works (it was updated)
    print("Testing updated scoring function via view...")
    url = f"{SUPABASE_URL}/rest/v1/view_company_scores?limit=1"
    r = requests.get(url, headers=HEADERS)
    if r.status_code == 200:
        print("✅ 'view_company_scores' is accessible (Scoring function working).")
    else:
        print(f"❌ 'view_company_scores' failed: {r.status_code} - {r.text}")
        all_exist = False

    if all_exist:
        print("\n🎉 Enhanced Governance Schema Verification Successful!")
    else:
        print("\n⚠️ Verification Failed. Please check if the SQL script was run correctly.")

if __name__ == "__main__":
    main()
