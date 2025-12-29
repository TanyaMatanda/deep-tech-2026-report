#!/usr/bin/env python3
"""
IPO Readiness Analyzer
Analyzes 95K private companies for IPO readiness using comprehensive database

Usage:
  python analyze_ipo_readiness.py --threshold 60 --export csv
"""

import psycopg2
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import argparse
from datetime import datetime
import os

# Database connection (update with your credentials)
DB_CONFIG = {
    'host': os.getenv('SUPABASE_HOST', 'localhost'),
    'database': os.getenv('SUPABASE_DB', 'postgres'),
    'user': os.getenv('SUPABASE_USER', 'postgres'),
    'password': os.getenv('SUPABASE_PASSWORD', '')
}

def create_ipo_readiness_view(conn):
    """Create the IPO readiness scoring view in the database"""
    
    create_view_sql = """
    CREATE OR REPLACE VIEW ipo_readiness_scores AS
    WITH 
    -- Financial Scoring (Max 30 points)
    financial_score AS (
      SELECT 
        company_id,
        fiscal_year,
        CASE 
          WHEN revenue_usd >= 500000000 THEN 30  -- $500M+ (Unicorn tier)
          WHEN revenue_usd >= 100000000 THEN 25  -- $100M+ (NYSE minimum)
          WHEN revenue_usd >= 50000000 THEN 20   -- $50M+ (NASDAQ viable)
          WHEN revenue_usd >= 20000000 THEN 15   -- $20M+ (TSX viable)
          WHEN revenue_usd >= 10000000 THEN 10   -- $10M+ (TSX-V viable)
          ELSE 3
        END +
        CASE WHEN net_income_usd > 0 THEN 10 ELSE 0 END +  -- Profitability bonus
        CASE WHEN rd_percent_revenue > 15 THEN 5 ELSE 0 END  -- R&D intensity (innovation signal)
        AS financial_points,
        revenue_usd,
        net_income_usd,
        gross_margin,
        rd_spend_usd,
        employee_count
      FROM financial_metrics
      WHERE fiscal_quarter IS NULL  -- Annual data only
    ),
    
    -- Governance Scoring (Max 25 points)
    governance_score AS (
      SELECT 
        bca.company_id,
        bca.fiscal_year,
        CASE 
          WHEN (bca.independent_directors::FLOAT / NULLIF(bca.total_directors, 0)) >= 0.5 THEN 12
          WHEN (bca.independent_directors::FLOAT / NULLIF(bca.total_directors, 0)) >= 0.33 THEN 7
          ELSE 2
        END +
        CASE WHEN bca.total_directors >= 5 THEN 5 ELSE 0 END +  -- Sufficient board size
        CASE WHEN bca.tech_experts >= 1 THEN 3 ELSE 0 END +  -- Tech expertise
        CASE WHEN bca.has_ai_oversight_committee THEN 5 ELSE 0 END  -- AI governance (deep tech bonus)
        AS governance_points,
        bca.total_directors,
        bca.independent_directors,
        bca.tech_experts,
        gs.overall_governance_score
      FROM board_composition_annual bca
      LEFT JOIN governance_scores gs ON bca.company_id = gs.company_id AND bca.fiscal_year = gs.fiscal_year
    ),
    
    -- Legal/Compliance Scoring (Max 15 points)
    legal_score AS (
      SELECT 
        c.id AS company_id,
        15 -  -- Start with full points, deduct for issues
        COALESCE(
          CASE WHEN COUNT(lc.id) FILTER (WHERE lc.material_risk = TRUE AND lc.case_status IN ('Active', 'Appealed')) > 0 THEN 10 ELSE 0 END +
          CASE WHEN COUNT(lc.id) FILTER (WHERE lc.case_status IN ('Active', 'Appealed')) > 5 THEN 3 ELSE 0 END +
          CASE WHEN COUNT(re.id) > 0 THEN 5 ELSE 0 END,  -- Regulatory enforcement
          0
        )
        AS legal_points,
        COUNT(lc.id) FILTER (WHERE lc.case_status IN ('Active', 'Appealed')) AS active_litigation_count,
        COUNT(re.id) AS enforcement_action_count
      FROM companies c
      LEFT JOIN litigation_cases lc ON c.id = lc.company_id
      LEFT JOIN regulatory_enforcement re ON c.id = re.company_id AND re.resolved = FALSE
      GROUP BY c.id
    ),
    
    -- Patent/Innovation Scoring (Max 10 points)
    patent_score AS (
      SELECT 
        c.id AS company_id,
        CASE 
          WHEN COALESCE(COUNT(p.id), 0) >= 100 THEN 10
          WHEN COALESCE(COUNT(p.id), 0) >= 50 THEN 8
          WHEN COALESCE(COUNT(p.id), 0) >= 20 THEN 6
          WHEN COALESCE(COUNT(p.id), 0) >= 5 THEN 4
          WHEN COALESCE(COUNT(p.id), 0) >= 1 THEN 2
          ELSE 0
        END AS patent_points,
        COALESCE(COUNT(p.id), 0) AS patent_count,
        COALESCE(AVG(p.citation_count), 0) AS avg_patent_citations
      FROM companies c
      LEFT JOIN patents p ON c.id = p.company_id AND p.is_active = TRUE
      GROUP BY c.id
    ),
    
    -- Risk Mitigation Scoring (Max 10 points)
    risk_score AS (
      SELECT 
        c.id AS company_id,
        -- Cybersecurity (4 points)
        CASE 
          WHEN COALESCE(COUNT(ci.id) FILTER (WHERE ci.severity IN ('Critical', 'High') 
            AND ci.incident_date > CURRENT_DATE - INTERVAL '3 years'),  0) = 0 THEN 4
          WHEN COALESCE(COUNT(ci.id) FILTER (WHERE ci.incident_date > CURRENT_DATE - INTERVAL '3 years'), 0) = 0 THEN 2
          ELSE 0
        END +
        -- Customer Concentration (3 points)
        CASE 
          WHEN COALESCE(MAX(cc.percent_total_revenue), 0) < 25 THEN 3
          WHEN COALESCE(MAX(cc.percent_total_revenue), 0) < 50 THEN 1
          ELSE 0
        END +
        -- Key Person Risk (3 points)
        CASE 
          WHEN COUNT(kpr.id) = 0 OR BOOL_AND(kpr.succession_plan_documented) THEN 3
          ELSE 0
        END
        AS risk_points,
        COUNT(ci.id) FILTER (WHERE ci.incident_date > CURRENT_DATE - INTERVAL '3 years') AS recent_cyber_incidents,
        MAX(cc.percent_total_revenue) AS top_customer_concentration_pct
      FROM companies c
      LEFT JOIN cybersecurity_incidents ci ON c.id = ci.company_id
      LEFT JOIN customer_concentration cc ON c.id = cc.company_id
      LEFT JOIN key_person_risk kpr ON c.id = kpr.company_id
      GROUP BY c.id
    ),
    
    -- Operational Readiness (Max 10 points)
    operational_score AS (
      SELECT 
        c.id AS company_id,
        CASE WHEN COUNT(sc.id) FILTER (WHERE sc.certification_type IN ('SOC2 Type II', 'ISO 27001') AND sc.is_current = TRUE) > 0 THEN 5 ELSE 0 END +
        CASE WHEN COUNT(et.id) FILTER (WHERE et.departure_date > CURRENT_DATE - INTERVAL '1 year' AND et.role IN ('CEO', 'CFO')) = 0 THEN 5 ELSE 0 END
        AS operational_points,
        COUNT(sc.id) FILTER (WHERE sc.is_current = TRUE) AS current_certifications,
        COUNT(et.id) FILTER (WHERE et.departure_date > CURRENT_DATE - INTERVAL '1 year') AS recent_exec_departures
      FROM companies c
      LEFT JOIN security_certifications sc ON c.id = sc.company_id
      LEFT JOIN executive_turnover et ON c.id = et.company_id
      GROUP BY c.id
    )
    
    -- Final Aggregation
    SELECT 
      c.id AS company_id,
      c.company_name,
      c.legal_name,
      c.ticker_symbol,
      c.primary_sector,
      c.primary_subsector,
      c.incorporation_country,
      c.listing_type,
      c.company_status,
      c.headquarters_city,
      c.headquarters_state_province,
      c.headquarters_country,
      
      -- Get most recent fiscal year
      COALESCE(fs.fiscal_year, gs.fiscal_year) AS latest_fiscal_year,
      
      -- Financial metrics
      fs.revenue_usd,
      fs.net_income_usd,
      fs.gross_margin,
      fs.rd_spend_usd,
      fs.employee_count,
      
      -- Governance metrics
      gs.total_directors,
      gs.independent_directors,
      gs.tech_experts,
      gs.overall_governance_score,
      
      -- Risk metrics
      ls.active_litigation_count,
      ls.enforcement_action_count,
      ps.patent_count,
      ps.avg_patent_citations,
      rs.recent_cyber_incidents,
      rs.top_customer_concentration_pct,
      os.current_certifications,
      os.recent_exec_departures,
      
      -- Component Scores
      COALESCE(fs.financial_points, 0) AS financial_score,
      COALESCE(gs.governance_points, 0) AS governance_score,
      COALESCE(ls.legal_points, 15) AS legal_score,  -- Default full points if no data
      COALESCE(ps.patent_points, 0) AS patent_score,
      COALESCE(rs.risk_points, 5) AS risk_score,  -- Default partial points
      COALESCE(os.operational_points, 0) AS operational_score,
      
      -- Total Score (Weighted)
      (
        COALESCE(fs.financial_points, 0) * 0.30 +
        COALESCE(gs.governance_points, 0) * 0.25 +
        COALESCE(ls.legal_points, 15) * 0.15 +
        COALESCE(ps.patent_points, 0) * 0.10 +
        COALESCE(rs.risk_points, 5) * 0.10 +
        COALESCE(os.operational_points, 0) * 0.10
      ) AS total_ipo_readiness_score,
      
      -- Readiness Tier
      CASE 
        WHEN (
          COALESCE(fs.financial_points, 0) * 0.30 +
          COALESCE(gs.governance_points, 0) * 0.25 +
          COALESCE(ls.legal_points, 15) * 0.15 +
          COALESCE(ps.patent_points, 0) * 0.10 +
          COALESCE(rs.risk_points, 5) * 0.10 +
          COALESCE(os.operational_points, 0) * 0.10
        ) >= 80 THEN 'IPO-Ready (12-18mo)'
        WHEN (
          COALESCE(fs.financial_points, 0) * 0.30 +
          COALESCE(gs.governance_points, 0) * 0.25 +
          COALESCE(ls.legal_points, 15) * 0.15 +
          COALESCE(ps.patent_points, 0) * 0.10 +
          COALESCE(rs.risk_points, 5) * 0.10 +
          COALESCE(os.operational_points, 0) * 0.10
        ) >= 60 THEN 'Near-Term (18-24mo)'
        WHEN (
          COALESCE(fs.financial_points, 0) * 0.30 +
          COALESCE(gs.governance_points, 0) * 0.25 +
          COALESCE(ls.legal_points, 15) * 0.15 +
          COALESCE(ps.patent_points, 0) * 0.10 +
          COALESCE(rs.risk_points, 5) * 0.10 +
          COALESCE(os.operational_points, 0) * 0.10
        ) >= 40 THEN 'Significant Gaps (2-3yr)'
        ELSE 'Not Ready (3+yr)'
      END AS readiness_tier,
      
      -- Target Exchange Recommendation
      CASE 
        WHEN fs.revenue_usd >= 100000000 THEN 'NYSE/NASDAQ'
        WHEN fs.revenue_usd >= 20000000 THEN 'NASDAQ/TSX'
        WHEN fs.revenue_usd >= 5000000 THEN 'TSX/TSX-V'
        ELSE 'TSX-V/Private'
      END AS target_exchange
    
    FROM companies c
    LEFT JOIN financial_score fs ON c.id = fs.company_id 
      AND fs.fiscal_year = (SELECT MAX(fiscal_year) FROM financial_metrics fm WHERE fm.company_id = c.id)
    LEFT JOIN governance_score gs ON c.id = gs.company_id
      AND gs.fiscal_year = (SELECT MAX(fiscal_year) FROM board_composition_annual bca WHERE bca.company_id = c.id)
    LEFT JOIN legal_score ls ON c.id = ls.company_id
    LEFT JOIN patent_score ps ON c.id = ps.company_id
    LEFT JOIN risk_score rs ON c.id = rs.company_id
    LEFT JOIN operational_score os ON c.id = os.company_id
    
    WHERE c.listing_type = 'Private'  -- Only private companies
      AND c.company_status = 'Active';
    """
    
    with conn.cursor() as cur:
        cur.execute(create_view_sql)
        conn.commit()
    print("✓ Created ipo_readiness_scores view")


def analyze_ipo_candidates(conn, threshold=60, export_format='csv'):
    """Analyze and export IPO-ready companies"""
    
    # Pull data
    query = f"""
    SELECT * FROM ipo_readiness_scores 
    WHERE total_ipo_readiness_score >= {threshold}
    ORDER BY total_ipo_readiness_score DESC
    """
    
    df = pd.read_sql(query, conn)
    print(f"\n📊 Found {len(df)} companies with IPO readiness score >= {threshold}")
    
    if len(df) == 0:
        print("No companies meet the threshold. Try lowering the threshold.")
        return
    
    # Summary statistics
    print("\n=== SUMMARY STATISTICS ===")
    print(f"Average Score: {df['total_ipo_readiness_score'].mean():.1f}")
    print(f"Median Revenue: ${df['revenue_usd'].median()/1e6:.1f}M")
    print(f"Total Patents: {df['patent_count'].sum():,.0f}")
    
    print("\n=== READINESS TIER DISTRIBUTION ===")
    print(df['readiness_tier'].value_counts())
    
    print("\n=== TOP SECTORS ===")
    print(df['primary_sector'].value_counts().head(10))
    
    # Export
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    if export_format == 'csv':
        filename = f"ipo_candidates_{timestamp}.csv"
        df.to_csv(filename, index=False)
        print(f"\n✓ Exported to {filename}")
    
    elif export_format == 'excel':
        filename = f"ipo_candidates_{timestamp}.xlsx"
        with pd.ExcelWriter(filename, engine='openpyxl') as writer:
            df.to_excel(writer, sheet_name='All Candidates', index=False)
            df[df['readiness_tier'] == 'IPO-Ready (12-18mo)'].to_excel(
                writer, sheet_name='IPO-Ready', index=False
            )
            sector_summary = df.groupby('primary_sector').agg({
                'company_name': 'count',
                'total_ipo_readiness_score': 'mean',
                'revenue_usd': 'median'
            }).sort_values('company_name', ascending=False)
            sector_summary.to_excel(writer, sheet_name='Sector Summary')
        print(f"\n✓ Exported to {filename}")
    
    return df


def visualize_results(df):
    """Create visualization charts"""
    
    sns.set_style("whitegrid")
    fig, axes = plt.subplots(2, 2, figsize=(15, 12))
    
    # 1. Score Distribution
    axes[0, 0].hist(df['total_ipo_readiness_score'], bins=20, edgecolor='black', color='skyblue')
    axes[0, 0].axvline(80, color='green', linestyle='--', label='IPO-Ready threshold')
    axes[0, 0].axvline(60, color='orange', linestyle='--', label='Near-term threshold')
    axes[0, 0].set_title("IPO Readiness Score Distribution")
    axes[0, 0].set_xlabel("Score")
    axes[0, 0].set_ylabel("Company Count")
    axes[0, 0].legend()
    
    # 2. Revenue vs Score
    axes[0, 1].scatter(df['revenue_usd']/1e6, df['total_ipo_readiness_score'], alpha=0.6)
    axes[0, 1].set_title("Revenue vs IPO Readiness")
    axes[0, 1].set_xlabel("Revenue ($M)")
    axes[0, 1].set_ylabel("IPO Readiness Score")
    axes[0, 1].set_xscale('log')
    
    # 3. Sector Distribution
    top_sectors = df['primary_sector'].value_counts().head(10)
    top_sectors.plot(kind='barh', ax=axes[1, 0], color='coral')
    axes[1, 0].set_title("Top 10 Sectors by Company Count")
    axes[1, 0].set_xlabel("Count")
    
    # 4. Component Score Breakdown
    score_cols = ['financial_score', 'governance_score', 'legal_score', 'patent_score', 'risk_score', 'operational_score']
    df[score_cols].mean().plot(kind='bar', ax=axes[1, 1], color='lightgreen', edgecolor='black')
    axes[1, 1].set_title("Average Component Scores")
    axes[1, 1].set_ylabel("Score")
    axes[1, 1].set_xticklabels(['Financial', 'Governance', 'Legal', 'IP', 'Risk', 'Operational'], rotation=45)
    
    plt.tight_layout()
    plt.savefig(f"ipo_analysis_{datetime.now().strftime('%Y%m%d')}.png", dpi=300)
    print("\n✓ Saved visualization to ipo_analysis_[date].png")


def main():
    parser = argparse.ArgumentParser(description='Analyze IPO readiness of private companies')
    parser.add_argument('--threshold', type=int, default=60, help='Minimum score threshold (default: 60)')
    parser.add_argument('--export', choices=['csv', 'excel'], default='csv', help='Export format')
    parser.add_argument('--visualize', action='store_true', help='Generate visualizations')
    parser.add_argument('--create-view', action='store_true', help='Create/refresh the IPO readiness view')
    
    args = parser.parse_args()
    
    # Connect to database
    print("Connecting to database...")
    conn = psycopg2.connect(**DB_CONFIG)
    
    try:
        # Create view if requested
        if args.create_view:
            create_ipo_readiness_view(conn)
        
        # Analyze candidates
        df = analyze_ipo_candidates(conn, threshold=args.threshold, export_format=args.export)
        
        # Create visualizations
        if args.visualize and df is not None and len(df) > 0:
            visualize_results(df)
        
    finally:
        conn.close()
        print("\n✓ Analysis complete")


if __name__ == '__main__':
    main()
