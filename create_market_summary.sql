-- Create Market Summary Views (Simplified for Performance)
-- Run this script in Supabase SQL Editor

-- 1. Market Summary View (Simplified)
DROP VIEW IF EXISTS vendor_governance.view_market_summary CASCADE;

CREATE OR REPLACE VIEW vendor_governance.view_market_summary AS
SELECT
    COUNT(*) as total_companies,
    SUM(CASE WHEN ticker_symbol IS NOT NULL THEN 1 ELSE 0 END) as public_companies,
    SUM(CASE WHEN ticker_symbol IS NULL THEN 1 ELSE 0 END) as private_companies,
    ROUND(AVG(deal_qualification_score), 1) as avg_deal_score,
    ROUND(AVG(governance_score), 1) as avg_governance_score,
    ROUND(AVG(innovation_score), 1) as avg_innovation_score,
    SUM(patents_count) as total_patents_tracked
FROM vendor_governance.view_company_scores;

-- 2. Sector Performance View (Unchanged)
DROP VIEW IF EXISTS vendor_governance.view_sector_performance CASCADE;

CREATE OR REPLACE VIEW vendor_governance.view_sector_performance AS
SELECT
    primary_sector as sector,
    COUNT(*) as company_count,
    ROUND(AVG(deal_qualification_score), 1) as avg_deal_score,
    ROUND(AVG(governance_score), 1) as avg_governance_score,
    ROUND(AVG(innovation_score), 1) as avg_innovation_score,
    SUM(patents_count) as total_patents
FROM vendor_governance.view_company_scores
GROUP BY primary_sector
ORDER BY total_patents DESC;
