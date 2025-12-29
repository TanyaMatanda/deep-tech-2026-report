-- OPTIMIZE VIEW PERFORMANCE
-- Fixes "Statement Timeout" by removing N+1 queries inside the view.
-- Strategy: Use JOINs in the view + Pure Calculation Function.

-- 1. Create a "Pure" Scoring Function (No DB lookups, just math)
CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_score_pure(
    p_board_independence DECIMAL,
    p_split_chair_ceo BOOLEAN,
    p_board_diversity DECIMAL,
    p_say_on_pay DECIMAL,
    p_ceo_pay_ratio INTEGER,
    p_has_clawback BOOLEAN,
    p_has_ai_ethics BOOLEAN,
    p_board_ai_expertise BOOLEAN,
    p_cyber_oversight BOOLEAN,
    p_ai_risk_mentions INTEGER
)
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 50;
BEGIN
    IF p_board_independence IS NULL THEN RETURN NULL; END IF;
    
    -- Board Independence
    IF p_board_independence >= 80 THEN score := score + 25;
    ELSIF p_board_independence >= 70 THEN score := score + 20;
    ELSIF p_board_independence >= 60 THEN score := score + 15;
    ELSIF p_board_independence >= 50 THEN score := score + 10;
    ELSE score := score - 10; END IF;
    
    -- Leadership
    IF p_split_chair_ceo THEN score := score + 15; ELSE score := score - 5; END IF;
    
    -- Diversity
    IF p_board_diversity >= 40 THEN score := score + 15;
    ELSIF p_board_diversity >= 30 THEN score := score + 10;
    ELSIF p_board_diversity >= 20 THEN score := score + 5;
    ELSE score := score - 5; END IF;
    
    -- Say on Pay
    IF p_say_on_pay IS NOT NULL THEN
        IF p_say_on_pay >= 90 THEN score := score + 10;
        ELSIF p_say_on_pay >= 75 THEN score := score + 5;
        ELSIF p_say_on_pay < 70 THEN score := score - 10; END IF;
    END IF;
    
    -- CEO Pay Ratio
    IF p_ceo_pay_ratio IS NOT NULL THEN
        IF p_ceo_pay_ratio <= 50 THEN score := score + 10;
        ELSIF p_ceo_pay_ratio <= 150 THEN score := score + 5;
        ELSIF p_ceo_pay_ratio > 300 THEN score := score - 10; END IF;
    END IF;
    
    -- Policies
    IF p_has_clawback THEN score := score + 5; END IF;
    IF p_has_ai_ethics THEN score := score + 5; END IF;
    IF p_board_ai_expertise THEN score := score + 5; END IF;
    IF p_cyber_oversight THEN score := score + 5; END IF;
    
    -- AI Risk Penalty
    IF p_ai_risk_mentions IS NOT NULL AND p_ai_risk_mentions > 10 THEN
        IF NOT COALESCE(p_has_ai_ethics, FALSE) AND NOT COALESCE(p_board_ai_expertise, FALSE) THEN
            score := score - 15;
        END IF;
    END IF;
    
    -- Clamp
    IF score > 100 THEN score := 100; END IF;
    IF score < 0 THEN score := 0; END IF;
    
    RETURN score;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 2. Recreate View using JOINs (Set-based approach)
DROP VIEW IF EXISTS vendor_governance.view_company_scores CASCADE;

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
    
    -- Calculate Governance Score using JOINed data passed to Pure Function
    vendor_governance.calculate_governance_score_pure(
        -- Independence: Prefer Risk Factors, fallback to Board Comp
        COALESCE(rf.board_independence_pct, (bca.independent_directors::DECIMAL / NULLIF(bca.total_directors, 0)) * 100),
        -- Split Chair: Prefer Risk Factors, fallback to Board Comp
        COALESCE(rf.split_chair_ceo, NOT bca.ceo_is_board_chair),
        -- Diversity: Prefer Risk Factors, fallback to Board Comp
        COALESCE(rf.board_diversity_pct, bca.women_percentage + bca.ethnic_minority_percentage),
        
        rf.say_on_pay_support,
        rf.ceo_pay_ratio,
        rf.has_clawback_policy,
        rf.has_ai_ethics_board,
        rf.board_ai_expertise,
        rf.cyber_oversight_explicit,
        rf.ai_risk_mentions
    ) as governance_score,
    
    vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) as innovation_score,
    
    -- Deal Score Calculation (Inline for speed)
    (
        COALESCE(
            vendor_governance.calculate_governance_score_pure(
                COALESCE(rf.board_independence_pct, (bca.independent_directors::DECIMAL / NULLIF(bca.total_directors, 0)) * 100),
                COALESCE(rf.split_chair_ceo, NOT bca.ceo_is_board_chair),
                COALESCE(rf.board_diversity_pct, bca.women_percentage + bca.ethnic_minority_percentage),
                rf.say_on_pay_support, rf.ceo_pay_ratio, rf.has_clawback_policy,
                rf.has_ai_ethics_board, rf.board_ai_expertise, rf.cyber_oversight_explicit, rf.ai_risk_mentions
            ), 
        50) * 0.4 + 
        vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) * 0.4 +
        (CASE WHEN c.data_tier = 1 THEN 100 ELSE 25 END) * 0.2
    )::INTEGER as deal_qualification_score,
    
    -- Placeholders
    NULL::INTEGER as "Gov: Independence", NULL::INTEGER as "Gov: Diversity",
    NULL::INTEGER as "Gov: Leadership", NULL::INTEGER as "Gov: Audit",
    NULL::INTEGER as "Gov: Say-on-Pay", NULL::INTEGER as "Gov: Pay Ratio",
    NULL::INTEGER as "Gov: Clawback", NULL::INTEGER as "Gov: AI Ethics",
    NULL::INTEGER as "Gov: AI Expert", NULL::INTEGER as "Gov: Cyber Oversight"

FROM vendor_governance.companies c
-- Efficient JOINs instead of per-row queries
LEFT JOIN vendor_governance.company_risk_factors rf 
    ON c.id = rf.company_id AND rf.fiscal_year = 2024
LEFT JOIN LATERAL (
    SELECT * FROM vendor_governance.board_composition_annual 
    WHERE company_id = c.id 
    ORDER BY fiscal_year DESC LIMIT 1
) bca ON TRUE;

GRANT SELECT ON vendor_governance.view_company_scores TO authenticated;
GRANT SELECT ON vendor_governance.view_company_scores TO service_role;

-- Force Schema Reload
NOTIFY pgrst, 'reload schema';
