import os
import subprocess
import sys
import getpass

def install_package(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

try:
    import psycopg2
except ImportError:
    print("Installing psycopg2-binary...")
    install_package("psycopg2-binary")
    import psycopg2

def main():
    print("="*60)
    print("SUPABASE DATABASE DEPLOYMENT")
    print("="*60)
    print()
    
    # Configuration
    DEFAULT_DB_HOST = "db.mpabbijfgrmqiqnysiwf.supabase.co"
    DB_NAME = "postgres"
    DB_USER = "postgres"
    DB_PORT = "5432"
    SQL_FILE = "MASTER_DEPLOYMENT.sql"
    
    print(f"File:   {SQL_FILE}")
    print("-" * 30)
    
    # Get Host
    db_host_input = input(f"Enter Database Host (Press Enter for '{DEFAULT_DB_HOST}'): ").strip()
    DB_HOST = db_host_input if db_host_input else DEFAULT_DB_HOST
    
    # Get password securely
    password = getpass.getpass("Enter your Supabase Database Password: ")
    
    if not password:
        print("Error: Password is required.")
        return

    print("\nConnecting to database...")
    
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=password,
            port=DB_PORT
        )
        conn.autocommit = True
        cursor = conn.cursor()
        print("✅ Connected successfully!")
        
        print(f"Reading {SQL_FILE}...")
        with open(SQL_FILE, 'r') as f:
            sql_content = f.read()
            
        print(f"🚀 Executing SQL script ({len(sql_content)/1024/1024:.2f} MB)...")
        print("This may take a minute or two...")
        
        cursor.execute(sql_content)
        
        print("\n✅ Deployment successful!")
        
        cursor.close()
        conn.close()
        
    except Exception as e:
        print(f"\n❌ Error: {e}")
        print("\nTroubleshooting:")
        print("1. Check your password")
        print("2. Ensure your IP is allowed in Supabase Network Settings")
        print("3. Check if the database is paused")

if __name__ == "__main__":
    main()
