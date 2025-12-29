-- ============================================
-- ENHANCED GOVERNANCE SCHEMA
-- ============================================

-- 1. Board Committees
CREATE TABLE IF NOT EXISTS vendor_governance.board_committees (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID REFERENCES vendor_governance.companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES vendor_governance.people(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    committee_name VARCHAR(100) NOT NULL, -- Audit, Compensation, Nominating, Risk, AI Oversight
    role VARCHAR(50) DEFAULT 'Member', -- Chair, Member, Observer
    is_independent BOOLEAN DEFAULT TRUE,
    
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(company_id, person_id, committee_name, fiscal_year)
);

-- 2. Director Education & Certifications
CREATE TABLE IF NOT EXISTS vendor_governance.director_education (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID REFERENCES vendor_governance.people(id) ON DELETE CASCADE,
    
    certification_name VARCHAR(255) NOT NULL, -- e.g. "NACD Directorship Certification", "AI Governance"
    issuing_body VARCHAR(255), -- NACD, Harvard, Stanford, Diligent
    date_earned DATE,
    expiration_date DATE,
    
    created_at TIMESTAMP DEFAULT NOW()
);

-- 3. Board Interlocks View
-- Identifies directors sitting on multiple boards in our dataset
CREATE OR REPLACE VIEW vendor_governance.view_board_interlocks AS
SELECT 
    p.full_name,
    cp1.company_id as company_a_id,
    c1.company_name as company_a_name,
    cp2.company_id as company_b_id,
    c2.company_name as company_b_name
FROM vendor_governance.company_people cp1
JOIN vendor_governance.company_people cp2 ON cp1.person_id = cp2.person_id AND cp1.company_id < cp2.company_id
JOIN vendor_governance.people p ON cp1.person_id = p.id
JOIN vendor_governance.companies c1 ON cp1.company_id = c1.id
JOIN vendor_governance.companies c2 ON cp2.company_id = c2.id
WHERE cp1.is_board_member = TRUE 
  AND cp2.is_board_member = TRUE
  AND cp1.is_current = TRUE
  AND cp2.is_current = TRUE;

-- ============================================
-- UPDATED SCORING FUNCTION
-- ============================================

CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_score(p_company_id UUID)
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 100;
    v_total_directors INTEGER;
    v_ind_directors INTEGER;
    v_ceo_chair BOOLEAN;
    v_women_pct DECIMAL;
    v_minority_pct DECIMAL;
    v_non_ind_audit_members INTEGER;
    v_certified_directors INTEGER;
BEGIN
    -- Fetch latest board data
    SELECT 
        total_directors, 
        independent_directors, 
        ceo_is_board_chair, 
        women_percentage, 
        ethnic_minority_percentage
    INTO 
        v_total_directors, 
        v_ind_directors, 
        v_ceo_chair, 
        v_women_pct, 
        v_minority_pct
    FROM vendor_governance.board_composition_annual
    WHERE company_id = p_company_id
    ORDER BY fiscal_year DESC
    LIMIT 1;

    -- If no data, return NULL
    IF v_total_directors IS NULL THEN
        RETURN NULL;
    END IF;

    -- 1. Independence Deductions
    IF (v_ind_directors::DECIMAL / NULLIF(v_total_directors, 0)) < 0.5 THEN
        score := score - 15;
    END IF;

    -- 2. Leadership Deductions
    IF v_ceo_chair THEN
        score := score - 5;
    END IF;

    -- 3. Committee Independence Check (Audit Committee MUST be 100% independent)
    SELECT COUNT(*) INTO v_non_ind_audit_members
    FROM vendor_governance.board_committees
    WHERE company_id = p_company_id 
      AND committee_name = 'Audit' 
      AND is_independent = FALSE;
      
    IF v_non_ind_audit_members > 0 THEN
        score := score - 20; -- Major Red Flag
    END IF;

    -- 4. Diversity Bonus
    IF (COALESCE(v_women_pct, 0) + COALESCE(v_minority_pct, 0)) > 30 THEN
        score := score + 5;
    END IF;

    -- 5. Education Bonus (New)
    SELECT COUNT(DISTINCT person_id) INTO v_certified_directors
    FROM vendor_governance.director_education de
    JOIN vendor_governance.company_people cp ON de.person_id = cp.person_id
    WHERE cp.company_id = p_company_id AND cp.is_board_member = TRUE;

    IF v_certified_directors > 0 THEN
        score := score + 5;
    END IF;

    -- Clamp score 0-100
    IF score > 100 THEN score := 100; END IF;
    IF score < 0 THEN score := 0; END IF;

    RETURN score;
END;
$$ LANGUAGE plpgsql;
