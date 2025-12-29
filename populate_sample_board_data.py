import os
import random
from supabase import create_client, Client, ClientOptions
from faker import Faker

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

fake = Faker()

def init_connection():
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def populate_board_data():
    client = init_connection()
    if not client: return

    print("Fetching top companies...")
    # Get top 20 companies
    response = client.table("companies").select("id, company_name").limit(20).execute()
    companies = response.data
    
    if not companies:
        print("No companies found.")
        return

    print(f"Found {len(companies)} companies. Populating board members...")
    
    roles = ["Chair", "Lead Independent Director", "Audit Chair", "Comp Chair", "Director", "Director", "Director"]
    skills_pool = ["Finance", "Legal", "Technology", "AI/ML", "Cybersecurity", "ESG", "Operations", "M&A", "Government"]
    
    for company in companies:
        print(f"Processing {company['company_name']}...")
        
        # Create 7-9 board members per company
        num_members = random.randint(7, 9)
        
        for i in range(num_members):
            # 1. Create Person
            full_name = fake.name()
            first = full_name.split()[0]
            last = full_name.split()[-1]
            
            person_skills = random.sample(skills_pool, k=random.randint(2, 4))
            
            person_data = {
                "full_name": full_name,
                "first_name": first,
                "last_name": last,
                "current_title": "Board Director",
                "expertise_areas": person_skills,
                "education": [f"{fake.random_element(['Harvard', 'Stanford', 'MIT', 'Wharton'])} {fake.random_element(['MBA', 'PhD', 'JD'])}"],
                "patents_count": random.randint(0, 5) if "Technology" in person_skills else 0
            }
            
            p_res = client.table("people").insert(person_data).execute()
            if not p_res.data: continue
            person_id = p_res.data[0]['id']
            
            # 2. Link to Company
            role = roles[i] if i < len(roles) else "Director"
            is_independent = role != "CEO" and role != "Founder" # Simplified logic
            
            cp_data = {
                "company_id": company['id'],
                "person_id": person_id,
                "role_title": role,
                "role_type": "Director",
                "is_board_member": True,
                "is_current": True,
                "start_date": fake.date_between(start_date='-5y', end_date='-1y').isoformat()
            }
            
            client.table("company_people").insert(cp_data).execute()
            
    print("Done!")

if __name__ == "__main__":
    populate_board_data()
