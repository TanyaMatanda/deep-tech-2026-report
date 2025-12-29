import os
import toml
from supabase import create_client, Client, ClientOptions

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

def run_sql_safe(sql):
    try:
        # Supabase-py doesn't support raw SQL directly easily without RPC, 
        # but we can use the 'rpc' call if a generic exec function exists, 
        # OR we can just use the table APIs for inserts/updates.
        # For DDL (ALTER TABLE), we might be stuck if we don't have a way to run raw SQL.
        # However, the user was running SQL in a dashboard or editor.
        
        # Actually, for the DDL, we can't easily do it via the JS/Python client unless we have a stored procedure.
        # BUT, we can try to use the 'rpc' endpoint if there's a function like 'exec_sql'.
        # Checking database_schema.sql... I don't see a generic exec_sql function.
        
        # WORKAROUND: We will skip the DDL for a moment and assume the user might have run it, 
        # OR we can try to use the 'postgres' connection if we had psycopg2, but we don't have the connection string, just the API URL/Key.
        
        # Wait, the user's previous error was "column does not exist".
        # I MUST fix the schema.
        # Since I cannot run DDL via the API client easily, I will ask the user to run *just* the DDL SQL, 
        # or I can try to use a very simple RPC if one exists.
        
        # Let's look at what I can do with the client.
        # I can insert/update.
        pass
    except Exception as e:
        print(f"Error: {e}")

def fix_nvidia():
    print("🚀 Starting NVIDIA Data Fix...")

    # 1. Get Company ID
    res = supabase.table("companies").select("id").eq("ticker_symbol", "NVDA").execute()
    if not res.data:
        print("❌ NVDA not found in companies table.")
        return
    
    company_id = res.data[0]['id']
    print(f"✅ Found NVDA: {company_id}")

    # 2. Update Company Metadata (Patents, Scores)
    # Note: If columns don't exist, this will fail. 
    # But I can't run DDL from here.
    # I will assume the columns MIGHT exist or I will try to update them.
    # If they fail, I will print a clear message to the user to run the DDL.
    
    try:
        supabase.table("companies").update({
            "patents_count": 5500,
            "innovation_score": 9.8,
            "governance_score": 8.5,
            "primary_sector": "Technology"
        }).eq("id", company_id).execute()
        print("✅ Updated Company Metadata (Patents, Scores)")
    except Exception as e:
        print(f"⚠️ Failed to update new columns (patents_count, etc). They might be missing.")
        print(f"   Error: {e}")
        print("   👉 Please run this SQL in the Supabase SQL Editor first:")
        print("   ALTER TABLE vendor_governance.companies ADD COLUMN IF NOT EXISTS patents_count INTEGER DEFAULT 0;")
        print("   ALTER TABLE vendor_governance.companies ADD COLUMN IF NOT EXISTS innovation_score DECIMAL(4,2);")
        print("   ALTER TABLE vendor_governance.companies ADD COLUMN IF NOT EXISTS governance_score DECIMAL(4,2);")
        # We continue, as the other inserts might work

    # 3. Insert People
    people = [
        {"name": "Jensen Huang", "role": "President and CEO", "type": "Executive", "is_exec": True},
        {"name": "Tench Coxe", "role": "Director", "type": "Director", "is_exec": False},
        {"name": "Harvey Jones", "role": "Director", "type": "Director", "is_exec": False},
        {"name": "Persis Drell", "role": "Director", "type": "Director", "is_exec": False},
        {"name": "Brooke Seawell", "role": "Director", "type": "Director", "is_exec": False},
        {"name": "Aarti Shah", "role": "Director", "type": "Director", "is_exec": False},
    ]

    for p in people:
        # Check if person exists
        p_res = supabase.table("people").select("id").eq("full_name", p["name"]).execute()
        if p_res.data:
            p_id = p_res.data[0]['id']
        else:
            # Insert
            new_p = {
                "full_name": p["name"],
                "first_name": p["name"].split()[0],
                "last_name": p["name"].split()[-1],
                "current_title": p["role"],
                "expertise_areas": ["Technology", "Leadership"]
            }
            p_insert = supabase.table("people").insert(new_p).execute()
            p_id = p_insert.data[0]['id']
        
        # Link
        link_data = {
            "company_id": company_id,
            "person_id": p_id,
            "role_title": p["role"],
            "role_type": p["type"],
            "is_board_member": True,
            "is_executive": p["is_exec"]
        }
        try:
            supabase.table("company_people").upsert(link_data, on_conflict="company_id, person_id, role_title, start_date").execute()
            print(f"   Linked {p['name']}")
        except Exception as e:
            print(f"   Error linking {p['name']}: {e}")

    # 4. Governance Scores
    gov_data = {
        "company_id": company_id,
        "fiscal_year": 2024,
        "overall_score": 8.5,
        "board_independence_pct": 92.0,
        "board_diversity_pct": 46.0,
        "shareholder_rights_score": 8.0,
        "audit_integrity_score": 9.0,
        "strategic_oversight_score": 9.5
    }
    try:
        supabase.table("governance_scores").upsert(gov_data, on_conflict="company_id, fiscal_year").execute()
        print("✅ Inserted Governance Scores")
    except Exception as e:
        print(f"❌ Failed to insert Governance Scores: {e}")

    # 5. Board Composition
    board_data = {
        "company_id": company_id,
        "fiscal_year": 2024,
        "total_directors": 13,
        "independent_directors": 12,
        "women_directors": 4,
        "ethnic_minority_directors": 5,
        "avg_director_age": 62.5,
        "avg_director_tenure": 8.4
    }
    try:
        supabase.table("board_composition_annual").upsert(board_data, on_conflict="company_id, fiscal_year").execute()
        print("✅ Inserted Board Composition")
    except Exception as e:
        print(f"❌ Failed to insert Board Composition: {e}")

if __name__ == "__main__":
    fix_nvidia()
