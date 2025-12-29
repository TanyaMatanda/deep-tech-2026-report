-- FIX DATA QUALITY: Normalization & Diversity

-- 1. Normalize Ownership Percentages to 100%
-- This fixes the "101.8%" issue by scaling all values down to sum to 100.
UPDATE vendor_governance.ownership_structure
SET 
    founder_pct = (founder_pct / total_pct) * 100,
    vc_pct = (vc_pct / total_pct) * 100,
    institutional_pct = (institutional_pct / total_pct) * 100,
    public_float_pct = (public_float_pct / total_pct) * 100,
    strategic_corp_pct = (strategic_corp_pct / total_pct) * 100,
    govt_univ_pct = (govt_univ_pct / total_pct) * 100,
    employee_other_pct = (employee_other_pct / total_pct) * 100
FROM (
    SELECT company_id, fiscal_year, 
           (founder_pct + vc_pct + institutional_pct + public_float_pct + strategic_corp_pct + govt_univ_pct + employee_other_pct) as total_pct
    FROM vendor_governance.ownership_structure
) as sub
WHERE vendor_governance.ownership_structure.company_id = sub.company_id 
  AND vendor_governance.ownership_structure.fiscal_year = sub.fiscal_year
  AND sub.total_pct > 0
  AND sub.total_pct != 100;

-- 2. Diversify Jurisdictions (Fix "All USA" issue)
-- Assign ~10% to Canada and ~5% to Mexico based on random hash
UPDATE vendor_governance.companies
SET jurisdiction = CASE 
    WHEN (hashtext(company_name) % 100) < 10 THEN 'Canada'
    WHEN (hashtext(company_name) % 100) < 15 THEN 'Mexico'
    ELSE 'USA'
END
WHERE jurisdiction = 'USA'; -- Only update those we defaulted earlier

-- 3. Refresh Materialized View to reflect changes
REFRESH MATERIALIZED VIEW vendor_governance.mv_company_scores;
