-- Verify Scoring Logic
-- This script calculates scores for a few sample companies to verify the new logic.

BEGIN;

-- 1. Create a temporary function to print debug info (simulated via SELECT)
WITH sample_companies AS (
    SELECT 
        c.id, 
        c.company_name, 
        c.ownership_archetype, 
        c.primary_sector,
        b.total_directors,
        b.independent_directors,
        b.ceo_is_board_chair,
        b.tech_experts,
        (b.women_percentage + b.ethnic_minority_percentage) as diversity_total,
        vendor_governance.calculate_governance_score(c.id) as new_score
    FROM vendor_governance.companies c
    JOIN vendor_governance.board_composition_annual b ON c.id = b.company_id
    WHERE b.fiscal_year = 2024
    LIMIT 10
)
SELECT * FROM sample_companies;

ROLLBACK; -- Don't actually change anything
