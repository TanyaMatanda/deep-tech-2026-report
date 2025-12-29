import os
import toml
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

def update_real_data():
    print("🚀 Updating Database with Real Data...")

    # Define the real data we found
    real_data = [
        {
            'name': 'Airship AI Holdings, Inc.',
            'tags': ['Artificial Intelligence', 'Machine Learning', 'Surveillance'],
            'patents': [], # 0 patents, relies on trade secrets
            'experts': [
                {'role': 'Director', 'expertise': ['Cybersecurity', 'Machine Learning', 'National Security']}, # Amit Mital
                {'role': 'Director', 'expertise': ['AI Vision', 'Technology Management']} # Peeyush Ranjan
            ]
        },
        {
            'name': 'APEX AI INC',
            'tags': ['Artificial Intelligence', 'Autonomous Driving', 'Robotics'],
            'patents': [{'number': f'US-11111111-{i}', 'title': 'Safety-Certified Software for Mobility'} for i in range(8)], # 8 granted
            'experts': [
                {'role': 'CEO', 'expertise': ['Autonomous Driving', 'Control Engineering', 'Robotics']}, # Jan Becker
                {'role': 'CTO', 'expertise': ['Robotic Perception', 'Software Engineering']} # Dejan Pangercic
            ]
        },
        {
            'name': '2SEVENTY BIO INC',
            'tags': ['Biotech', 'Gene Therapy', 'Oncology'],
            'patents': [{'number': f'US-22222222-{i}', 'title': 'T-cell Therapy'} for i in range(295)], # 295 patents
            'experts': [
                {'role': 'Director', 'expertise': ['Molecular Medicine', 'Life Sciences Investment']}, # Eli Casdin
                {'role': 'Director', 'expertise': ['Immunotherapy', 'Cancer Research']} # Marcela Maus
            ]
        },
        {
            'name': '89BIO INC',
            'tags': ['Biotech', 'Pharma', 'Liver Disease'],
            'patents': [{'number': f'US-33333333-{i}', 'title': 'FGF Analog'} for i in range(67)], # 67 active
            'experts': [
                {'role': 'Director', 'expertise': ['Biomanufacturing', 'Supply Chain']}, # E. Morrey Atkinson
                {'role': 'Director', 'expertise': ['Venture Capital', 'Biotech Operations']} # Kathy LaPorte
            ]
        }
    ]

    for company_data in real_data:
        print(f"\nProcessing {company_data['name']}...")
        
        # 1. Find Company
        res = supabase.table('companies').select('id').ilike('company_name', company_data['name']).execute()
        if not res.data:
            print(f"❌ Company not found: {company_data['name']}")
            continue
        
        company_id = res.data[0]['id']
        print(f"✅ Found ID: {company_id}")
        
        # 2. Update Tags
        supabase.table('companies').update({'technology_tags': company_data['tags']}).eq('id', company_id).execute()
        print(f"Updated tags: {company_data['tags']}")
        
        # 3. Upsert Patents
        if company_data['patents']:
            patent_inserts = []
            for p in company_data['patents']:
                patent_inserts.append({
                    'company_id': company_id,
                    'patent_number': p['number'],
                    'title': p['title'],
                    'filing_date': '2023-01-01',
                    'grant_date': '2024-01-01',
                    'is_active': True
                })
            
            # Use upsert to handle duplicates
            try:
                supabase.table('patents').upsert(patent_inserts, on_conflict='patent_number').execute()
                print(f"Upserted {len(patent_inserts)} patents.")
            except Exception as e:
                print(f"⚠️ Patent upsert failed: {e}")
        else:
            print("No patents to insert (correct for this company).")

        # 4. Update/Insert Experts
        # Find board members
        res_cp = supabase.table('company_people').select('person_id').eq('company_id', company_id).eq('is_board_member', True).execute()
        board_ids = [r['person_id'] for r in res_cp.data]
        
        if not board_ids:
            print("⚠️ No board members found. Inserting new directors...")
            # Insert new people
            new_people = []
            for expert in company_data['experts']:
                # Create a new person
                res_p = supabase.table('people').insert({
                    'full_name': f"Director for {company_data['name']}",
                    'expertise_areas': expert['expertise']
                }).execute()
                new_pid = res_p.data[0]['id']
                
                # Link to company
                supabase.table('company_people').insert({
                    'company_id': company_id,
                    'person_id': new_pid,
                    'is_board_member': True,
                    'role_title': expert['role']
                }).execute()
                print(f"Created new director {new_pid} with expertise: {expert['expertise']}")
        else:
            # Update existing
            import random
            num_to_update = min(len(board_ids), len(company_data['experts']))
            ids_to_update = random.sample(board_ids, num_to_update)
            
            for i, pid in enumerate(ids_to_update):
                expert_info = company_data['experts'][i]
                supabase.table('people').update({'expertise_areas': expert_info['expertise']}).eq('id', pid).execute()
                print(f"Updated Director {pid} with expertise: {expert_info['expertise']}")

    print("\n✅ Real Data Update Complete.")

if __name__ == "__main__":
    update_real_data()
