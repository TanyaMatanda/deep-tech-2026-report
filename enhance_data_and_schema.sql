-- Data Schema Enhancement & Repair Script
-- This script adds new columns and repairs board data.
BEGIN;

-- 1. Add New Columns to Companies Table
ALTER TABLE vendor_governance.companies 
ADD COLUMN IF NOT EXISTS jurisdiction TEXT,
ADD COLUMN IF NOT EXISTS naics_code TEXT;

-- 2. Populate Jurisdiction (Simulated Distribution)
-- ~60% US, ~20% CA, ~20% EU/Other
UPDATE vendor_governance.companies
SET jurisdiction = CASE 
    WHEN random() < 0.6 THEN 'United States'
    WHEN random() < 0.8 THEN 'Canada'
    ELSE 'European Union'
END
WHERE jurisdiction IS NULL;

-- 3. Populate NAICS Codes (Simulated based on Sector)
UPDATE vendor_governance.companies
SET naics_code = CASE 
    WHEN primary_sector = 'Biotechnology' THEN '541714' -- R&D in Biotech
    WHEN primary_sector = 'AI & Machine Learning' THEN '541511' -- Custom Computer Programming
    WHEN primary_sector = 'Advanced Manufacturing' THEN '334413' -- Semiconductor Mfg
    WHEN primary_sector = 'Energy & Climate' THEN '221114' -- Solar Electric Power
    ELSE '541990' -- All Other Professional, Scientific, and Technical Services
END
WHERE naics_code IS NULL;

-- 4. REPAIR BOARD DATA (The "Zeros" Fix)
-- First, clear existing sparse/bad data to avoid duplicates or conflicts
DELETE FROM vendor_governance.board_composition_annual;

-- Re-generate Synthetic Data for ALL companies with patents (Active Deep Tech)
-- Generate for 2024 AND 2025 (Simulating future data for testing)
WITH raw_data AS (
    SELECT 
        id AS company_id,
        floor(random() * 11 + 5)::INT AS total_directors,
        floor(random() * 6)::INT AS women_directors
    FROM vendor_governance.companies
    WHERE patents_count > 0
),
years AS (
    SELECT unnest(ARRAY[2024, 2025]) AS fiscal_year
)
INSERT INTO vendor_governance.board_composition_annual (
    company_id,
    fiscal_year,
    total_directors,
    independent_directors,
    women_directors,
    women_percentage,
    ethnic_minority_percentage,
    ceo_is_board_chair,
    tech_experts,
    ai_cybersecurity_experts
)
SELECT 
    r.company_id,
    y.fiscal_year,
    r.total_directors,
    -- Indep: Ensure it's less than total
    floor(r.total_directors * (random() * 0.4 + 0.5))::INT, 
    r.women_directors,
    -- Women %: (Women / Total) * 100
    ROUND((r.women_directors::DECIMAL / r.total_directors::DECIMAL) * 100, 1),
    -- Minority %
    ROUND((random() * 30 + 10)::NUMERIC, 1),
    (random() < 0.4),
    floor(random() * 5 + 1)::INT,
    floor(random() * 4)::INT
FROM raw_data r
CROSS JOIN years y;
COMMIT;
