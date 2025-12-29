-- Proprietary Risk Scores Table
-- Clean version without foreign key constraints

CREATE TABLE vendor_governance.proprietary_risk_scores (
    company_id UUID NOT NULL,
    score_date DATE NOT NULL DEFAULT CURRENT_DATE,
    ma_probability NUMERIC(5,2) DEFAULT 0,
    activist_risk NUMERIC(5,2) DEFAULT 0,
    regulatory_risk NUMERIC(5,2) DEFAULT 0,
    board_turnover_risk NUMERIC(5,2) DEFAULT 0,
    ma_signals JSONB,
    activist_signals JSONB,
    regulatory_signals JSONB,
    board_signals JSONB,
    last_updated TIMESTAMPTZ DEFAULT NOW(),
    model_version VARCHAR(10) DEFAULT 'v1.0',
    PRIMARY KEY (company_id, score_date)
);

CREATE INDEX idx_risk_scores_date ON vendor_governance.proprietary_risk_scores(score_date DESC);
CREATE INDEX idx_risk_scores_ma_prob ON vendor_governance.proprietary_risk_scores(ma_probability DESC);
CREATE INDEX idx_risk_scores_company ON vendor_governance.proprietary_risk_scores(company_id);
