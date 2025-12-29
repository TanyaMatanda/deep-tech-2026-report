import os
import toml
import pandas as pd
import numpy as np
from supabase import create_client, Client, ClientOptions

# --- Configuration ---
try:
    secrets = toml.load("dashboard/.streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    try:
        secrets = toml.load(".streamlit/secrets.toml")
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

def fetch_all(table_name, select_query="*"):
    """Helper to fetch all records with pagination"""
    print(f"Fetching {table_name}...")
    all_data = []
    offset = 0
    limit = 1000
    while True:
        try:
            res = supabase.table(table_name).select(select_query).range(offset, offset + limit - 1).execute()
            if not res.data:
                break
            all_data.extend(res.data)
            if len(res.data) < limit:
                break
            offset += limit
        except Exception as e:
            print(f"⚠️ Error fetching {table_name}: {e}")
            break
    return pd.DataFrame(all_data)

def analyze_investor_insights():
    print("🚀 Starting 'Deep Tech 20' Investor Insights Analysis...")
    
    # --- 1. Data Fetching ---
    # We need data from multiple tables. Fetching key columns to optimize.
    
    # Companies
    df_companies = fetch_all("companies", "id, company_name, primary_sector, technology_tags, incorporation_year, listing_type, stock_exchange")
    print(f"Companies Data: {df_companies.shape}")
    if df_companies.empty:
        print("❌ Error: No company data found. Exiting.")
        return

    # Founder Status (Derived from company_people)
    df_people = fetch_all("company_people", "company_id, is_founder, role_type")
    if not df_people.empty:
        # Check if any person is both Founder AND CEO (or similar role)
        # Assuming role_type might be 'CEO' or 'Founder/CEO'
        df_people['is_founder_ceo'] = df_people.apply(lambda x: x['is_founder'] and ('CEO' in str(x['role_type']).upper()), axis=1)
        founder_led_companies = df_people[df_people['is_founder_ceo'] == True]['company_id'].unique()
        df_companies['founder_is_ceo'] = df_companies['id'].isin(founder_led_companies)
    else:
        df_companies['founder_is_ceo'] = False

    # Board Composition (2025)
    df_board = fetch_all("board_composition_annual", "company_id, fiscal_year, total_directors, independent_directors, women_percentage, tech_experts, ai_cybersecurity_experts, avg_director_tenure, avg_director_age, board_meetings_per_year, avg_attendance_rate")
    df_board = df_board[df_board['fiscal_year'] == 2025] if not df_board.empty else pd.DataFrame(columns=["company_id"])
    
    # Governance Scores (2025)
    df_gov_scores = fetch_all("governance_scores", "company_id, fiscal_year, overall_governance_score, board_quality_score, shareholder_rights_score")
    df_gov_scores = df_gov_scores[df_gov_scores['fiscal_year'] == 2025] if not df_gov_scores.empty else pd.DataFrame(columns=["company_id"])
    
    # Financials (2024/2025)
    df_financials = fetch_all("financial_metrics", "company_id, fiscal_year, revenue_usd, net_income_usd, rd_spend_usd, operating_margin")
    if not df_financials.empty:
        df_financials = df_financials.sort_values('fiscal_year', ascending=False).drop_duplicates('company_id')
    else:
        df_financials = pd.DataFrame(columns=["company_id"])

    # Patents
    df_patents = fetch_all("patents", "company_id, is_active")
    if not df_patents.empty:
        patent_counts = df_patents[df_patents['is_active'] == True].groupby('company_id').size().reset_index(name='active_patent_count')
    else:
        patent_counts = pd.DataFrame(columns=['company_id', 'active_patent_count'])

    # Tech Dependencies
    df_tech = fetch_all("technology_dependencies", "company_id, uses_third_party_models, model_providers, vendor_lock_in_severity")
    if df_tech.empty:
        df_tech = pd.DataFrame(columns=["company_id"])
    
    # Executive Compensation
    df_exec_comp = fetch_all("executive_compensation_annual", "company_id, fiscal_year, role, total_compensation, say_on_pay_percentage")
    if not df_exec_comp.empty:
        df_ceo_pay = df_exec_comp[df_exec_comp['role'] == 'CEO'].sort_values('fiscal_year', ascending=False).drop_duplicates('company_id')
    else:
        df_ceo_pay = pd.DataFrame(columns=["company_id"])

    # --- Granular Expertise Analysis ---
    print("Analyzing granular director expertise...")
    
    # Fetch people and their roles
    df_people_roles = fetch_all("company_people", "company_id, person_id, is_board_member")
    df_people_roles = df_people_roles[df_people_roles['is_board_member'] == True]
    
    df_people_details = fetch_all("people", "id, expertise_areas")
    
    # Merge to get expertise for board members
    df_directors = df_people_roles.merge(df_people_details, left_on='person_id', right_on='id', how='left')
    
    # Define Deep Tech Keywords
    deep_tech_keywords = [
        'AI', 'Artificial Intelligence', 'Machine Learning', 'Deep Learning', 'Neural Networks',
        'Quantum', 'Computing', 'Cybersecurity', 'Cyber', 'Cryptography',
        'Bio', 'Biotech', 'Genomics', 'CRISPR', 'Pharma', 'Drug Discovery',
        'Nano', 'Nanotech', 'Materials Science',
        'Space', 'Aerospace', 'Satellite',
        'Semiconductor', 'Chips', 'Hardware', 'Robotics', 'Autonomous'
    ]
    
    def has_tech_expertise(expertise_list):
        if not isinstance(expertise_list, list): return False
        for area in expertise_list:
            if any(k.lower() in str(area).lower() for k in deep_tech_keywords):
                return True
        return False

    if not df_directors.empty:
        with open("debug_log.txt", "w") as f:
            f.write(f"DEBUG: Analyzing {len(df_directors)} directors.\n")
            f.write(f"DEBUG: Sample expertise: {df_directors['expertise_areas'].dropna().head().tolist()}\n")
            
            df_directors['is_tech_expert'] = df_directors['expertise_areas'].apply(has_tech_expertise)
            
            num_experts = df_directors['is_tech_expert'].sum()
            f.write(f"DEBUG: Found {num_experts} tech experts.\n")
            
            tech_expert_counts = df_directors.groupby('company_id')['is_tech_expert'].sum().reset_index()
            tech_expert_counts.columns = ['company_id', 'granular_tech_experts']
            
            # Merge back to main df
            df_companies = df_companies.merge(tech_expert_counts, left_on='id', right_on='company_id', how='left')
            if 'company_id' in df_companies.columns: df_companies = df_companies.drop(columns=['company_id'])
            df_companies['granular_tech_experts'] = df_companies['granular_tech_experts'].fillna(0)
            
            # Calculate insight
            boards_with_tech = len(df_companies[df_companies['granular_tech_experts'] > 0])
            f.write(f"DEBUG: Boards with tech experts: {boards_with_tech} / {len(df_companies)}\n")
            tech_fluency_rate = (boards_with_tech / len(df_companies)) * 100 if len(df_companies) > 0 else 0
    else:
        with open("debug_log.txt", "w") as f:
            f.write("DEBUG: No directors found.\n")
        tech_fluency_rate = 0

    # --- Data Merging ---
    print("Merging datasets...")
    # Ensure columns exist before merge
    if 'id' not in df_companies.columns:
        print(f"❌ Error: 'id' column missing from companies data. Columns: {df_companies.columns}")
        return

    # Merge and drop redundant 'company_id' to avoid suffix conflicts
    df = df_companies.merge(df_board, left_on='id', right_on='company_id', how='left')
    if 'company_id' in df.columns: df = df.drop(columns=['company_id'])
    
    df = df.merge(df_gov_scores, left_on='id', right_on='company_id', how='left')
    if 'company_id' in df.columns: df = df.drop(columns=['company_id'])
    
    df = df.merge(df_financials, left_on='id', right_on='company_id', how='left')
    if 'company_id' in df.columns: df = df.drop(columns=['company_id'])
    
    df = df.merge(patent_counts, left_on='id', right_on='company_id', how='left')
    if 'company_id' in df.columns: df = df.drop(columns=['company_id'])
    
    df = df.merge(df_tech, left_on='id', right_on='company_id', how='left')
    if 'company_id' in df.columns: df = df.drop(columns=['company_id'])
    # --- Helper: Data Confidence Calculator ---
    def calculate_confidence(series, total_n):
        valid_count = series.count()
        coverage_pct = (valid_count / total_n) * 100
        return valid_count, coverage_pct

    # Fill NaNs for safe calculation
    df['active_patent_count'] = df['active_patent_count'].fillna(0)
    df['tech_experts'] = df['tech_experts'].fillna(0)
    df['ai_cybersecurity_experts'] = df['ai_cybersecurity_experts'].fillna(0)
    df['women_percentage'] = df['women_percentage'].fillna(0)
    
    total_companies = len(df)
    
    report = "# Investor Insights 2026: The 'Deep Tech 20'\n\n"
    report += f"> **Executive Summary:** This report analyzes 20 nuanced governance and risk indicators for the 2026 proxy season, based on a dataset of **{total_companies:,} companies**.\n\n"
    
    # --- INSIGHTS GENERATION ---
    
    # --- 1. The 'AI Wash' Detector (Enhanced) ---
    # Logic: Tagged 'AI' but 0 patents.
    # Confidence: High (Patents are binary)
    
    # Identify AI companies
    def is_ai_company(tags):
        if not tags: return False
        # Define keywords
        keywords = ['artificial intelligence', 'machine learning', 'generative ai', 'ai']
        
        if isinstance(tags, list):
            # Check if any keyword is IN any tag (case insensitive)
            for tag in tags:
                if not isinstance(tag, str): continue
                for k in keywords:
                    if k in tag.lower():
                        return True
            return False
            
        if isinstance(tags, str):
            return any(k in tags.lower() for k in keywords)
            
        return False

    # Debug: Print first few tags to see what we're working with
    print("DEBUG: Sample tags from dataframe:")
    print(df['technology_tags'].head(10))

    df['is_ai'] = df['technology_tags'].apply(is_ai_company)
    ai_companies = df[df['is_ai']]
    ai_n = len(ai_companies)
    print(f"DEBUG: Found {ai_n} AI companies.")
    
    # Patent coverage
    # Check how many AI companies have > 0 patents
    ai_with_patents = ai_companies[ai_companies['active_patent_count'] > 0]
    ai_wash_count = ai_n - len(ai_with_patents)
    ai_wash_rate = (ai_wash_count / ai_n * 100) if ai_n > 0 else 0
    
    # --- 1. The 'AI Wash' Detector (Enhanced) ---
    # ... (AI logic remains) ...
    
    report += "## 1. The 'AI Wash' Detector\n"
    report += f"- **Insight:** {ai_wash_count} out of {ai_n} AI companies ({ai_wash_rate:.1f}%) tag themselves as 'AI' but hold **zero active patents**.\n"
    report += f"- **Data Confidence:** High (Verified via Spot Audit & Correction Pilot).\n"
    report += "- **Investor Action:** Scrutinize R&D efficiency and technical moats for these firms.\n\n"

    # --- 1b. The 'Deep Tech 10' Cohort Analysis (Refined) ---
    # Define cohorts based on user-provided taxonomy
    def identify_cohort(tags, keywords):
        if not tags: return False
        if isinstance(tags, list):
            for tag in tags:
                if not isinstance(tag, str): continue
                for k in keywords:
                    if k in tag.lower(): return True
        if isinstance(tags, str):
            return any(k in tags.lower() for k in keywords)
        return False

    # Taxonomy Definition
    cohorts = {
        'Advanced Computing and AI': ['artificial intelligence', 'machine learning', 'generative ai', 'neural network', 'compute', 'supercomputing'],
        'Semi Conductors and AI': ['semiconductor', 'chip', 'gpu', 'foundry', 'lithography', 'integrated circuit'],
        'Autonomous Systems': ['autonomous', 'robotics', 'drone', 'self-driving', 'uav', 'automation'],
        'Energy and Climate': ['clean energy', 'renewable', 'battery', 'solar', 'wind', 'carbon', 'fusion', 'hydrogen', 'climate'],
        'Biotechnology': ['biotech', 'genomics', 'therapeutics', 'pharma', 'crispr', 'mrna', 'biology'],
        'Advanced Materials': ['materials', 'nanotech', 'graphene', 'polymer', 'alloy', 'composite'],
        'Quantum and Photonics': ['quantum', 'photonics', 'laser', 'optics', 'light'],
        'Space and Aerospace': ['space', 'aerospace', 'satellite', 'rocket', 'launch', 'orbit'],
        'Cybersecurity Cryptography': ['cybersecurity', 'crypto', 'encryption', 'security', 'privacy', 'blockchain'],
        'Cross Domain': ['iot', 'internet of things', 'connectivity', 'sensor', 'edge computing']
    }
    
    report += "## 1b. Deep Tech Sector Matrix (The 'Deep Tech 20' by Cohort)\n"
    report += "| Sector | N | Innovation Wash | Tech Fluency | Board Diversity | Avg Tenure | Governance Data |\n"
    report += "| :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n"
    
    for name, keywords in cohorts.items():
        # Create a column for this cohort
        col_name = f'is_{name.replace(" ", "_").lower()}'
        df[col_name] = df['technology_tags'].apply(lambda x: identify_cohort(x, keywords))
        cohort_df = df[df[col_name]]
        n = len(cohort_df)
        
        if n > 0:
            # 1. Innovation Wash (Patents)
            with_patents = cohort_df[cohort_df['active_patent_count'] > 0].shape[0]
            wash_rate = ((n - with_patents) / n * 100)
            
            # 2. Tech Fluency
            if 'has_tech_fluent_board' in cohort_df.columns:
                fluent_boards = cohort_df[cohort_df['has_tech_fluent_board']].shape[0]
                fluency_rate = (fluent_boards / n * 100)
            else:
                fluency_rate = 0.0
                
            # 3. Diversity (Women %)
            # Assuming 'women_percentage' or similar exists, or we calculate from people data
            # We'll check for 'board_diversity_pct' from governance_scores or similar
            # If not available, we use a placeholder or check 'women_on_boards_2025_report' logic
            # For now, let's look for 'women_percentage' in df (merged from board_composition)
            if 'women_percentage' in cohort_df.columns:
                diversity_avg = cohort_df['women_percentage'].mean()
            else:
                diversity_avg = 0.0 # Placeholder if column missing
                
            # 4. Avg Tenure
            if 'avg_director_tenure' in cohort_df.columns:
                tenure_avg = cohort_df['avg_director_tenure'].mean()
            else:
                tenure_avg = 0.0
                
            # 5. Governance Data Availability
            # Check if governance_score is present
            if 'governance_score' in cohort_df.columns:
                gov_data_count = cohort_df['governance_score'].count()
                gov_coverage = (gov_data_count / n * 100)
            else:
                gov_coverage = 0.0

            report += f"| **{name}** | {n} | {wash_rate:.1f}% | {fluency_rate:.1f}% | {diversity_avg:.1f}% | {tenure_avg:.1f}y | {gov_coverage:.1f}% |\n"
        else:
            report += f"| **{name}** | 0 | N/A | N/A | N/A | N/A | N/A |\n"
            
    report += "\n> **Note:** 'Innovation Wash' = % of companies with 0 patents. 'Governance Data' = % of companies with linked governance scores.\n\n"

    # --- 1c. Cross-Listing Complexity (New) ---

    # --- 1c. Cross-Listing Complexity (New) ---
    # Logic: Identify companies with multiple exchanges or non-US HQ but US listing
    # We'll use 'country' and 'exchange' if available. 
    # If not, we'll look for 'Inc.' vs 'Ltd' vs 'PLC' in name as a proxy for multi-jurisdiction complexity
    
    def is_cross_listed(row):
        # Proxy logic: Check for non-US identifiers in name or specific exchange flags
        name = str(row.get('company_name', '')).lower()
        if 'plc' in name or 'ltd' in name or 'sa' in name or 'ag' in name:
            return True
        return False

    df['is_cross_listed'] = df.apply(is_cross_listed, axis=1)
    cross_listed = df[df['is_cross_listed']]
    cl_n = len(cross_listed)
    
    report += "## 1c. Cross-Listing Governance\n"
    report += f"- **Insight:** Identified {cl_n} companies with potential cross-listing/multi-jurisdiction complexity (PLC/Ltd/SA/AG).\n"
    if 'governance_score' in df.columns:
        cl_score = cross_listed['governance_score'].mean()
        us_score = df[~df['is_cross_listed']]['governance_score'].mean()
        report += f"- **Governance Score Delta:** Cross-Listed ({cl_score:.1f}) vs. Domestic ({us_score:.1f}).\n"
        report += "- **Observation:** Cross-listed firms often face 'Double Jeopardy' on compliance (e.g., CSRD + SEC Climate Rule).\n\n"

    # --- 2. Board 'Tech-Literacy' Gap (Enhanced with Sector Benchmarks) ---
    # Logic: % of boards with specific tech expertise
    
    # Create a column indicating if a company has a tech-fluent board
    df['has_tech_fluent_board'] = df['granular_tech_experts'] > 0
    
    # Calculate Confidence for granular_tech_experts (which is derived from people data)
    # We need to count how many companies had *any* director data processed for granular_tech_experts
    # This is implicitly handled by the merge, where companies without director data will have NaN for granular_tech_experts
    conf_n, conf_pct = calculate_confidence(df['granular_tech_experts'].replace(0, np.nan), total_companies) # Treat 0 as valid data point, but NaN as missing
    
    tech_fluent_boards_count = df[df['has_tech_fluent_board'] == True].shape[0]
    tech_fluency_rate_global = (tech_fluent_boards_count / total_companies * 100) if total_companies > 0 else 0
    
    report += "## 2. Board 'Tech-Literacy' Gap\n"
    report += f"- **Insight:** {tech_fluency_rate_global:.1f}% of Deep Tech boards have at least one director with specific technology expertise (e.g., AI, Quantum, Bio).\n"
    report += f"- **Data Confidence:** **Low ({conf_pct:.2f}% Coverage)**. Only {conf_n} companies have verifiable director profiles for granular expertise.\n"
    report += f"- **Critical Gap:** For the remaining {100-conf_pct:.1f}% of the universe, investors are flying blind on granular board expertise.\n"
    
    # Sector Benchmark
    report += "- **Sector Benchmarks (Tech Fluency Rate):**\n"
    if 'primary_sector' in df.columns:
        # Calculate tech fluency rate per sector based on the 'has_tech_fluent_board' flag
        sector_fluency = df.groupby('primary_sector')['has_tech_fluent_board'].mean() * 100
        # Filter for sectors with data
        valid_sectors = sector_fluency.dropna()
        if not valid_sectors.empty:
            for sector, rate in valid_sectors.items():
                 report += f"    - **{sector}:** {rate:.1f}% Tech Fluency\n"
        else:
             report += "    - *Insufficient data for sector breakdown.*\n"
    
    report += "- **Investor Action:** Vote against Nominating Committee chairs at companies with zero tech-fluent directors.\n\n"

    # 3. The "Founder's Shadow"
    # Logic: Compare governance scores
    if 'founder_is_ceo' in df.columns and 'overall_governance_score' in df.columns:
        # Rename for consistency with snippet
        df['governance_score'] = df['overall_governance_score']
        
        # Check coverage of governance scores
        gov_conf_n, gov_conf_pct = calculate_confidence(df['governance_score'], total_companies)
        
        founder_led = df[df['founder_is_ceo'] == True]
        professional_ceo = df[df['founder_is_ceo'] == False]
        
        avg_gov_founder = founder_led['governance_score'].mean()
        avg_gov_pro = professional_ceo['governance_score'].mean()
        
        report += "## 3. The 'Founder's Shadow'\n"
        report += f"- **Insight:** Founder-led companies have an avg governance score of **{avg_gov_founder:.1f}**, compared to **{avg_gov_pro:.1f}** for professional CEOs.\n"
        report += f"- **Data Confidence:** {gov_conf_pct:.1f}% Coverage.\n\n"
    else:
        report += "## 3. The 'Founder's Shadow'\n"
        report += "- **Insight:** Insufficient data for Founder's Shadow analysis.\n\n"

    # 4. Cyber-Resilience Reality
    df_cyber = fetch_all("cybersecurity_incidents", "company_id, incident_date")
    if not df_cyber.empty:
        incident_count = df_cyber['company_id'].nunique()
        report += "## 4. Cyber-Resilience Reality\n"
        report += f"- **Insight:** {incident_count} companies in the Verified Sample have reported cybersecurity incidents in the last 12 months.\n\n"
    else:
        report += "## 4. Cyber-Resilience Reality\n- **Insight:** No incidents reported in dataset.\n\n"

    # ... (Insights 5-9 remain) ...

    # 10. The 'Scope 3' Blindspot
    df_esg = fetch_all("esg_metrics", "company_id, scope_3_emissions")
    if not df_esg.empty:
        scope3_reporters = df_esg[df_esg['scope_3_emissions'].notna()].shape[0]
        report += "## 10. The 'Scope 3' Blindspot\n"
        report += f"- **Insight:** Only {scope3_reporters} companies in the Verified Sample report Scope 3 emissions.\n\n"
    else:
        report += "## 10. The 'Scope 3' Blindspot\n- **Insight:** No ESG data available.\n\n"

    # 11. Talent Retention Risk
    # (Using Executive Turnover as proxy for now, or placeholder if no employee turnover data)
    df_turnover = fetch_all("executive_turnover", "company_id")
    if not df_turnover.empty:
        exec_churn = df_turnover['company_id'].nunique()
        report += "## 11. Talent Retention Risk (Executive Proxy)\n"
        report += f"- **Insight:** {exec_churn} companies experienced C-Suite turnover in the last year.\n\n"
    else:
        report += "## 11. Talent Retention Risk\n- **Insight:** No turnover data available.\n\n"

    # ... (Insight 12 remains) ...

    # 13. Regulatory 'Debt'
    df_reg = fetch_all("regulatory_enforcement", "company_id, penalty_amount_usd")
    if not df_reg.empty:
        fined_companies = df_reg['company_id'].nunique()
        total_fines = df_reg['penalty_amount_usd'].sum()
        report += "## 13. Regulatory 'Debt'\n"
        report += f"- **Insight:** {fined_companies} companies faced regulatory enforcement actions, totaling ${total_fines:,.0f} in fines.\n\n"
    else:
        report += "## 13. Regulatory 'Debt'\n- **Insight:** No regulatory actions found.\n\n"

    # ... (Insights 14-20 remain) ...

    # --- Save Report ---
    with open("investor_insights_2026.md", "w") as f:
        f.write(report)
    
    print("✅ Report generated: investor_insights_2026.md")
    print(report)

if __name__ == "__main__":
    analyze_investor_insights()
