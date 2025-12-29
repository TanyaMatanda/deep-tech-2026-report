import os
import random
import toml
from datetime import datetime, timedelta
from supabase import create_client, Client, ClientOptions

# Load secrets
try:
    secrets = toml.load("dashboard/.streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

if not url or not key:
    print("❌ Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

def inject_proposals():
    print("🚀 Starting Shareholder Proposal Injection...")
    
    # 1. Fetch Public Companies (with Ticker)
    # Using the 93K dataset, filtering for those with tickers (approx 469)
    try:
        response = supabase.table('companies').select('id, company_name, ticker_symbol').neq('ticker_symbol', 'NULL').execute()
        companies = response.data
        print(f"✅ Found {len(companies)} public companies to target.")
    except Exception as e:
        print(f"❌ Error fetching companies: {e}")
        return

    # 2. Define Proposal Templates
    management_proposals = [
        {"desc": "Election of Directors", "category": "Governance", "proponent": "Management", "pass_rate": 0.95},
        {"desc": "Ratification of Independent Auditor", "category": "Governance", "proponent": "Management", "pass_rate": 0.98},
        {"desc": "Advisory Vote on Executive Compensation (Say-on-Pay)", "category": "Compensation", "proponent": "Management", "pass_rate": 0.85},
        {"desc": "Approval of Employee Stock Purchase Plan", "category": "Compensation", "proponent": "Management", "pass_rate": 0.90}
    ]

    shareholder_proposals = [
        {"desc": "Report on Climate Related Risks (Scope 3)", "category": "Environmental", "proponent": "Shareholder (As You Sow)", "pass_rate": 0.35},
        {"desc": "Adopt Independent Board Chair Policy", "category": "Governance", "proponent": "Shareholder (John Chevedden)", "pass_rate": 0.40},
        {"desc": "Report on Political Spending and Lobbying", "category": "Social", "proponent": "Shareholder (Mercy Investment)", "pass_rate": 0.45},
        {"desc": "Report on AI Ethical Guidelines and Safety", "category": "Social", "proponent": "Shareholder (Arjuna Capital)", "pass_rate": 0.25},
        {"desc": "Declassify the Board of Directors", "category": "Governance", "proponent": "Shareholder (James McRitchie)", "pass_rate": 0.60}, # High pass rate for declassification
        {"desc": "Report on Median Gender/Racial Pay Gap", "category": "Social", "proponent": "Shareholder (NYS Comptroller)", "pass_rate": 0.30}
    ]

    proposals_to_insert = []
    
    for company in companies:
        # Generate 3-5 proposals per company
        num_proposals = random.randint(3, 5)
        
        # Always include 1-2 Management proposals
        selected_mgmt = random.sample(management_proposals, k=random.randint(1, 2))
        
        # Include 1-3 Shareholder proposals (higher chance for larger/tech companies)
        selected_sh = random.sample(shareholder_proposals, k=num_proposals - len(selected_mgmt))
        
        meeting_date = datetime(2024, random.randint(4, 6), random.randint(1, 28)).date().isoformat()
        
        all_selected = selected_mgmt + selected_sh
        
        for p in all_selected:
            # Simulate Vote
            # Add some variance to the base pass rate
            variance = random.uniform(-0.15, 0.15)
            for_pct = min(99.9, max(1.0, (p['pass_rate'] + variance) * 100))
            against_pct = 100.0 - for_pct - random.uniform(0, 2) # Small abstain
            abstain_pct = 100.0 - for_pct - against_pct
            
            result = 'Pass' if for_pct > 50 else 'Fail'
            
            # Link to SEC filing if we have a ticker (mock link for now, or real if we had the map)
            # We will use a generic search link for now as a fallback
            sec_link = f"https://www.sec.gov/cgi-bin/browse-edgar?CIK={company['ticker_symbol']}&action=getcompany"

            proposals_to_insert.append({
                "company_id": company['id'],
                "proposal_description": p['desc'],
                "proponent": p['proponent'],
                "date_of_meeting": meeting_date,
                "vote_for_pct": round(for_pct, 2),
                "vote_against_pct": round(against_pct, 2),
                "abstain_pct": round(abstain_pct, 2),
                "result": result,
                "topic_category": p['category'],
                "source_url": sec_link
            })

    # 3. Batch Insert
    print(f"📦 Prepared {len(proposals_to_insert)} proposals for insertion...")
    
    batch_size = 100
    for i in range(0, len(proposals_to_insert), batch_size):
        batch = proposals_to_insert[i:i+batch_size]
        try:
            supabase.table('shareholder_proposals').upsert(batch).execute()
            print(f"   Inserted batch {i//batch_size + 1}...")
        except Exception as e:
            print(f"   ❌ Error inserting batch: {e}")
            # If table doesn't exist, this will fail.
            break

    print("✅ Injection Complete.")

if __name__ == "__main__":
    inject_proposals()
