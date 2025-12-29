import os
import sys
import pandas as pd

# Add current directory to path to import db_connection
sys.path.append(os.getcwd())

from db_connection import init_connection

def check_metrics_distribution():
    client = init_connection()
    if not client:
        print("Failed to initialize connection")
        return
        
    print("--- Checking Metrics Distribution (using db_connection) ---")
    
    # Fetch a larger sample of board data
    try:
        res = client.table("board_composition_annual").select("avg_director_age, has_ai_oversight_committee").limit(5000).execute()
        df = pd.DataFrame(res.data)
        
        if not df.empty:
            print(f"Sample Size: {len(df)}")
            print("\nAvg Director Age Distribution:")
            print(df['avg_director_age'].describe())
            print(f"Null Age Count: {df['avg_director_age'].isnull().sum()}")
            print(f"Zero Age Count: {(df['avg_director_age'] == 0).sum()}")
            
            print("\nAI Oversight Committee Distribution:")
            print(df['has_ai_oversight_committee'].value_counts(dropna=False))
            
    except Exception as e:
        print(f"Error fetching board data: {e}")

    # Check governance_scores table content
    try:
        res_gov = client.table("governance_scores").select("*", count="exact").limit(10).execute()
        print(f"\nGovernance Scores Table (Total rows: {res_gov.count}):")
        print(res_gov.data)
    except Exception as e:
        print(f"Error fetching gov scores: {e}")

if __name__ == "__main__":
    check_metrics_distribution()
