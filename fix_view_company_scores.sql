-- Recreate view_company_scores as a direct view to ensure all companies are included
-- This removes dependency on potentially stale materialized views

DROP VIEW IF EXISTS vendor_governance.view_company_scores CASCADE;
DROP MATERIALIZED VIEW IF EXISTS vendor_governance.mv_company_scores CASCADE;

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
    -- Calculate scores dynamically
    vendor_governance.calculate_governance_score(c.id) as governance_score,
    vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) as innovation_score,
    
    -- Composite Deal Qualification Score
    (
        COALESCE(vendor_governance.calculate_governance_score(c.id), 50) * 0.4 + 
        vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) * 0.4 +
        (CASE WHEN c.data_tier = 1 THEN 100 ELSE 25 END) * 0.2
    )::INTEGER as deal_qualification_score,
    
    -- Placeholder columns for UI compatibility (until we have real data for them)
    NULL::INTEGER as "Gov: Independence",
    NULL::INTEGER as "Gov: Diversity",
    NULL::INTEGER as "Gov: Leadership",
    NULL::INTEGER as "Gov: Audit",
    NULL::INTEGER as "Gov: Say-on-Pay",
    NULL::INTEGER as "Gov: Pay Ratio",
    NULL::INTEGER as "Gov: Clawback",
    NULL::INTEGER as "Gov: AI Ethics",
    NULL::INTEGER as "Gov: AI Expert",
    NULL::INTEGER as "Gov: Cyber Oversight"

FROM vendor_governance.companies c;

GRANT SELECT ON vendor_governance.view_company_scores TO authenticated;
GRANT SELECT ON vendor_governance.view_company_scores TO service_role;

COMMENT ON VIEW vendor_governance.view_company_scores IS 'Master view of companies with dynamically calculated scores. Direct view to ensure real-time data accuracy.';
