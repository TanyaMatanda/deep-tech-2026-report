-- Schema Update V2
-- Applying missing columns and tables to the live database

-- 1. Add AI Governance Columns to Companies
ALTER TABLE vendor_governance.companies 
ADD COLUMN IF NOT EXISTS has_ai_ethics_board BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS board_ai_expertise BOOLEAN DEFAULT FALSE;

-- 2. Add Board Chair Gender to Board Composition
ALTER TABLE vendor_governance.board_composition_annual
ADD COLUMN IF NOT EXISTS board_chair_gender VARCHAR(20);

-- 3. Create Shareholder Proposals Table
CREATE TABLE IF NOT EXISTS vendor_governance.shareholder_proposals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES vendor_governance.companies(id) ON DELETE CASCADE,
    proposal_description TEXT NOT NULL,
    proponent TEXT NOT NULL, -- 'Management' or 'Shareholder'
    date_of_meeting DATE,
    vote_for_pct DECIMAL(5,2),
    vote_against_pct DECIMAL(5,2),
    abstain_pct DECIMAL(5,2),
    result TEXT CHECK (result IN ('Pass', 'Fail')),
    topic_category TEXT, -- 'Governance', 'Environmental', 'Social', 'Compensation'
    source_url TEXT, -- Link to SEC filing
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_proposals_company_id ON vendor_governance.shareholder_proposals(company_id);

-- 4. Create News & Monitoring Tables

-- News Tracker
CREATE TABLE IF NOT EXISTS vendor_governance.governance_news (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES vendor_governance.companies(id) ON DELETE CASCADE,
    
    -- Content
    headline TEXT NOT NULL,
    summary TEXT,
    full_text TEXT,
    
    -- Metadata
    source VARCHAR(100) NOT NULL, -- 'SEC', 'Reuters', 'WSJ', 'Bloomberg', etc.
    news_type VARCHAR(50), -- 'M&A', 'Proxy Fight', 'Board Change', 'Activism', 'Compensation', 'Governance', 'Other'
    filing_type VARCHAR(20), -- If from SEC: '8-K', 'DEF 14A', 'SC 13D', etc.
    item_numbers TEXT[], -- For 8-K: ['Item 1.01', 'Item 5.02']
    
    -- Links
    url TEXT NOT NULL,
    sec_accession_number VARCHAR(50), -- If from SEC filing
    
    -- Classification
    relevance_score DECIMAL(3,2) DEFAULT 0.5, -- AI-generated relevance (0-1)
    sentiment VARCHAR(20), -- 'positive', 'negative', 'neutral'
    entities JSONB, -- {"companies": [...], "people": [...], "topics": [...]}
    
    -- Timestamps
    published_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    
    -- Deduplication
    content_hash VARCHAR(64), -- SHA256 of headline+summary for dedup
    
    UNIQUE(content_hash)
);

-- Indexes for news
CREATE INDEX IF NOT EXISTS idx_news_company ON vendor_governance.governance_news(company_id);
CREATE INDEX IF NOT EXISTS idx_news_published ON vendor_governance.governance_news(published_at DESC);
CREATE INDEX IF NOT EXISTS idx_news_type ON vendor_governance.governance_news(news_type);
CREATE INDEX IF NOT EXISTS idx_news_fulltext ON vendor_governance.governance_news USING gin(to_tsvector('english', headline || ' ' || COALESCE(summary, '')));

-- Alert subscriptions
CREATE TABLE IF NOT EXISTS vendor_governance.news_alerts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_email VARCHAR(255) NOT NULL,
    
    -- Filters
    company_ids UUID[], -- Empty array = all companies
    keywords TEXT[], -- ['proxy fight', 'activist', 'merger']
    news_types TEXT[], -- ['M&A', 'Proxy Fight', 'Board Change']
    
    -- Delivery settings
    alert_frequency VARCHAR(20) DEFAULT 'immediate', -- 'immediate', 'daily', 'weekly'
    delivery_channel VARCHAR(20) DEFAULT 'email', -- 'email', 'slack', 'webhook'
    webhook_url TEXT, -- For Slack/Discord webhooks
    
    -- Status
    is_active BOOLEAN DEFAULT true,
    last_sent_at TIMESTAMP,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_alerts_user ON vendor_governance.news_alerts(user_email);

-- Monitoring stats
CREATE TABLE IF NOT EXISTS vendor_governance.news_collection_stats (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    collection_type VARCHAR(50), -- 'SEC_RSS', 'Google_News', etc.
    articles_collected INTEGER,
    articles_stored INTEGER,
    articles_duplicates INTEGER,
    run_duration_seconds DECIMAL(10,2),
    status VARCHAR(20), -- 'success', 'partial', 'failed'
    error_message TEXT,
    collected_at TIMESTAMP DEFAULT NOW()
);
