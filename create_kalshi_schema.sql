-- Kalshi Predictions Database Schema
-- Track prediction market data from Kalshi for corporate events

CREATE TABLE IF NOT EXISTS vendor_governance.kalshi_predictions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID REFERENCES vendor_governance.companies(id),
    
    -- Market identifiers
    market_ticker VARCHAR(50) UNIQUE NOT NULL, -- e.g., "DATABRICKS-IPO-2026"
    event_ticker VARCHAR(50),                   -- Parent event ticker
    series_ticker VARCHAR(50),                  -- Series grouping
    
    -- Event details
    event_type VARCHAR(50) NOT NULL,            -- 'M&A', 'IPO', 'CEO_Change', 'Governance', etc.
    question TEXT NOT NULL,                     -- "Will Databricks IPO by end of 2026?"
    description TEXT,                            -- Full market description
    
    -- Market data
    yes_price DECIMAL(5,4),                     -- Current yes price (0-1)
    no_price DECIMAL(5,4),                      -- Current no price (0-1)
    yes_probability DECIMAL(5,4),               -- Implied probability from yes price
    volume INTEGER DEFAULT 0,                   -- 24h trading volume
    open_interest INTEGER DEFAULT 0,            -- Open contracts
    
    -- Market status
    status VARCHAR(20),                         -- 'active', 'closed', 'settled'
    settlement_value VARCHAR(10),               -- 'yes', 'no', or null if not settled
    
    -- Timeline
    opens_at TIMESTAMP,                         -- Market open time
    closes_at TIMESTAMP,                        -- Market close/expiration time
    settles_at TIMESTAMP,                       -- When market settles
    
    -- Our analysis
    confidence_score DECIMAL(3,2),              -- How reliable is this signal? (0-1)
    supporting_evidence JSONB,                  -- Links to news, filings, etc.
    tags TEXT[],                                 -- ['tech', 'ai', 'mega-deal']
    
    -- Metadata
    last_updated TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_kalshi_company ON vendor_governance.kalshi_predictions(company_id);
CREATE INDEX IF NOT EXISTS idx_kalshi_event_type ON vendor_governance.kalshi_predictions(event_type);
CREATE INDEX IF NOT EXISTS idx_kalshi_status ON vendor_governance.kalshi_predictions(status);
CREATE INDEX IF NOT EXISTS idx_kalshi_closes_at ON vendor_governance.kalshi_predictions(closes_at);

-- Historical price tracking
CREATE TABLE IF NOT EXISTS vendor_governance.kalshi_price_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    market_ticker VARCHAR(50) NOT NULL,
    
    -- Price snapshot
    yes_price DECIMAL(5,4) NOT NULL,
    no_price DECIMAL(5,4) NOT NULL,
    volume INTEGER,
    open_interest INTEGER,
    
    -- Timestamp
    snapshot_at TIMESTAMP DEFAULT NOW(),
    
    FOREIGN KEY (market_ticker) REFERENCES vendor_governance.kalshi_predictions(market_ticker)
);

CREATE INDEX IF NOT EXISTS idx_price_history_ticker ON vendor_governance.kalshi_price_history(market_ticker);
CREATE INDEX IF NOT EXISTS idx_price_history_time ON vendor_governance.kalshi_price_history(snapshot_at DESC);

-- Company-market associations (for when one market involves multiple companies)
CREATE TABLE IF NOT EXISTS vendor_governance.kalshi_company_links (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    market_ticker VARCHAR(50) NOT NULL,
    company_id UUID REFERENCES vendor_governance.companies(id),
    role VARCHAR(50),  -- 'target', 'acquirer', 'subject', etc.
    
    FOREIGN KEY (market_ticker) REFERENCES vendor_governance.kalshi_predictions(market_ticker)
);

CREATE INDEX IF NOT EXISTS idx_company_links_market ON vendor_governance.kalshi_company_links(market_ticker);
CREATE INDEX IF NOT EXISTS idx_company_links_company ON vendor_governance.kalshi_company_links(company_id);

-- Permissions
GRANT SELECT, INSERT, UPDATE ON vendor_governance.kalshi_predictions TO authenticated;
GRANT SELECT, INSERT ON vendor_governance.kalshi_price_history TO authenticated;
GRANT SELECT, INSERT ON vendor_governance.kalshi_company_links TO authenticated;

-- Comments
COMMENT ON TABLE vendor_governance.kalshi_predictions IS 'Prediction market data from Kalshi for corporate events';
COMMENT ON TABLE vendor_governance.kalshi_price_history IS 'Historical price tracking for Kalshi markets';
COMMENT ON TABLE vendor_governance.kalshi_company_links IS 'Links markets to multiple companies (e.g., M&A deals)';
