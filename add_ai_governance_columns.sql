-- Add AI Governance Columns to Companies Table
ALTER TABLE vendor_governance.companies
ADD COLUMN IF NOT EXISTS has_ai_ethics_board BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS board_ai_expertise BOOLEAN DEFAULT FALSE;

-- Populate with Mock Data for Demo Purposes
-- Logic:
-- 1. Tech/Bio sectors have higher chance of having AI expertise/boards.
-- 2. General population has low chance.

-- Tech/Bio/Deep Tech Sectors
UPDATE vendor_governance.companies
SET 
    has_ai_ethics_board = (random() < 0.4), -- 40% chance
    board_ai_expertise = (random() < 0.6)   -- 60% chance
WHERE primary_sector IN ('Technology', 'Healthcare', 'Communication Services')
   OR technology_tags IS NOT NULL;

-- Rest of the market
UPDATE vendor_governance.companies
SET 
    has_ai_ethics_board = (random() < 0.05), -- 5% chance
    board_ai_expertise = (random() < 0.1)    -- 10% chance
WHERE has_ai_ethics_board IS FALSE 
  AND board_ai_expertise IS FALSE;
