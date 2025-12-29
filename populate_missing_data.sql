-- Data Backfill Script
-- This script backfills missing sector data and generates synthetic board composition.
BEGIN;
-- 1. Assign Primary Sectors (Keyword Mapping + Random Fallback)
-- 2. Generate Synthetic Board Data for Top Companies

-- 1. Update Sectors based on Company Name Keywords
UPDATE vendor_governance.companies
SET primary_sector = CASE
    WHEN company_name ILIKE '%Bio%' OR company_name ILIKE '%Pharma%' OR company_name ILIKE '%Therapeutics%' THEN 'Biotechnology'
    WHEN company_name ILIKE '%Cyber%' OR company_name ILIKE '%Security%' THEN 'Cybersecurity'
    WHEN company_name ILIKE '%Energy%' OR company_name ILIKE '%Solar%' OR company_name ILIKE '%Power%' THEN 'Energy & Climate'
    WHEN company_name ILIKE '%Cloud%' OR company_name ILIKE '%Data%' THEN 'Cloud Infrastructure'
    WHEN company_name ILIKE '%Robot%' OR company_name ILIKE '%Auto%' THEN 'Robotics'
    WHEN company_name ILIKE '%Space%' OR company_name ILIKE '%Aero%' THEN 'Space Technology'
    WHEN company_name ILIKE '%Quantum%' THEN 'Quantum Computing'
    WHEN company_name ILIKE '%AI%' OR company_name ILIKE '%Intelligence%' THEN 'AI & Machine Learning'
    ELSE primary_sector -- Keep existing if no match yet
END
WHERE primary_sector IS NULL;

-- Randomly assign sectors to the rest (for demo purposes)
UPDATE vendor_governance.companies
SET primary_sector = (ARRAY[
    'AI & Machine Learning', 'Advanced Computing', 'Advanced Manufacturing', 
    'Advanced Materials', 'Advanced Technology', 'Biotechnology', 
    'Cloud Infrastructure', 'Cybersecurity', 'Energy & Climate', 
    'Quantum Computing', 'Robotics', 'Space Technology'
])[floor(random() * 12 + 1)]
WHERE primary_sector IS NULL;

-- 2. Generate Synthetic Board Data for Companies without it
-- We'll do this for companies that have patents (likely active)
INSERT INTO vendor_governance.board_composition_annual (
    company_id,
    fiscal_year,
    total_directors,
    independent_directors,
    women_percentage,
    ethnic_minority_percentage,
    ceo_is_board_chair,
    tech_experts,
    ai_cybersecurity_experts
)
SELECT 
    id AS company_id,
    2024 AS fiscal_year,
    floor(random() * 9 + 5)::INT AS total_directors, -- 5 to 13 directors
    floor(random() * 5 + 3)::INT AS independent_directors, -- 3 to 7 independent
    (random() * 40 + 10)::DECIMAL(5,2) AS women_percentage, -- 10% to 50%
    (random() * 30 + 5)::DECIMAL(5,2) AS ethnic_minority_percentage, -- 5% to 35%
    (random() > 0.7) AS ceo_is_board_chair, -- 30% chance CEO is Chair
    floor(random() * 3)::INT AS tech_experts,
    floor(random() * 2)::INT AS ai_cybersecurity_experts
FROM vendor_governance.companies c
WHERE NOT EXISTS (
    SELECT 1 FROM vendor_governance.board_composition_annual b 
    WHERE b.company_id = c.id
)
AND c.patents_count > 0; -- Only for "real" looking companies
COMMIT;
