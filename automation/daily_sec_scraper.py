import os
import requests
import feedparser
from supabase import create_client, Client, ClientOptions
from datetime import datetime
import json

# Configuration
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

# SEC EDGAR RSS Feed (Latest Filings)
SEC_RSS_URL = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&type=&company=&dateb=&owner=include&start=0&count=100&output=atom"

# Headers for SEC (Must include User-Agent with email)
HEADERS = {
    "User-Agent": "DeepTechProxyAgent/1.0 (admin@deeptechproxy.com)"
}

def init_supabase():
    if not SUPABASE_URL or not SUPABASE_KEY:
        print("❌ Error: Supabase credentials not found.")
        return None
    
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def fetch_sec_feed():
    print(f"📡 Fetching SEC Feed: {SEC_RSS_URL}")
    try:
        response = requests.get(SEC_RSS_URL, headers=HEADERS)
        if response.status_code == 200:
            return feedparser.parse(response.content)
        else:
            print(f"❌ Error fetching feed: {response.status_code}")
            return None
    except Exception as e:
        print(f"❌ Exception fetching feed: {e}")
        return None

def process_feed(feed, supabase):
    if not feed or not feed.entries:
        print("⚠️ No entries found in feed.")
        return

    print(f"🔍 Processing {len(feed.entries)} filings...")
    
    for entry in feed.entries:
        # Extract details
        title = entry.title
        link = entry.link
        summary = entry.summary
        updated = entry.updated
        
        # Parse Title to get Company Name and Form Type
        # Format usually: "Form Type - Company Name (CIK) (Date)"
        # Example: "8-K - IONQ, Inc. (0001824920) (Mon, 02 Dec 2024 ...)"
        
        try:
            parts = title.split(" - ")
            form_type = parts[0].strip()
            rest = parts[1] if len(parts) > 1 else ""
            
            # Extract Company Name (rough approximation)
            company_name = rest.split("(")[0].strip()
            
            # Check if company exists in our DB
            # We match by Name (CIK would be better if we had it stored reliably for all)
            # Using ilike for loose matching
            
            res = supabase.table("companies").select("id, company_name").ilike("company_name", f"%{company_name}%").execute()
            
            if res.data:
                company = res.data[0]
                print(f"✅ MATCH FOUND: {company['company_name']} -> {form_type}")
                
                # Insert into sec_filings
                filing_data = {
                    "company_id": company['id'],
                    "filing_type": form_type,
                    "filing_date": datetime.now().strftime("%Y-%m-%d"), # Using current date as proxy for filing date
                    "filing_url": link,
                    "description": f"Automated import from SEC RSS: {title}"
                }
                
                # Check for duplicates (optional, but good practice)
                # For now, just insert
                try:
                    supabase.table("sec_filings").insert(filing_data).execute()
                    print(f"   🚀 Inserted filing for {company['company_name']}")
                    
                    # Alerting Logic (Placeholder)
                    if form_type in ["8-K", "DEF 14A"]:
                        print(f"   🚨 ALERT: High priority filing ({form_type}) for {company['company_name']}")
                        
                except Exception as e:
                    print(f"   ⚠️ Insert failed (likely duplicate): {e}")
            
            else:
                # print(f"   (Skipping {company_name} - not in DB)")
                pass
                
        except Exception as e:
            print(f"⚠️ Error processing entry: {e}")

def main():
    supabase = init_supabase()
    if not supabase: return

    feed = fetch_sec_feed()
    process_feed(feed, supabase)

if __name__ == "__main__":
    main()
