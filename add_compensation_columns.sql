-- Add Compensation Columns to Companies Table
ALTER TABLE vendor_governance.companies
ADD COLUMN IF NOT EXISTS say_on_pay_support DECIMAL(5,2),
ADD COLUMN IF NOT EXISTS has_clawback_policy BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS ceo_pay_ratio INTEGER;

-- Populate with Mock Data for Demo Purposes
-- Logic:
-- 1. Say-on-Pay: Randomly assign between 60% and 99%. Skew towards higher support.
-- 2. Clawback: 80% chance of having a policy.
-- 3. Pay Ratio: Randomly assign between 50:1 and 500:1.

UPDATE vendor_governance.companies
SET 
    say_on_pay_support = FLOOR(random() * (99 - 60 + 1) + 60), -- Random 60-99%
    has_clawback_policy = (random() < 0.8), -- 80% chance of TRUE
    ceo_pay_ratio = FLOOR(random() * (500 - 50 + 1) + 50) -- Random 50-500
WHERE say_on_pay_support IS NULL;

-- Force some "Bad Actors" for demonstration
-- Update a few specific companies to have poor compensation metrics
UPDATE vendor_governance.companies
SET 
    say_on_pay_support = 55.5, -- Fail
    has_clawback_policy = FALSE,
    ceo_pay_ratio = 450 -- High
WHERE id IN (
    SELECT id FROM vendor_governance.companies 
    ORDER BY random() 
    LIMIT 50
);
