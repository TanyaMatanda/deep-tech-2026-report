import os

def split_file(filename, lines_per_chunk=20000, prefix="chunk"):
    with open(filename, 'r') as f:
        lines = f.readlines()
    
    total_lines = len(lines)
    print(f"Splitting {filename} ({total_lines} lines)...")
    
    chunks_created = 0
    current_chunk_lines = []
    current_chunk_size = 0
    
    for line in lines:
        current_chunk_lines.append(line)
        current_chunk_size += 1
        
        # Only split if we are over the limit AND we found a statement terminator
        if current_chunk_size >= lines_per_chunk and line.strip().endswith(';'):
            chunks_created += 1
            chunk_filename = f"{prefix}_{chunks_created}.sql"
            
            # Join lines and replace table names with fully qualified names
            chunk_content = "".join(current_chunk_lines)
            chunk_content = chunk_content.replace("INSERT INTO companies", "INSERT INTO vendor_governance.companies")
            chunk_content = chunk_content.replace("INSERT INTO sec_filings", "INSERT INTO vendor_governance.sec_filings")
            
            with open(chunk_filename, 'w') as f_out:
                # f_out.write("SET search_path TO vendor_governance, public;\n\n")
                f_out.write(chunk_content)
            
            print(f"  - Created {chunk_filename} ({len(current_chunk_lines)} lines)")
            current_chunk_lines = []
            current_chunk_size = 0
            
    # Write remaining lines
    if current_chunk_lines:
        chunks_created += 1
        chunk_filename = f"{prefix}_{chunks_created}.sql"
        
        chunk_content = "".join(current_chunk_lines)
        chunk_content = chunk_content.replace("INSERT INTO companies", "INSERT INTO vendor_governance.companies")
        chunk_content = chunk_content.replace("INSERT INTO sec_filings", "INSERT INTO vendor_governance.sec_filings")
        
        with open(chunk_filename, 'w') as f_out:
            # f_out.write("SET search_path TO vendor_governance, public;\n\n")
            f_out.write(chunk_content)
        print(f"  - Created {chunk_filename} ({len(current_chunk_lines)} lines)")
        
    return chunks_created

def main():
    print("Preparing files for Supabase Browser Upload...")
    print("-" * 40)
    
    # 1. Split Patent Companies (50k rows)
    # 4.9MB file
    split_file("collectors/patent_companies_insert.sql", lines_per_chunk=5000, prefix="3_patents_part")
    
    # 2. Split Base Companies (5k rows)
    # 2.0MB file
    split_file("collectors/final_combined_database.sql", lines_per_chunk=5000, prefix="2_companies_part")
    
    print("-" * 40)
    print("✅ Done! Files have been fixed to ensure valid SQL syntax.")

if __name__ == "__main__":
    main()
