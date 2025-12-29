-- Phase 12: Governance Reality Check (The "Matanda Adjustment")

-- 1. Add Ownership Archetype Column
ALTER TABLE vendor_governance.companies 
ADD COLUMN IF NOT EXISTS ownership_archetype TEXT;

-- 2. Populate Archetypes (Simulated Distribution)
-- Venture (~45%), Spinout (~25%), Megacap (~20%), Public (~10%)
UPDATE vendor_governance.companies
SET ownership_archetype = CASE 
    WHEN random() < 0.45 THEN 'Venture-Backed'
    WHEN random() < 0.70 THEN 'Academic Spinout' -- 0.45 + 0.25
    WHEN random() < 0.90 THEN 'Megacap Subsidiary' -- 0.70 + 0.20
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
    
    -- Independence Logic
    CASE 
        WHEN r.ownership_archetype = 'Venture-Backed' THEN floor(r.total_directors * (random() * 0.2 + 0.2))::INT -- 20-40% (Low)
        WHEN r.ownership_archetype = 'Academic Spinout' THEN floor(r.total_directors * (random() * 0.2 + 0.3))::INT -- 30-50% (Low-Med)
        WHEN r.ownership_archetype = 'Megacap Subsidiary' THEN floor(r.total_directors * (random() * 0.2 + 0.7))::INT -- 70-90% (High - Corporate)
        ELSE floor(r.total_directors * (random() * 0.3 + 0.5))::INT -- 50-80% (Public)
    END AS independent_directors,
    
    -- Women Directors (Megacaps/Public have more)
    CASE 
        WHEN r.ownership_archetype IN ('Megacap Subsidiary', 'Public Pure-Play') THEN floor(random() * 4 + 2)::INT -- 2-5
        ELSE floor(random() * 2)::INT -- 0-1 (Venture/Spinout often low)
    END AS women_directors,
    
    -- Women % (Calculated)
    NULL, -- Placeholder, calculated below in UPDATE or we can do it here if we use a subquery. 
    -- Let's just use a simple calculation here assuming non-zero total
    -- We'll fix it in a second pass or just use the logic:
    -- ROUND((women_directors / total_directors) * 100, 1)
    -- But we can't reference the alias. So we'll update it after insert or use a smarter query.
    -- Let's use 0 for now and UPDATE immediately.
    0,
    
    -- Minority %
    ROUND((random() * 30 + 5)::NUMERIC, 1),
    
    -- CEO Chair (Common in Venture/Spinout)
    CASE 
        WHEN r.ownership_archetype IN ('Venture-Backed', 'Academic Spinout') THEN (random() < 0.8) -- 80% chance
        ELSE (random() < 0.4) -- 40% chance (Public/Megacap often separate)
    END,
    
    -- Tech Experts (High in Spinout/Venture, Low in Megacap Board)
    CASE 
        WHEN r.ownership_archetype = 'Academic Spinout' THEN floor(random() * 3 + 3)::INT -- 3-5
        WHEN r.ownership_archetype = 'Venture-Backed' THEN floor(random() * 3 + 2)::INT -- 2-4
        WHEN r.ownership_archetype = 'Megacap Subsidiary' THEN floor(random() * 2)::INT -- 0-1 (Diluted)
        ELSE floor(random() * 3 + 1)::INT -- 1-3
    END,
    
    -- AI/Cyber Experts (Generally Low)
    floor(random() * 2)::INT
FROM raw_data r
CROSS JOIN years y;

-- Fix Women Percentage
UPDATE vendor_governance.board_composition_annual
SET women_percentage = ROUND((women_directors::DECIMAL / NULLIF(total_directors, 0)::DECIMAL) * 100, 1);

-- 4. UPDATE SCORING FUNCTION (Penalty Logic)
CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_score(p_company_id UUID, p_year INTEGER DEFAULT NULL)
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 100;
    v_total_directors INTEGER;
    v_ind_directors INTEGER;
    v_ceo_chair BOOLEAN;
    v_women_pct DECIMAL;
    v_minority_pct DECIMAL;
    v_archetype TEXT;
BEGIN
    -- Fetch data
    SELECT 
        b.total_directors, 
        b.independent_directors, 
        b.ceo_is_board_chair, 
        b.women_percentage, 
        b.ethnic_minority_percentage,
        c.ownership_archetype
    INTO 
        v_total_directors, 
        v_ind_directors, 
        v_ceo_chair, 
        v_women_pct, 
        v_minority_pct,
        v_archetype
    FROM vendor_governance.board_composition_annual b
    JOIN vendor_governance.companies c ON b.company_id = c.id
    WHERE b.company_id = p_company_id
      AND (p_year IS NULL OR b.fiscal_year = p_year)
    ORDER BY b.fiscal_year DESC
    LIMIT 1;

    IF v_total_directors IS NULL THEN RETURN NULL; END IF;

    -- 1. Independence Deductions (Stricter)
    IF (v_ind_directors::DECIMAL / NULLIF(v_total_directors, 0)) < 0.5 THEN
        score := score - 25; -- Increased penalty (was 15)
    END IF;

    -- 2. Leadership Deductions
    IF v_ceo_chair THEN
        score := score - 10; -- Increased penalty (was 5)
    END IF;

    -- 3. Archetype Specific Adjustments (The "Matanda Adjustment")
    IF v_archetype = 'Venture-Backed' THEN
        score := score - 5; -- Structural penalty for investor dominance
    ELSIF v_archetype = 'Academic Spinout' THEN
        score := score - 5; -- Structural penalty for dual-role conflicts
    ELSIF v_archetype = 'Megacap Subsidiary' THEN
        score := score + 10; -- Bonus for parent corp maturity (Compliance/Audit)
    END IF;

    -- 4. Diversity Bonus (Harder to get)
    IF (COALESCE(v_women_pct, 0) + COALESCE(v_minority_pct, 0)) > 40 THEN -- Was 30
        score := score + 5;
    END IF;

    -- Clamp
    IF score > 100 THEN score := 100; END IF;
    IF score < 0 THEN score := 0; END IF;

    RETURN score;
END;
$$ LANGUAGE plpgsql;
