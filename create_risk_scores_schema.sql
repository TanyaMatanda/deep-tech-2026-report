-- Proprietary Risk Scores Schema
-- Stores company-specific risk predictions based on SEC filing patterns

CREATE TABLE IF NOT EXISTS vendor_governance.proprietary_risk_scores (
    company_id UUID,
    score_date DATE DEFAULT CURRENT_DATE,
    
    -- Risk scores (0-100)
    ma_probability NUMERIC(5,2) DEFAULT 0,
    activist_risk NUMERIC(5,2) DEFAULT 0,
    regulatory_risk NUMERIC(5,2) DEFAULT 0,
    board_turnover_risk NUMERIC(5,2) DEFAULT 0,
    
    -- Supporting signals (JSON evidence)
    ma_signals JSONB,
    activist_signals JSONB,
    regulatory_signals JSONB,
    board_signals JSONB,
    
    -- Metadata
    last_updated TIMESTAMPTZ DEFAULT NOW(),
    model_version VARCHAR(10) DEFAULT 'v1.0',
    
    PRIMARY KEY (company_id, score_date),
    CONSTRAINT fk_company
        FOREIGN KEY (company_id) 
        REFERENCES vendor_governance.companies(id)
        ON DELETE CASCADE
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_risk_scores_date 
ON vendor_governance.proprietary_risk_scores(score_date DESC);

CREATE INDEX IF NOT EXISTS idx_risk_scores_ma_prob 
ON vendor_governance.proprietary_risk_scores(ma_probability DESC);

CREATE INDEX IF NOT EXISTS idx_risk_scores_company 
ON vendor_governance.proprietary_risk_scores(company_id);

-- View for latest scores only
CREATE OR REPLACE VIEW vendor_governance.latest_risk_scores AS
SELECT DISTINCT ON (company_id) *
FROM vendor_governance.proprietary_risk_scores
ORDER BY company_id, score_date DESC;

-- Grant permissions
GRANT SELECT ON vendor_governance.proprietary_risk_scores TO postgres, anon, authenticated, service_role;
GRANT ALL ON vendor_governance.proprietary_risk_scores TO postgres, service_role;

COMMENT ON TABLE vendor_governance.proprietary_risk_scores IS 
'Proprietary risk intelligence: M&A, activist, regulatory, and board turnover predictions based on SEC filing patterns';
