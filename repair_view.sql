-- Repair View: view_company_scores
-- The view likely became invalid when the underlying function signature changed.
-- We drop and recreate it to link to the updated calculate_governance_score function.

DROP VIEW IF EXISTS vendor_governance.view_company_scores;

CREATE OR REPLACE VIEW vendor_governance.view_company_scores AS
SELECT 
    c.id,
    c.company_name,
    c.primary_sector,
    c.patents_count,
    c.technology_tags,
    c.data_tier,
    c.jurisdiction, -- Added in Phase 11
    c.naics_code,   -- Added in Phase 11
    c.ownership_archetype, -- Added in Phase 12
    -- Call function with default year (NULL = Latest)
    vendor_governance.calculate_governance_score(c.id) as governance_score,
    vendor_governance.calculate_governance_breakdown(c.id) as governance_details,
    vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) as innovation_score,
    (
        COALESCE(vendor_governance.calculate_governance_score(c.id), 50) * 0.4 + 
        vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) * 0.4 +
        (CASE WHEN c.data_tier = 1 THEN 100 ELSE 25 END) * 0.2
    )::INTEGER as deal_qualification_score
FROM vendor_governance.companies c;
