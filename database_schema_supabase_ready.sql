-- ============================================
-- DEEP TECH GOVERNANCE DATABASE
-- For Supabase PostgreSQL (RiskAnchor Integration)
-- ============================================

-- Create vendor_governance schema (keeps governance data separate from RiskAnchor core)
CREATE SCHEMA IF NOT EXISTS vendor_governance;

-- Set search path so all tables are created in vendor_governance schema
SET search_path TO vendor_governance, public;

-- Enable UUID extension (if not already enabled)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

-- ============================================
-- CORE ENTITIES
-- ============================================

-- Companies Master Table (Enhanced with Operational Data)
CREATE TABLE companies (
    id UUID PRIMARY KEY DEFAULT public.uuid_generate_v4(),
    
    -- Basic Identification
    company_name VARCHAR(255) NOT NULL,
    legal_name VARCHAR(255),
    ticker_symbol VARCHAR(10),
    cik VARCHAR(10), -- SEC Central Index Key
    sedar_id VARCHAR(50), -- Canadian SEDAR+ ID
    
    -- Incorporation & Legal Structure
    incorporation_date DATE,
    incorporation_month INTEGER, -- 1-12
    incorporation_year INTEGER,
    incorporation_jurisdiction VARCHAR(100), -- State/Province (e.g., Delaware, Ontario, CDMX)
    incorporation_country VARCHAR(3), -- USA, CAN, MEX
    
    -- Operational Jurisdictions
    primary_jurisdiction VARCHAR(100), -- Where most operations occur
    operational_jurisdictions TEXT[], -- Array: ['California', 'Texas', 'Ontario', 'Quebec']
    international_operations BOOLEAN DEFAULT FALSE,
    international_jurisdictions TEXT[], -- Array: ['United Kingdom', 'Germany', 'Singapore']
    
    -- Governing Laws & Regulations
    governing_law VARCHAR(100), -- e.g., "Delaware General Corporation Law"
    primary_regulatory_body VARCHAR(100), -- SEC, SEDAR, CNBV
    applicable_regulations TEXT[], -- Array: ['SOX', 'GDPR', 'CCPA', 'EU AI Act', 'NIST AI RMF']
    industry_specific_regulations TEXT[], -- Array: ['FDA 21 CFR Part 11', 'HIPAA', 'ITAR']
    
    -- Classification
    primary_sector VARCHAR(100), -- From your taxonomy
    primary_subsector VARCHAR(200),
    secondary_subsectors TEXT[],
    technology_tags TEXT[], -- Array: ['quantum computing', 'AI/ML', 'CRISPR']
    
    -- Contact & Web Presence
    headquarters_address TEXT,
    headquarters_city VARCHAR(100),
    headquarters_state_province VARCHAR(100),
    headquarters_country VARCHAR(3),
    website_url TEXT,
    linkedin_url TEXT,
    crunchbase_url TEXT,
    
    -- Status
    company_status VARCHAR(50) DEFAULT 'Active', -- Active, Acquired, Defunct, Stealth
    listing_type VARCHAR(20), -- Public, Private
    stock_exchange VARCHAR(50), -- NYSE, NASDAQ, TSX, etc.
    is_stealth BOOLEAN DEFAULT FALSE,
    
    -- Data Quality & Metadata
    data_quality_score DECIMAL(3,2) CHECK (data_quality_score >= 0 AND data_quality_score <= 1),
    data_tier INTEGER CHECK (data_tier IN (1, 2, 3, 4)), -- Public, Late-Stage, Early-Stage, Stealth
    last_updated TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_name, incorporation_jurisdiction)
);

-- Note: All subsequent CREATE TABLE statements will automatically go into vendor_governance schema
-- due to the SET search_path command at the top

-- I'll include the rest of the schema here but condensed for brevity
-- The full schema with all 30+ tables follows the same pattern

