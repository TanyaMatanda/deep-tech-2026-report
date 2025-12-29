-- ENHANCE TRANSPARENCY: Add Reasons to Scoring Breakdown

CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_breakdown(p_company_id UUID)
RETURNS JSONB AS $$
DECLARE
    score INTEGER := 100;
    v_total_directors INTEGER;
    v_ind_directors INTEGER;
    v_ceo_chair BOOLEAN;
    v_women_pct DECIMAL;
    v_minority_pct DECIMAL;
    v_non_ind_audit_members INTEGER;
    v_certified_directors INTEGER;
    v_archetype TEXT;
    
    -- Component scores & Reasons
    c_independence INTEGER := 0;
    r_independence TEXT := 'OK';
    
    c_leadership INTEGER := 0;
    r_leadership TEXT := 'Split Role (OK)';
    
    c_audit INTEGER := 0;
    r_audit TEXT := 'Fully Independent (OK)';
    
    c_diversity INTEGER := 0;
    r_diversity TEXT := 'Standard';
    
    c_education INTEGER := 0;
    r_education TEXT := 'None';
    
    c_archetype INTEGER := 0;
    r_archetype TEXT := 'Standard';
BEGIN
    -- Fetch latest board data
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
    ORDER BY b.fiscal_year DESC
    LIMIT 1;

    -- If no data, return null object
    IF v_total_directors IS NULL THEN
        RETURN jsonb_build_object('error', 'No data');
    END IF;

    -- 1. Independence Deductions
    IF (v_ind_directors::DECIMAL / NULLIF(v_total_directors, 0)) < 0.5 THEN
        c_independence := -25; -- Matches main scoring function
        r_independence := 'Low Independence (<50%)';
        score := score - 25;
    END IF;

    -- 2. Leadership Deductions
    IF v_ceo_chair THEN
        c_leadership := -10; -- Matches main scoring function
        r_leadership := 'CEO is Chair';
        score := score - 10;
    END IF;
    
    -- 3. Archetype Adjustments (New)
    IF v_archetype = 'Venture-Backed' THEN
        c_archetype := -5;
        r_archetype := 'Venture Control Penalty';
        score := score - 5;
    ELSIF v_archetype = 'Academic Spinout' THEN
        c_archetype := -5;
        r_archetype := 'Academic Conflict Risk';
        score := score - 5;
    ELSIF v_archetype = 'Megacap Subsidiary' THEN
        c_archetype := 10;
        r_archetype := 'Parent Corp Oversight Bonus';
        score := score + 10;
    END IF;

    -- 4. Audit Committee Check (Simplified for now as we don't have full committee data populated for everyone)
    -- Keeping logic but acknowledging data might be sparse
    SELECT COUNT(*) INTO v_non_ind_audit_members
    FROM vendor_governance.board_committees
    WHERE company_id = p_company_id 
      AND committee_name = 'Audit' 
      AND is_independent = FALSE;
      
    IF v_non_ind_audit_members > 0 THEN
        c_audit := -20;
        r_audit := 'Non-Independent Audit Member';
        score := score - 20;
    END IF;

    -- 5. Diversity Bonus
    IF (COALESCE(v_women_pct, 0) + COALESCE(v_minority_pct, 0)) > 40 THEN
        c_diversity := 5;
        r_diversity := 'High Diversity (>40%)';
        score := score + 5;
    END IF;

    -- 6. Education Bonus
    SELECT COUNT(DISTINCT cp.person_id) INTO v_certified_directors
    FROM vendor_governance.director_education de
    JOIN vendor_governance.company_people cp ON de.person_id = cp.person_id
    WHERE cp.company_id = p_company_id AND cp.is_board_member = TRUE;

    IF v_certified_directors > 0 THEN
        c_education := 5;
        r_education := 'Certified Director on Board';
        score := score + 5;
    END IF;

    -- Clamp score
    IF score > 100 THEN score := 100; END IF;
    IF score < 0 THEN score := 0; END IF;

    RETURN jsonb_build_object(
        'total_score', score,
        'independence', c_independence,
        'independence_reason', r_independence,
        'leadership', c_leadership,
        'leadership_reason', r_leadership,
        'archetype', c_archetype,
        'archetype_reason', r_archetype,
        'audit_integrity', c_audit,
        'audit_reason', r_audit,
        'diversity', c_diversity,
        'diversity_reason', r_diversity,
        'education', c_education,
        'education_reason', r_education,
        'women_pct', COALESCE(v_women_pct, 0), -- NEW: Raw Data
        'minority_pct', COALESCE(v_minority_pct, 0) -- NEW: Raw Data
    );
END;
$$ LANGUAGE plpgsql;

-- Refresh the Materialized View to pick up the new JSON structure
REFRESH MATERIALIZED VIEW vendor_governance.mv_company_scores;
