-- Add missing governance columns to fix schema mismatch errors
-- These columns are expected by extraction scripts but missing from database

-- 1. Add overboarded_directors_count to board_composition_annual
ALTER TABLE vendor_governance.board_composition_annual
ADD COLUMN IF NOT EXISTS overboarded_directors_count INTEGER;

COMMENT ON COLUMN vendor_governance.board_composition_annual.overboarded_directors_count IS 'Count of directors serving on >4 public boards';

-- 2. Add CEO pay ratio and clawback policy to executive_compensation_annual
ALTER TABLE vendor_governance.executive_compensation_annual
ADD COLUMN IF NOT EXISTS ceo_pay_ratio INTEGER,
ADD COLUMN IF NOT EXISTS has_clawback_policy BOOLEAN DEFAULT FALSE;

COMMENT ON COLUMN vendor_governance.executive_compensation_annual.ceo_pay_ratio IS 'CEO-to-median-worker pay ratio (e.g., 250 means 250:1)';
COMMENT ON COLUMN vendor_governance.executive_compensation_annual.has_clawback_policy IS 'Whether company has clawback/recoupment policy';

-- 3. Add board structure score to governance_scores
ALTER TABLE vendor_governance.governance_scores
ADD COLUMN IF NOT EXISTS board_structure_score INTEGER;

COMMENT ON COLUMN vendor_governance.governance_scores.board_structure_score IS 'Composite score for board structure quality (0-100)';
