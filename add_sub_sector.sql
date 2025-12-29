-- Add Sub-Sector Column and Populate
-- This script adds a sub_sector column and derives it from technology_tags.

BEGIN;

-- 1. Add Column
ALTER TABLE vendor_governance.companies 
ADD COLUMN IF NOT EXISTS sub_sector VARCHAR(100);

-- 2. Populate Sub-Sector based on Tags (Priority Order)
UPDATE vendor_governance.companies
SET sub_sector = CASE 
    -- AI & ML Sub-sectors
    WHEN 'Generative AI' = ANY(technology_tags) THEN 'Generative AI'
    WHEN 'Computer Vision' = ANY(technology_tags) THEN 'Computer Vision'
    WHEN 'NLP' = ANY(technology_tags) THEN 'NLP & Language Models'
    WHEN 'Robotics' = ANY(technology_tags) THEN 'Robotics & Automation'
    
    -- Biotech
    WHEN 'CRISPR' = ANY(technology_tags) THEN 'Gene Editing (CRISPR)'
    WHEN 'Synthetic Biology' = ANY(technology_tags) THEN 'Synthetic Biology'
    WHEN 'Drug Discovery' = ANY(technology_tags) THEN 'AI Drug Discovery'
    
    -- Quantum / Compute
    WHEN 'Quantum' = ANY(technology_tags) THEN 'Quantum Computing'
    WHEN 'Semiconductor' = ANY(technology_tags) THEN 'Advanced Semiconductors'
    
    -- Energy
    WHEN 'Fusion' = ANY(technology_tags) THEN 'Nuclear Fusion'
    WHEN 'Hydrogen' = ANY(technology_tags) THEN 'Green Hydrogen'
    WHEN 'Battery' = ANY(technology_tags) THEN 'Next-Gen Batteries'
    
    -- Space
    WHEN 'Satellite' = ANY(technology_tags) THEN 'Satellite Tech'
    WHEN 'Launch' = ANY(technology_tags) THEN 'Space Launch'
    
    -- Default Fallback
    ELSE primary_sector || ' (General)'
END;

-- 3. Update Materialized View Definition (Must drop and recreate)
DROP MATERIALIZED VIEW IF EXISTS vendor_governance.mv_company_scores CASCADE;

CREATE MATERIALIZED VIEW vendor_governance.mv_company_scores AS
SELECT 
    c.id,
    c.company_name,
    c.primary_sector,
    c.sub_sector, -- NEW COLUMN
    c.patents_count,
    c.technology_tags,
    c.data_tier,
    c.jurisdiction,
    c.naics_code,
    c.ownership_archetype,
    vendor_governance.calculate_governance_score(c.id) as governance_score,
    vendor_governance.calculate_governance_breakdown(c.id) as governance_details,
    vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) as innovation_score,
    (
        COALESCE(vendor_governance.calculate_governance_score(c.id), 50) * 0.4 + 
        vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) * 0.4 +
        (CASE WHEN c.data_tier = 1 THEN 100 ELSE 25 END) * 0.2
    )::INTEGER as deal_qualification_score
FROM vendor_governance.companies c;

-- 4. Recreate Indexes
CREATE INDEX idx_mv_scores_deal_score ON vendor_governance.mv_company_scores(deal_qualification_score DESC);
CREATE INDEX idx_mv_scores_sector ON vendor_governance.mv_company_scores(primary_sector);
CREATE INDEX idx_mv_scores_sub_sector ON vendor_governance.mv_company_scores(sub_sector); -- NEW INDEX
CREATE INDEX idx_mv_scores_id ON vendor_governance.mv_company_scores(id);

-- 5. Recreate Wrapper View
CREATE OR REPLACE VIEW vendor_governance.view_company_scores AS
SELECT * FROM vendor_governance.mv_company_scores;

-- 6. Restore Dependent Views (Simplified for this script, assuming previous definitions hold if they query view_company_scores)
-- Note: Dependent views were dropped by CASCADE. We need to recreate them.
-- I'll include the definitions from optimize_performance.sql here to be safe.

-- A. Innovation Momentum
CREATE OR REPLACE VIEW vendor_governance.view_innovation_momentum AS
SELECT c.id AS company_id, c.company_name, c.primary_sector, c.patents_count AS current_patents, FLOOR(c.patents_count * (0.8 + (random() * 0.15))) AS patents_n_1, FLOOR(c.patents_count * (0.6 + (random() * 0.2))) AS patents_n_2, FLOOR(c.patents_count * (0.4 + (random() * 0.2))) AS patents_n_3, CASE WHEN c.patents_count > 5 THEN ROUND((((c.patents_count::DECIMAL / NULLIF(FLOOR(c.patents_count * 0.5), 0)) ^ (1.0/3.0) - 1) * 100)::NUMERIC, 2) ELSE 0 END AS patent_cagr_3yr, ROUND(((c.innovation_score::DECIMAL / 10.0) * (1 + random()))::NUMERIC, 2) AS rd_efficiency_index FROM vendor_governance.view_company_scores c WHERE c.patents_count > 0;

-- B. Financial Resilience
CREATE OR REPLACE VIEW vendor_governance.view_financial_resilience AS
SELECT c.id AS company_id, c.company_name, c.primary_sector, c.governance_score, ROUND((CASE WHEN c.governance_score > 80 THEN 15 WHEN c.governance_score > 50 THEN 5 ELSE -10 END + (random() * 20 - 10))::NUMERIC, 2) AS operating_margin_pct, ROUND((c.innovation_score / 10.0 + (c.governance_score / 20.0) + (random() * 2))::NUMERIC, 1) AS valuation_multiple_x, CASE WHEN c.governance_score < 50 THEN -15 WHEN c.governance_score > 80 THEN 10 ELSE 0 END AS governance_valuation_impact_pct FROM vendor_governance.view_company_scores c;

-- C. ESG Materiality
CREATE OR REPLACE VIEW vendor_governance.view_esg_materiality AS
SELECT c.id AS company_id, c.company_name, c.primary_sector, c.governance_score, ROUND((CASE WHEN c.primary_sector = 'Energy & Climate' THEN 500 WHEN c.primary_sector = 'Advanced Manufacturing' THEN 200 WHEN c.primary_sector = 'Biotechnology' THEN 100 ELSE 20 END * (0.5 + random()))::NUMERIC, 1) AS carbon_intensity, ROUND((CASE WHEN c.primary_sector IN ('AI & Machine Learning', 'Cybersecurity') THEN 20 ELSE 12 END + (random() * 10 - 5))::NUMERIC, 1) AS employee_turnover_pct, CASE WHEN c.governance_score < 50 THEN 'High' WHEN c.governance_score < 75 THEN 'Medium' ELSE 'Low' END AS human_capital_risk_level FROM vendor_governance.view_company_scores c;

-- D. Engagement Flags
CREATE OR REPLACE VIEW vendor_governance.view_engagement_flags AS
SELECT c.id AS company_id, c.company_name, c.primary_sector, c.governance_score, c.patents_count, ROUND((random() * 15)::NUMERIC, 1) AS supplier_diversity_pct, CASE WHEN c.governance_score > 80 THEN true WHEN c.governance_score > 60 AND random() > 0.5 THEN true ELSE false END AS has_ai_ethics_policy, COALESCE(b.tech_experts, 0) AS board_tech_experts, CASE WHEN (random() * 15) < 5 THEN true ELSE false END AS flag_vendor_diversity, CASE WHEN c.patents_count > 50 AND COALESCE(b.tech_experts, 0) = 0 THEN true ELSE false END AS flag_ai_oversight, CASE WHEN c.primary_sector IN ('AI & Machine Learning', 'Cybersecurity', 'Robotics') AND (CASE WHEN c.governance_score > 80 THEN true ELSE false END) = false THEN true ELSE false END AS flag_ethics_void FROM vendor_governance.view_company_scores c LEFT JOIN vendor_governance.board_composition_annual b ON c.id = b.company_id AND b.fiscal_year = 2024;

COMMIT;
