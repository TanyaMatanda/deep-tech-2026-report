
import os
import sys
import pandas as pd
from supabase import create_client, Client, ClientOptions
import toml
from datetime import datetime
import concurrent.futures
import time
import random

# Add collectors to path
sys.path.append(os.path.join(os.path.dirname(__file__), 'collectors'))
from sec_filing_parser import SECFilingParser

# Configuration
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

if not url or not key:
    print("❌ Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

def process_company(company, parser):
    try:
        # Random sleep to distribute load slightly
        time.sleep(random.uniform(0.1, 0.5))
        
        # Extract
        factors = parser.extract_all_factors(company['cik'], company['company_name'])
        
        if factors.get('def14a_url') == 'Not found':
            return None
            
        # Prepare Data for Insert
        board_data = {
            "company_id": company['id'],
            "fiscal_year": 2024,
            "total_directors": factors.get('total_directors'),
            "independent_directors": factors.get('independent_directors'),
            "board_independence_pct": factors.get('board_independence_pct'),
            "women_percentage": factors.get('board_diversity_pct'),
            "women_board_chair": factors.get('women_board_chair', False),
            "independent_women_board_chair": factors.get('independent_women_board_chair', False),
            "independent_board_chair": factors.get('independent_board_chair', False),
            "has_ai_oversight_committee": factors.get('has_ai_ethics_board', False),
            "has_ai_ethics_policy": factors.get('has_ai_ethics_board', False),
            "tech_experts": 1 if factors.get('board_ai_expertise') else 0,
            "avg_director_age": factors.get('avg_director_age'),
            "avg_director_tenure": factors.get('avg_director_tenure'),
        }
        
        # Insert Board Data
        try:
            supabase.table("board_composition_annual").insert(board_data).execute()
            print(f"  ✅ {company['company_name']}: Saved Board Data (Women: {board_data['women_percentage']}%)")
        except Exception as e:
            # If duplicate, update
            if 'duplicate key' in str(e):
                supabase.table("board_composition_annual").update(board_data).eq("company_id", company['id']).eq("fiscal_year", 2024).execute()
                print(f"  🔄 {company['company_name']}: Updated Board Data")
            else:
                print(f"  ⚠️ {company['company_name']}: Board Data Error {e}")

        # Insert Shareholder Proposals
        proposals = factors.get('shareholder_proposals', [])
        for prop in proposals:
            prop_data = {
                "company_id": company['id'],
                "fiscal_year": 2024,
                "proposal_number": prop['proposal_number'],
                "proposal_description": prop['proposal_description'],
                "category": prop['category']
            }
            try:
                supabase.table("shareholder_proposals").insert(prop_data).execute()
            except:
                pass # Ignore duplicates
                
        # Insert Risk Factors
        risks = factors.get('detailed_risks', [])
        for risk in risks:
            risk_data = {
                "company_id": company['id'],
                "fiscal_year": 2024,
                "risk_category": risk['category'],
                "risk_title": risk['title'],
                "risk_description": risk['description'],
                "ai_related": risk.get('ai_related', False),
                "climate_related": risk.get('climate_related', False)
            }
            try:
                supabase.table("company_risk_factors").insert(risk_data).execute()
            except:
                pass

        return True
        
    except Exception as e:
        print(f"  ❌ {company['company_name']}: Error {e}")
        return False

def run_extraction():
    print("🚀 Starting PARALLEL Governance Data Extraction...")
    
    # 1. Fetch Target Companies (Tier 1 = US, Tier 2 = Canadian/Manual)
    response = supabase.table("companies")\
        .select("id, company_name, cik")\
        .in_("data_tier", [1, 2])\
        .eq("listing_type", "Public")\
        .neq("cik", "null")\
        .execute()
        
    companies = response.data
    print(f"📋 Found {len(companies)} target companies.")
    
    # 2. Check Existing Data to avoid re-running
    # DISABLED to force update of new metrics (Chair, Risks)
    # existing_response = supabase.table("board_composition_annual")\
    #     .select("company_id")\
    #     .eq("fiscal_year", 2024)\
    #     .execute()
        
    # existing_ids = set(item['company_id'] for item in existing_response.data)
    
    # Filter
    # targets = [c for c in companies if c['id'] not in existing_ids]
    targets = companies # Process ALL
    print(f"🎯 Processing {len(targets)} companies (Forcing update for new metrics).")
    
    # 3. Process in Parallel
    parser = SECFilingParser()
    success_count = 0
    
    # Use 5 workers to respect SEC rate limit (10 req/s, each worker does ~2 reqs)
    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        futures = {executor.submit(process_company, company, parser): company for company in targets}
        
        for i, future in enumerate(concurrent.futures.as_completed(futures)):
            if future.result():
                success_count += 1
            
            if i % 10 == 0:
                print(f"  Progress: {i}/{len(targets)} completed...")
            
    print(f"\n✨ Done! Successfully processed {success_count} companies.")

if __name__ == "__main__":
    run_extraction()
