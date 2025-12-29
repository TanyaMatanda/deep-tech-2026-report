-- RECALIBRATE GOVERNANCE: Stricter Scoring for "Honesty"

-- 1. Add New Risk Columns
ALTER TABLE vendor_governance.companies 
ADD COLUMN IF NOT EXISTS has_dual_class_shares BOOLEAN DEFAULT FALSE;

ALTER TABLE vendor_governance.companies 
ADD COLUMN IF NOT EXISTS founder_voting_power_pct DECIMAL(5,2);

-- 2. Populate Synthetic Risk Data (The "Reality Check")
-- Mark ~15% of Venture-Backed companies as having Dual Class Shares
UPDATE vendor_governance.companies
SET has_dual_class_shares = TRUE,
    founder_voting_power_pct = 60.0
WHERE ownership_archetype = 'Venture-Backed' 
  AND (hashtext(company_name) % 100) < 15; -- 15% probability

-- Mark ~10% of Public companies as having Dual Class
UPDATE vendor_governance.companies
SET has_dual_class_shares = TRUE,
    founder_voting_power_pct = 55.0
WHERE ownership_archetype = 'Public' 
  AND (hashtext(company_name) % 100) < 10;

-- 3. Update Scoring Function with Stricter Penalties
CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_breakdown(p_company_id UUID)
RETURNS JSONB AS $$
DECLARE
    score INTEGER := 100;
    v_total_directors INTEGER; v_ind_directors INTEGER; v_ceo_chair BOOLEAN; v_women_pct DECIMAL; v_minority_pct DECIMAL; 
    v_archetype TEXT; v_avg_tenure DECIMAL; v_tech_experts INTEGER; v_dual_class BOOLEAN;
    
    -- Component scores & Reasons
    c_independence INTEGER := 0; r_independence TEXT := 'OK';
    c_leadership INTEGER := 0; r_leadership TEXT := 'Split Role (OK)';
    c_audit INTEGER := 0; r_audit TEXT := 'Fully Independent (OK)';
    c_diversity INTEGER := 0; r_diversity TEXT := 'Standard';
    c_education INTEGER := 0; r_education TEXT := 'None';
    c_archetype INTEGER := 0; r_archetype TEXT := 'Standard';
    c_shareholder INTEGER := 0; r_shareholder TEXT := 'Standard'; -- NEW
    c_expertise INTEGER := 0; r_expertise TEXT := 'Standard'; -- NEW
BEGIN
    -- Fetch Expanded Data
    SELECT 
        b.total_directors, b.independent_directors, b.ceo_is_board_chair, b.women_percentage, b.ethnic_minority_percentage, 
        b.avg_director_tenure, b.tech_experts,
        c.ownership_archetype, c.has_dual_class_shares
    INTO 
        v_total_directors, v_ind_directors, v_ceo_chair, v_women_pct, v_minority_pct, 
        v_avg_tenure, v_tech_experts,
        v_archetype, v_dual_class
    FROM vendor_governance.board_composition_annual b 
    JOIN vendor_governance.companies c ON b.company_id = c.id
    WHERE b.company_id = p_company_id 
    ORDER BY b.fiscal_year DESC LIMIT 1;

    IF v_total_directors IS NULL THEN RETURN jsonb_build_object('error', 'No data'); END IF;

    -- 1. Independence (Existing)
    IF (v_ind_directors::DECIMAL / NULLIF(v_total_directors, 0)) < 0.5 THEN
        c_independence := -25; r_independence := 'Low Independence (<50%)'; score := score - 25;
    END IF;

    -- 2. Leadership (Existing)
    IF v_ceo_chair THEN
        c_leadership := -10; r_leadership := 'CEO is Chair'; score := score - 10;
    END IF;
    
    -- 3. Shareholder Rights (NEW: Dual Class Penalty)
    IF v_dual_class THEN
        c_shareholder := -15;
        r_shareholder := 'Dual Class Shares (Voting Risk)';
        score := score - 15;
    END IF;

    -- 4. Board Entrenchment (NEW: Tenure Penalty)
    IF v_avg_tenure > 10 THEN
        -- If we already have a shareholder penalty, add to it, otherwise set it
        IF c_shareholder < 0 THEN
            c_shareholder := c_shareholder - 10;
            r_shareholder := 'Dual Class + High Tenure (>10y)';
        ELSE
            c_shareholder := -10;
            r_shareholder := 'Entrenched Board (>10y Tenure)';
        END IF;
        score := score - 10;
    END IF;

    -- 5. Tech Competence (NEW: Deep Tech Specific)
    IF COALESCE(v_tech_experts, 0) = 0 THEN
        c_expertise := -10;
        r_expertise := 'No Tech Experts on Board';
        score := score - 10;
    ELSE
        c_expertise := 5;
        r_expertise := 'Tech Experts Present';
        score := score + 5;
    END IF;

    -- 6. Archetype (Existing)
    IF v_archetype = 'Venture-Backed' THEN c_archetype := -5; r_archetype := 'Venture Control Penalty'; score := score - 5;
    ELSIF v_archetype = 'Academic Spinout' THEN c_archetype := -5; r_archetype := 'Academic Conflict Risk'; score := score - 5;
    ELSIF v_archetype = 'Megacap Subsidiary' THEN c_archetype := 10; r_archetype := 'Parent Corp Oversight Bonus'; score := score + 10;
    END IF;

    -- 7. Diversity (Existing)
    IF (COALESCE(v_women_pct, 0) + COALESCE(v_minority_pct, 0)) > 40 THEN c_diversity := 5; r_diversity := 'High Diversity (>40%)'; score := score + 5; END IF;

    -- Clamp
    IF score > 100 THEN score := 100; END IF; IF score < 0 THEN score := 0; END IF;

    RETURN jsonb_build_object(
        'total_score', score,
        'independence', c_independence, 'independence_reason', r_independence,
        'leadership', c_leadership, 'leadership_reason', r_leadership,
        'shareholder_rights', c_shareholder, 'shareholder_reason', r_shareholder, -- NEW
        'expertise', c_expertise, 'expertise_reason', r_expertise, -- NEW
        'archetype', c_archetype, 'archetype_reason', r_archetype,
        'diversity', c_diversity, 'diversity_reason', r_diversity,
        'women_pct', COALESCE(v_women_pct, 0),
        'minority_pct', COALESCE(v_minority_pct, 0)
    );
END;
$$ LANGUAGE plpgsql;

-- 4. Update Main Score Function to Match (for sorting/filtering)
CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_score(p_company_id UUID, p_year INTEGER DEFAULT NULL)
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 100;
    v_total_directors INTEGER; v_ind_directors INTEGER; v_ceo_chair BOOLEAN; v_women_pct DECIMAL; v_minority_pct DECIMAL; 
    v_archetype TEXT; v_avg_tenure DECIMAL; v_tech_experts INTEGER; v_dual_class BOOLEAN;
BEGIN
    SELECT b.total_directors, b.independent_directors, b.ceo_is_board_chair, b.women_percentage, b.ethnic_minority_percentage, 
           b.avg_director_tenure, b.tech_experts, c.ownership_archetype, c.has_dual_class_shares
    INTO v_total_directors, v_ind_directors, v_ceo_chair, v_women_pct, v_minority_pct, v_avg_tenure, v_tech_experts, v_archetype, v_dual_class
    FROM vendor_governance.board_composition_annual b JOIN vendor_governance.companies c ON b.company_id = c.id
    WHERE b.company_id = p_company_id AND (p_year IS NULL OR b.fiscal_year = p_year) ORDER BY b.fiscal_year DESC LIMIT 1;

    IF v_total_directors IS NULL THEN RETURN 50; END IF;

    -- Penalties
    IF (v_ind_directors::DECIMAL / NULLIF(v_total_directors, 0)) < 0.5 THEN score := score - 25; END IF;
    IF v_ceo_chair THEN score := score - 10; END IF;
    IF v_dual_class THEN score := score - 15; END IF; -- NEW
    IF v_avg_tenure > 10 THEN score := score - 10; END IF; -- NEW
    IF COALESCE(v_tech_experts, 0) = 0 THEN score := score - 10; ELSE score := score + 5; END IF; -- NEW
    
    -- Archetype
    IF v_archetype = 'Venture-Backed' THEN score := score - 5; ELSIF v_archetype = 'Academic Spinout' THEN score := score - 5; ELSIF v_archetype = 'Megacap Subsidiary' THEN score := score + 10; END IF;
    
    -- Bonus
    IF (COALESCE(v_women_pct, 0) + COALESCE(v_minority_pct, 0)) > 40 THEN score := score + 5; END IF;

    IF score > 100 THEN score := 100; END IF; IF score < 0 THEN score := 0; END IF;
    RETURN score;
END;
$$ LANGUAGE plpgsql;

-- 5. Refresh View
REFRESH MATERIALIZED VIEW vendor_governance.mv_company_scores;
