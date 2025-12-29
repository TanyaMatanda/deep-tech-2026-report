-- Create Patents Table if it doesn't exist
CREATE TABLE IF NOT EXISTS vendor_governance.patents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES vendor_governance.companies(id) ON DELETE CASCADE,
    patent_number VARCHAR(50),
    filing_date DATE,
    grant_date DATE,
    title TEXT,
    technology_classification TEXT[],
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create Innovation Momentum View (Simulated History for Demo)
CREATE OR REPLACE VIEW vendor_governance.view_innovation_momentum AS
SELECT 
    c.id AS company_id,
    c.company_name,
    c.primary_sector,
    c.patents_count AS current_patents,
    FLOOR(c.patents_count * (0.8 + (random() * 0.15))) AS patents_n_1,
    FLOOR(c.patents_count * (0.6 + (random() * 0.2))) AS patents_n_2,
    FLOOR(c.patents_count * (0.4 + (random() * 0.2))) AS patents_n_3,
    CASE 
        WHEN c.patents_count > 5 THEN 
            ROUND((((c.patents_count::DECIMAL / NULLIF(FLOOR(c.patents_count * 0.5), 0)) ^ (1.0/3.0) - 1) * 100)::NUMERIC, 2)
        ELSE 0 
    END AS patent_cagr_3yr,
    ROUND(((c.innovation_score::DECIMAL / 10.0) * (1 + random()))::NUMERIC, 2) AS rd_efficiency_index
FROM vendor_governance.view_company_scores c
WHERE c.patents_count > 0;
