-- Apply Data Reality Check (The "Matanda Adjustment" Data)
-- This script populates ownership archetypes and regenerates board data with realistic "messiness".
-- It does NOT overwrite the scoring function.

BEGIN;

-- 1. Add Ownership Archetype Column (if not exists)
ALTER TABLE vendor_governance.companies 
ADD COLUMN IF NOT EXISTS ownership_archetype TEXT;

-- 2. Populate Archetypes (Simulated Distribution)
-- Venture (~45%), Spinout (~25%), Megacap (~20%), Public (~10%)
UPDATE vendor_governance.companies
SET ownership_archetype = CASE 
    WHEN random() < 0.45 THEN 'Venture-Backed'
    WHEN random() < 0.70 THEN 'Academic Spinout'
    WHEN random() < 0.90 THEN 'Megacap Subsidiary'
    ELSE 'Public Pure-Play'
END
WHERE ownership_archetype IS NULL;

-- 3. RE-GENERATE BOARD DATA (Recalibrated)
DELETE FROM vendor_governance.board_composition_annual;

WITH raw_data AS (
    SELECT 
        id AS company_id,
        ownership_archetype,
        -- Board Size Logic
        CASE 
            WHEN ownership_archetype = 'Venture-Backed' THEN floor(random() * 3 + 5)::INT -- 5-7
            WHEN ownership_archetype = 'Academic Spinout' THEN floor(random() * 5 + 5)::INT -- 5-9
            WHEN ownership_archetype = 'Megacap Subsidiary' THEN floor(random() * 5 + 11)::INT -- 11-15 (Parent Board)
            ELSE floor(random() * 5 + 7)::INT -- 7-11 (Public Pure-Play)
        END AS total_directors
    FROM vendor_governance.companies
    WHERE patents_count > 0 -- Only generate for active deep tech
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
    
    -- Independence Logic (The "Messy" Part)
    CASE 
        WHEN r.ownership_archetype = 'Venture-Backed' THEN floor(r.total_directors * (random() * 0.2 + 0.2))::INT -- 20-40% (Low)
        WHEN r.ownership_archetype = 'Academic Spinout' THEN floor(r.total_directors * (random() * 0.2 + 0.3))::INT -- 30-50% (Low-Med)
        WHEN r.ownership_archetype = 'Megacap Subsidiary' THEN floor(r.total_directors * (random() * 0.2 + 0.7))::INT -- 70-90% (High)
        ELSE floor(r.total_directors * (random() * 0.3 + 0.5))::INT -- 50-80% (Public)
    END AS independent_directors,
    
    -- Women Directors
    CASE 
        WHEN r.ownership_archetype IN ('Megacap Subsidiary', 'Public Pure-Play') THEN floor(random() * 4 + 2)::INT -- 2-5
        ELSE floor(random() * 2)::INT -- 0-1 (Venture/Spinout often low)
    END AS women_directors,
    
    -- Women % (Placeholder, updated below)
    0,
    
    -- Minority %
    ROUND((random() * 30 + 5)::NUMERIC, 1),
    
    -- CEO Chair (Common in Venture/Spinout)
    CASE 
        WHEN r.ownership_archetype IN ('Venture-Backed', 'Academic Spinout') THEN (random() < 0.8) -- 80% chance
        ELSE (random() < 0.4) -- 40% chance
    END,
    
    -- Tech Experts (High in Spinout/Venture)
    CASE 
        WHEN r.ownership_archetype = 'Academic Spinout' THEN floor(random() * 3 + 3)::INT -- 3-5
        WHEN r.ownership_archetype = 'Venture-Backed' THEN floor(random() * 3 + 2)::INT -- 2-4
        WHEN r.ownership_archetype = 'Megacap Subsidiary' THEN floor(random() * 2)::INT -- 0-1
        ELSE floor(random() * 3 + 1)::INT -- 1-3
    END,
    
    -- AI/Cyber Experts
    floor(random() * 2)::INT
FROM raw_data r
CROSS JOIN years y;

-- Fix Women Percentage
UPDATE vendor_governance.board_composition_annual
SET women_percentage = ROUND((women_directors::DECIMAL / NULLIF(total_directors, 0)::DECIMAL) * 100, 1);

COMMIT;
