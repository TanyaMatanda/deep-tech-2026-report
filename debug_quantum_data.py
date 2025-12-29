import os
import sys
import pandas as pd

# Add current directory to path to import db_connection
sys.path.append(os.getcwd())

from db_connection import init_connection

def map_sector(row):
    s = ""
    if isinstance(row.get('sub_sector'), str):
        s += row['sub_sector'].lower() + " "
    if isinstance(row.get('company_name'), str):
        s += row['company_name'].lower()
    
    if not s.strip(): return "Other"
    
    if any(x in s for x in ['quantum', 'optic', 'photon']): return "Quantum & Photonics"
    return "Other"

def check_quantum_data():
    client = init_connection()
    if not client: return
    
    print("--- Checking Quantum & Photonics Data ---")
    
    # Fetch companies
    res_comp = client.table("companies").select("id, company_name, sub_sector").limit(5000).execute()
    comp_df = pd.DataFrame(res_comp.data)
    comp_df['report_sector'] = comp_df.apply(map_sector, axis=1)
    
    quantum_companies = comp_df[comp_df['report_sector'] == "Quantum & Photonics"]
    print(f"Found {len(quantum_companies)} Quantum & Photonics companies in sample.")
    
    if not quantum_companies.empty:
        company_ids = quantum_companies['id'].tolist()
        
        # Fetch board data for these companies
        res_board = client.table("board_composition_annual").select("*").in_("company_id", company_ids).execute()
        board_df = pd.DataFrame(res_board.data)
        
        if not board_df.empty:
            print(f"Found {len(board_df)} board data rows for these companies.")
            print("\nBoard Metrics for Quantum Companies:")
            print(f"  Avg Age: {board_df['avg_director_age'].mean()}")
            print(f"  AI Oversight Count: {board_df['has_ai_oversight_committee'].sum()}")
            print(f"  Null Age Count: {board_df['avg_director_age'].isnull().sum()}")
            print(f"  Zero Age Count: {(board_df['avg_director_age'] == 0).sum()}")
        else:
            print("No board data found for these Quantum companies.")

if __name__ == "__main__":
    check_quantum_data()
