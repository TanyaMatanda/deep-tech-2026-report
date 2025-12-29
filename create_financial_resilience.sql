-- Create Financial Resilience View
-- Simulates financial metrics correlated with governance scores for demonstration.

CREATE OR REPLACE VIEW vendor_governance.view_financial_resilience AS
SELECT 
    c.id AS company_id,
    c.company_name,
    c.primary_sector,
    c.governance_score,
    
    -- Simulate Operating Margin (-20% to +40%)
    -- Better Governance (score > 70) tends to have better margins (simulated correlation)
    ROUND(
        (CASE 
            WHEN c.governance_score > 80 THEN 15 
            WHEN c.governance_score > 50 THEN 5 
            ELSE -10 
         END + (random() * 20 - 10))::NUMERIC, 
    2) AS operating_margin_pct,
    
    -- Simulate Valuation Multiple (Revenue Multiple 2x - 20x)
    -- Innovation Score drives this heavily, but Governance adds a premium
    ROUND(
        (c.innovation_score / 10.0 + (c.governance_score / 20.0) + (random() * 2))::NUMERIC,
    1) AS valuation_multiple_x,
    
    -- Governance-Adjusted Valuation Discount/Premium
    -- If Gov Score < 50, apply a "Risk Discount"
    CASE 
        WHEN c.governance_score < 50 THEN -15 -- 15% Discount
        WHEN c.governance_score > 80 THEN 10  -- 10% Premium
        ELSE 0 
    END AS governance_valuation_impact_pct

FROM vendor_governance.view_company_scores c;
