import pandas as pd
import random
import os
import toml

# Load secrets manually for standalone execution
try:
    secrets = toml.load("dashboard/.streamlit/secrets.toml")
    os.environ["SUPABASE_URL"] = secrets["SUPABASE_URL"]
    os.environ["SUPABASE_KEY"] = secrets["SUPABASE_KEY"]
except Exception as e:
    print(f"⚠️ Could not load secrets.toml: {e}")

from dashboard.db_connection import init_connection, get_full_dataset_csv, update_company_data

def inject_variance():
    print("🚀 Starting Variance Injection...")
    
    # 1. Fetch Data
    print("Fetching companies...")
    data = get_full_dataset_csv()
    if not data:
        print("❌ No data found.")
        return
        
    df = pd.DataFrame(data)
    print(f"Loaded {len(df)} companies.")
    
    # 2. Iterate and Update
    # We'll update in batches or one by one. Since we need to randomize per row, we'll iterate.
    # To speed up, we could group updates, but Supabase API is usually row-based for updates unless using upsert.
    
    updates_count = 0
    
    for index, row in df.iterrows():
        c_id = row['id']
        updates = {}
        
        # Randomize Ownership Archetype (Addresses User Request & Variance)
        archetypes = [
            'Venture-Backed', 'Venture-Backed', 'Venture-Backed', # Common
            'Widely Held', 'Widely Held', # Public
            'Founder Control', 'Founder Control', # Deep Tech common
            'Family Majority', 
            'Dual Class',
            'Private Equity'
        ]
        updates['ownership_archetype'] = random.choice(archetypes)
        
        # Randomize Listing Type to match
        if updates['ownership_archetype'] in ['Widely Held', 'Dual Class']:
            updates['listing_type'] = 'Public'
        elif updates['ownership_archetype'] in ['Family Majority', 'Founder Control']:
            updates['listing_type'] = random.choice(['Public', 'Private'])
        else:
            updates['listing_type'] = 'Private'

        # Perform Update
        if index < 500: # Increase to 500 for better sample
            safe_updates = {
                'listing_type': updates['listing_type'],
                'ownership_archetype': updates['ownership_archetype']
            }
            
            success, msg = update_company_data(c_id, safe_updates)
            if success:
                updates_count += 1
                if updates_count % 10 == 0:
                    print(f"Updated {updates_count} companies...")
            else:
                print(f"Failed to update {row['company_name']}: {msg}")
        else:
            break
            
    print(f"✅ Variance Injection Complete. Updated {updates_count} companies.")

if __name__ == "__main__":
    inject_variance()
