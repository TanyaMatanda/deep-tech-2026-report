import os
import toml
import pandas as pd
from supabase import create_client, ClientOptions

def reclassify_listing_types():
    print("🚀 Starting Company Reclassification...")
    
    # 1. Connect to Supabase
    try:
        secrets = toml.load(".streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
    except Exception as e:
        print(f"❌ Error loading secrets: {e}")
        return

    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    supabase = create_client(url, key, options=options)
    
    # 2. Fetch all companies
    print("📡 Fetching companies...")
    res = supabase.table('companies').select('id, company_name, ticker_symbol, cik, sedar_id, listing_type').execute()
    if not res.data:
        print("❌ No data found.")
        return
    
    df = pd.DataFrame(res.data)
    total = len(df)
    print(f"✅ Fetched {total} companies.")
    
    # 3. Determine correct listing type
    # Public if has ticker OR CIK OR SEDAR ID
    df['should_be_public'] = (
        df['ticker_symbol'].notna() & (df['ticker_symbol'] != 'None') & (df['ticker_symbol'] != '') |
        df['cik'].notna() & (df['cik'] != 'None') & (df['cik'] != '') |
        df['sedar_id'].notna() & (df['sedar_id'] != 'None') & (df['sedar_id'] != '')
    )
    
    df['target_listing_type'] = df['should_be_public'].map({True: 'Public', False: 'Private'})
    
    # 4. Identify changes needed
    to_update = df[df['listing_type'] != df['target_listing_type']]
    num_updates = len(to_update)
    print(f"📝 Identified {num_updates} companies to reclassify.")
    
    if num_updates == 0:
        print("✨ All companies are already correctly classified.")
        return

    # 5. Batch update
    print(f"🔄 Updating {num_updates} records...")
    
    # We'll update in batches to avoid timeouts or payload limits
    batch_size = 50
    updated_count = 0
    
    for i in range(0, num_updates, batch_size):
        batch = to_update.iloc[i:i+batch_size]
        
        # Supabase Python client doesn't support bulk updates with different values easily 
        # unless we use RPC or multiple calls. 
        # For listing_type, we can group by target_listing_type and update in two large chunks.
        pass

    # Grouping by target type for efficient updates
    for target_type in ['Public', 'Private']:
        ids_to_update = to_update[to_update['target_listing_type'] == target_type]['id'].tolist()
        if not ids_to_update:
            continue
            
        print(f"  - Setting {len(ids_to_update)} companies to '{target_type}'...")
        
        # Update in chunks of 200 IDs to be safe
        id_chunks = [ids_to_update[x:x+200] for x in range(0, len(ids_to_update), 200)]
        for chunk in id_chunks:
            try:
                supabase.table('companies').update({'listing_type': target_type}).in_('id', chunk).execute()
                updated_count += len(chunk)
            except Exception as e:
                print(f"  ❌ Error updating chunk: {e}")

    print(f"🎉 Successfully reclassified {updated_count} companies.")

if __name__ == "__main__":
    reclassify_listing_types()
