import requests
import re
import json
import ast
import time

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

HEADERS = {
    "apikey": SUPABASE_KEY,
    "Authorization": f"Bearer {SUPABASE_KEY}",
    "Content-Type": "application/json",
    "Prefer": "resolution=ignore-duplicates", # Skip duplicates
    "Content-Profile": "vendor_governance",
    "Accept-Profile": "vendor_governance"
}

# Lookup Maps
TICKER_TO_ID = {}
NAME_TO_ID = {}
ACCESSION_TO_ID = {}
PERSON_TO_ID = {}

def get_companies_map():
    print("Fetching existing companies to build ID map...")
    url = f"{SUPABASE_URL}/rest/v1/companies?select=id,ticker_symbol,company_name"
    # Fetch in chunks if necessary, but for 5k it might fit. Max rows is usually 1000.
    # We need to paginate.
    
    offset = 0
    limit = 1000
    all_companies = []
    
    while True:
        r = requests.get(url, headers=HEADERS, params={"offset": offset, "limit": limit})
        if r.status_code != 200:
            print(f"Error fetching companies: {r.text}")
            break
        
        data = r.json()
        if not data:
            break
            
        all_companies.extend(data)
        if len(data) < limit:
            break
        offset += limit
        print(f"  Fetched {len(all_companies)} companies so far...")
        
    for c in all_companies:
        if c.get('ticker_symbol'):
            TICKER_TO_ID[c['ticker_symbol']] = c['id']
        if c.get('company_name'):
            NAME_TO_ID[c['company_name']] = c['id']
            
    print(f"✅ Loaded {len(TICKER_TO_ID)} tickers and {len(NAME_TO_ID)} names.")

def get_sec_filings_map():
    print("Fetching existing SEC filings to build ID map...")
    url = f"{SUPABASE_URL}/rest/v1/sec_filings?select=id,accession_number"
    offset = 0
    limit = 1000
    
    while True:
        r = requests.get(url, headers=HEADERS, params={"offset": offset, "limit": limit})
        if r.status_code != 200: break
        data = r.json()
        if not data: break
        
        for f in data:
            if f.get('accession_number'):
                ACCESSION_TO_ID[f['accession_number']] = f['id']
        
        if len(data) < limit: break
        offset += limit
        
    print(f"✅ Loaded {len(ACCESSION_TO_ID)} filings.")

def get_people_map():
    print("Fetching existing people to build ID map...")
    url = f"{SUPABASE_URL}/rest/v1/people?select=id,full_name"
    offset = 0
    limit = 1000
    
    while True:
        r = requests.get(url, headers=HEADERS, params={"offset": offset, "limit": limit})
        if r.status_code != 200: break
        data = r.json()
        if not data: break
        
        for p in data:
            if p.get('full_name'):
                PERSON_TO_ID[p['full_name']] = p['id']
        
        if len(data) < limit: break
        offset += limit
        
    print(f"✅ Loaded {len(PERSON_TO_ID)} people.")

def split_sql_values(line):
    # Split by comma, respecting quotes and brackets []
    values = []
    current_val = []
    in_quote = False
    quote_char = ''
    bracket_depth = 0
    
    for char in line:
        if in_quote:
            current_val.append(char)
            if char == quote_char:
                # Check for escape (double quote) - simplified
                # We'll just toggle for now, assuming standard SQL escaping isn't breaking us here
                # Actually, we need to be careful.
                # But for this specific dataset, simple toggle is likely enough.
                in_quote = False
        else:
            if char == "'":
                in_quote = True
                quote_char = "'"
                current_val.append(char)
            elif char == '[':
                bracket_depth += 1
                current_val.append(char)
            elif char == ']':
                bracket_depth -= 1
                current_val.append(char)
            elif char == ',' and bracket_depth == 0:
                # Split!
                values.append("".join(current_val).strip())
                current_val = []
            else:
                current_val.append(char)
                
    if current_val:
        values.append("".join(current_val).strip())
        
    return values

def parse_sql_value(val_str):
    val_str = val_str.strip()
    if val_str.upper() == 'NULL':
        return None
    if val_str.upper() == 'TRUE':
        return True
    if val_str.upper() == 'FALSE':
        return False
    
    # Handle Arrays: ARRAY['a', 'b']
    if val_str.upper().startswith('ARRAY['):
        inner = val_str[6:-1] # Remove ARRAY[ and ]
        # Inner split needs to respect quotes too!
        # Recursive call to split_sql_values?
        # Inner content is like: 'a', 'b'
        # split_sql_values will work perfectly here.
        items_raw = split_sql_values(inner)
        items = []
        for p in items_raw:
            p = p.strip()
            if p.startswith("'") and p.endswith("'"):
                items.append(p[1:-1].replace("''", "'"))
            else:
                items.append(p)
        return items

    # Handle Strings: 'Value'
    if val_str.startswith("'") and val_str.endswith("'"):
        # Handle escaped quotes: '' -> '
        return val_str[1:-1].replace("''", "'")
    
    # Numbers
    try:
        if '.' in val_str:
            return float(val_str)
        return int(val_str)
    except:
        return val_str

def upload_batch(table, rows):
    if not rows: return
    print(f"Uploading {len(rows)} rows to {table}...")
    url = f"{SUPABASE_URL}/rest/v1/{table}"
    r = requests.post(url, headers=HEADERS, json=rows)
    if r.status_code not in [200, 201]:
        print(f"❌ Error uploading to {table}: {r.status_code} - {r.text}")
    else:
        print(f"✅ Success uploading to {table}.")

def main():
    print("🚀 Starting Deployment via REST API (Full Dataset)...")
    
    # 1. Upload Base Companies (Safe to rerun)
    process_companies_file("collectors/final_combined_database.sql")
    
    # 2. Upload Patent Companies (The big 50k file)
    process_patent_companies("collectors/patent_companies_insert.sql")
    
    # 3. Refresh Companies Map
    get_companies_map()
    
    # 4. Upload People (No dependencies)
    process_real_governance("real_governance_data.sql", target_tables=["people"])
    
    # 5. Refresh People Map
    get_people_map()
    
    # 6. Upload SEC Filings (Depends on Companies)
    process_real_governance("real_governance_data.sql", target_tables=["sec_filings"])
    
    # 7. Refresh Filings Map
    get_sec_filings_map()
    
    # 8. Upload Everything Else (Dependent tables)
    dependent_tables = [
        "proxy_statement_data", 
        "board_composition_annual", 
        "company_people", 
        "executive_compensation_annual", 
        "governance_scores", 
        "cybersecurity_incidents", 
        "customer_concentration", 
        "technology_dependencies", 
        "export_control_classification"
    ]
    process_real_governance("real_governance_data.sql", target_tables=dependent_tables)
    
    print("✅ Governance Deployment Complete!")

def process_companies_file(filename):
    print(f"Processing {filename}...")
    with open(filename, 'r') as f:
        content = f.read()
        
    statements = content.split("INSERT INTO")
    
    batch = []
    
    for stmt in statements:
        stmt = stmt.strip()
        if not stmt: continue
        
        # Identify table
        if stmt.startswith("companies") or stmt.startswith("vendor_governance.companies"):
            # Extract VALUES content
            if "VALUES" in stmt:
                parts = stmt.split("VALUES", 1)
                values_part = parts[1].strip()
                # Remove ON CONFLICT ...
                if "ON CONFLICT" in values_part:
                    values_part = values_part.split("ON CONFLICT")[0].strip()
                
                # Remove leading ( and trailing )
                if values_part.startswith("(") and values_part.endswith(")"):
                    values_part = values_part[1:-1]
                
                # Split fields by comma, respecting quotes
                # We need a csv reader logic or regex
                # Regex for splitting by comma outside quotes
                # fields = re.split(r",(?=(?:[^']*'[^']*')*[^']*$)", values_part)
                fields = split_sql_values(values_part)
                
                # Map to columns. We need to know the columns from the INSERT statement
                # Parsing columns from parts[0]
                cols_part = parts[0].strip()
                if cols_part.startswith("(") and cols_part.endswith(")"):
                    cols = [c.strip() for c in cols_part[1:-1].split(',')]
                else:
                    # Fallback for known files
                    if "patent_companies_insert.sql" in filename:
                         cols = ['company_name', 'incorporation_year', 'incorporation_country', 'primary_sector', 'technology_tags', 'data_tier', 'patents_count']
                    else:
                         cols = ['company_name', 'incorporation_year', 'incorporation_country', 'primary_sector', 'technology_tags', 'listing_type', 'data_tier']

                row = {}
                for i, col in enumerate(cols):
                    if i < len(fields):
                        row[col] = parse_sql_value(fields[i])
                    else:
                        row[col] = None
                
                batch.append(row)
                
                if len(batch) >= 1000:
                    upload_batch("companies", batch)
                    batch = []

    if batch:
        upload_batch("companies", batch)

def process_patent_companies(filename):
    # This file has one huge INSERT statement with multiple tuples
    print(f"Processing {filename}...")
    try:
        with open(filename, 'r') as f:
            lines = f.readlines()
    except FileNotFoundError:
        print(f"❌ File not found: {filename}")
        return

    print(f"  - Read {len(lines)} lines from file.")
        
    cols = ['company_name', 'incorporation_year', 'incorporation_country', 'primary_sector', 'technology_tags', 'data_tier', 'patents_count']
    batch = []
    total_processed = 0
    skipped_count = 0
    
    for line in lines:
        line = line.strip()
        # Debug: print first few lines to check format
        if total_processed < 3:
            print(f"  - Sample line: {line[:100]}...")

        if line.startswith("("):
            # Relaxed check: just look for start.
            # It's a value tuple
            content = line[1:] # Remove (
            
            # Strip trailing characters safely
            content = content.rstrip()
            if content.endswith(";"): content = content[:-1]
            if content.endswith(","): content = content[:-1]
            if content.endswith(")"): content = content[:-1]
            
            # Split fields
            # fields = re.split(r",(?=(?:[^']*'[^']*')*[^']*$)", content)
            fields = split_sql_values(content)
            
            if len(fields) != len(cols):
                if total_processed < 10:
                    print(f"  - Warning: Field count mismatch. Expected {len(cols)}, got {len(fields)}. Line: {line[:50]}...")
                continue
            
            row = {}
            for i, col in enumerate(cols):
                if i < len(fields):
                    row[col] = parse_sql_value(fields[i])
                else:
                    row[col] = None
            
            batch.append(row)
            total_processed += 1
            
            if len(batch) >= 5000:
                print(f"  - Uploading batch {total_processed // 5000} (Total processed: {total_processed})...")
                upload_batch("companies", batch)
                batch = []
        else:
             skipped_count += 1
             if skipped_count < 5 and line:
                 print(f"  - Skipped line: {line[:50]}...")
                
    if batch:
        upload_batch("companies", batch)
        
    print(f"  - Processed {total_processed} rows total. Skipped {skipped_count} lines.")

def remove_comments(line):
    clean = []
    in_quote = False
    quote_char = ''
    i = 0
    while i < len(line):
        char = line[i]
        if in_quote:
            clean.append(char)
            if char == quote_char:
                in_quote = False
        else:
            if char == "'":
                in_quote = True
                quote_char = "'"
                clean.append(char)
            elif char == '-' and i+1 < len(line) and line[i+1] == '-':
                # Found comment start!
                break
            else:
                clean.append(char)
        i += 1
    return "".join(clean).strip()

def process_real_governance(filename, target_tables=None):
    print(f"Processing {filename} (Tables: {target_tables if target_tables else 'ALL'})...")
    with open(filename, 'r') as f:
        content = f.read()
        
    statements = content.split("INSERT INTO")
    
    for stmt in statements:
        stmt = stmt.strip()
        if not stmt: continue
        
        table_name = stmt.split()[0].replace("vendor_governance.", "").strip()
        
        if target_tables and table_name not in target_tables:
            continue
        
        # Parse Columns
        try:
            cols_part = stmt.split("VALUES")[0].strip()
            cols_part = cols_part[cols_part.find("(")+1 : cols_part.rfind(")")]
            cols = [c.strip() for c in cols_part.split(',')]
            
            # Parse Values
            values_part = stmt.split("VALUES")[1].strip()
            # Remove ON CONFLICT...
            if "ON CONFLICT" in values_part:
                values_part = values_part.split("ON CONFLICT")[0].strip()
            
            # Clean comments from values_part FIRST
            # Split by newline, remove comments, then rejoin
            clean_lines = [remove_comments(line) for line in values_part.split('\n')]
            values_part = " ".join(clean_lines).strip()

            # Remove trailing semicolon if present
            if values_part.endswith(";"):
                values_part = values_part[:-1].strip()
            
            # Remove outer parens
            if values_part.startswith("(") and values_part.endswith(")"):
                values_part = values_part[1:-1]
            
            # Remove comments from the values string!
            # This is tricky because comments might be inside the multi-line string.
            # We should probably process line by line or use the remove_comments function on the whole block?
            # remove_comments works on a single line.
            # Let's split by newline, remove comments, then rejoin?
            # Yes, that's safer.
            # remove_comments works on a single line.
            # We already cleaned comments above.
            # clean_lines = [remove_comments(line) for line in values_part.split('\n')]
            # values_part = " ".join(clean_lines)

            # Handle Subqueries replacements BEFORE splitting
            # (SELECT id FROM companies WHERE ticker_symbol = 'IONQ')
            # Regex to find these patterns
            
            def resolve_company(match):
                ticker = match.group(1)
                return f"'{TICKER_TO_ID.get(ticker, '')}'"
            
            values_part = re.sub(r"\(SELECT id FROM companies WHERE ticker_symbol = '([^']+)'\)", resolve_company, values_part)
            
            def resolve_company_name(match):
                name = match.group(1)
                return f"'{NAME_TO_ID.get(name, '')}'"
            
            values_part = re.sub(r"\(SELECT id FROM companies WHERE company_name = '([^']+)'\)", resolve_company_name, values_part)

            def resolve_filing(match):
                acc = match.group(1)
                return f"'{ACCESSION_TO_ID.get(acc, '')}'"
            
            values_part = re.sub(r"\(SELECT id FROM sec_filings WHERE accession_number = '([^']+)'\)", resolve_filing, values_part)
            
            def resolve_person(match):
                name = match.group(1)
                return f"'{PERSON_TO_ID.get(name, '')}'"
            
            values_part = re.sub(r"\(SELECT id FROM people WHERE full_name = '([^']+)'\)", resolve_person, values_part)

            # Now split fields
            # fields = re.split(r",(?=(?:[^']*'[^']*')*[^']*$)", values_part)
            fields = split_sql_values(values_part)
            
            row = {}
            for i, field in enumerate(fields):
                if i < len(cols):
                    val = parse_sql_value(field)
                    if val == '': val = None # Handle failed lookups
                    row[cols[i]] = val
            
            # Upload single row (since this file is small and mixed tables)
            upload_batch(table_name, [row])
            
        except Exception as e:
            print(f"⚠️ Error parsing statement for {table_name}: {e}")
            # print(stmt[:100])

def main():
    print("🚀 Starting Deployment via REST API...")
    
    # 1. Upload Base Companies
    process_companies_file("collectors/final_combined_database.sql")
    
    # 2. Upload Patent Companies
    process_patent_companies("collectors/patent_companies_insert.sql")
    
    # 3. Refresh Companies Map
    get_companies_map()
    
    # 4. Upload People (No dependencies)
    process_real_governance("real_governance_data.sql", target_tables=["people"])
    
    # 5. Refresh People Map
    get_people_map()
    
    # 6. Upload SEC Filings (Depends on Companies)
    process_real_governance("real_governance_data.sql", target_tables=["sec_filings"])
    
    # 7. Refresh Filings Map
    get_sec_filings_map()
    
    # 8. Upload Everything Else (Dependent tables)
    dependent_tables = [
        "proxy_statement_data", 
        "board_composition_annual", 
        "company_people", 
        "executive_compensation_annual", 
        "governance_scores", 
        "cybersecurity_incidents", 
        "customer_concentration", 
        "technology_dependencies", 
        "export_control_classification"
    ]
    process_real_governance("real_governance_data.sql", target_tables=dependent_tables)
    
    print("✅ Full Deployment Complete!")

if __name__ == "__main__":
    main()
