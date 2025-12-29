
-- Set Search Path to ensure we target the correct schema
SET search_path TO vendor_governance, public;

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Update Schema for Enhanced Governance & Risk Collection

-- 1. Add new columns to board_composition_annual
ALTER TABLE board_composition_annual 
ADD COLUMN IF NOT EXISTS women_board_chair BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS independent_women_board_chair BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS independent_board_chair BOOLEAN DEFAULT FALSE;

-- 2. Create Company Risk Factors Table (Extracted from 10-K Item 1A)
DROP TABLE IF EXISTS company_risk_factors CASCADE;
CREATE TABLE company_risk_factors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    source_filing_date DATE,
    
    -- Risk Categories
    risk_category VARCHAR(100), -- e.g., "Cybersecurity", "Regulatory", "Market", "AI"
    risk_title TEXT,
    risk_description TEXT,
    
    -- Analysis
    is_material BOOLEAN DEFAULT TRUE,
    ai_related BOOLEAN DEFAULT FALSE,
    climate_related BOOLEAN DEFAULT FALSE,
    cyber_related BOOLEAN DEFAULT FALSE,
    
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(company_id, fiscal_year, risk_title)
);

-- 3. Create Shareholder Proposals Table (Extracted from DEF 14A)
DROP TABLE IF EXISTS shareholder_proposals CASCADE;
CREATE TABLE shareholder_proposals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    meeting_date DATE,
    fiscal_year INTEGER,
    
    -- Proposal Details
    proposal_number VARCHAR(10),
    proposal_description TEXT,
    proponent VARCHAR(255), -- e.g., "John Chevedden", "As You Sow"
    category VARCHAR(100), -- Governance, Environmental, Social, Compensation
    
    -- Board Stance
    board_recommendation VARCHAR(20), -- For, Against, Abstain
    
    -- Voting Results
    votes_for BIGINT,
    votes_against BIGINT,
    votes_abstained BIGINT,
    broker_non_votes BIGINT,
    percent_support DECIMAL(5,2),
    passed BOOLEAN,
    
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(company_id, meeting_date, proposal_number)
);

-- Index for analysis
CREATE INDEX IF NOT EXISTS idx_risk_factors_category ON company_risk_factors(risk_category);
CREATE INDEX IF NOT EXISTS idx_proposals_category ON shareholder_proposals(category);
