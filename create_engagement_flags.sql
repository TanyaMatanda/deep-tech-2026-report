-- Create Engagement Flags View
-- Simulates metrics for Shareholder Engagement (Proxy Card)

CREATE OR REPLACE VIEW vendor_governance.view_engagement_flags AS
SELECT 
    c.id AS company_id,
    c.company_name,
    c.primary_sector,
    c.governance_score,
    c.patents_count,
    
    -- Simulate Supplier Diversity (% of spend with diverse vendors)
    -- Target is usually > 10%. Tech companies often struggle here.
    ROUND((random() * 15)::NUMERIC, 1) AS supplier_diversity_pct,
    
    -- Simulate AI Ethics Policy (Critical for AI/Tech)
    -- Higher governance scores are more likely to have one.
    CASE 
        WHEN c.governance_score > 80 THEN true
        WHEN c.governance_score > 60 AND random() > 0.5 THEN true
        ELSE false 
    END AS has_ai_ethics_policy,
    
    -- Check for Board Tech Literacy (from board_composition_annual)
    COALESCE(b.tech_experts, 0) AS board_tech_experts,
    
    -- RED FLAG LOGIC
    -- 1. Vendor Diversity Flag (< 5% is Critical Fail)
    CASE WHEN (random() * 15) < 5 THEN true ELSE false END AS flag_vendor_diversity,
    
    -- 2. AI Oversight Flag (High Patents but No Tech Experts)
    CASE WHEN c.patents_count > 50 AND COALESCE(b.tech_experts, 0) = 0 THEN true ELSE false END AS flag_ai_oversight,
    
    -- 3. Ethics Void Flag (AI Sector but No Policy)
    CASE 
        WHEN c.primary_sector IN ('AI & Machine Learning', 'Cybersecurity', 'Robotics') 
             AND (CASE WHEN c.governance_score > 80 THEN true ELSE false END) = false 
        THEN true 
        ELSE false 
    END AS flag_ethics_void

FROM vendor_governance.view_company_scores c
LEFT JOIN vendor_governance.board_composition_annual b 
    ON c.id = b.company_id AND b.fiscal_year = 2024;
