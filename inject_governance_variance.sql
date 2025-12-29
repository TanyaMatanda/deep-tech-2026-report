-- Inject Variance into Governance Data
-- Goal: Break the 60-65 score clustering by creating "Heroes" and "Villains"

BEGIN;

-- 1. Randomize Listing Type (Impacts -5 pt penalty)
-- 60% Venture, 30% Public, 10% Academic/Subsidiary
UPDATE vendor_governance.companies
SET listing_type = CASE 
    WHEN random() < 0.6 THEN 'Private' -- Often treated as Venture-Backed in logic
    WHEN random() < 0.9 THEN 'Public'
    ELSE 'Academic Spinout'
END;

-- 2. Randomize Say-on-Pay Support (Impacts -10 pt penalty if < 70)
-- Skew towards high support, but with a "fat tail" of failures
UPDATE vendor_governance.companies
SET say_on_pay_support = CASE 
    WHEN random() < 0.8 THEN 85 + (random() * 14) -- 85-99% (Safe)
    WHEN random() < 0.9 THEN 70 + (random() * 15) -- 70-85% (Mediocre)
    ELSE 50 + (random() * 19) -- 50-69% (Fail)
END;

-- 3. Randomize AI & Cyber Flags (Bonuses/Penalties)
-- Create "Heroes" (Top 15%) who have everything
UPDATE vendor_governance.companies
SET 
    has_ai_ethics_board = (random() < 0.15),
    board_ai_expertise = (random() < 0.20),
    cyber_oversight_flag = (random() < 0.25),
    has_clawback_policy = (random() < 0.70); -- Most should have this now

-- 4. Randomize Board Structure (The Big Swingers)
-- Audit Independence (Critical -20 pt penalty) -> 95% Pass
-- CEO Chair (Common -5 pt penalty) -> 50/50
UPDATE vendor_governance.companies
SET 
    is_audit_committee_independent = (random() < 0.95),
    is_ceo_chair = (random() < 0.50);

-- 5. Recalculate Scores
-- We need to call the scoring function for all companies
UPDATE vendor_governance.companies
SET governance_score = calculate_governance_score(id, 2025);

-- 6. Update Deal Qualification Score (Composite)
-- Deal Score = 40% Gov + 40% Innov + 20% Data
UPDATE vendor_governance.companies
SET deal_qualification_score = (
    (governance_score * 0.4) + 
    (innovation_score * 0.4) + 
    (data_tier * 25 * 0.2) -- Assuming Data Tier 1-4 maps to 25-100
);

COMMIT;
