-- Fix for ambiguous column reference in calculate_governance_score

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
    -- FIXED: Specify cp.person_id to avoid ambiguity
    SELECT COUNT(DISTINCT cp.person_id) INTO v_certified_directors
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
