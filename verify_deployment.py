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

TABLES = [
    "companies",
    "people",
    "sec_filings",
    "proxy_statement_data",
    "board_composition_annual",
    "governance_scores",
    "cybersecurity_incidents"
]

def count_rows(table):
    url = f"{SUPABASE_URL}/rest/v1/{table}?select=count"
    # We need to use HEAD request or select=count with Prefer: count=exact
    headers = HEADERS.copy()
    headers["Prefer"] = "count=exact"
    
    r = requests.get(url, headers=headers)
    if r.status_code in [200, 206]:
        # The count is in the Content-Range header: 0-0/123
        content_range = r.headers.get("Content-Range")
        if content_range:
            count = content_range.split('/')[-1]
            return int(count)
    else:
        print(f"⚠️ Error checking {table}: {r.status_code} - {r.text}")
    return 0

def main():
    print("📊 Verifying Deployment...")
    print("-" * 30)
    
    total_rows = 0
    for table in TABLES:
        count = count_rows(table)
        print(f"{table.ljust(30)}: {count} rows")
        total_rows += count
        
    print("-" * 30)
    if total_rows > 0:
        print("✅ Deployment Verification Successful (Partial or Full)!")
        
        # Check for specific tickers
        print("Checking for key companies...")
        tickers = ['IONQ', 'PLTR', 'NVDA', 'CRWD', 'AI']
        found = 0
        for t in tickers:
            url = f"{SUPABASE_URL}/rest/v1/companies?ticker_symbol=eq.{t}&select=count"
            headers = HEADERS.copy()
            headers["Prefer"] = "count=exact"
            r = requests.get(url, headers=headers)
            if r.status_code in [200, 206]:
                count = r.headers.get("Content-Range").split('/')[-1]
                if int(count) > 0:
                    print(f"  ✅ Found {t}")
                    found += 1
                else:
                    print(f"  ❌ Missing {t}")
        
        if found == len(tickers):
            print("All key companies present.")
        else:
            print(f"Missing {len(tickers) - found} key companies.")
            
    else:
        print("❌ Deployment Verification Failed (No rows found).")

if __name__ == "__main__":
    main()
