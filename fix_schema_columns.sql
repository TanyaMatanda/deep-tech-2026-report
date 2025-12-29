-- Fix Missing Schema Columns (Updated)
-- Run this script in the Supabase SQL Editor to ensure all columns exist.

-- 1. Companies Table
ALTER TABLE vendor_governance.companies ADD COLUMN IF NOT EXISTS patents_count INTEGER DEFAULT 0;
ALTER TABLE vendor_governance.companies ADD COLUMN IF NOT EXISTS innovation_score DECIMAL(4,2);
ALTER TABLE vendor_governance.companies ADD COLUMN IF NOT EXISTS governance_score DECIMAL(4,2);

-- 2. Governance Scores Table
ALTER TABLE vendor_governance.governance_scores ADD COLUMN IF NOT EXISTS audit_integrity_score INTEGER;
ALTER TABLE vendor_governance.governance_scores ADD COLUMN IF NOT EXISTS strategic_oversight_score INTEGER;
ALTER TABLE vendor_governance.governance_scores ADD COLUMN IF NOT EXISTS board_diversity_pct DECIMAL(5,2);
ALTER TABLE vendor_governance.governance_scores ADD COLUMN IF NOT EXISTS board_independence_pct DECIMAL(5,2); -- Added

-- 3. Board Composition Table
ALTER TABLE vendor_governance.board_composition_annual ADD COLUMN IF NOT EXISTS average_age DECIMAL(4,1);
ALTER TABLE vendor_governance.board_composition_annual ADD COLUMN IF NOT EXISTS average_tenure DECIMAL(4,1);
ALTER TABLE vendor_governance.board_composition_annual ADD COLUMN IF NOT EXISTS minority_directors INTEGER;
ALTER TABLE vendor_governance.board_composition_annual ADD COLUMN IF NOT EXISTS female_directors INTEGER; -- Added
