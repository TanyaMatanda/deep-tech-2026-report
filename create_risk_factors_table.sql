-- Create table for detailed risk and governance factors
-- Linked to companies table via company_id

SET search_path TO vendor_governance, public;

CREATE TABLE IF NOT EXISTS company_risk_factors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- 1. Governance
    board_independence_pct DECIMAL(5,2),
    split_chair_ceo BOOLEAN,
    board_diversity_pct DECIMAL(5,2),
    overboarded_directors_count INTEGER,
    avg_director_tenure DECIMAL(4,1),
    board_interlocks_count INTEGER,
    attendance_issues_count INTEGER,
    
    -- 2. Compensation
    say_on_pay_support DECIMAL(5,2),
    ceo_pay_ratio INTEGER,
    has_clawback_policy BOOLEAN,
    pay_for_perf_alignment TEXT,
    
    -- 3. AI Governance
    has_ai_ethics_board BOOLEAN,
    board_ai_expertise BOOLEAN,
    ai_risk_mentions INTEGER,
    
    -- 4. Cybersecurity
    cyber_oversight_explicit BOOLEAN,
    ciso_reporting_line TEXT,
    breach_history BOOLEAN,
    
    -- 5. Shareholder Rights
    dual_class_stock BOOLEAN,
    special_meeting_threshold TEXT,
    written_consent BOOLEAN,
    
    -- 6. Risk Factors (10-K)
    risk_factor_count INTEGER,
    new_risk_count INTEGER,
    climate_risk_mentions INTEGER,
    supply_chain_risk_mentions INTEGER,
    
    -- 7. Committees
    audit_meetings INTEGER,
    comp_meetings INTEGER,
    gov_meetings INTEGER,
    has_tech_committee BOOLEAN,
    has_risk_committee BOOLEAN,
    has_sustainability_committee BOOLEAN,
    
    -- 8. Financial Performance
    tsr_1y DECIMAL(10,2),
    tsr_3y DECIMAL(10,2),
    roic DECIMAL(10,2),
    revenue_growth DECIMAL(10,2),
    ebitda_margin DECIMAL(10,2),
    free_cash_flow DECIMAL(15,2),
    
    -- 9. Business Continuity & ESG
    has_succession_plan BOOLEAN,
    has_bcp BOOLEAN,
    climate_oversight BOOLEAN,
    discloses_scope1_2 BOOLEAN,
    turnover_rate DECIMAL(5,2),
    dei_disclosure BOOLEAN,
    
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(company_id, fiscal_year)
);

-- RLS Policies
ALTER TABLE company_risk_factors ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access" ON company_risk_factors
    FOR SELECT USING (true);

CREATE POLICY "Allow service role full access" ON company_risk_factors
    FOR ALL USING (auth.role() = 'service_role');
