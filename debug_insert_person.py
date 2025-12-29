import requests
import json

SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

HEADERS = {
    "apikey": SUPABASE_KEY,
    "Authorization": f"Bearer {SUPABASE_KEY}",
    "Content-Type": "application/json",
    "Content-Profile": "vendor_governance",
    "Accept-Profile": "vendor_governance",
    "Prefer": "resolution=ignore-duplicates"
}

def test_insert():
    print("Testing insert into people table...")
    row = {
        "full_name": "Test Person",
        "first_name": "Test",
        "last_name": "Person",
        "current_title": "Tester"
    }
    
    url = f"{SUPABASE_URL}/rest/v1/people"
    r = requests.post(url, headers=HEADERS, json=[row])
    
    print(f"Status: {r.status_code}")
    print(f"Response: {r.text}")

if __name__ == "__main__":
    test_insert()
