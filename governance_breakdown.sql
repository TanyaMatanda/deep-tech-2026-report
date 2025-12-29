-- Function to return detailed governance score breakdown
-- UPDATED: Matches "Matanda Adjustment" logic in update_scoring_year.sql

BEGIN;

CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_breakdown(p_company_id UUID)
RETURNS JSONB AS $$
DECLARE
    score INTEGER := 100;
    v_total_directors INTEGER;
    v_ind_directors INTEGER;
    v_ceo_chair BOOLEAN;
    v_women_pct DECIMAL;
    v_minority_pct DECIMAL;
    v_tech_experts INTEGER;
    v_archetype TEXT;
    v_sector TEXT;
    v_non_ind_audit_members INTEGER;
    v_certified_directors INTEGER;
    
    -- Component scores (Delta values)
    c_independence INTEGER := 0;
    c_leadership INTEGER := 0;
    c_audit INTEGER := 0;
    c_archetype INTEGER := 0;
    c_innovation INTEGER := 0;
    c_diversity INTEGER := 0;
    c_policy INTEGER := 0;
    c_education INTEGER := 0;
BEGIN
    -- Fetch latest board data
    SELECT 
        b.total_directors, 
        b.independent_directors, 
        b.ceo_is_board_chair, 
        b.women_percentage, 
        b.ethnic_minority_percentage,
        b.tech_experts,
        c.ownership_archetype,
        c.primary_sector
    INTO 
        v_total_directors, 
        v_ind_directors, 
        v_ceo_chair, 
        v_women_pct, 
        v_minority_pct,
        v_tech_experts,
        v_archetype,
        v_sector
    FROM vendor_governance.board_composition_annual b
    JOIN vendor_governance.companies c ON b.company_id = c.id
    WHERE b.company_id = p_company_id
    ORDER BY b.fiscal_year DESC
    LIMIT 1;

    -- If no data, return null object
    IF v_total_directors IS NULL THEN
        RETURN jsonb_build_object('error', 'No data');
    END IF;

    -- 1. Independence Deductions (Stricter: -25)
    IF (v_ind_directors::DECIMAL / NULLIF(v_total_directors, 0)) < 0.5 THEN
        c_independence := -25;
        score := score - 25;
    END IF;

    -- 2. Leadership Deductions (Stricter: -10)
    IF v_ceo_chair THEN
        c_leadership := -10;
        score := score - 10;
    END IF;

    -- 3. Committee Independence Check (Critical: -20)
    SELECT COUNT(*) INTO v_non_ind_audit_members
    FROM vendor_governance.board_committees
    WHERE company_id = p_company_id 
      AND committee_name = 'Audit' 
      AND is_independent = FALSE;
      
    IF v_non_ind_audit_members > 0 THEN
        c_audit := -20;
        score := score - 20;
    END IF;
    
    -- 4. Archetype Adjustments
    IF v_archetype = 'Venture-Backed' THEN
        c_archetype := -5;
        score := score - 5;
    ELSIF v_archetype = 'Academic Spinout' THEN
        c_archetype := -5;
        score := score - 5;
    ELSIF v_archetype = 'Megacap Subsidiary' THEN
        c_archetype := 10;
        score := score + 10;
    END IF;

    -- 5. Innovation Expertise (Board Tech Experts)
    IF (v_tech_experts::DECIMAL / NULLIF(v_total_directors, 0)) > 0.2 THEN
        c_innovation := 5;
        score := score + 5;
    END IF;

    -- 6. Diversity Bonus (Higher Threshold: >40%)
    IF (COALESCE(v_women_pct, 0) + COALESCE(v_minority_pct, 0)) > 40 THEN
        c_diversity := 5;
        score := score + 5;
    END IF;
    
    -- 7. Policy Checks (AI Ethics)
    IF v_sector IN ('AI & Machine Learning', 'Robotics', 'Biotechnology') THEN
        -- If score is already low (<60), assume missing policy -> Extra Penalty
        -- Note: We use the current running score for this check
        IF score < 60 THEN
            c_policy := -10;
            score := score - 10;
        END IF;
    END IF;

    -- 8. Education Bonus
    SELECT COUNT(DISTINCT cp.person_id) INTO v_certified_directors
    FROM vendor_governance.director_education de
    JOIN vendor_governance.company_people cp ON de.person_id = cp.person_id
    WHERE cp.company_id = p_company_id AND cp.is_board_member = TRUE;

    IF v_certified_directors > 0 THEN
        c_education := 5;
        score := score + 5;
    END IF;

    -- Clamp score
    IF score > 100 THEN score := 100; END IF;
    IF score < 0 THEN score := 0; END IF;

    RETURN jsonb_build_object(
        'total_score', score,
        'independence', c_independence,
        'leadership', c_leadership,
        'audit_integrity', c_audit,
        'archetype_adj', c_archetype,
        'innovation_exp', c_innovation,
        'diversity', c_diversity,
        'ai_policy_risk', c_policy,
        'education', c_education
    );
END;
$$ LANGUAGE plpgsql;

-- No need to recreate the view if the function signature hasn't changed, 
-- but refreshing the materialized view is crucial.
COMMIT;
