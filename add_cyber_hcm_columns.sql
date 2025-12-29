-- Add Cybersecurity and HCM Columns to Companies Table
ALTER TABLE vendor_governance.companies
ADD COLUMN IF NOT EXISTS cyber_oversight_flag BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS discloses_turnover BOOLEAN DEFAULT FALSE;

-- Populate with Mock Data for Demo Purposes
-- Logic:
-- 1. Cyber Oversight: Higher probability for Tech/Finance/Healthcare.
-- 2. HCM Disclosure: Generally low, but higher for larger companies (simulated by random).

-- Tech/Finance/Healthcare Sectors - Higher Cyber Oversight
UPDATE vendor_governance.companies
SET 
    cyber_oversight_flag = (random() < 0.7), -- 70% chance
    discloses_turnover = (random() < 0.5)    -- 50% chance
WHERE primary_sector IN ('Technology', 'Financials', 'Healthcare', 'Communication Services');

-- Rest of the market
UPDATE vendor_governance.companies
SET 
    cyber_oversight_flag = (random() < 0.3), -- 30% chance
    discloses_turnover = (random() < 0.2)    -- 20% chance
WHERE cyber_oversight_flag IS FALSE 
  AND discloses_turnover IS FALSE;
