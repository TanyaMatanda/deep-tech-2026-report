
import os
from supabase import create_client, Client, ClientOptions
import pandas as pd
import toml

# Configuration
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
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

def analyze_women_on_boards():
    print("Fetching all board data for 2025 (with pagination)...")
    all_board_data = []
    offset = 0
    limit = 1000
    
    while True:
        print(f"  Fetching batch starting at {offset}...")
        res = supabase.table("board_composition_annual").select("*").in_("fiscal_year", [2024, 2025]).range(offset, offset + limit - 1).execute()
        
        if not res.data:
            break
            
        all_board_data.extend(res.data)
        
        if len(res.data) < limit:
            break
            
        offset += limit
        
    print(f"Total 2025 board records fetched: {len(all_board_data)}")
    df_board = pd.DataFrame(all_board_data)
    
    # Get unique company IDs from board data
    board_company_ids = df_board['company_id'].unique().tolist()
    print(f"Fetching details for {len(board_company_ids)} companies...")
    
    # Fetch companies in batches (Supabase URL length limits might apply, so batching is safer)
    all_companies = []
    batch_size = 100
    for i in range(0, len(board_company_ids), batch_size):
        batch = board_company_ids[i:i+batch_size]
        res = supabase.table("companies").select("id, company_name, primary_sector").in_("id", batch).execute()
        all_companies.extend(res.data)
        
    df_companies = pd.DataFrame(all_companies)
    
    # Merge
    print(f"Fetched {len(df_companies)} company profiles.")
    print("Merging data...")
    df = pd.merge(df_board, df_companies, left_on='company_id', right_on='id', how='left')
    
    # Filter for 2025
    df_2025 = df[df['fiscal_year'] == 2025]
    df_2024 = df[df['fiscal_year'] == 2024]
    
    report = "# State of Women on Boards - 2025 Proxy Season Analysis\n\n"
    report += "> **Note:** This analysis is based on the Deep Tech company dataset (N=500).\n\n"
    report += "## Methodology\n\n"
    report += "- **Dataset:** 500 Deep Tech companies (Public & Private).\n"
    report += "- **Data Source:** `board_composition_annual` table from the Vendor Governance database.\n"
    report += "- **Fiscal Year:** 2025 (representing Proxy Season 2025 / FY 2024 financials).\n"
    report += "- **Metric:** Percentage of women directors per board.\n\n"
    
    # Overall Stats
    avg_2025 = df_2025['women_percentage'].mean()
    avg_2024 = df_2024['women_percentage'].mean()
    
    report += "## Executive Summary\n\n"
    report += f"- **Average Women on Boards (2025):** {avg_2025:.1f}%\n"
    report += f"- **Average Women on Boards (2024):** {avg_2024:.1f}%\n"
    report += f"- **Year-over-Year Change:** {avg_2025 - avg_2024:+.1f}%\n\n"
    
    # Distribution
    zero_women = df_2025[df_2025['women_directors'] == 0].shape[0]
    # If women_directors is NaN, check women_percentage
    if df_2025['women_directors'].isnull().all():
         zero_women = df_2025[df_2025['women_percentage'] == 0].shape[0]

    total_companies = df_2025.shape[0]
    pct_zero = (zero_women / total_companies) * 100
    
    over_30 = df_2025[df_2025['women_percentage'] >= 30].shape[0]
    pct_over_30 = (over_30 / total_companies) * 100
    
    parity = df_2025[df_2025['women_percentage'] >= 50].shape[0]
    pct_parity = (parity / total_companies) * 100
    
    report += "## Key Milestones (2025)\n\n"
    report += f"- **Companies with Zero Women:** {zero_women} ({pct_zero:.1f}%)\n"
    report += f"- **Companies with >30% Women:** {over_30} ({pct_over_30:.1f}%)\n"
    report += f"- **Gender Parity (>=50%):** {parity} ({pct_parity:.1f}%)\n\n"
    
    # Sector Breakdown
    if 'primary_sector' in df_2025.columns:
        report += "## Sector Breakdown (2025)\n\n"
        sector_stats = df_2025.groupby('primary_sector')['women_percentage'].agg(['mean', 'count']).sort_values('mean', ascending=False)
        report += "| Sector | Average Women % | Company Count |\n"
        report += "|---|---|---|\n"
        for sector, row in sector_stats.iterrows():
            report += f"| {sector} | {row['mean']:.1f}% | {row['count']} |\n"
        report += "\n"

    # --- NEW: Correlation Analysis ---
    report += "## Impact of Diversity on Governance Metrics\n\n"
    report += "We analyzed how board diversity correlates with other key governance indicators.\n\n"
    
    # Define Tiers
    df_2025['diversity_tier'] = pd.cut(df_2025['women_percentage'], 
                                       bins=[-1, 0, 29.9, 100], 
                                       labels=['Zero Women', '1-29% Women', '30%+ Women'])
    
    # Metrics to analyze
    metrics = {
        'independent_directors': 'Avg Independent Directors',
        'avg_director_age': 'Avg Director Age',
        'avg_director_tenure': 'Avg Tenure (Years)',
        'tech_experts': 'Avg Tech Experts',
        'ai_cybersecurity_experts': 'Avg AI/Cyber Experts',
        'board_meetings_per_year': 'Avg Meetings/Year'
    }
    
    # Calculate means by tier
    tier_stats = df_2025.groupby('diversity_tier')[list(metrics.keys())].mean()
    
    # Calculate Independence % (derived)
    # Note: 'independent_directors' is a count. We need percentage if possible, but let's stick to count or derive if total exists.
    # df_2025['independence_pct'] = (df_2025['independent_directors'] / df_2025['total_directors']) * 100
    # Let's add independence_pct to metrics if columns exist
    if 'total_directors' in df_2025.columns and 'independent_directors' in df_2025.columns:
        df_2025['independence_pct'] = (df_2025['independent_directors'] / df_2025['total_directors']) * 100
        metrics['independence_pct'] = 'Board Independence %'
        tier_stats = df_2025.groupby('diversity_tier')[list(metrics.keys())].mean()

    report += "| Diversity Tier | " + " | ".join(metrics.values()) + " |\n"
    report += "|---|---" + "|---" * len(metrics) + "|\n"
    
    for tier, row in tier_stats.iterrows():
        row_str = f"| {tier} | "
        vals = []
        for col in metrics.keys():
            val = row[col]
            if pd.isna(val):
                vals.append("-")
            elif 'pct' in col or 'percentage' in col or 'Age' in metrics[col]: # Format % or Age
                vals.append(f"{val:.1f}")
            else:
                vals.append(f"{val:.1f}")
        row_str += " | ".join(vals) + " |\n"
        report += row_str
    
    report += "\n> **Insight:** Companies with higher gender diversity tend to have...\n\n"

    # Top Performers
    report += "## Top Performers (2025)\n\n"
    top_10 = df_2025.nlargest(10, 'women_percentage')[['company_name', 'women_percentage', 'primary_sector']]
    report += "| Company | Women % | Sector |\n"
    report += "|---|---|---|\n"
    for _, row in top_10.iterrows():
        name = row['company_name'] if pd.notna(row['company_name']) else "Unknown"
        sector = row['primary_sector'] if pd.notna(row['primary_sector']) else "N/A"
        report += f"| {name} | {row['women_percentage']:.1f}% | {sector} |\n"
    
    report += "\n## Data Coverage\n\n"
    report += f"- **Total Companies Analyzed:** {total_companies}\n"
    report += "- **Dataset:** Deep Tech / Private & Public Mix\n"
    
    # Save Report
    with open("women_on_boards_2025_report.md", "w") as f:
        f.write(report)
        
    print("Report generated: women_on_boards_2025_report.md")
    print(report)

if __name__ == "__main__":
    analyze_women_on_boards()
