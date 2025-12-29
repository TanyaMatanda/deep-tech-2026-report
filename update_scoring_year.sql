-- Update Scoring Function to Support Year Filtering
-- This script updates the scoring function to allow optional year filtering.
BEGIN;
CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_score(p_company_id UUID, p_year INTEGER DEFAULT NULL)
RETURNS INTEGER AS $$
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
    v_has_ai_policy BOOLEAN;
BEGIN
    -- Fetch board data and company details
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
      AND (p_year IS NULL OR b.fiscal_year = p_year)
    ORDER BY b.fiscal_year DESC
    LIMIT 1;

    -- If no data, return NULL
    IF v_total_directors IS NULL THEN
        RETURN NULL;
    END IF;

    -- ==================================================================
    -- 1. CORE GOVERNANCE (The "Matanda Adjustment")
    -- ==================================================================

    -- A. Independence Deductions (Stricter: -25)
    IF (v_ind_directors::DECIMAL / NULLIF(v_total_directors, 0)) < 0.5 THEN
        score := score - 25; 
    END IF;

    -- B. Leadership Deductions (Stricter: -10)
    IF v_ceo_chair THEN
        score := score - 10;
    END IF;

    -- C. Audit Committee Independence (Critical: -20)
    SELECT COUNT(*) INTO v_non_ind_audit_members
    FROM vendor_governance.board_committees
    WHERE company_id = p_company_id 
      AND committee_name = 'Audit' 
      AND is_independent = FALSE;
      
    IF v_non_ind_audit_members > 0 THEN
        score := score - 20;
    END IF;

    -- D. Archetype Specific Adjustments
    IF v_archetype = 'Venture-Backed' THEN
        score := score - 5; -- Structural penalty for investor dominance
    ELSIF v_archetype = 'Academic Spinout' THEN
        score := score - 5; -- Structural penalty for dual-role conflicts
    ELSIF v_archetype = 'Megacap Subsidiary' THEN
        score := score + 10; -- Bonus for parent corp maturity
    END IF;

    -- ==================================================================
    -- 2. RESILIENCE FRAMEWORK COMPONENTS
    -- ==================================================================

    -- A. Innovation Expertise (Board Tech Experts)
    -- Bonus if > 20% of board has tech expertise
    IF (v_tech_experts::DECIMAL / NULLIF(v_total_directors, 0)) > 0.2 THEN
        score := score + 5;
    END IF;

    -- B. Diversity Bonus (Higher Threshold: >40%)
    IF (COALESCE(v_women_pct, 0) + COALESCE(v_minority_pct, 0)) > 40 THEN
        score := score + 5;
    END IF;

    -- C. Policy Checks (Simulated: AI Ethics Policy)
    -- Check engagement flags view or simulate based on score/sector
    -- For now, we simulate: High Governance companies likely have it.
    -- Penalty if missing in high-risk sectors.
    IF v_sector IN ('AI & Machine Learning', 'Robotics', 'Biotechnology') THEN
        -- If score is already low (<60), assume missing policy -> Extra Penalty
        IF score < 60 THEN
            score := score - 10; -- "AI-ESG Risk" Penalty
        END IF;
    END IF;

    -- D. Education Bonus
    SELECT COUNT(DISTINCT cp.person_id) INTO v_certified_directors
    FROM vendor_governance.director_education de
    JOIN vendor_governance.company_people cp ON de.person_id = cp.person_id
    WHERE cp.company_id = p_company_id AND cp.is_board_member = TRUE;

    IF v_certified_directors > 0 THEN
        score := score + 5;
    END IF;

    -- E. Compensation Alignment (New)
    -- 1. Say-on-Pay Support (<70% is a red flag)
    IF (SELECT say_on_pay_support FROM vendor_governance.companies WHERE id = p_company_id) < 70 THEN
        score := score - 10;
    END IF;

    -- 2. Clawback Policy (Bonus)
    IF (SELECT has_clawback_policy FROM vendor_governance.companies WHERE id = p_company_id) THEN
        score := score + 5;
    END IF;

    -- 3. CEO Pay Ratio (>300:1 is excessive)
    IF (SELECT ceo_pay_ratio FROM vendor_governance.companies WHERE id = p_company_id) > 300 THEN
        score := score - 5;
    END IF;

    -- F. AI Governance (New - 2025 Trend)
    -- SCORING IMPACT: Only applies for 2025 and beyond. For 2024, these are warning flags only.
    IF p_year IS NOT NULL AND p_year >= 2025 THEN
        -- 1. AI Ethics Board (Bonus)
        IF (SELECT has_ai_ethics_board FROM vendor_governance.companies WHERE id = p_company_id) THEN
            score := score + 5;
        END IF;

        -- 2. Board AI Expertise (Bonus)
        IF (SELECT board_ai_expertise FROM vendor_governance.companies WHERE id = p_company_id) THEN
            score := score + 5;
        END IF;

        -- 3. AI Risk Penalty (High Risk Sectors missing safeguards)
        IF v_sector IN ('Technology', 'Healthcare', 'Communication Services') OR v_sector LIKE '%AI%' THEN
            IF NOT (SELECT has_ai_ethics_board FROM vendor_governance.companies WHERE id = p_company_id) 
               AND NOT (SELECT board_ai_expertise FROM vendor_governance.companies WHERE id = p_company_id) THEN
                score := score - 10;
            END IF;
        END IF;
    END IF;

    -- G. Cybersecurity Oversight (Committee Charter)
    -- Bonus if oversight is explicitly in a committee charter
    IF (SELECT cyber_oversight_flag FROM vendor_governance.companies WHERE id = p_company_id) THEN
        score := score + 5;
    END IF;

    -- ==================================================================
    -- CLAMP & RETURN
    -- ==================================================================
    IF score > 100 THEN score := 100; END IF;
    IF score < 0 THEN score := 0; END IF;

    RETURN score;
END;
$$ LANGUAGE plpgsql;
COMMIT;
