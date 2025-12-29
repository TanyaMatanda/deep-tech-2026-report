-- SEC Filings & Document Tracking Tables
-- Add to vendor_governance schema

SET search_path TO vendor_governance, public;

-- ============================================
-- SEC FILINGS & REGULATORY DOCUMENTS
-- ============================================

-- Main Filings Table
CREATE TABLE sec_filings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Filing Identification
    accession_number VARCHAR(20) UNIQUE NOT NULL, -- SEC unique identifier (e.g., 0001234567-23-000123)
    filing_type VARCHAR(20) NOT NULL, -- DEF 14A, 10-K, 10-Q, 8-K, S-1, etc.
    filing_date DATE NOT NULL,
    filing_year INTEGER,
    filing_quarter INTEGER, -- NULL for annual filings
    
    -- URLs & Access
    filing_url TEXT, -- Direct SEC EDGAR URL
    htm_url TEXT, -- Human-readable HTML URL
    xml_url TEXT, -- XBRL/XML structured data URL
    
    -- Document Metadata
    document_title TEXT,
    document_description TEXT,
    period_of_report DATE, -- Fiscal period covered (e.g., Q4 2024)
    
    -- Processing Status
    processing_status VARCHAR(50) DEFAULT 'pending', -- pending, processing, completed, failed
    downloaded BOOLEAN DEFAULT FALSE,
    parsed BOOLEAN DEFAULT FALSE,
    data_extracted BOOLEAN DEFAULT FALSE,
    
    -- Extracted Sections Storage
    full_text TEXT, -- Complete filing text (can be large!)
    full_text_length INTEGER, -- Character count
    
    -- Processing Metadata
    download_date TIMESTAMP,
    parse_date TIMESTAMP,
    extraction_date TIMESTAMP,
    last_processed TIMESTAMP,
    
    -- Error Tracking
    processing_errors TEXT,
    parse_errors TEXT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    -- Indexes
    CONSTRAINT unique_company_filing UNIQUE(company_id, accession_number)
);

-- Filing Sections (Structured Extraction)
CREATE TABLE filing_sections (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    filing_id UUID REFERENCES sec_filings(id) ON DELETE CASCADE,
    
    -- Section Identification
    section_type VARCHAR(100) NOT NULL, -- 'Item 1 - Business', 'Item 1A - Risk Factors', 'Compensation Discussion', etc.
    section_number VARCHAR(20), -- '1', '1A', '8', etc.
    section_title TEXT,
    
    -- Section Content
    section_text TEXT, -- Extracted text for this section
    section_text_length INTEGER,
    section_html TEXT, -- Original HTML if needed for formatting
    
    -- Parsing Metadata
    extraction_method VARCHAR(50), -- 'regex', 'ML_model', 'manual', 'API'
    confidence_score DECIMAL(3,2), -- How confident are we in this extraction? (0.00-1.00)
    
    -- NLP Analysis (Optional: for future AI analysis)
    key_topics TEXT[], -- Array of identified topics
    named_entities TEXT[], -- Companies, people, regulations mentioned
    sentiment_score DECIMAL(3,2), -- -1.00 to 1.00
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(filing_id, section_type)
);

-- Proxy Statement Specific Data (DEF 14A)
CREATE TABLE proxy_statement_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    filing_id UUID REFERENCES sec_filings(id) ON DELETE CASCADE,
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- Meeting Information
    meeting_date DATE,
    meeting_type VARCHAR(50), -- Annual, Special
    record_date DATE, -- Shareholder eligibility date
    
    -- Extracted Governance Data
    board_proposals_text TEXT, -- Raw text of board proposals
    shareholder_proposals_text TEXT, -- Raw text of shareholder proposals
    compensation_discussion_text TEXT, -- CD&A section
    auditor_section_text TEXT,
    
    -- Vote Results (if available)
    total_shares_outstanding BIGINT,
    total_shares_voted BIGINT,
    voter_turnout_pct DECIMAL(5,2),
    
    -- Processing
    data_extracted_to_board_composition BOOLEAN DEFAULT FALSE,
    data_extracted_to_compensation BOOLEAN DEFAULT FALSE,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, filing_id)
);

-- 10-K Specific Data
CREATE TABLE form_10k_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    filing_id UUID REFERENCES sec_filings(id) ON DELETE CASCADE,
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- Key Sections
    business_description_text TEXT, -- Item 1
    risk_factors_text TEXT, -- Item 1A
    legal_proceedings_text TEXT, -- Item 3
    md_and_a_text TEXT, -- Item 7 - Management Discussion & Analysis
    financial_statements_text TEXT, -- Item 8
    
    -- Extracted Operational Data
    revenue_segment_text TEXT, -- For parsing revenue by segment
    geographic_revenue_text TEXT,
    regulatory_compliance_text TEXT,
    
    -- Processing Flags
    data_extracted_to_financials BOOLEAN DEFAULT FALSE,
    data_extracted_to_lines_of_business BOOLEAN DEFAULT FALSE,
    data_extracted_to_compliance BOOLEAN DEFAULT FALSE,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, filing_id)
);

-- 8-K Current Events (Material Events)
CREATE TABLE form_8k_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    filing_id UUID REFERENCES sec_filings(id) ON DELETE CASCADE,
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Event Information
    event_date DATE, -- When the event occurred
    item_numbers TEXT[], -- Array: ['5.02', '5.07'] - which 8-K items triggered filing
    
    -- Common 8-K Events
    is_executive_departure BOOLEAN DEFAULT FALSE, -- Item 5.02
    is_proxy_voting_results BOOLEAN DEFAULT FALSE, -- Item 5.07
    is_acquisition BOOLEAN DEFAULT FALSE, -- Item 2.01
    is_asset_disposal BOOLEAN DEFAULT FALSE, -- Item 2.01
    is_bankruptcy BOOLEAN DEFAULT FALSE, -- Item 1.03
    is_material_agreement BOOLEAN DEFAULT FALSE, -- Item 1.01
    
    -- Event Description
    event_description TEXT,
    event_text TEXT, -- Full text of the event disclosure
    
    -- Processing
    processed BOOLEAN DEFAULT FALSE,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Document Processing Queue (For Automation)
CREATE TABLE filing_processing_queue (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    filing_id UUID REFERENCES sec_filings(id) ON DELETE CASCADE,
    
    -- Queue Management
    queue_status VARCHAR(50) DEFAULT 'queued', -- queued, processing, completed, failed, retrying
    priority INTEGER DEFAULT 5, -- 1 (highest) to 10 (lowest)
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    
    -- Processing Assignment
    worker_id VARCHAR(100), -- Which worker/process is handling this
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    
    -- Error Handling
    error_message TEXT,
    last_error_at TIMESTAMP,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- CANADIAN FILINGS (SEDAR+)
-- ============================================

CREATE TABLE sedar_filings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- SEDAR Identification
    sedar_filing_id VARCHAR(50) UNIQUE, -- SEDAR's unique ID
    filing_type VARCHAR(50), -- 'Management Circular', 'Annual Information Form', 'MD&A', etc.
    filing_date DATE,
    
    -- URLs
    filing_url TEXT,
    
    -- Content
    full_text TEXT,
    full_text_length INTEGER,
    
    -- Processing
    processing_status VARCHAR(50) DEFAULT 'pending',
    downloaded BOOLEAN DEFAULT FALSE,
    parsed BOOLEAN DEFAULT FALSE,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

CREATE INDEX idx_sec_filings_company ON sec_filings(company_id, filing_date DESC);
CREATE INDEX idx_sec_filings_type ON sec_filings(filing_type, filing_date DESC);
CREATE INDEX idx_sec_filings_accession ON sec_filings(accession_number);
CREATE INDEX idx_sec_filings_status ON sec_filings(processing_status);
CREATE INDEX idx_sec_filings_year ON sec_filings(company_id, filing_year, filing_type);

CREATE INDEX idx_filing_sections_filing ON filing_sections(filing_id, section_type);
CREATE INDEX idx_proxy_data_company ON proxy_statement_data(company_id, fiscal_year DESC);
CREATE INDEX idx_10k_data_company ON form_10k_data(company_id, fiscal_year DESC);
CREATE INDEX idx_8k_data_company ON form_8k_data(company_id, event_date DESC);

CREATE INDEX idx_processing_queue_status ON filing_processing_queue(queue_status, priority);

-- ============================================
-- HELPER FUNCTIONS
-- ============================================

-- Function to get latest proxy statement for a company
CREATE OR REPLACE FUNCTION get_latest_proxy(p_company_id UUID)
RETURNS TABLE(
    filing_id UUID,
    filing_date DATE,
    filing_url TEXT,
    fiscal_year INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        sf.id,
        sf.filing_date,
        sf.filing_url,
        sf.filing_year
    FROM sec_filings sf
    WHERE sf.company_id = p_company_id
    AND sf.filing_type = 'DEF 14A'
    ORDER BY sf.filing_date DESC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;

-- Function to check if we've already processed a filing
CREATE OR REPLACE FUNCTION is_filing_processed(p_accession_number VARCHAR)
RETURNS BOOLEAN AS $$
DECLARE
    v_exists BOOLEAN;
BEGIN
    SELECT EXISTS(
        SELECT 1 
        FROM sec_filings 
        WHERE accession_number = p_accession_number
        AND processing_status = 'completed'
    ) INTO v_exists;
    
    RETURN v_exists;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- SAMPLE QUERIES
-- ============================================

COMMENT ON TABLE sec_filings IS 
'Sample Queries:

-- Get all unprocessed DEF 14A filings
SELECT c.company_name, sf.filing_date, sf.filing_url
FROM sec_filings sf
JOIN companies c ON sf.company_id = c.id
WHERE sf.filing_type = ''DEF 14A''
AND sf.processing_status = ''pending''
ORDER BY sf.filing_date DESC;

-- Get companies missing recent proxy statements
SELECT c.company_name, MAX(sf.filing_date) as last_proxy_date
FROM companies c
LEFT JOIN sec_filings sf ON c.id = sf.company_id AND sf.filing_type = ''DEF 14A''
WHERE c.listing_type = ''Public''
GROUP BY c.id, c.company_name
HAVING MAX(sf.filing_date) < CURRENT_DATE - INTERVAL ''18 months''
OR MAX(sf.filing_date) IS NULL;

-- Count filings by type and year
SELECT 
    filing_type,
    filing_year,
    COUNT(*) as filing_count
FROM sec_filings
GROUP BY filing_type, filing_year
ORDER BY filing_year DESC, filing_type;
';

-- Success message
SELECT 'Document tracking tables created successfully!' AS status;
