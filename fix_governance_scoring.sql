-- NEW Governance Score Function using Real SEC Data
-- This replaces the old scoring function with one that uses extracted risk factors

DROP FUNCTION IF EXISTS vendor_governance.calculate_governance_score(UUID) CASCADE;
DROP FUNCTION IF EXISTS vendor_governance.calculate_governance_score(UUID, INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_score(p_company_id UUID, p_year INTEGER DEFAULT 2024)
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 50;  -- Start at neutral 50 instead of 100
    v_board_independence DECIMAL;
    v_split_chair_ceo BOOLEAN;
    v_board_diversity DECIMAL;
    v_say_on_pay DECIMAL;
    v_ceo_pay_ratio INTEGER;
    v_has_clawback BOOLEAN;
    v_has_ai_ethics BOOLEAN;
    v_board_ai_expertise BOOLEAN;
    v_cyber_oversight BOOLEAN;
    v_ai_risk_mentions INTEGER;
BEGIN
    -- Fetch real SEC filing data from company_risk_factors table
    SELECT 
        board_independence_pct,
        split_chair_ceo,
        board_diversity_pct,
        say_on_pay_support,
        ceo_pay_ratio,
        has_clawback_policy,
        has_ai_ethics_board,
        board_ai_expertise,
        cyber_oversight_explicit,
        ai_risk_mentions
    INTO 
        v_board_independence,
        v_split_chair_ceo,
        v_board_diversity,
        v_say_on_pay,
        v_ceo_pay_ratio,
        v_has_clawback,
        v_has_ai_ethics,
        v_board_ai_expertise,
        v_cyber_oversight,
        v_ai_risk_mentions
    FROM vendor_governance.company_risk_factors
    WHERE company_id = p_company_id
      AND fiscal_year = p_year
    LIMIT 1;
    
    -- If no SEC data, fall back to old board_composition_annual
    IF v_board_independence IS NULL THEN
        SELECT 
            (independent_directors::DECIMAL / NULLIF(total_directors, 0)) * 100,
            NOT ceo_is_board_chair,
            women_percentage + ethnic_minority_percentage
        INTO 
            v_board_independence,
            v_split_chair_ceo,
            v_board_diversity
        FROM vendor_governance.board_composition_annual
        WHERE company_id = p_company_id
        ORDER BY fiscal_year DESC
        LIMIT 1;
    END IF;
    
    -- If still no data, return NULL
    IF v_board_independence IS NULL THEN
        RETURN NULL;
    END IF;
    
    -- === BOARD INDEPENDENCE (0-25 points) ===
    IF v_board_independence >= 80 THEN
        score := score + 25;
    ELSIF v_board_independence >= 70 THEN
        score := score + 20;
    ELSIF v_board_independence >= 60 THEN
        score := score + 15;
    ELSIF v_board_independence >= 50 THEN
        score := score + 10;
    ELSE
        score := score - 10;  -- Penalty for low independence
    END IF;
    
    -- === LEADERSHIP STRUCTURE (0-15 points) ===
    IF v_split_chair_ceo THEN
        score := score + 15;
    ELSE
        score := score - 5;
    END IF;
    
    -- === BOARD DIVERSITY (0-15 points) ===
    IF v_board_diversity >= 40 THEN
        score := score + 15;
    ELSIF v_board_diversity >= 30 THEN
        score := score + 10;
    ELSIF v_board_diversity >= 20 THEN
        score := score + 5;
    ELSE
        score := score - 5;  -- Penalty for lack of diversity
    END IF;
    
    -- === SAY-ON-PAY SUPPORT (0-10 points) ===
    IF v_say_on_pay IS NOT NULL THEN
        IF v_say_on_pay >= 90 THEN
            score := score + 10;
        ELSIF v_say_on_pay >= 75 THEN
            score := score + 5;
        ELSIF v_say_on_pay < 70 THEN
            score := score - 10;  -- Shareholder revolt penalty
        END IF;
    END IF;
    
    -- === CEO PAY RATIO (0-10 points) ===
    IF v_ceo_pay_ratio IS NOT NULL THEN
        IF v_ceo_pay_ratio <= 50 THEN
            score := score + 10;  -- Excellent alignment
        ELSIF v_ceo_pay_ratio <= 150 THEN
            score := score + 5;
        ELSIF v_ceo_pay_ratio > 300 THEN
            score := score - 10;  -- Excessive inequality penalty
        END IF;
    END IF;
    
    -- === CLAWBACK POLICY (0-5 points) ===
    IF v_has_clawback THEN
        score := score + 5;
    END IF;
    
    -- === AI GOVERNANCE (0-10 points) ===
    IF v_has_ai_ethics THEN
        score := score + 5;
    END IF;
    
    IF v_board_ai_expertise THEN
        score := score + 5;
    END IF;
    
    -- === CYBERSECURITY OVERSIGHT (0-5 points) ===
    IF v_cyber_oversight THEN
        score := score + 5;
    END IF;
    
    -- === AI RISK DISCLOSURE PENALTY ===
    -- High AI risk mentions without governance = red flag
    IF v_ai_risk_mentions IS NOT NULL AND v_ai_risk_mentions > 10 THEN
        IF NOT COALESCE(v_has_ai_ethics, FALSE) AND NOT COALESCE(v_board_ai_expertise, FALSE) THEN
            score := score - 15;  -- High AI risk with no AI governance
        END IF;
    END IF;
    
    -- Clamp score 0-100
    IF score > 100 THEN score := 100; END IF;
    IF score < 0 THEN score := 0; END IF;
    
    RETURN score;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION vendor_governance.calculate_governance_score IS 
'Calculates governance score (0-100) using real SEC filing data from company_risk_factors table.
Scoring Breakdown:
- Board Independence: 0-25 pts
- Leadership Structure: 0-15 pts  
- Board Diversity: 0-15 pts
- Say-on-Pay Support: 0-10 pts
- CEO Pay Ratio: 0-10 pts
- Clawback Policy: 0-5 pts
- AI Governance: 0-10 pts
- Cyber Oversight: 0-5 pts
- AI Risk Penalty: -15 pts (if high AI risk without governance)
Maximum theoretical score: 100 (starting from 50 + bonuses - penalties)';
