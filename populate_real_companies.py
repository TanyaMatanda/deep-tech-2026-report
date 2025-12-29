import os
import pandas as pd
from supabase import create_client, Client
import toml

# Load secrets
try:
    try:
        secrets = toml.load(".streamlit/secrets.toml")
    except FileNotFoundError:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")

if not url or not key:
    print("Error: Supabase credentials not found.")
    exit(1)

from supabase import ClientOptions
options = ClientOptions(schema="vendor_governance")
supabase: Client = create_client(url, key, options=options)

def populate_tsx_companies():
    csv_file = 'tsx_deep_tech_companies.csv'
    if not os.path.exists(csv_file):
        print(f"Skipping {csv_file} (not found)")
        return

    print(f"Processing {csv_file}...")
    df = pd.read_csv(csv_file)
    
    companies = []
    for _, row in df.iterrows():
        company = {
            'company_name': row['name'],
            'ticker_symbol': row['ticker'] if row['ticker'] != 'Private' else None,
            'incorporation_country': 'CAN',
            'incorporation_jurisdiction': 'Ontario', # Default for TSX usually
            'primary_sector': row['sector'],
            'listing_type': 'Public' if row['ticker'] != 'Private' else 'Private',
            'stock_exchange': row.get('exchange', 'TSX'),
            'data_tier': 2
        }
        companies.append(company)
    
    if companies:
        try:
            # Upsert in batches
            batch_size = 100
            for i in range(0, len(companies), batch_size):
                batch = companies[i:i+batch_size]
                data = supabase.table('companies').upsert(batch, on_conflict='company_name, incorporation_jurisdiction').execute()
                print(f"  Upserted batch {i//batch_size + 1}")
            print(f"✅ Successfully populated {len(companies)} TSX companies.")
        except Exception as e:
            print(f"Error upserting TSX companies: {e}")

def populate_sec_companies():
    csv_file = 'sec_deep_tech_companies.csv'
    if not os.path.exists(csv_file):
        print(f"Skipping {csv_file} (not found)")
        return

    print(f"Processing {csv_file}...")
    df = pd.read_csv(csv_file)
    
    companies = []
    for _, row in df.iterrows():
        # Infer sector if possible, or default
        sector = 'Technology' # Default
        name_lower = row['name'].lower()
        if 'bio' in name_lower or 'pharma' in name_lower:
            sector = 'Biotechnology'
        elif 'energy' in name_lower or 'solar' in name_lower:
            sector = 'Energy & Climate'
        elif 'ai' in name_lower or 'intelligence' in name_lower:
            sector = 'AI & Machine Learning'
            
        company = {
            'company_name': row['name'],
            'ticker_symbol': row['ticker'],
            'cik': str(row['cik']).zfill(10),
            'incorporation_country': 'USA',
            'incorporation_jurisdiction': 'Delaware', # Common default
            'primary_sector': sector,
            'listing_type': 'Public',
            'stock_exchange': 'NASDAQ', # Assumption for deep tech
            'data_tier': 1
        }
        companies.append(company)
    
    # Deduplicate by composite key (company_name, incorporation_jurisdiction)
    unique_companies = {}
    for c in companies:
        key = (c['company_name'].strip(), c['incorporation_jurisdiction'].strip())
        unique_companies[key] = c
    companies = list(unique_companies.values())
    
    if companies:
        try:
            # Upsert companies one by one to avoid batch conflicts
            for company in companies:
                try:
                    response = supabase.table('companies').upsert(company, on_conflict='company_name, incorporation_jurisdiction').execute()
                    print(f"  Upserted {company['company_name']}")
                    
                    # Insert filings if available
                    if response.data:
                        filings_to_insert = []
                        company_record = response.data[0]
                        
                        # Find original row to get filings
                        ticker = company_record.get('ticker_symbol')
                        if not ticker: continue
                        
                        # Find row in df (inefficient but fine for small dataset)
                        row = df[df['ticker'] == ticker]
                        if row.empty: continue
                        row = row.iloc[0]
                        
                        company_id = company_record['id']
                        
                        # Parse filings
                        import ast
                        try:
                            proxy_filings = ast.literal_eval(row['proxy_filings']) if 'proxy_filings' in row and pd.notna(row['proxy_filings']) else []
                            k10_filings = ast.literal_eval(row['10k_filings']) if '10k_filings' in row and pd.notna(row['10k_filings']) else []
                            
                            all_filings = proxy_filings + k10_filings
                            for filing in all_filings:
                                filings_to_insert.append({
                                    'company_id': company_id,
                                    'accession_number': filing['accession_number'],
                                    'filing_type': filing['filing_type'],
                                    'filing_date': filing['filing_date'],
                                    'filing_url': filing['filing_url'],
                                    'processing_status': 'pending'
                                })
                        except Exception as e:
                            print(f"    Error parsing filings for {ticker}: {e}")
                            
                        if filings_to_insert:
                            # Upsert filings in batches
                            batch_size = 50
                            for j in range(0, len(filings_to_insert), batch_size):
                                f_batch = filings_to_insert[j:j+batch_size]
                                supabase.table('sec_filings').upsert(f_batch, on_conflict='accession_number').execute()
                            print(f"    Upserted {len(filings_to_insert)} filings")
                            
                except Exception as e:
                    print(f"  Error upserting {company['company_name']}: {e}")

            print(f"✅ Successfully populated SEC companies and filings.")
        except Exception as e:
            print(f"Error in SEC population loop: {e}")

if __name__ == "__main__":
    print("Starting database population...")
    populate_tsx_companies()
    populate_sec_companies()
    print("Done.")
