import os
import pandas as pd
from supabase import create_client, ClientOptions
from collections import Counter

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

def map_sector(sector_raw):
    """Maps raw sector strings to report categories."""
    if not isinstance(sector_raw, str):
        return "Other"
    
    s = sector_raw.lower()
    if any(x in s for x in ['semi', 'hpc', 'computing', 'learning tech', 'supply chain ai', 'telehealth', 'e-commerce & ai']): return "Semiconductors & AI"
    if any(x in s for x in ['robot', 'drone', 'autonomous']): return "Autonomous Systems"
    if any(x in s for x in ['energy', 'climate', 'solar', 'hydrogen']): return "Energy & Climate"
    if any(x in s for x in ['bio', 'pharma', 'oncology']): return "Biotechnology"
    if any(x in s for x in ['material', 'plasma']): return "Advanced Materials"
    if any(x in s for x in ['quantum', 'optic', 'photon']): return "Quantum & Photonics"
    if any(x in s for x in ['space', 'missile', 'aircraft']): return "Space & Aerospace"
    if any(x in s for x in ['cyber', 'crypto', 'forensic', 'decryption', 'security']): return "Cybersecurity"
    if any(x in s for x in ['software', 'iot', 'data', 'info', 'tech']): return "Cross Domain Enablement"
    return "Other"

def inspect_others():
    client = init_connection()
    
    print("Fetching board data to identify relevant companies...")
    # Fetch IDs of companies with board data
    board_res = client.table("board_composition_annual").select("company_id").range(0, 10000).execute()
    company_ids = [row['company_id'] for row in board_res.data]
    
    print(f"Fetched {len(company_ids)} company IDs with board data.")
    
    # Fetch sectors for these companies using IN query (chunked)
    print("Fetching company details...")
    relevant_data = []
    
    chunk_size = 100
    for i in range(0, len(company_ids), chunk_size):
        chunk = company_ids[i:i + chunk_size]
        try:
            comp_res = client.table("companies").select("id, primary_sector, primary_subsector, technology_tags").in_("id", chunk).execute()
            relevant_data.extend(comp_res.data)
        except Exception as e:
            print(f"Error fetching chunk {i}: {e}")
            
    print(f"Matched {len(relevant_data)} companies.")
    
    # Analyze "Advanced Technology" breakdown
    subsectors = []
    tags = []
    
    for row in relevant_data:
        if row.get('primary_sector') == "Advanced Technology":
            if row.get('primary_subsector'):
                subsectors.append(row.get('primary_subsector'))
            if row.get('technology_tags'):
                # tags is a list
                tags.extend(row.get('technology_tags'))
                
    print("\nTop Subsectors in 'Advanced Technology':")
    for s, c in Counter(subsectors).most_common(20):
        print(f"{s}: {c}")
        
    print("\nTop Tags in 'Advanced Technology':")
    for t, c in Counter(tags).most_common(20):
        print(f"{t}: {c}")

if __name__ == "__main__":
    inspect_others()
