-- FORCE MESSY DATA (The "Nuclear Option" - DIRECT UPDATE)
-- This script targets ALL deep tech companies (patents > 0) directly.

BEGIN;

-- 1. Force Archetype to 'Venture-Backed' (Penalty: -5)
UPDATE vendor_governance.companies
SET ownership_archetype = 'Venture-Backed'
WHERE patents_count > 0;

-- 2. Force Board Data to be "Messy"
-- Independence: 20% (Penalty: -25)
-- CEO is Chair: TRUE (Penalty: -10)
UPDATE vendor_governance.board_composition_annual
SET 
    independent_directors = GREATEST(1, FLOOR(total_directors * 0.2)), -- 20% Independence
    ceo_is_board_chair = TRUE,
    tech_experts = GREATEST(1, FLOOR(total_directors * 0.5)) -- Keep tech experts high
WHERE company_id IN (SELECT id FROM vendor_governance.companies WHERE patents_count > 0);

-- 3. Refresh Materialized View
REFRESH MATERIALIZED VIEW vendor_governance.mv_company_scores;

COMMIT;

-- 4. Refresh Materialized View to apply changes
REFRESH MATERIALIZED VIEW vendor_governance.mv_company_scores;

COMMIT;
