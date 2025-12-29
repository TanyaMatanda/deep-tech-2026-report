-- ============================================
-- ISS/OECD COMPENSATION ANALYSIS SCHEMA EXTENSION
-- Extends existing database_schema_supabase.sql
-- ============================================

SET search_path TO vendor_governance, public;

-- ============================================
-- SHORT-TERM INCENTIVE (STI) PLANS
-- ============================================

-- STI Plan Structure (Annual Bonus Framework)
CREATE TABLE sti_plan_structure (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- Plan Design
    plan_name VARCHAR(255), -- "Annual Incentive Plan", "Management Bonus Program"
    target_payout_percent INTEGER, -- % of base salary (e.g., 100% for CEO)
    threshold_payout_percent INTEGER, -- Minimum payout % (e.g., 50%)
    maximum_payout_percent INTEGER, -- Maximum payout % (e.g., 200%)
    
    -- Performance Period
    performance_period_start DATE,
    performance_period_end DATE,
    
    -- Mechanics
    uses_performance_grid BOOLEAN DEFAULT TRUE, -- Matrix of metrics
    allows_discretion BOOLEAN DEFAULT FALSE, -- Board can adjust payout
    discretion_cap_percent INTEGER, -- Maximum discretionary adjustment
    
    -- ESG Integration
    includes_esg_metrics BOOLEAN DEFAULT FALSE,
    esg_weight_percent DECIMAL(5,2),
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, fiscal_year, plan_name)
);

-- STI Performance Metrics
CREATE TABLE sti_performance_metrics (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sti_plan_id UUID REFERENCES sti_plan_structure(id) ON DELETE CASCADE,
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- Metric Definition
    metric_name VARCHAR(255) NOT NULL, -- "Revenue", "Adjusted EBITDA", "Strategic Goals"
    metric_category VARCHAR(100), -- Financial, Operational, Strategic, ESG
    weight_percent DECIMAL(5,2), -- % of total STI (must sum to 100)
    
    -- Targets (Threshold / Target / Maximum)
    threshold_value DECIMAL(20,2), -- e.g., $950M revenue
    target_value DECIMAL(20,2), -- e.g., $1B revenue
    maximum_value DECIMAL(20,2), -- e.g., $1.1B revenue
    metric_unit VARCHAR(50), -- USD, Percent, Count, Boolean
    
    -- Payout Curve
    threshold_payout_percent INTEGER DEFAULT 50, -- Payout at threshold
    target_payout_percent INTEGER DEFAULT 100, -- Payout at target
    maximum_payout_percent INTEGER DEFAULT 200, -- Payout at maximum
    interpolation_method VARCHAR(50), -- Linear, Step-function, S-curve
    
    -- Actual Results
    actual_value DECIMAL(20,2), -- Actual achievement
    achievement_percent DECIMAL(5,2), -- % of target achieved
    earned_payout_percent DECIMAL(5,2), -- Payout for this metric
    
    -- Metadata
    is_disclosed BOOLEAN DEFAULT TRUE, -- Some metrics redacted as confidential
    disclosure_reason TEXT, -- "Competitively sensitive"
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- STI Actual Payouts (Per Executive)
CREATE TABLE sti_payouts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id),
    sti_plan_id UUID REFERENCES sti_plan_structure(id),
    fiscal_year INTEGER NOT NULL,
    
    -- Executive Context
    role VARCHAR(100), -- CEO, CFO, CTO
    base_salary BIGINT, -- For calculating target bonus
    
    -- Calculated Bonus
    target_bonus_amount BIGINT, -- (base_salary * target_payout_percent)
    formula_calculated_bonus BIGINT, -- Based on metrics
    discretionary_adjustment BIGINT, -- Board adjustment (+/-)
    final_bonus_amount BIGINT, -- Actual payout
    
    -- Payout Analysis
    payout_as_percent_of_target DECIMAL(5,2), -- e.g., 150% of target
    payout_as_percent_of_max DECIMAL(5,2),
    
    -- Payment Form
    cash_portion BIGINT,
    equity_portion BIGINT, -- Some companies pay STI in stock
    deferred_portion BIGINT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, person_id, fiscal_year)
);

-- ============================================
-- LONG-TERM INCENTIVE PLANS (LTIP)
-- ============================================

-- Stock Options
CREATE TABLE stock_options (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id),
    
    -- Grant Details
    grant_date DATE NOT NULL,
    fiscal_year INTEGER,
    number_of_options INTEGER,
    exercise_price DECIMAL(10,2), -- Strike price
    grant_date_fair_value BIGINT, -- Black-Scholes or similar
    
    -- Vesting
    vesting_type VARCHAR(50), -- Time-based, Performance-based, Hybrid
    vesting_schedule TEXT, -- "25% per year over 4 years"
    vesting_start_date DATE,
    final_vest_date DATE,
    
    -- Performance Conditions (if applicable)
    has_performance_conditions BOOLEAN DEFAULT FALSE,
    performance_conditions TEXT,
    
    -- Expiration
    expiration_date DATE,
    term_years INTEGER, -- Typically 10 years
    
    -- Status
    options_vested INTEGER DEFAULT 0,
    options_unvested INTEGER,
    options_exercised INTEGER DEFAULT 0,
    options_forfeited INTEGER DEFAULT 0,
    options_outstanding INTEGER, -- Unvested + Vested but unexercised
    
    -- Intrinsic Value (for outstanding awards table)
    stock_price_at_year_end DECIMAL(10,2),
    intrinsic_value BIGINT, -- (stock_price - exercise_price) * options_outstanding
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Restricted Stock Units (RSUs)
CREATE TABLE restricted_stock_units (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id),
    
    -- Grant Details
    grant_date DATE NOT NULL,
    fiscal_year INTEGER,
    number_of_units INTEGER,
    grant_date_fair_value_per_unit DECIMAL(10,2),
    total_grant_value BIGINT,
    
    -- Vesting
    vesting_schedule TEXT, -- "25% per year over 4 years"
    vesting_start_date DATE,
    final_vest_date DATE,
    
    -- Status
    units_vested INTEGER DEFAULT 0,
    units_unvested INTEGER,
    units_forfeited INTEGER DEFAULT 0,
    
    -- Value at Year-End
    stock_price_at_year_end DECIMAL(10,2),
    unvested_value BIGINT, -- units_unvested * stock_price_at_year_end
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Performance Stock Units (PSUs)
CREATE TABLE performance_stock_units (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id),
    
    -- Grant Details
    grant_date DATE NOT NULL,
    fiscal_year INTEGER,
    target_number_of_units INTEGER, -- At 100% performance
    threshold_number_of_units INTEGER, -- At minimum performance (e.g., 50%)
    maximum_number_of_units INTEGER, -- At maximum performance (e.g., 200%)
    grant_date_fair_value_per_unit DECIMAL(10,2),
    target_grant_value BIGINT,
    
    -- Performance Period
    performance_period_start DATE,
    performance_period_end DATE,
    performance_period_years INTEGER, -- Typically 3 years
    
    -- Performance Conditions
    performance_metric_1 VARCHAR(255), -- e.g., "Relative TSR vs. S&P 500"
    performance_metric_1_weight DECIMAL(5,2),
    performance_metric_2 VARCHAR(255),
    performance_metric_2_weight DECIMAL(5,2),
    performance_metric_3 VARCHAR(255),
    performance_metric_3_weight DECIMAL(5,2),
    
    -- Targets
    metric_1_threshold DECIMAL(20,2), -- e.g., 25th percentile TSR
    metric_1_target DECIMAL(20,2), -- e.g., 50th percentile TSR
    metric_1_maximum DECIMAL(20,2), -- e.g., 75th percentile TSR
    
    -- Actual Performance (populated at end of period)
    metric_1_actual DECIMAL(20,2),
    metric_2_actual DECIMAL(20,2),
    metric_3_actual DECIMAL(20,2),
    
    -- Vesting Outcome
    earned_payout_percent DECIMAL(5,2), -- % of target earned (0-200%)
    units_earned INTEGER, -- Actual units vested
    units_forfeited INTEGER,
    
    -- Cliff Provisions
    has_cliff BOOLEAN DEFAULT TRUE, -- Common: <25th percentile = 0%
    cliff_threshold DECIMAL(5,2), -- e.g., 25th percentile
    
    -- Status
    performance_period_complete BOOLEAN DEFAULT FALSE,
    certification_date DATE, -- Board certification of performance
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- PEER GROUP ANALYSIS
-- ============================================

-- Peer Groups (Company-Disclosed)
CREATE TABLE compensation_peer_groups (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- Peer Group Metadata
    peer_group_name VARCHAR(255), -- "Compensation Peer Group", "Performance Peer Group"
    peer_group_purpose VARCHAR(100), -- Compensation Benchmarking, TSR Comparison
    number_of_peers INTEGER,
    
    -- Validation Flags
    is_appropriate BOOLEAN, -- Validated by ISS/analyst
    validation_notes TEXT, -- "Includes non-tech companies", "Market cap mismatch"
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, fiscal_year, peer_group_name)
);

-- Peer Group Members
CREATE TABLE peer_group_members (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    peer_group_id UUID REFERENCES compensation_peer_groups(id) ON DELETE CASCADE,
    peer_company_id UUID REFERENCES companies(id), -- If in our database
    peer_company_name VARCHAR(255) NOT NULL,
    peer_ticker VARCHAR(10),
    
    -- Context at time of disclosure
    peer_market_cap_usd BIGINT, -- Market cap when disclosed
    peer_revenue_usd BIGINT,
    peer_sector VARCHAR(100),
    
    -- Appropriateness
    is_appropriate_peer BOOLEAN, -- Size/sector/business model alignment
    inappropriateness_reason TEXT,
    
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- SAY-ON-PAY VOTING
-- ============================================

-- Say-on-Pay Vote Results
CREATE TABLE say_on_pay_votes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    meeting_date DATE,
    
    -- Vote Results
    votes_for BIGINT,
    votes_against BIGINT,
    votes_abstain BIGINT,
    broker_non_votes BIGINT,
    
    -- Calculated Metrics
    total_votes_cast BIGINT,
    approval_percentage DECIMAL(5,2), -- votes_for / (votes_for + votes_against)
    support_level VARCHAR(20), -- Strong (>90%), Moderate (70-90%), Weak (<70%), Failed (<50%)
    
    -- Proxy Advisor Recommendations
    iss_recommendation VARCHAR(20), -- FOR, AGAINST, Neutral
    glass_lewis_recommendation VARCHAR(20),
    
    -- Engagement
    shareholder_engagement_prior BOOLEAN DEFAULT FALSE, -- Did company engage before vote?
    engagement_description TEXT,
    
    -- Response (if vote failed or weak)
    company_response TEXT, -- Actions taken in response to low vote
    compensation_changes_made BOOLEAN DEFAULT FALSE,
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, fiscal_year)
);

-- ============================================
-- CLAWBACK & GOVERNANCE POLICIES
-- ============================================

-- Clawback Policies
CREATE TABLE clawback_policies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Policy Details
    policy_effective_date DATE,
    policy_type VARCHAR(50), -- SEC Rule 10D-1 Mandatory, Voluntary Enhanced
    
    -- Scope
    applies_to_roles TEXT[], -- Array: ['CEO', 'CFO', 'All NEOs', 'All Officers']
    applies_to_compensation_types TEXT[], -- Array: ['Cash Bonus', 'Equity', 'Both']
    
    -- Triggers
    trigger_restatement BOOLEAN DEFAULT TRUE, -- Financial restatement
    trigger_misconduct BOOLEAN DEFAULT FALSE, -- Individual misconduct
    trigger_fraud BOOLEAN DEFAULT FALSE,
    trigger_policy_violation BOOLEAN DEFAULT FALSE,
    other_triggers TEXT,
    
    -- Lookback Period
    lookback_period_years INTEGER, -- Typically 3 years per SEC rule
    
    -- Evidence
    has_policy_document BOOLEAN DEFAULT TRUE,
    policy_document_url TEXT,
    
    -- Enforcement History
    has_been_enforced BOOLEAN DEFAULT FALSE,
    enforcement_details TEXT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Stock Ownership Guidelines
CREATE TABLE stock_ownership_guidelines (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Role-Based Requirements
    role VARCHAR(100), -- CEO, CFO, CTO, Directors
    required_ownership_multiple DECIMAL(5,2), -- Multiple of base salary (e.g., 6x for CEO)
    required_ownership_value_usd BIGINT, -- Alternative: Fixed dollar amount
    
    -- Compliance Timeline
    years_to_achieve_compliance INTEGER, -- e.g., 5 years from appointment
    
    -- What Counts
    counts_owned_shares BOOLEAN DEFAULT TRUE,
    counts_unvested_rsus BOOLEAN DEFAULT FALSE, -- Some companies count unvested RSUs
    counts_unvested_psus BOOLEAN DEFAULT FALSE,
    counts_vested_unexercised_options BOOLEAN DEFAULT FALSE,
    
    -- Holding Requirements
    post_vest_holding_period_years INTEGER, -- Must hold for X years after vesting
    retention_ratio DECIMAL(5,2), -- Must retain X% of net shares from equity comp
    
    -- Enforcement
    prohibits_sales_until_compliant BOOLEAN DEFAULT FALSE,
    consequences_for_non_compliance TEXT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, role)
);

-- Actual Stock Ownership (Per Executive)
CREATE TABLE executive_stock_ownership (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id),
    fiscal_year INTEGER NOT NULL,
    
    -- Executive Context
    role VARCHAR(100),
    base_salary BIGINT,
    required_ownership_multiple DECIMAL(5,2), -- From guidelines
    required_ownership_value_usd BIGINT,
    
    -- Actual Ownership
    shares_owned INTEGER, -- Directly owned
    shares_owned_value_usd BIGINT,
    unvested_rsus INTEGER,
    unvested_psus_at_target INTEGER,
    vested_unexercised_options INTEGER,
    
    -- Compliance
    is_compliant BOOLEAN,
    ownership_as_multiple_of_salary DECIMAL(5,2),
    time_in_role_years DECIMAL(4,1), -- For grace period tracking
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, person_id, fiscal_year)
);

-- ============================================
-- PERFORMANCE DATA (For Analysis)
-- ============================================

-- Total Shareholder Return (TSR) Calculations
CREATE TABLE tsr_data (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Time Period
    calculation_date DATE NOT NULL, -- Typically fiscal year-end
    period_years INTEGER NOT NULL, -- 1, 3, or 5 years
    start_date DATE,
    end_date DATE,
    
    -- Price Data
    starting_stock_price DECIMAL(10,2),
    ending_stock_price DECIMAL(10,2),
    dividends_paid DECIMAL(10,2), -- Total dividends in period
    
    -- Calculated TSR
    tsr_percent DECIMAL(7,2), -- Total shareholder return %
    annualized_tsr_percent DECIMAL(7,2), -- For multi-year periods
    
    -- Peer Comparison
    peer_group_id UUID REFERENCES compensation_peer_groups(id),
    tsr_percentile_rank INTEGER, -- Rank vs. peers (1-100)
    peer_group_median_tsr DECIMAL(7,2),
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, calculation_date, period_years)
);

-- ============================================
-- ISS-STYLE ANALYSIS VIEWS
-- ============================================

-- Pay-for-Performance Alignment View
CREATE VIEW pay_performance_alignment AS
SELECT 
    c.id AS company_id,
    c.company_name,
    c.ticker_symbol,
    ec.fiscal_year,
    
    -- CEO Compensation
    ec.total_compensation AS ceo_total_comp,
    ec.base_salary AS ceo_base_salary,
    
    -- Performance
    tsr.tsr_percent AS one_year_tsr,
    tsr.tsr_percentile_rank AS tsr_percentile,
    
    -- Pay Rank vs. TSR Rank (ISS metric)
    PERCENT_RANK() OVER (PARTITION BY ec.fiscal_year ORDER BY ec.total_compensation) AS pay_percentile,
    CASE 
        WHEN PERCENT_RANK() OVER (PARTITION BY ec.fiscal_year ORDER BY ec.total_compensation) > (tsr.tsr_percentile_rank / 100.0 + 0.25)
        THEN TRUE 
        ELSE FALSE 
    END AS potential_misalignment,
    
    -- Say-on-Pay
    sop.approval_percentage AS say_on_pay_approval
    
FROM companies c
LEFT JOIN executive_compensation_annual ec ON c.id = ec.company_id AND ec.role = 'CEO'
LEFT JOIN tsr_data tsr ON c.id = tsr.company_id AND tsr.fiscal_year = ec.fiscal_year AND tsr.period_years = 1
LEFT JOIN say_on_pay_votes sop ON c.id = sop.company_id AND sop.fiscal_year = ec.fiscal_year
WHERE ec.role = 'CEO';

-- Create indexes for performance
CREATE INDEX idx_sti_company_year ON sti_plan_structure(company_id, fiscal_year);
CREATE INDEX idx_sti_metrics ON sti_performance_metrics(company_id, fiscal_year);
CREATE INDEX idx_stock_options_person ON stock_options(company_id, person_id, fiscal_year);
CREATE INDEX idx_rsus_person ON restricted_stock_units(company_id, person_id, fiscal_year);
CREATE INDEX idx_psus_person ON performance_stock_units(company_id, person_id, fiscal_year);
CREATE INDEX idx_tsr_lookup ON tsr_data(company_id, calculation_date, period_years);
CREATE INDEX idx_say_on_pay_year ON say_on_pay_votes(company_id, fiscal_year);
