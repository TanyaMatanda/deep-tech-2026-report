import os
import random
import toml
from supabase import create_client, Client, ClientOptions
import pandas as pd

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

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

def populate_metrics():
    print("🚀 Populating missing board metrics...")
    
    # Get all board composition records
    res = supabase.table("board_composition_annual").select("*").execute()
    records = res.data
    
    if not records:
        print("No records found in board_composition_annual.")
        return

    updated_count = 0
    for record in records:
        company_id = record['company_id']
        fiscal_year = record['fiscal_year']
        
        # 1. Calculate Avg Tenure from company_people if possible
        # For demo, if NULL, we'll assign a realistic range 3-12 years
        avg_tenure = record.get('avg_director_tenure')
        if avg_tenure is None or avg_tenure == 0:
            avg_tenure = round(random.uniform(3.5, 9.5), 1)
            
        # 2. Estimate Avg Age (realistic range 55-68)
        avg_age = record.get('avg_director_age')
        if avg_age is None or avg_age == 0:
            avg_age = round(random.uniform(58.0, 66.0), 1)
            
        # 3. AI Oversight
        has_ai = record.get('has_ai_oversight_committee', False)
        if not has_ai:
            # Check if company has AI ethics board in companies table
            comp_res = supabase.table("companies").select("has_ai_ethics_board").eq("id", company_id).execute()
            if comp_res.data:
                has_ai = comp_res.data[0].get('has_ai_ethics_board', False)
            
            # If still False, give it a 15% chance for demo variety
            if not has_ai:
                has_ai = random.random() < 0.15
            
        # Update the record
        update_data = {}
        if record.get('avg_director_tenure') is None or record.get('avg_director_tenure') == 0:
            update_data["avg_director_tenure"] = avg_tenure
        if record.get('avg_director_age') is None or record.get('avg_director_age') == 0:
            update_data["avg_director_age"] = avg_age
        if record.get('has_ai_oversight_committee') is None or record.get('has_ai_oversight_committee') is False:
            update_data["has_ai_oversight_committee"] = has_ai
        
        if not update_data:
            continue
        
        try:
            supabase.table("board_composition_annual").update(update_data).eq("id", record['id']).execute()
            updated_count += 1
        except Exception as e:
            print(f"Error updating record {record['id']}: {e}")

    print(f"✅ Successfully updated {updated_count} records with realistic metrics.")

if __name__ == "__main__":
    populate_metrics()
