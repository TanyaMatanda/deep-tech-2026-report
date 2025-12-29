
import os
from supabase import create_client, Client, ClientOptions
import toml
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

if not url or not key:
    print("❌ Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

# Simple Gender Inference
FEMALE_NAMES = {'mary', 'elizabeth', 'jennifer', 'linda', 'patricia', 'susan', 'jessica', 'sarah', 'karen', 'nancy', 'lisa', 'betty', 'margaret', 'sandra', 'ashley', 'kimberly', 'emily', 'donna', 'michelle', 'dorothy', 'carol', 'amanda', 'melissa', 'deborah', 'stephanie', 'rebecca', 'sharon', 'laura', 'cynthia', 'kathleen', 'amy', 'shirley', 'angela', 'helen', 'anna', 'brenda', 'pamela', 'nicole', 'samantha', 'katherine', 'emma', 'ruth', 'christine', 'catherine', 'debra', 'rachel', 'carolyn', 'janet', 'virginia', 'maria', 'heather', 'diane', 'julie', 'joyce', 'victoria', 'olivia', 'kelly', 'christina', 'lauren', 'joan', 'evelyn', 'judith', 'megan', 'cheryl', 'andrea', 'hannah', 'martha', 'jacqueline', 'frances', 'gloria', 'ann', 'teresa', 'kathryn', 'sara', 'janice', 'jean', 'alice', 'madison', 'julia', 'grace', 'judy', 'abigail', 'marie', 'danielle', 'marilyn', 'amber', 'beverly', 'denise', 'theresa', 'diana', 'brittany', 'natalie', 'sophia', 'charlotte', 'rose', 'kayla', 'alexis', 'lori', 'indrani', 'rima', 'margaret'}

MALE_EXCEPTIONS = {'joshua', 'luca', 'noah', 'elijah', 'isaiah', 'jeremiah', 'micah', 'jonah', 'ezra', 'ira', 'dana', 'sasha', 'mika'}

def guess_gender(first_name):
    name = first_name.lower()
    if name in FEMALE_NAMES:
        return 'Female'
    if name in MALE_EXCEPTIONS:
        return 'Male'
    if name.endswith('a'):
        return 'Female'
    return 'Male'

def aggregate_data():
    print("Aggregating Board Data...")
    
    # Get public companies with pagination
    companies = []
    offset = 0
    limit = 1000
    while True:
        print(f"Fetching companies (offset {offset})...")
        res_companies = supabase.table("companies").select("id, company_name").eq("listing_type", "Public").range(offset, offset + limit - 1).execute()
        batch = res_companies.data
        if not batch:
            break
        companies.extend(batch)
        offset += limit
        
    print(f"Found {len(companies)} public companies.")
    
    updated_count = 0
    
    # Process in batches
    batch_size = 100
    for i in range(0, len(companies), batch_size):
        batch = companies[i:i+batch_size]
        print(f"Processing batch {i//batch_size + 1} ({len(batch)} companies)...")
        
        for company in batch:
            company_id = company['id']
            
            try:
                # Get directors
                res_people = supabase.table("company_people").select("person_id, people(first_name)").eq("company_id", company_id).eq("role_type", "Director").execute()
                
                directors = res_people.data
                if not directors:
                    continue
                    
                total_directors = len(directors)
                women_count = 0
                
                for d in directors:
                    person = d['people']
                    if person and person['first_name']:
                        gender = guess_gender(person['first_name'])
                        if gender == 'Female':
                            women_count += 1
                            
                women_pct = (women_count / total_directors * 100) if total_directors > 0 else 0
                
                # Update board_composition_annual
                data = {
                    "company_id": company_id,
                    "fiscal_year": 2025,
                    "total_directors": total_directors,
                    "women_directors": women_count,
                    "women_percentage": women_pct,
                    "independent_directors": int(total_directors * 0.8) # Estimate for now
                }
                
                supabase.table("board_composition_annual").upsert(data, on_conflict="company_id, fiscal_year").execute()
                updated_count += 1
                
            except Exception as e:
                print(f"Error processing {company['company_name']}: {e}")
                continue
            
    print(f"✅ Updated board composition for {updated_count} companies.")

if __name__ == "__main__":
    aggregate_data()
