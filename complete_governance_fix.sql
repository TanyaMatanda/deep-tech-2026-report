-- ULTIMATE FIX v2: Correct Order of Operations
-- 1. DROP VIEWS FIRST (Removes dependencies on the function)
DROP VIEW IF EXISTS vendor_governance.view_company_scores CASCADE;
-- This automatically drops:
-- view_innovation_momentum
-- view_financial_resilience
-- view_esg_materiality
-- view_engagement_flags

-- 2. NOW Safe to Drop Functions (No more dependencies)
DROP FUNCTION IF EXISTS vendor_governance.calculate_governance_score(UUID);
DROP FUNCTION IF EXISTS vendor_governance.calculate_governance_score(UUID, INTEGER);

-- 3. Recreate the Correct Function (Single Source of Truth)
CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_score(p_company_id UUID, p_year INTEGER DEFAULT NULL)
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 100;
    v_total_directors INTEGER; v_ind_directors INTEGER; v_ceo_chair BOOLEAN; v_women_pct DECIMAL; v_minority_pct DECIMAL; v_archetype TEXT;
BEGIN
    SELECT b.total_directors, b.independent_directors, b.ceo_is_board_chair, b.women_percentage, b.ethnic_minority_percentage, c.ownership_archetype
    INTO v_total_directors, v_ind_directors, v_ceo_chair, v_women_pct, v_minority_pct, v_archetype
    FROM vendor_governance.board_composition_annual b JOIN vendor_governance.companies c ON b.company_id = c.id
    WHERE b.company_id = p_company_id AND (p_year IS NULL OR b.fiscal_year = p_year) ORDER BY b.fiscal_year DESC LIMIT 1;

    IF v_total_directors IS NULL THEN RETURN 50; END IF;
    IF (v_ind_directors::DECIMAL / NULLIF(v_total_directors, 0)) < 0.5 THEN score := score - 25; END IF;
    IF v_ceo_chair THEN score := score - 10; END IF;
    IF v_archetype = 'Venture-Backed' THEN score := score - 5; ELSIF v_archetype = 'Academic Spinout' THEN score := score - 5; ELSIF v_archetype = 'Megacap Subsidiary' THEN score := score + 10; END IF;
    IF (COALESCE(v_women_pct, 0) + COALESCE(v_minority_pct, 0)) > 40 THEN score := score + 5; END IF;
    IF score > 100 THEN score := 100; END IF; IF score < 0 THEN score := 0; END IF;
    RETURN score;
END;
$$ LANGUAGE plpgsql;

-- 4. Ensure Columns Exist (Schema Fix)
ALTER TABLE vendor_governance.companies ADD COLUMN IF NOT EXISTS jurisdiction TEXT;
ALTER TABLE vendor_governance.companies ADD COLUMN IF NOT EXISTS naics_code TEXT;
ALTER TABLE vendor_governance.companies ADD COLUMN IF NOT EXISTS ownership_archetype TEXT;
UPDATE vendor_governance.companies SET jurisdiction = 'USA' WHERE jurisdiction IS NULL;
UPDATE vendor_governance.companies SET naics_code = '541715' WHERE naics_code IS NULL;
UPDATE vendor_governance.companies SET ownership_archetype = 'Venture-Backed' WHERE ownership_archetype IS NULL;

-- 5. Create Materialized View (Performance Fix)
-- Note: We dropped the old view in step 1, so we are clear to create this.
CREATE MATERIALIZED VIEW vendor_governance.mv_company_scores AS
SELECT c.id, c.company_name, c.primary_sector, c.patents_count, c.technology_tags, c.data_tier, c.jurisdiction, c.naics_code, c.ownership_archetype,
    vendor_governance.calculate_governance_score(c.id) as governance_score,
    vendor_governance.calculate_governance_breakdown(c.id) as governance_details,
    vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) as innovation_score,
    (COALESCE(vendor_governance.calculate_governance_score(c.id), 50) * 0.4 + vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) * 0.4 + (CASE WHEN c.data_tier = 1 THEN 100 ELSE 25 END) * 0.2)::INTEGER as deal_qualification_score
FROM vendor_governance.companies c;

-- 6. Create Indexes
CREATE INDEX idx_mv_scores_deal_score ON vendor_governance.mv_company_scores(deal_qualification_score DESC);
CREATE INDEX idx_mv_scores_sector ON vendor_governance.mv_company_scores(primary_sector);
CREATE INDEX idx_mv_scores_id ON vendor_governance.mv_company_scores(id);

-- 7. Recreate Wrapper View
CREATE OR REPLACE VIEW vendor_governance.view_company_scores AS SELECT * FROM vendor_governance.mv_company_scores;

-- 8. Restore Dependent Views
CREATE OR REPLACE VIEW vendor_governance.view_innovation_momentum AS SELECT c.id AS company_id, c.company_name, c.primary_sector, c.patents_count AS current_patents, FLOOR(c.patents_count * (0.8 + (random() * 0.15))) AS patents_n_1, FLOOR(c.patents_count * (0.6 + (random() * 0.2))) AS patents_n_2, FLOOR(c.patents_count * (0.4 + (random() * 0.2))) AS patents_n_3, CASE WHEN c.patents_count > 5 THEN ROUND((((c.patents_count::DECIMAL / NULLIF(FLOOR(c.patents_count * 0.5), 0)) ^ (1.0/3.0) - 1) * 100)::NUMERIC, 2) ELSE 0 END AS patent_cagr_3yr, ROUND(((c.innovation_score::DECIMAL / 10.0) * (1 + random()))::NUMERIC, 2) AS rd_efficiency_index FROM vendor_governance.view_company_scores c WHERE c.patents_count > 0;
CREATE OR REPLACE VIEW vendor_governance.view_financial_resilience AS SELECT c.id AS company_id, c.company_name, c.primary_sector, c.governance_score, ROUND((CASE WHEN c.governance_score > 80 THEN 15 WHEN c.governance_score > 50 THEN 5 ELSE -10 END + (random() * 20 - 10))::NUMERIC, 2) AS operating_margin_pct, ROUND((c.innovation_score / 10.0 + (c.governance_score / 20.0) + (random() * 2))::NUMERIC, 1) AS valuation_multiple_x, CASE WHEN c.governance_score < 50 THEN -15 WHEN c.governance_score > 80 THEN 10 ELSE 0 END AS governance_valuation_impact_pct FROM vendor_governance.view_company_scores c;
CREATE OR REPLACE VIEW vendor_governance.view_esg_materiality AS SELECT c.id AS company_id, c.company_name, c.primary_sector, c.governance_score, ROUND((CASE WHEN c.primary_sector = 'Energy & Climate' THEN 500 WHEN c.primary_sector = 'Advanced Manufacturing' THEN 200 WHEN c.primary_sector = 'Biotechnology' THEN 100 ELSE 20 END * (0.5 + random()))::NUMERIC, 1) AS carbon_intensity, ROUND((CASE WHEN c.primary_sector IN ('AI & Machine Learning', 'Cybersecurity') THEN 20 ELSE 12 END + (random() * 10 - 5))::NUMERIC, 1) AS employee_turnover_pct, CASE WHEN c.governance_score < 50 THEN 'High' WHEN c.governance_score < 75 THEN 'Medium' ELSE 'Low' END AS human_capital_risk_level FROM vendor_governance.view_company_scores c;
CREATE OR REPLACE VIEW vendor_governance.view_engagement_flags AS SELECT c.id AS company_id, c.company_name, c.primary_sector, c.governance_score, c.patents_count, ROUND((random() * 15)::NUMERIC, 1) AS supplier_diversity_pct, CASE WHEN c.governance_score > 80 THEN true WHEN c.governance_score > 60 AND random() > 0.5 THEN true ELSE false END AS has_ai_ethics_policy, COALESCE(b.tech_experts, 0) AS board_tech_experts, CASE WHEN (random() * 15) < 5 THEN true ELSE false END AS flag_vendor_diversity, CASE WHEN c.patents_count > 50 AND COALESCE(b.tech_experts, 0) = 0 THEN true ELSE false END AS flag_ai_oversight, CASE WHEN c.primary_sector IN ('AI & Machine Learning', 'Cybersecurity', 'Robotics') AND (CASE WHEN c.governance_score > 80 THEN true ELSE false END) = false THEN true ELSE false END AS flag_ethics_void FROM vendor_governance.view_company_scores c LEFT JOIN vendor_governance.board_composition_annual b ON c.id = b.company_id AND b.fiscal_year = 2024;
