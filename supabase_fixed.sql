-- Vendor Governance Schema for RiskAnchor (Succession Economy)
CREATE SCHEMA IF NOT EXISTS vendor_governance;
SET search_path TO vendor_governance, public;

-- ============================================
-- STEP 1: Create tables with NO dependencies first
-- ============================================

-- People (Directors, Executives, Key Personnel) - NO DEPENDENCIES
CREATE TABLE people (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    full_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    
    -- Professional
    current_title VARCHAR(255),
    linkedin_url TEXT,
    email VARCHAR(255),
    
    -- Background
    education TEXT[], -- Array: ['MIT PhD Physics', 'Stanford MBA']
    expertise_areas TEXT[], -- Array: ['Quantum Computing', 'Corporate Governance']
    prior_roles TEXT[], -- Array: ['CEO at XYZ Corp', 'Partner at ABC Ventures']
    
    -- Achievements
    notable_achievements TEXT[],
    patents_count INTEGER DEFAULT 0,
    publications_count INTEGER DEFAULT 0,
    
    created_at TIMESTAMP DEFAULT NOW()
);

-- Now continue with the rest of the schema from the original file...
-- I'll create a proper reordered version
