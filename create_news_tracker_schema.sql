-- News Tracker Database Schema
-- Track corporate governance news from SEC filings and news sources

CREATE TABLE IF NOT EXISTS vendor_governance.governance_news (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID REFERENCES vendor_governance.companies(id),
    
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

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_news_company ON vendor_governance.governance_news(company_id);
CREATE INDEX IF NOT EXISTS idx_news_published ON vendor_governance.governance_news(published_at DESC);
CREATE INDEX IF NOT EXISTS idx_news_type ON vendor_governance.governance_news(news_type);
CREATE INDEX IF NOT EXISTS idx_news_source ON vendor_governance.governance_news(source);
CREATE INDEX IF NOT EXISTS idx_news_filing_type ON vendor_governance.governance_news(filing_type);

-- Full-text search on headlines and summaries
CREATE INDEX IF NOT EXISTS idx_news_fulltext ON vendor_governance.governance_news 
    USING gin(to_tsvector('english', headline || ' ' || COALESCE(summary, '')));

-- Alert subscriptions table
CREATE TABLE IF NOT EXISTS vendor_governance.news_alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
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
CREATE INDEX IF NOT EXISTS idx_alerts_active ON vendor_governance.news_alerts(is_active);

-- Monitoring stats table
CREATE TABLE IF NOT EXISTS vendor_governance.news_collection_stats (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    collection_type VARCHAR(50), -- 'SEC_RSS', 'Google_News', etc.
    articles_collected INTEGER,
    articles_stored INTEGER,
    articles_duplicates INTEGER,
    run_duration_seconds DECIMAL(10,2),
    status VARCHAR(20), -- 'success', 'partial', 'failed'
    error_message TEXT,
    collected_at TIMESTAMP DEFAULT NOW()
);

-- Grant permissions
GRANT SELECT, INSERT, UPDATE ON vendor_governance.governance_news TO authenticated;
GRANT SELECT, INSERT, UPDATE ON vendor_governance.news_alerts TO authenticated;
GRANT SELECT, INSERT ON vendor_governance.news_collection_stats TO authenticated;

-- Sample data for testing
COMMENT ON TABLE vendor_governance.governance_news IS 'Corporate governance news from SEC filings and external sources';
COMMENT ON TABLE vendor_governance.news_alerts IS 'User subscriptions for governance news alerts';
