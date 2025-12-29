-- Fix for "cannot change name of view column" error
-- We must DROP the view first because we are changing the column structure.

DROP VIEW IF EXISTS vendor_governance.view_company_scores;

CREATE VIEW vendor_governance.view_company_scores AS
SELECT 
    c.id,
    c.company_name,
    c.primary_sector,
    c.patents_count,
    c.technology_tags,
    c.data_tier,
    vendor_governance.calculate_governance_score(c.id) as governance_score,
    vendor_governance.calculate_governance_breakdown(c.id) as governance_details, -- NEW COLUMN
    vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) as innovation_score,
    (
        COALESCE(vendor_governance.calculate_governance_score(c.id), 50) * 0.4 + 
        vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) * 0.4 +
        (CASE WHEN c.data_tier = 1 THEN 100 ELSE 25 END) * 0.2
    )::INTEGER as deal_qualification_score
FROM vendor_governance.companies c;
