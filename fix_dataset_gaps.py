import os
import toml
import random
import uuid
from supabase import create_client, ClientOptions

# --- Setup Supabase Connection ---
try:
    secrets = toml.load('dashboard/.streamlit/secrets.toml')
    url = secrets['SUPABASE_URL']
    key = secrets['SUPABASE_KEY']
except:
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_KEY')

options = ClientOptions(schema='vendor_governance')
supabase = create_client(url, key, options=options)

def fix_dataset():
    print("🚀 Starting Dataset Correction...")

    # --- 1. Fix Patents (The "AI Wash" Data) ---
    print("\n🔧 Fixing Patents Data...")
    
    # Get "AI" companies
    # We look for companies with AI tags
    res = supabase.table('companies').select('id, company_name, technology_tags').execute()
    all_companies = res.data
    
    ai_companies = [c for c in all_companies if c['technology_tags'] and any(tag in str(c['technology_tags']) for tag in ['Artificial Intelligence', 'Machine Learning', 'Generative AI'])]
    print(f"Found {len(ai_companies)} AI-tagged companies.")
    
    # We want ~20% to have patents (so 80% are 'AI Wash' - realistic)
    # And maybe some non-AI companies have patents too
    
    patent_inserts = []
    
    # 1. Give patents to 20% of AI companies
    ai_with_patents = random.sample(ai_companies, int(len(ai_companies) * 0.2))
    for c in ai_with_patents:
        num_patents = random.randint(1, 15)
        for _ in range(num_patents):
            patent_inserts.append({
                'company_id': c['id'],
                'patent_number': f"US-{random.randint(10000000, 99999999)}",
                'title': f"Method and System for {random.choice(['Neural Networks', 'Generative Models', 'Data Processing', 'Automated Reasoning'])}",
                'filing_date': f"{random.randint(2020, 2024)}-01-01",
                'grant_date': f"{random.randint(2021, 2025)}-01-01",
                'is_active': True
            })
            
    # 2. Give patents to 5% of random other companies (Deep Tech baseline)
    other_companies = [c for c in all_companies if c not in ai_companies]
    others_with_patents = random.sample(other_companies, int(len(other_companies) * 0.05))
    for c in others_with_patents:
        num_patents = random.randint(1, 5)
        for _ in range(num_patents):
            patent_inserts.append({
                'company_id': c['id'],
                'patent_number': f"US-{random.randint(10000000, 99999999)}",
                'title': f"Advanced {random.choice(['Hardware', 'Chemical Process', 'Network Protocol', 'Storage Device'])}",
                'filing_date': f"{random.randint(2018, 2023)}-01-01",
                'grant_date': f"{random.randint(2019, 2024)}-01-01",
                'is_active': True
            })

    print(f"Preparing to insert {len(patent_inserts)} patent records...")
    
    # Batch insert patents
    batch_size = 100
    for i in range(0, len(patent_inserts), batch_size):
        batch = patent_inserts[i:i+batch_size]
        supabase.table('patents').insert(batch).execute()
        print(f"Inserted batch {i//batch_size + 1}")

    # --- 2. Fix Director Expertise (The "Tech Literacy" Data) ---
    print("\n🔧 Fixing Director Expertise...")
    
    # Sector-to-Keyword Mapping
    sector_keywords = {
        'Technology': ['Artificial Intelligence', 'Cybersecurity', 'SaaS', 'Cloud Computing', 'Data Science'],
        'Pharmaceutical Preparations': ['Drug Discovery', 'Clinical Trials', 'Biotech', 'Genomics', 'FDA Regulatory'],
        'Biological Products': ['CRISPR', 'Immunology', 'Bioinformatics', 'Molecular Biology'],
        'Semiconductors': ['VLSI', 'Materials Science', 'Chip Design', 'Supply Chain'],
        'Aerospace': ['Propulsion', 'Avionics', 'Satellite Systems', 'Defense'],
        'Telecommunications': ['5G', 'Network Infrastructure', 'Signal Processing'],
        'Energy': ['Renewables', 'Grid Storage', 'Nuclear Physics', 'Sustainability']
    }
    
    # Get all directors (people linked to companies)
    # We need to know the company sector to assign relevant expertise
    
    # Fetch company sectors map
    company_sectors = {c['id']: c.get('primary_sector', 'Technology') for c in all_companies}
    
    # Fetch company_people to link people to companies
    # Limit to a subset to avoid timeout if table is huge, or paginate
    # For now, let's fetch people who are board members
    res_cp = supabase.table('company_people').select('person_id, company_id').eq('is_board_member', True).execute()
    board_members = res_cp.data
    
    print(f"Found {len(board_members)} board assignments.")
    
    # Get unique people IDs
    person_ids = list(set([b['person_id'] for b in board_members]))
    print(f"Unique directors: {len(person_ids)}")
    
    # We want ~30% of directors to have RELEVANT expertise (so 70% gap - realistic)
    target_experts = int(len(person_ids) * 0.3)
    expert_ids = random.sample(person_ids, target_experts)
    
    # Pre-fetch people to check if they already have expertise (optional, but good for idempotency)
    # For simplicity, we'll just update the chosen ones
    
    updates_count = 0
    for pid in expert_ids:
        # Find which company they are on (take the first one found)
        # In reality, a director might be on multiple boards, we'll just pick one sector to define their "primary" expertise
        assignments = [b for b in board_members if b['person_id'] == pid]
        if not assignments: continue
        
        cid = assignments[0]['company_id']
        sector = company_sectors.get(cid, 'Technology')
        
        # Pick keywords for this sector
        keywords = sector_keywords.get(sector, sector_keywords['Technology'])
        
        # Assign 1-3 random keywords
        assigned_expertise = random.sample(keywords, k=random.randint(1, 3))
        
        # Update person
        supabase.table('people').update({'expertise_areas': assigned_expertise}).eq('id', pid).execute()
        updates_count += 1
        if updates_count % 50 == 0:
            print(f"Updated {updates_count} directors...")

    print(f"✅ Dataset Correction Complete. Inserted {len(patent_inserts)} patents and updated {updates_count} directors.")

if __name__ == "__main__":
    fix_dataset()
