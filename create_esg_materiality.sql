-- Create ESG Materiality View
-- Simulates ESG metrics for "Impact vs. Returns" analysis.

CREATE OR REPLACE VIEW vendor_governance.view_esg_materiality AS
SELECT 
    c.id AS company_id,
    c.company_name,
    c.primary_sector,
    c.governance_score,
    
    -- Simulate Carbon Intensity (tCO2e / $M Revenue)
    -- Varies heavily by sector
    ROUND(
        (CASE 
            WHEN c.primary_sector = 'Energy & Climate' THEN 500 
            WHEN c.primary_sector = 'Advanced Manufacturing' THEN 200 
            WHEN c.primary_sector = 'Biotechnology' THEN 100 
            ELSE 20 -- Software/AI is low carbon
         END * (0.5 + random()))::NUMERIC, 
    1) AS carbon_intensity,
    
    -- Simulate Employee Turnover Rate (%)
    -- High turnover in AI/Tech (15-25%), lower in others
    ROUND(
        (CASE 
            WHEN c.primary_sector IN ('AI & Machine Learning', 'Cybersecurity') THEN 20 
            ELSE 12 
         END + (random() * 10 - 5))::NUMERIC, 
    1) AS employee_turnover_pct,
    
    -- Human Capital Risk Score (Derived from Turnover & Governance)
    -- Higher Score = Higher Risk
    CASE 
        WHEN c.governance_score < 50 THEN 'High'
        WHEN c.governance_score < 75 THEN 'Medium'
        ELSE 'Low'
    END AS human_capital_risk_level

FROM vendor_governance.view_company_scores c;
