-- MASTER REPAIR SCRIPT
-- Run this ENTIRE script to fix everything at once.
-- It handles dependencies in the correct order.

-- 1. Drop everything first to clear conflicts (CASCADE handles dependencies)
DROP FUNCTION IF EXISTS vendor_governance.calculate_governance_score(UUID) CASCADE;
DROP FUNCTION IF EXISTS vendor_governance.calculate_governance_score(UUID, INTEGER) CASCADE;
DROP VIEW IF EXISTS vendor_governance.view_company_scores CASCADE;
DROP MATERIALIZED VIEW IF EXISTS vendor_governance.mv_company_scores CASCADE;

-- 2. Recreate the Governance Scoring Function
CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_score(p_company_id UUID, p_year INTEGER DEFAULT 2024)
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 50;
    v_board_independence DECIMAL;
    v_split_chair_ceo BOOLEAN;
    v_board_diversity DECIMAL;
    v_say_on_pay DECIMAL;
    v_ceo_pay_ratio INTEGER;
    v_has_clawback BOOLEAN;
    v_has_ai_ethics BOOLEAN;
    v_board_ai_expertise BOOLEAN;
    v_cyber_oversight BOOLEAN;
    v_ai_risk_mentions INTEGER;
BEGIN
    -- Fetch real SEC filing data
    SELECT 
        board_independence_pct, split_chair_ceo, board_diversity_pct,
        say_on_pay_support, ceo_pay_ratio, has_clawback_policy,
        has_ai_ethics_board, board_ai_expertise, cyber_oversight_explicit, ai_risk_mentions
    INTO 
        v_board_independence, v_split_chair_ceo, v_board_diversity,
        v_say_on_pay, v_ceo_pay_ratio, v_has_clawback,
        v_has_ai_ethics, v_board_ai_expertise, v_cyber_oversight, v_ai_risk_mentions
    FROM vendor_governance.company_risk_factors
    WHERE company_id = p_company_id AND fiscal_year = p_year
    LIMIT 1;
    
    -- Fallback to old data
    IF v_board_independence IS NULL THEN
        SELECT 
            (independent_directors::DECIMAL / NULLIF(total_directors, 0)) * 100,
            NOT ceo_is_board_chair,
            women_percentage + ethnic_minority_percentage
        INTO v_board_independence, v_split_chair_ceo, v_board_diversity
        FROM vendor_governance.board_composition_annual
        WHERE company_id = p_company_id
        ORDER BY fiscal_year DESC LIMIT 1;
    END IF;
    
    IF v_board_independence IS NULL THEN RETURN NULL; END IF;
    
    -- Scoring Logic
    IF v_board_independence >= 80 THEN score := score + 25;
    ELSIF v_board_independence >= 70 THEN score := score + 20;
    ELSIF v_board_independence >= 60 THEN score := score + 15;
    ELSIF v_board_independence >= 50 THEN score := score + 10;
    ELSE score := score - 10; END IF;
    
    IF v_split_chair_ceo THEN score := score + 15; ELSE score := score - 5; END IF;
    
    IF v_board_diversity >= 40 THEN score := score + 15;
    ELSIF v_board_diversity >= 30 THEN score := score + 10;
    ELSIF v_board_diversity >= 20 THEN score := score + 5;
    ELSE score := score - 5; END IF;
    
    IF v_say_on_pay IS NOT NULL THEN
        IF v_say_on_pay >= 90 THEN score := score + 10;
        ELSIF v_say_on_pay >= 75 THEN score := score + 5;
        ELSIF v_say_on_pay < 70 THEN score := score - 10; END IF;
    END IF;
    
    IF v_ceo_pay_ratio IS NOT NULL THEN
        IF v_ceo_pay_ratio <= 50 THEN score := score + 10;
        ELSIF v_ceo_pay_ratio <= 150 THEN score := score + 5;
        ELSIF v_ceo_pay_ratio > 300 THEN score := score - 10; END IF;
    END IF;
    
    IF v_has_clawback THEN score := score + 5; END IF;
    IF v_has_ai_ethics THEN score := score + 5; END IF;
    IF v_board_ai_expertise THEN score := score + 5; END IF;
    IF v_cyber_oversight THEN score := score + 5; END IF;
    
    IF v_ai_risk_mentions IS NOT NULL AND v_ai_risk_mentions > 10 THEN
        IF NOT COALESCE(v_has_ai_ethics, FALSE) AND NOT COALESCE(v_board_ai_expertise, FALSE) THEN
            score := score - 15;
        END IF;
    END IF;
    
    IF score > 100 THEN score := 100; END IF;
    IF score < 0 THEN score := 0; END IF;
    
    RETURN score;
END;
$$ LANGUAGE plpgsql;

-- 3. Recreate the View (Now that function exists)
CREATE OR REPLACE VIEW vendor_governance.view_company_scores AS
SELECT 
    c.id,
    c.company_name,
    c.ticker_symbol,
    c.primary_sector,
    c.sub_sector,
    c.jurisdiction,
    c.ownership_archetype,
    c.patents_count,
    c.technology_tags,
    c.data_tier,
    vendor_governance.calculate_governance_score(c.id) as governance_score,
    vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) as innovation_score,
    (
        COALESCE(vendor_governance.calculate_governance_score(c.id), 50) * 0.4 + 
        vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) * 0.4 +
        (CASE WHEN c.data_tier = 1 THEN 100 ELSE 25 END) * 0.2
    )::INTEGER as deal_qualification_score,
    -- Real Data for Benchmarking (Raw Percentages/Values)
    COALESCE(rf.board_independence_pct, (bca.independent_directors::DECIMAL / NULLIF(bca.total_directors, 0)) * 100, 0)::INTEGER as "Gov: Independence",
    COALESCE(rf.board_diversity_pct, COALESCE(bca.women_percentage, 0) + COALESCE(bca.ethnic_minority_percentage, 0), 0)::INTEGER as "Gov: Diversity",
    (CASE WHEN COALESCE(rf.split_chair_ceo, NOT bca.ceo_is_board_chair) THEN 100 ELSE 0 END)::INTEGER as "Gov: Leadership", -- 100% if Split
    COALESCE(NULL::INTEGER, 0) as "Gov: Audit", -- Placeholder, now 0 instead of NULL
    COALESCE(rf.say_on_pay_support, 0)::INTEGER as "Gov: Say-on-Pay",
    COALESCE(rf.ceo_pay_ratio, 0)::INTEGER as "Gov: Pay Ratio", -- Not a %, but a ratio
    (CASE WHEN rf.has_clawback_policy THEN 100 ELSE 0 END)::INTEGER as "Gov: Clawback",
    (CASE WHEN rf.has_ai_ethics_board THEN 100 ELSE 0 END)::INTEGER as "Gov: AI Ethics",
    (CASE WHEN rf.board_ai_expertise THEN 100 ELSE 0 END)::INTEGER as "Gov: AI Expert",
    (CASE WHEN rf.cyber_oversight_explicit THEN 100 ELSE 0 END)::INTEGER as "Gov: Cyber Oversight"
FROM vendor_governance.companies c
-- 1. Risk Factors (Standard Join)
LEFT JOIN vendor_governance.company_risk_factors rf 
    ON c.id = rf.company_id AND rf.fiscal_year = 2024
-- 2. Board Composition (Optimized: Pre-calculate latest year once)
LEFT JOIN (
    SELECT DISTINCT ON (company_id) *
    FROM vendor_governance.board_composition_annual
    ORDER BY company_id, fiscal_year DESC
) bca ON c.id = bca.company_id;

-- 4. Grant Permissions
GRANT SELECT ON vendor_governance.view_company_scores TO authenticated;
GRANT SELECT ON vendor_governance.view_company_scores TO service_role;

-- 5. Force Schema Cache Reload
CREATE TABLE IF NOT EXISTS vendor_governance._cache_buster (id serial primary key);
NOTIFY pgrst, 'reload schema';
DROP TABLE IF EXISTS vendor_governance._cache_buster;
