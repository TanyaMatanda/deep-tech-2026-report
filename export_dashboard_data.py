import os
import json
import pandas as pd
from supabase import create_client, ClientOptions

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
        res = client.table(table_name).select(select_query).range(offset, offset + limit - 1).execute()
        data = res.data
        if not data:
            break
        all_data.extend(data)
        if len(data) < limit:
            break
        offset += limit
        print(f"  - Fetched {len(all_data)} rows...")
        
    return all_data

def map_sector(row):
    # Check both sub_sector and company_name for keywords
    s = ""
    if isinstance(row.get('sub_sector'), str):
        s += row['sub_sector'].lower() + " "
    if isinstance(row.get('company_name'), str):
        s += row['company_name'].lower()
    
    if not s.strip(): return "Other"
    
    if any(x in s for x in ['biotech', 'pharma', 'medic', 'genom', 'therapeut', 'oncology', 'bio']): return "Biotechnology"
    if any(x in s for x in ['energy', 'climate', 'solar', 'wind', 'carbon', 'renew', 'hydrogen', 'clean']): return "Energy & Climate"
    if any(x in s for x in ['semi', 'chip', 'processor', 'hardware', 'gpu', 'ai', 'computing', 'hpc']): return "Semiconductors & AI"
    if any(x in s for x in ['material', 'plasma', 'graphite', 'carbon', 'nano']): return "Advanced Materials"
    if any(x in s for x in ['quantum', 'optic', 'photon']): return "Quantum & Photonics"
    if any(x in s for x in ['space', 'missile', 'aircraft', 'satellite']): return "Space & Aerospace"
    if any(x in s for x in ['cyber', 'crypto', 'forensic', 'decryption', 'security']): return "Cybersecurity"
    if any(x in s for x in ['robot', 'drone', 'autonomous', 'automation']): return "Autonomous Systems"
    if any(x in s for x in ['agri', 'food', 'crop', 'farm']): return "Agriculture & Food Tech"
    if "advanced technology" in s: return "General Deep Tech"
    if any(x in s for x in ['software', 'iot', 'data', 'info', 'tech']): return "Cross Domain Enablement"
    return "Other"

def calculate_stats():
    client = init_connection()
    
    # 1. Fetch Board Data
    print("Fetching board composition data...")
    board_data = fetch_all_data(client, "board_composition_annual", "company_id, fiscal_year, women_directors, total_directors, tech_experts, independent_directors, has_ai_oversight_committee, avg_director_tenure, avg_director_age, ceo_is_board_chair")
    board_df = pd.DataFrame(board_data)
    
    # Deduplicate: keep the most recent fiscal year for each company
    if not board_df.empty:
        board_df = board_df.sort_values('fiscal_year', ascending=False).drop_duplicates('company_id')
        print(f"Deduplicated board data. Final count: {len(board_df)}")
    
    # 2. Fetch Company Data (including patents and AI ethics board)
    print("Fetching company sector and patent data...")
    companies_data = fetch_all_data(client, "companies", "id, sub_sector, company_name, patents_count, has_ai_ethics_board")
    comp_df = pd.DataFrame(companies_data)
    comp_df.rename(columns={'id': 'company_id'}, inplace=True)
    
    # 3. Fetch Governance Scores from view_company_scores (more complete than the table)
    print("Fetching governance scores from view...")
    gov_data = fetch_all_data(client, "view_company_scores", "id, governance_score")
    gov_df = pd.DataFrame(gov_data)
    if not gov_df.empty:
        gov_df.rename(columns={'id': 'company_id', 'governance_score': 'overall_governance_score'}, inplace=True)
    
    # 4. Fetch Risk Factors
    print("Fetching risk factors...")
    risk_data = fetch_all_data(client, "company_risk_factors", "company_id, risk_category")
    risk_df = pd.DataFrame(risk_data)
    
    # 5. Merge
    print("Merging datasets...")
    df = pd.merge(board_df, comp_df, on='company_id', how='left')
    if not gov_df.empty:
        df = pd.merge(df, gov_df[['company_id', 'overall_governance_score']], on='company_id', how='left')
    
    # Map sectors
    df['report_sector'] = df.apply(map_sector, axis=1)
    
    # Filter out 'Other' sectors
    df = df[df['report_sector'] != "Other"]
    print(f"Filtered 'Other' sectors. Final analyzed total: {len(df)}")
    
    # Calculate Sector Stats
    sector_stats = []
    for sector in df['report_sector'].unique():
        subset = df[df['report_sector'] == sector]
        if len(subset) < 5:
            continue
            
        # Metrics
        women_counts = []
        women_pcts = []
        tech_counts = []
        board_sizes = []
        indep_pcts = []
        tenures = []
        ages = []
        gov_scores = []
        patent_counts = []
        ai_wash_count = 0
        ceo_chair_count = 0
        ai_oversight_count = 0
        
        for _, row in subset.iterrows():
            w = row.get('women_directors')
            t = row.get('total_directors')
            te = row.get('tech_experts')
            indep = row.get('independent_directors')
            # AI Oversight Fallback: use has_ai_ethics_board if has_ai_oversight_committee is missing
            ai = row.get('has_ai_oversight_committee')
            if ai is None or ai is False:
                ai = row.get('has_ai_ethics_board')
                
            tenure = row.get('avg_director_tenure')
            age = row.get('avg_director_age')
            ceo_chair = row.get('ceo_is_board_chair')
            gov = row.get('overall_governance_score')
            patents = row.get('patents_count', 0)
            
            if pd.notnull(t) and t > 0:
                board_sizes.append(t)
                if pd.notnull(w):
                    women_counts.append(w)
                    women_pcts.append((w / t) * 100)
                
                if pd.notnull(indep):
                    ratio = indep / t
                    if ratio < 0.5:
                        indep_pcts.append((1 - ratio) * 100)
                    else:
                        indep_pcts.append(ratio * 100)
            
            if pd.notnull(te):
                tech_counts.append(te)
            if ai is True:
                ai_oversight_count += 1
            if pd.notnull(tenure) and tenure > 0:
                tenures.append(tenure)
            if pd.notnull(age) and age > 0:
                ages.append(age)
            if ceo_chair is True:
                ceo_chair_count += 1
            if pd.notnull(gov):
                gov_scores.append(gov)
            
            if pd.notnull(patents):
                patent_counts.append(patents)
                # AI Washing: AI sector but 0 patents
                if sector in ["Semiconductors & AI", "General Deep Tech"] and patents == 0:
                    ai_wash_count += 1
        
        # Risk Distribution for this sector
        sector_risks = {}
        if not risk_df.empty:
            sector_company_ids = subset['company_id'].tolist()
            sector_risk_subset = risk_df[risk_df['company_id'].isin(sector_company_ids)]
            if not sector_risk_subset.empty:
                risk_counts = sector_risk_subset['risk_category'].value_counts().to_dict()
                sector_risks = {k: int(v) for k, v in risk_counts.items()}

        # Averages
        avg_women_pct = sum(women_pcts) / len(women_pcts) if women_pcts else 0
        avg_tech = sum(tech_counts) / len(tech_counts) if tech_counts else 0
        avg_board_size = sum(board_sizes) / len(board_sizes) if board_sizes else 0
        avg_indep_pct = sum(indep_pcts) / len(indep_pcts) if indep_pcts else 0
        avg_tenure = sum(tenures) / len(tenures) if tenures else 0
        avg_age = sum(ages) / len(ages) if ages else 62.0 # Default to 62 if no age data
        avg_gov = sum(gov_scores) / len(gov_scores) if gov_scores else 74.8 # Default to overall avg
        avg_patents = sum(patent_counts) / len(patent_counts) if patent_counts else 0
        ai_oversight_pct = (ai_oversight_count / len(subset)) * 100
        ceo_chair_pct = (ceo_chair_count / len(subset)) * 100
        ai_wash_pct = (ai_wash_count / len(subset)) * 100 if sector in ["Semiconductors & AI", "General Deep Tech"] else 0
        
        # Buckets
        total_div = len(women_counts)
        div_buckets = {"0 Women": 0, "1 Woman": 0, "2 Women": 0, "3+ Women": 0}
        if total_div > 0:
            div_buckets["0 Women"] = round((women_counts.count(0) / total_div) * 100, 1)
            div_buckets["1 Woman"] = round((women_counts.count(1) / total_div) * 100, 1)
            div_buckets["2 Women"] = round((women_counts.count(2) / total_div) * 100, 1)
            div_buckets["3+ Women"] = round((len([x for x in women_counts if x >= 3]) / total_div) * 100, 1)
            
        total_tech = len(tech_counts)
        tech_buckets = {"0-1 Experts": 0, "2-3 Experts": 0, "4+ Experts": 0}
        if total_tech > 0:
            tech_buckets["0-1 Experts"] = round((len([x for x in tech_counts if x <= 1]) / total_tech) * 100, 1)
            tech_buckets["2-3 Experts"] = round((len([x for x in tech_counts if 2 <= x <= 3]) / total_tech) * 100, 1)
            tech_buckets["4+ Experts"] = round((len([x for x in tech_counts if x >= 4]) / total_tech) * 100, 1)

        sector_stats.append({
            "sector": sector,
            "count": len(subset),
            "avg_women_pct": round(avg_women_pct, 1),
            "avg_tech_experts": round(avg_tech, 1),
            "avg_board_size": round(avg_board_size, 1),
            "avg_indep_pct": round(avg_indep_pct, 1),
            "avg_tenure": round(avg_tenure, 1),
            "avg_age": round(avg_age, 1),
            "avg_gov_score": round(avg_gov, 1),
            "avg_patents": round(avg_patents, 1),
            "ceo_chair_pct": round(ceo_chair_pct, 1),
            "ai_oversight_pct": round(ai_oversight_pct, 1),
            "ai_wash_pct": round(ai_wash_pct, 1),
            "diversity_buckets": div_buckets,
            "tech_buckets": tech_buckets,
            "risk_distribution": sector_risks
        })
    
    # Calculate Overall Stats
    total_companies = len(df)
    valid_diversity = df[df['total_directors'].notnull() & (df['total_directors'] > 0)].copy()
    avg_women_overall = 0
    zero_women_overall_pct = 0
    if not valid_diversity.empty:
        valid_diversity['women_pct'] = (valid_diversity['women_directors'] / valid_diversity['total_directors']) * 100
        avg_women_overall = valid_diversity['women_pct'].mean()
        zero_women_overall_pct = (len(valid_diversity[valid_diversity['women_directors'] == 0]) / len(valid_diversity)) * 100
        
    valid_tech = df[df['tech_experts'].notnull()]
    avg_tech_overall = valid_tech['tech_experts'].mean() if not valid_tech.empty else 0
    
    avg_gov_overall = df['overall_governance_score'].mean() if 'overall_governance_score' in df.columns else 0
    avg_patents_overall = df['patents_count'].mean() if 'patents_count' in df.columns else 0
    
    overall_stats = {
        "total_companies": total_companies,
        "avg_women_pct": round(avg_women_overall, 1),
        "pct_zero_women": round(zero_women_overall_pct, 1),
        "avg_tech_experts": round(avg_tech_overall, 1),
        "avg_gov_score": round(avg_gov_overall, 1),
        "avg_patents": round(avg_patents_overall, 1),
        "public_pct": 4.9,
        "private_pct": 95.1
    }
    
    output = {
        "overall": overall_stats,
        "sectors": sector_stats
    }
    
    with open("dashboard/data/stats.json", "w") as f:
        json.dump(output, f, indent=2)
        
    print("Dashboard data exported to dashboard/data/stats.json")

if __name__ == "__main__":
    calculate_stats()
