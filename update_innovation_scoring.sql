-- Update calculate_innovation_index to differentiate massive patent holders

CREATE OR REPLACE FUNCTION vendor_governance.calculate_innovation_index(p_patents_count INTEGER, p_tech_tags TEXT[])
RETURNS INTEGER AS $$
DECLARE
    score INTEGER := 0;
BEGIN
    -- Patent Volume Scoring (Expanded Tiers)
    IF p_patents_count >= 100000 THEN score := 80; -- Tech Giants
    ELSIF p_patents_count >= 50000 THEN score := 70;
    ELSIF p_patents_count >= 10000 THEN score := 60;
    ELSIF p_patents_count >= 5000 THEN score := 55;
    ELSIF p_patents_count >= 1000 THEN score := 50;
    ELSIF p_patents_count >= 100 THEN score := 30;
    ELSIF p_patents_count >= 10 THEN score := 15;
    ELSIF p_patents_count >= 1 THEN score := 5;
    ELSE score := 0;
    END IF;

    -- Technology Tag Bonus
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
