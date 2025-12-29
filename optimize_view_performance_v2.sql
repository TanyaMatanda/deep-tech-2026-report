-- OPTIMIZE VIEW PERFORMANCE V2
-- Replaces LATERAL JOIN with DISTINCT ON for massive speedup on 95k rows.

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
    
    -- Calculate Governance Score
    vendor_governance.calculate_governance_score_pure(
        COALESCE(rf.board_independence_pct, (bca.independent_directors::DECIMAL / NULLIF(bca.total_directors, 0)) * 100),
        COALESCE(rf.split_chair_ceo, NOT bca.ceo_is_board_chair),
        COALESCE(rf.board_diversity_pct, bca.women_percentage + bca.ethnic_minority_percentage),
        rf.say_on_pay_support, rf.ceo_pay_ratio, rf.has_clawback_policy,
        rf.has_ai_ethics_board, rf.board_ai_expertise, rf.cyber_oversight_explicit, rf.ai_risk_mentions
    ) as governance_score,
    
    vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) as innovation_score,
    
    -- Deal Score
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
-- 1. Risk Factors (Standard Join)
LEFT JOIN vendor_governance.company_risk_factors rf 
    ON c.id = rf.company_id AND rf.fiscal_year = 2024
-- 2. Board Composition (Optimized: Pre-calculate latest year once)
LEFT JOIN (
    SELECT DISTINCT ON (company_id) *
    FROM vendor_governance.board_composition_annual
    ORDER BY company_id, fiscal_year DESC
) bca ON c.id = bca.company_id;

GRANT SELECT ON vendor_governance.view_company_scores TO authenticated;
GRANT SELECT ON vendor_governance.view_company_scores TO service_role;

-- Force Schema Reload
NOTIFY pgrst, 'reload schema';
