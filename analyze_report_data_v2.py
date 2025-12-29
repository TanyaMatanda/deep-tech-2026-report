import os
import pandas as pd
from supabase import create_client, Client, ClientOptions

# Configuration
SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

def init_connection():
    options = ClientOptions(
        schema="vendor_governance",
        headers={
            "Content-Profile": "vendor_governance",
            "Accept-Profile": "vendor_governance"
        }
    )
    return create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

def fetch_all_data(client, table_name, select_query="*"):
    """Fetches all rows from a table using pagination."""
    all_data = []
    offset = 0
    limit = 1000
    
    print(f"Fetching data from {table_name}...")
    while True:
        print(f"  - Fetching offset {offset}...")
        res = client.table(table_name).select(select_query).range(offset, offset + limit - 1).execute()
        data = res.data
        if not data:
            break
        all_data.extend(data)
        if len(data) < limit:
            break
        offset += limit
        
    print(f"Total rows fetched: {len(all_data)}")
    return all_data

def analyze():
    client = init_connection()
    print("--- Analyzing Real Governance Data (Full Dataset) ---")
    
    # Fetch all board data
    # Note: Fetching 100k rows might be slow. We can optimize by fetching only needed columns.
    # We need: women_percentage, women_directors, tech_experts, company_id
    # And we need company info for top performers.
    
    # Let's fetch just the metrics first to be fast
    board_data = fetch_all_data(client, "board_composition_annual", "women_percentage, women_directors, tech_experts, has_ai_oversight_committee")
    
    df = pd.DataFrame(board_data)
    
    print(f"Total Records: {len(df)}")
    
    # Filter for valid data
    # women_directors should be non-null (or >= 0)
    real_df = df[df['women_directors'].notnull()]
    print(f"Records with Diversity Data: {len(real_df)}")
    
    if len(real_df) == 0:
        print("No governance data to analyze.")
        return

    # 1. Diversity
    avg_women_pct = real_df['women_percentage'].mean()
    zero_women_count = len(real_df[real_df['women_directors'] == 0])
    parity_count = len(real_df[real_df['women_percentage'] >= 50])
    
    print(f"\n1. Diversity:")
    print(f"   - Average Women on Boards: {avg_women_pct:.1f}%")
    print(f"   - Companies with Zero Women: {zero_women_count} ({zero_women_count/len(real_df)*100:.1f}%)")
    print(f"   - Gender Parity (>=50%): {parity_count} ({parity_count/len(real_df)*100:.1f}%)")
    
    # 2. Tech Expertise
    tech_df = df[df['tech_experts'].notnull()]
    if len(tech_df) > 0:
        avg_tech = tech_df['tech_experts'].mean()
        print(f"\n2. Technical Expertise (N={len(tech_df)}):")
        print(f"   - Average Tech Experts per Board: {avg_tech:.1f}")
        print(f"   - Max Tech Experts: {tech_df['tech_experts'].max()}")
    
    # 3. AI Governance
    # Check has_ai_oversight_committee
    ai_gov_count = len(df[df['has_ai_oversight_committee'] == True])
    print(f"\n3. AI Governance:")
    print(f"   - Companies with AI Oversight Committee: {ai_gov_count} ({ai_gov_count/len(df)*100:.1f}%)")
    
    # 4. Top Performers (Need to fetch company names for top 5)
    # We'll just fetch the top 5 IDs and then query companies table
    print("\n4. Top Diversity Performers:")
    top_div = real_df.sort_values('women_percentage', ascending=False).head(5)
    
    # Fetch company names for these
    # This is more efficient than joining 100k rows
    # But we don't have company_id in the dataframe if we didn't select it.
    # Wait, I didn't select company_id in fetch_all_data call above.
    # Let's fix the select query.
    
if __name__ == "__main__":
    # Redefine analyze to include company_id
    client = init_connection()
    board_data = fetch_all_data(client, "board_composition_annual", "company_id, women_percentage, women_directors, tech_experts, has_ai_oversight_committee")
    df = pd.DataFrame(board_data)
    
    # Fetch company info to map sectors
    # We need to fetch companies and join or just fetch company_id and sector from companies table
    # and merge with board data.
    
    print("Fetching company sector data...")
    companies_data = fetch_all_data(client, "companies", "id, primary_sector, company_name")
    comp_df = pd.DataFrame(companies_data)
    comp_df.rename(columns={'id': 'company_id'}, inplace=True)
    
    # Merge
    full_df = pd.merge(df, comp_df, on='company_id', how='left')
    
    # Define Sector Mapping
    def map_sector(s):
        if not s or not isinstance(s, str): return "Other"
        s = s.lower()
        if any(x in s for x in ['semi', 'hpc', 'computing', 'learning tech', 'supply chain ai', 'telehealth', 'e-commerce & ai']): return "Semi Conductors and AI"
        if any(x in s for x in ['robot', 'drone', 'autonomous']): return "Autonomous Systems"
        if any(x in s for x in ['energy', 'climate', 'solar', 'hydrogen']): return "Energy and Climate"
        if any(x in s for x in ['bio', 'pharma', 'oncology']): return "Biotechnology"
        if any(x in s for x in ['material', 'plasma']): return "Advanced Materials"
        if any(x in s for x in ['quantum', 'optic', 'photon']): return "Quantum and Photonics"
        if any(x in s for x in ['space', 'missile', 'aircraft']): return "Space and Aerospace"
        if any(x in s for x in ['cyber', 'crypto', 'forensic', 'decryption', 'security']): return "Cybersecurity Cryptography"
        if any(x in s for x in ['software', 'iot', 'data', 'info', 'tech']): return "Cross Domain Enablement"
        return "Other"

    full_df['mapped_sector'] = full_df['primary_sector'].apply(map_sector)
    
    real_df = full_df[full_df['women_directors'].notnull()]
    
    avg_women_pct = real_df['women_percentage'].mean()
    zero_women_count = len(real_df[real_df['women_directors'] == 0])
    parity_count = len(real_df[real_df['women_percentage'] >= 50])
    
    print(f"\n1. Diversity (N={len(real_df)}):")
    print(f"   - Average Women on Boards: {avg_women_pct:.1f}%")
    print(f"   - Companies with Zero Women: {zero_women_count} ({zero_women_count/len(real_df)*100:.1f}%)")
    print(f"   - Gender Parity (>=50%): {parity_count} ({parity_count/len(real_df)*100:.1f}%)")
    
    tech_df = full_df[full_df['tech_experts'].notnull()]
    if len(tech_df) > 0:
        avg_tech = tech_df['tech_experts'].mean()
        print(f"\n2. Technical Expertise (N={len(tech_df)}):")
        print(f"   - Average Tech Experts per Board: {avg_tech:.1f}")
    
    ai_gov_count = len(full_df[full_df['has_ai_oversight_committee'] == True])
    print(f"\n3. AI Governance:")
    print(f"   - Companies with AI Oversight Committee: {ai_gov_count} ({ai_gov_count/len(full_df)*100:.1f}%)")

    # Sector Deep Dives
    print("\n4. Sector Deep Dives:")
    sectors = [
        "Semi Conductors and AI", "Autonomous Systems", "Energy and Climate", 
        "Biotechnology", "Advanced Materials", "Quantum and Photonics", 
        "Space and Aerospace", "Cybersecurity Cryptography", "Cross Domain Enablement"
    ]
    
    for sec in sectors:
        sec_df = real_df[real_df['mapped_sector'] == sec]
        if len(sec_df) == 0:
            print(f"   - {sec}: No Data")
            continue
            
        avg_w = sec_df['women_percentage'].mean()
        zero_w = len(sec_df[sec_df['women_directors'] == 0])
        avg_t = sec_df['tech_experts'].mean() if 'tech_experts' in sec_df else 0
        
        print(f"   - {sec} (N={len(sec_df)}):")
        print(f"     * Women %: {avg_w:.1f}%")
        print(f"     * Zero Women: {zero_w/len(sec_df)*100:.1f}%")
        print(f"     * Tech Experts: {avg_t:.1f}")
