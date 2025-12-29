-- Function to calculate Governance Risk Score
CREATE OR REPLACE FUNCTION vendor_governance.calculate_governance_score(p_company_id UUID)
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 100;
    v_total_directors INTEGER;
    v_ind_directors INTEGER;
    v_ceo_chair BOOLEAN;
    v_women_pct DECIMAL;
    v_minority_pct DECIMAL;
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

    -- If no data, return NULL or default
    IF v_total_directors IS NULL THEN
        RETURN NULL;
    END IF;

    -- Deductions
    -- Low Independence (<50%)
    IF (v_ind_directors::DECIMAL / NULLIF(v_total_directors, 0)) < 0.5 THEN
        score := score - 15;
    END IF;

    -- Combined CEO/Chair
    IF v_ceo_chair THEN
        score := score - 5;
    END IF;

    -- Bonuses
    -- Diversity (>30% combined)
    IF (COALESCE(v_women_pct, 0) + COALESCE(v_minority_pct, 0)) > 30 THEN
        score := score + 5;
    END IF;

    -- Clamp score 0-100
    IF score > 100 THEN score := 100; END IF;
    IF score < 0 THEN score := 0; END IF;

    RETURN score;
END;
$$ LANGUAGE plpgsql;

-- Function to calculate Innovation Index
CREATE OR REPLACE FUNCTION vendor_governance.calculate_innovation_index(p_patents_count INTEGER, p_tech_tags TEXT[])
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 0;
BEGIN
    -- Patent Volume Scoring
    IF p_patents_count >= 1000 THEN score := 50;
    ELSIF p_patents_count >= 100 THEN score := 30;
    ELSIF p_patents_count >= 10 THEN score := 15;
    ELSIF p_patents_count >= 1 THEN score := 5;
    ELSE score := 0;
    END IF;

    -- Technology Tag Bonus
    -- Simple check for presence of tags
    IF p_tech_tags IS NOT NULL AND array_length(p_tech_tags, 1) > 0 THEN
        score := score + 10;
        
        -- Extra bonus for specific high-value tags
        IF 'Quantum' = ANY(p_tech_tags) OR 'Generative AI' = ANY(p_tech_tags) THEN
            score := score + 10;
        END IF;
    END IF;

    -- Clamp
    IF score > 100 THEN score := 100; END IF;

    RETURN score;
END;
$$ LANGUAGE plpgsql;

-- Master View for Company Scores
CREATE OR REPLACE VIEW vendor_governance.view_company_scores AS
SELECT 
    c.id,
    c.company_name,
    c.primary_sector,
    c.patents_count,
    vendor_governance.calculate_governance_score(c.id) as governance_score,
    vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) as innovation_score,
    -- Composite Deal Qualification Score
    (
        COALESCE(vendor_governance.calculate_governance_score(c.id), 50) * 0.4 + 
        vendor_governance.calculate_innovation_index(c.patents_count, c.technology_tags) * 0.4 +
        (CASE WHEN c.data_tier = 1 THEN 100 ELSE 25 END) * 0.2
    )::INTEGER as deal_qualification_score
FROM vendor_governance.companies c;
