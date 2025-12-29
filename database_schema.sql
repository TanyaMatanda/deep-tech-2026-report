-- Deep Tech Governance Database - Complete Schema
-- For Supabase PostgreSQL
-- Includes: Governance, Operations, Revenue Segmentation, Regulatory Compliance

-- ============================================
-- CORE ENTITIES
-- ============================================

-- Companies Master Table (Enhanced with Operational Data)
CREATE TABLE companies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
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
    
    -- AI Governance
    has_ai_ethics_board BOOLEAN DEFAULT FALSE,
    board_ai_expertise BOOLEAN DEFAULT FALSE,
    
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

-- Lines of Business (Revenue Segmentation)
CREATE TABLE lines_of_business (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Business Line Details
    business_line_name VARCHAR(255) NOT NULL, -- e.g., "Quantum Hardware", "Drug Discovery Services"
    business_line_category VARCHAR(100), -- Product, Service, Licensing, Platform
    
    -- Revenue Attribution (from 10-K segment reporting)
    revenue_usd BIGINT, -- Annual revenue from this line
    revenue_percentage DECIMAL(5,2), -- % of total company revenue
    fiscal_year INTEGER,
    
    -- Operating Metrics
    operating_margin DECIMAL(5,2), -- Profitability of this line
    growth_rate_yoy DECIMAL(5,2), -- Year-over-year growth
    
    -- Strategic Importance
    is_core_business BOOLEAN DEFAULT FALSE, -- Dominant revenue driver?
    strategic_priority VARCHAR(20), -- High, Medium, Low
    
    -- Regulatory/Compliance
    requires_special_licensing BOOLEAN DEFAULT FALSE,
    regulatory_approvals_needed TEXT[], -- Array: ['FDA approval', 'ITAR export license']
    
    -- Department/Division Attribution
    department_ownership VARCHAR(100), -- Which department controls this line? (R&D, Sales, Manufacturing)
    executive_sponsor VARCHAR(255), -- Which C-suite exec owns this P&L?
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, business_line_name, fiscal_year)
);

-- Create index for revenue-based queries
CREATE INDEX idx_lines_of_business_revenue ON lines_of_business(company_id, revenue_percentage DESC);

-- Department Power Analysis (Derived from Lines of Business)
CREATE VIEW department_influence AS
SELECT 
    c.id AS company_id,
    c.company_name,
    lob.department_ownership,
    SUM(lob.revenue_usd) AS total_department_revenue,
    SUM(lob.revenue_percentage) AS total_revenue_share,
    COUNT(*) AS number_of_lines,
    AVG(lob.operating_margin) AS avg_operating_margin,
    -- Power score: Revenue % × Profitability × Strategic priority
    (SUM(lob.revenue_percentage) * AVG(lob.operating_margin) * 
     CASE 
        WHEN MAX(lob.strategic_priority) = 'High' THEN 1.5
        WHEN MAX(lob.strategic_priority) = 'Medium' THEN 1.0
        ELSE 0.5
     END) AS department_power_score
FROM companies c
LEFT JOIN lines_of_business lob ON c.id = lob.company_id
WHERE lob.fiscal_year = (SELECT MAX(fiscal_year) FROM lines_of_business WHERE company_id = c.id)
GROUP BY c.id, c.company_name, lob.department_ownership
ORDER BY department_power_score DESC;

-- Regulatory Compliance Tracking
CREATE TABLE regulatory_compliance (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Regulation Details
    regulation_name VARCHAR(255) NOT NULL, -- e.g., "SOX Section 404", "EU AI Act Article 6"
    regulation_category VARCHAR(100), -- Financial, Privacy, Product Safety, AI Governance
    jurisdiction VARCHAR(100), -- USA Federal, California, EU, Ontario
    
    -- Compliance Status
    compliance_status VARCHAR(50), -- Compliant, Non-Compliant, Partially Compliant, Not Applicable
    last_audit_date DATE,
    next_audit_date DATE,
    
    -- Governance Implications
    board_oversight_required BOOLEAN DEFAULT FALSE,
    dedicated_compliance_officer BOOLEAN DEFAULT FALSE,
    
    -- Risk Metrics
    non_compliance_risk_level VARCHAR(20), -- Low, Medium, High, Critical
    potential_penalties_usd BIGINT, -- Maximum fine exposure
    
    -- Evidence Trail
    compliance_documentation_url TEXT,
    certification_number VARCHAR(100),
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, regulation_name)
);

-- ============================================
-- GOVERNANCE DATA (From Proxy Statements)
-- ============================================

-- Board Composition (Annual Snapshot from DEF 14A / Management Circular)
CREATE TABLE board_composition_annual (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- Board Size & Structure
    total_directors INTEGER,
    independent_directors INTEGER,
    non_independent_directors INTEGER,
    
    -- Diversity Metrics
    women_directors INTEGER,
    women_percentage DECIMAL(5,2),
    ethnic_minority_directors INTEGER,
    ethnic_minority_percentage DECIMAL(5,2),
    
    -- Age & Tenure
    avg_director_age DECIMAL(4,1),
    avg_director_tenure DECIMAL(4,1),
    longest_serving_tenure INTEGER,
    
    -- Expertise (Deep Tech Specific)
    tech_experts INTEGER, -- Directors with tech background
    ai_cybersecurity_experts INTEGER,
    scientific_advisors INTEGER,
    
    -- AI Governance (Critical for RiskAnchor)
    has_ai_oversight_committee BOOLEAN DEFAULT FALSE,
    ai_committee_name VARCHAR(255),
    has_ai_ethics_policy BOOLEAN DEFAULT FALSE,
    
    -- Leadership
    ceo_is_board_chair BOOLEAN,
    board_chair_gender VARCHAR(20), -- Male, Female, Non-Binary, Not Disclosed
    lead_independent_director VARCHAR(255),
    
    -- Meetings
    board_meetings_per_year INTEGER,
    avg_attendance_rate DECIMAL(5,2),
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, fiscal_year)
);

-- Executive Compensation (Annual from DEF 14A)
CREATE TABLE executive_compensation_annual (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id),
    fiscal_year INTEGER NOT NULL,
    
    -- Executive Role
    role VARCHAR(100), -- CEO, CFO, CTO, COO, General Counsel
    
    -- Compensation Components (USD)
    base_salary BIGINT,
    bonus BIGINT,
    stock_awards BIGINT,
    option_awards BIGINT,
    non_equity_incentive BIGINT,
    change_in_pension_value BIGINT,
    all_other_compensation BIGINT,
    total_compensation BIGINT,
    
    -- Governance Metrics
    say_on_pay_percentage DECIMAL(5,2), -- Only for CEO, % shareholder approval
    
    -- Department Alignment (NEW: Links exec comp to LOB performance)
    primary_lob_id UUID REFERENCES lines_of_business(id), -- Which LOB does this exec run?
    comp_tied_to_lob_performance BOOLEAN DEFAULT FALSE,
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, person_id, fiscal_year)
);

-- People (Directors, Executives, Key Personnel)
CREATE TABLE people (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
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

-- Company-People Relationships
CREATE TABLE company_people (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id) ON DELETE CASCADE,
    
    role_title VARCHAR(255),
    role_type VARCHAR(50), -- Founder, CEO, CFO, Director, Advisor
    is_board_member BOOLEAN DEFAULT FALSE,
    is_executive BOOLEAN DEFAULT FALSE,
    is_founder BOOLEAN DEFAULT FALSE,
    
    start_date DATE,
    end_date DATE,
    is_current BOOLEAN DEFAULT TRUE,
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, person_id, role_title, start_date)
);

-- ============================================
-- FINANCIAL & PATENT DATA
-- ============================================

-- Financial Metrics (from 10-K, 10-Q)
CREATE TABLE financial_metrics (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    fiscal_year INTEGER,
    fiscal_quarter INTEGER, -- 1-4, NULL for annual
    
    -- Income Statement
    revenue_usd BIGINT,
    gross_profit_usd BIGINT,
    operating_income_usd BIGINT,
    net_income_usd BIGINT,
    
    -- Margins
    gross_margin DECIMAL(5,2),
    operating_margin DECIMAL(5,2),
    net_margin DECIMAL(5,2),
    
    -- R&D Investment
    rd_spend_usd BIGINT,
    rd_percent_revenue DECIMAL(5,2),
    
    -- Balance Sheet
    total_assets_usd BIGINT,
    total_liabilities_usd BIGINT,
    cash_and_equivalents_usd BIGINT,
    
    -- Headcount
    employee_count INTEGER,
    
    source VARCHAR(255), -- 10-K, 10-Q, Company Website
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, fiscal_year, fiscal_quarter)
);

-- Patents (from USPTO, Google Patents)
CREATE TABLE patents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    patent_number VARCHAR(50) UNIQUE NOT NULL,
    patent_office VARCHAR(10), -- USPTO, CIPO, EPO, IMPI
    
    filing_date DATE,
    grant_date DATE,
    
    title TEXT,
    abstract TEXT,
    
    technology_classification TEXT[], -- CPC codes
    inventor_names TEXT[],
    
    citation_count INTEGER DEFAULT 0,
    forward_citations INTEGER DEFAULT 0, -- How many cite this patent
    backward_citations INTEGER DEFAULT 0, -- How many this patent cites
    
    is_active BOOLEAN DEFAULT TRUE,
    expiration_date DATE,
    
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- GOVERNANCE SCORING & RISK METRICS
-- ============================================

-- Governance Scores (Composite)
CREATE TABLE governance_scores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- Component Scores (0-100)
    board_quality_score INTEGER,
    compensation_alignment_score INTEGER,
    shareholder_rights_score INTEGER,
    esg_oversight_score INTEGER,
    ai_governance_score INTEGER, -- Deep tech specific
    regulatory_compliance_score INTEGER,
    
    -- Composite Score (weighted average)
    overall_governance_score INTEGER,
    
    -- Risk Flags for RiskAnchor
    governance_concerns TEXT[], -- Array: ['Dual-class structure', 'Low say-on-pay vote']
    activist_risk_level VARCHAR(20), -- Low, Medium, High
    regulatory_risk_level VARCHAR(20),
    operational_continuity_risk VARCHAR(20), -- Based on leadership stability
    
    -- Department Risk (NEW: Which department poses governance risk?)
    highest_risk_department VARCHAR(100),
    department_risk_rationale TEXT,
    
    last_updated TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, fiscal_year)
);

-- ============================================
-- RISK FACTORS (For RiskAnchor Integration)
-- ============================================

-- 1. Cybersecurity Risk Profile
CREATE TABLE cybersecurity_incidents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Incident Details
    incident_date DATE NOT NULL,
    incident_type VARCHAR(100), -- Data Breach, Ransomware, DDoS, Insider Threat, API Compromise
    severity VARCHAR(20), -- Critical, High, Medium, Low
    
    -- Impact
    records_compromised BIGINT,
    customer_data_exposed BOOLEAN DEFAULT FALSE,
    pii_exposed BOOLEAN DEFAULT FALSE,
    financial_impact_usd BIGINT,
    downtime_hours INTEGER,
    
    -- Response
    notification_required BOOLEAN DEFAULT FALSE, -- GDPR, CCPA, state breach laws
    regulatory_fines_usd BIGINT,
    public_disclosure_url TEXT,
    public_disclosure_date DATE,
    
    -- Insurance
    cyber_insurance_claim_filed BOOLEAN DEFAULT FALSE,
    insurance_payout_usd BIGINT,
    
    -- Resolution
    incident_resolved BOOLEAN DEFAULT FALSE,
    resolution_date DATE,
    root_cause TEXT,
    remediation_actions TEXT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE security_certifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    certification_type VARCHAR(100) NOT NULL, -- SOC2 Type II, ISO 27001, ISO 27017, FedRAMP, HIPAA, PCI-DSS
    certification_scope TEXT, -- What systems/processes are covered
    certification_date DATE,
    expiration_date DATE,
    auditor VARCHAR(255),
    is_current BOOLEAN DEFAULT TRUE,
    
    -- Public Verification
    certification_url TEXT, -- Link to public trust center
    trust_center_url TEXT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- 2. Litigation & Legal Exposure
CREATE TABLE litigation_cases (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Case Details
    case_number VARCHAR(100) UNIQUE,
    court VARCHAR(255),
    jurisdiction VARCHAR(100),
    filing_date DATE,
    case_type VARCHAR(100), -- IP Infringement, Securities Fraud, Employment, Product Liability, Antitrust, Privacy Violation
    
    -- Parties
    plaintiff TEXT,
    defendant TEXT,
    is_company_defendant BOOLEAN, -- TRUE if company is defendant
    
    -- Status
    case_status VARCHAR(50), -- Active, Settled, Dismissed, Judgment, Appealed
    settlement_amount_usd BIGINT,
    settlement_date DATE,
    judgment_amount_usd BIGINT,
    judgment_date DATE,
    
    -- Risk Implications
    material_risk BOOLEAN DEFAULT FALSE, -- Disclosed in 10-K risk factors?
    potential_liability_usd BIGINT, -- Company estimate from 10-K
    insurance_coverage_applicable BOOLEAN,
    
    -- Case Details
    case_summary TEXT,
    allegations TEXT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Regulatory Enforcement Actions
CREATE TABLE regulatory_enforcement (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Action Details
    enforcement_agency VARCHAR(255), -- SEC, FDA, FTC, DOJ, State AG, CNBV
    action_type VARCHAR(100), -- Warning Letter, Consent Decree, Civil Penalty, Criminal Charge
    action_date DATE,
    
    -- Violation
    violation_description TEXT,
    regulation_violated TEXT[], -- Array: ['21 CFR Part 11', 'GDPR Article 5']
    
    -- Outcome
    fine_amount_usd BIGINT,
    other_penalties TEXT, -- Injunction, corrective action plan, etc.
    
    -- Resolution
    resolved BOOLEAN DEFAULT FALSE,
    resolution_date DATE,
    compliance_plan_url TEXT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- 3. Customer Concentration Risk
CREATE TABLE customer_concentration (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- Customer Details (often anonymized in 10-K as "Customer A")
    customer_name VARCHAR(255), -- If disclosed; otherwise "Customer A", "Customer B"
    customer_identifier VARCHAR(100), -- Anonymous ID for tracking across years
    customer_type VARCHAR(100), -- Government, Enterprise, Consumer, Strategic Partner
    customer_industry VARCHAR(100),
    
    -- Revenue Dependency
    revenue_from_customer_usd BIGINT,
    percent_total_revenue DECIMAL(5,2),
    
    -- Risk Flags
    single_customer_over_10_pct BOOLEAN DEFAULT FALSE, -- SEC disclosure threshold
    government_dependent BOOLEAN DEFAULT FALSE, -- Customer is government entity
    
    -- Contract Details
    contract_term_years INTEGER,
    contract_expiration_date DATE,
    renewal_option BOOLEAN,
    
    -- Diversification
    customer_churn_risk VARCHAR(20), -- Low, Medium, High
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, fiscal_year, customer_identifier)
);

-- 4. Technology Stack & Dependencies (Critical for AI Vendors)
CREATE TABLE technology_dependencies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Infrastructure
    cloud_provider TEXT[], -- Array: ['AWS', 'Azure', 'GCP', 'Oracle Cloud']
    cloud_region TEXT[], -- Array: ['us-east-1', 'eu-west-1']
    on_premise_infrastructure BOOLEAN DEFAULT FALSE,
    compute_dependency VARCHAR(255), -- 'NVIDIA H100 GPUs', 'Google TPUs', 'AWS Trainium'
    
    -- AI Model Dependencies
    uses_third_party_models BOOLEAN DEFAULT FALSE,
    model_providers TEXT[], -- Array: ['OpenAI GPT-4', 'Anthropic Claude', 'Meta Llama', 'Mistral']
    foundation_model_licenses TEXT[], -- License types for models used
    
    -- Open Source Dependencies
    critical_open_source_libraries TEXT[], -- Array: ['TensorFlow', 'PyTorch', 'Transformers', 'LangChain']
    open_source_license_risks TEXT[], -- GPL contamination, Apache 2.0, MIT, etc.
    software_bill_of_materials_url TEXT, -- SBOM for transparency
    
    -- Data Dependencies
    training_data_sources TEXT[], -- Proprietary, Common Crawl, Licensed (e.g., shutterstock), Scraped
    data_licensing_issues BOOLEAN DEFAULT FALSE,
    data_provenance_documented BOOLEAN DEFAULT FALSE,
    
    -- Vendor Concentration Risk
    has_vendor_concentration_risk BOOLEAN DEFAULT FALSE,
    vendor_lock_in_severity VARCHAR(20), -- Low, Medium, High, Critical
    single_point_of_failure TEXT[], -- Array: ['OpenAI API', 'NVIDIA GPU supply']
    
    -- API Dependencies
    third_party_apis TEXT[], -- External APIs the product depends on
    api_rate_limit_risks BOOLEAN DEFAULT FALSE,
    
    last_updated TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW()
);

-- 5. Export Controls & National Security
CREATE TABLE export_control_classification (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- ITAR (International Traffic in Arms Regulations)
    subject_to_itar BOOLEAN DEFAULT FALSE,
    itar_registration_number VARCHAR(50),
    itar_controlled_products TEXT[], -- Which products/tech are ITAR-controlled
    
    -- EAR (Export Administration Regulations)
    subject_to_ear BOOLEAN DEFAULT FALSE,
    eccn_classification VARCHAR(20), -- Export Control Classification Number (e.g., 3E991)
    ear_controlled_products TEXT[],
    
    -- Emerging & Foundational Technologies
    emerging_tech_category TEXT[], -- Array: ['AI', 'Quantum', 'Biotech', 'Hypersonics', 'Advanced Semiconductors']
    foundational_tech BOOLEAN DEFAULT FALSE, -- Subject to Commerce Dept restrictions (2018 ECRA)
    
    -- Foreign Ownership & CFIUS
    foreign_ownership_percent DECIMAL(5,2),
    foreign_ownership_countries TEXT[], -- Countries of foreign investors
    cfius_review_required BOOLEAN DEFAULT FALSE, -- Committee on Foreign Investment in US
    cfius_review_date DATE,
    cfius_review_outcome VARCHAR(50), -- Approved, Approved with Mitigation, Blocked
    
    -- Restricted Parties
    cannot_export_to TEXT[], -- Array: ['China', 'Russia', 'Iran', 'North Korea', etc.]
    entity_list_concerns BOOLEAN DEFAULT FALSE, -- Products used by Entity List companies
    
    -- Deemed Exports
    employs_foreign_nationals BOOLEAN,
    deemed_export_controls BOOLEAN, -- Restrictions on foreign national employees
    
    last_updated TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW()
);

-- 6. Executive Turnover & Key Person Risk
CREATE TABLE executive_turnover (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id),
    
    role VARCHAR(100) NOT NULL, -- CEO, CTO, CFO, COO, Chief Scientist, General Counsel
    departure_date DATE,
    departure_type VARCHAR(50), -- Resignation, Termination, Retirement, Mutual Agreement, Death
    departure_reason TEXT,
    is_planned_succession BOOLEAN DEFAULT FALSE,
    
    -- Succession
    immediate_replacement BOOLEAN DEFAULT FALSE,
    replacement_person_id UUID REFERENCES people(id),
    interim_leadership BOOLEAN DEFAULT FALSE,
    time_to_replacement_days INTEGER,
    
    -- Market Impact (for public companies)
    stock_price_change_pct DECIMAL(5,2), -- Change on announcement day
    announcement_url TEXT,
    
    -- Governance Red Flags
    part_of_mass_exodus BOOLEAN DEFAULT FALSE, -- Multiple execs leaving simultaneously
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE key_person_risk (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id),
    
    role VARCHAR(100),
    is_irreplaceable BOOLEAN DEFAULT FALSE, -- Disclosed as key person in 10-K risk factors?
    key_person_insurance_coverage_usd BIGINT,
    
    succession_plan_documented BOOLEAN DEFAULT FALSE,
    successor_identified BOOLEAN DEFAULT FALSE,
    
    -- Risk Rationale
    criticality_reason TEXT, -- Why is this person irreplaceable? (e.g., "Only person with quantum expertise")
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, person_id)
);

-- 7. Product Safety & Recalls
CREATE TABLE product_safety_incidents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    incident_date DATE,
    incident_type VARCHAR(100), -- Recall, Safety Alert, FDA Warning Letter, Accident, Adverse Event
    
    -- Product Details
    product_name VARCHAR(255),
    product_line_id UUID REFERENCES lines_of_business(id),
    product_category VARCHAR(100), -- Drug, Medical Device, Autonomous Vehicle, Food Product
    
    -- Severity
    severity VARCHAR(20), -- Critical, Serious, Moderate, Minor
    injuries_reported INTEGER DEFAULT 0,
    deaths_reported INTEGER DEFAULT 0,
    adverse_events_count INTEGER DEFAULT 0,
    
    -- Regulatory Response
    fda_warning_letter BOOLEAN DEFAULT FALSE,
    fda_483_observations BOOLEAN DEFAULT FALSE,
    consent_decree BOOLEAN DEFAULT FALSE,
    production_halted BOOLEAN DEFAULT FALSE,
    clinical_hold BOOLEAN DEFAULT FALSE, -- For drug trials
    
    -- Scope
    units_affected INTEGER,
    geographic_scope TEXT[], -- Array: ['United States', 'European Union', 'Global']
    
    -- Financial Impact
    recall_cost_usd BIGINT,
    legal_settlements_usd BIGINT,
    revenue_impact_usd BIGINT, -- Lost sales
    
    -- Resolution
    root_cause TEXT,
    corrective_actions TEXT,
    preventive_actions TEXT,
    resolved_date DATE,
    
    -- Public Disclosure
    disclosure_url TEXT,
    fda_recall_number VARCHAR(50),
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- 8. Insurance Coverage Details
CREATE TABLE insurance_coverage (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Policy Details
    policy_type VARCHAR(100) NOT NULL, -- D&O, Cyber, E&O, Product Liability, Clinical Trial, Employment Practices
    policy_carrier VARCHAR(255),
    policy_number VARCHAR(100),
    
    -- Coverage Limits
    coverage_limit_usd BIGINT,
    deductible_usd BIGINT,
    aggregate_limit_usd BIGINT,
    per_occurrence_limit_usd BIGINT,
    
    -- Policy Period
    effective_date DATE,
    expiration_date DATE,
    is_current BOOLEAN DEFAULT TRUE,
    
    -- Pricing (if disclosed in 10-K)
    annual_premium_usd BIGINT,
    premium_increase_yoy DECIMAL(5,2), -- % increase indicates rising risk
    
    -- Claims History
    claims_last_3_years INTEGER,
    total_claims_paid_usd BIGINT,
    
    -- Coverage Gaps
    has_coverage_gaps BOOLEAN DEFAULT FALSE,
    coverage_gap_description TEXT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- 9. ESG & Sustainability Metrics
CREATE TABLE esg_metrics (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER NOT NULL,
    
    -- Carbon Emissions (Scope 1, 2, 3)
    scope1_emissions_mt_co2e BIGINT, -- Metric tons CO2 equivalent (direct emissions)
    scope2_emissions_mt_co2e BIGINT, -- Indirect (electricity, heating, cooling)
    scope3_emissions_mt_co2e BIGINT, -- Value chain (supply chain, employee commuting, etc.)
    total_emissions_mt_co2e BIGINT,
    
    -- Energy
    renewable_energy_pct DECIMAL(5,2),
    total_energy_consumed_mwh BIGINT, -- Megawatt-hours
    carbon_intensity DECIMAL(10,2), -- Emissions per unit revenue
    
    -- Workforce
    employee_count INTEGER,
    employee_turnover_rate DECIMAL(5,2),
    women_workforce_pct DECIMAL(5,2),
    women_leadership_pct DECIMAL(5,2),
    underrepresented_minorities_pct DECIMAL(5,2),
    pay_equity_disclosed BOOLEAN DEFAULT FALSE,
    pay_gap_pct DECIMAL(5,2), -- Gender pay gap
    
    -- Certifications
    b_corp_certified BOOLEAN DEFAULT FALSE,
    carbon_neutral_certified BOOLEAN DEFAULT FALSE,
    leed_certified_facilities INTEGER,
    
    -- Disclosure Frameworks
    follows_tcfd BOOLEAN DEFAULT FALSE, -- Task Force on Climate-related Financial Disclosures
    follows_sasb BOOLEAN DEFAULT FALSE, -- Sustainability Accounting Standards Board
    follows_gri BOOLEAN DEFAULT FALSE, -- Global Reporting Initiative
    
    -- Third-Party Ratings (if available from free sources)
    cdp_score VARCHAR(3), -- A, A-, B, B-, C, C-, D, D-, F
    
    -- Controversies
    esg_controversies TEXT[], -- Environmental fines, labor violations, etc.
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(company_id, fiscal_year)
);

-- 10. Clinical Trials (Biotech/Pharma Specific)
CREATE TABLE clinical_trials (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- ClinicalTrials.gov Data
    nct_number VARCHAR(20) UNIQUE, -- ClinicalTrials.gov identifier (e.g., NCT04567890)
    trial_title TEXT,
    official_title TEXT,
    
    -- Intervention
    drug_or_device_name VARCHAR(255),
    intervention_type VARCHAR(50), -- Drug, Biological, Device, Diagnostic Test
    
    -- Trial Design
    phase VARCHAR(20), -- Phase I, Phase I/II, Phase II, Phase III, Phase IV
    study_type VARCHAR(50), -- Interventional, Observational
    indication TEXT, -- Disease/condition being treated
    primary_outcome TEXT,
    secondary_outcomes TEXT[],
    
    -- Enrollment
    enrollment_target INTEGER,
    actual_enrollment INTEGER,
    enrollment_start_date DATE,
    
    -- Status
    trial_status VARCHAR(50), -- Not yet recruiting, Recruiting, Active, Completed, Terminated, Suspended, Withdrawn
    start_date DATE,
    primary_completion_date DATE,
    study_completion_date DATE,
    
    -- Outcomes
    primary_endpoint_met BOOLEAN,
    statistical_significance_achieved BOOLEAN,
    fda_approval_granted BOOLEAN,
    approval_date DATE,
    
    -- Negative Outcomes
    trial_discontinued BOOLEAN DEFAULT FALSE,
    discontinuation_reason TEXT, -- Lack of efficacy, Safety concerns, Futility
    serious_adverse_events INTEGER,
    
    -- Financial Impact
    estimated_trial_cost_usd BIGINT,
    
    -- Public Data
    clinicaltrials_gov_url TEXT,
    trial_results_published BOOLEAN DEFAULT FALSE,
    results_publication_url TEXT,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- RISK FACTOR INDEXES
-- ============================================

-- Cybersecurity
CREATE INDEX idx_cyber_incidents_company ON cybersecurity_incidents(company_id, incident_date DESC);
CREATE INDEX idx_cyber_incidents_severity ON cybersecurity_incidents(severity, incident_date DESC);
CREATE INDEX idx_security_certs_current ON security_certifications(company_id, is_current);

-- Litigation
CREATE INDEX idx_litigation_company ON litigation_cases(company_id, filing_date DESC);
CREATE INDEX idx_litigation_status ON litigation_cases(case_status, case_type);
CREATE INDEX idx_enforcement_agency ON regulatory_enforcement(enforcement_agency, action_date DESC);

-- Customer Concentration
CREATE INDEX idx_customer_concentration ON customer_concentration(company_id, fiscal_year, percent_total_revenue DESC);

-- Technology Dependencies
CREATE INDEX idx_tech_dependencies ON technology_dependencies(company_id);

-- Export Controls
CREATE INDEX idx_export_controls ON export_control_classification(company_id);

-- Executive Turnover
CREATE INDEX idx_exec_turnover_company ON executive_turnover(company_id, departure_date DESC);
CREATE INDEX idx_key_person_risk ON key_person_risk(company_id, is_irreplaceable);

-- Product Safety
CREATE INDEX idx_product_safety ON product_safety_incidents(company_id, incident_date DESC, severity);

-- Insurance
CREATE INDEX idx_insurance_coverage ON insurance_coverage(company_id, policy_type, is_current);

-- ESG
CREATE INDEX idx_esg_metrics ON esg_metrics(company_id, fiscal_year DESC);

-- Clinical Trials
CREATE INDEX idx_clinical_trials_company ON clinical_trials(company_id, phase);
CREATE INDEX idx_clinical_trials_status ON clinical_trials(trial_status, phase);

-- ============================================
-- DATA COLLECTION METADATA
-- ============================================

-- Scraping Jobs Log
CREATE TABLE scraping_jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
    job_type VARCHAR(100), -- 'sec_edgar_daily', 'sedar_weekly', 'patent_monthly'
    target_entity VARCHAR(100), -- 'Tier 1 Public Companies', 'All Companies'
    
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    duration_seconds INTEGER,
    
    records_processed INTEGER,
    records_updated INTEGER,
    records_created INTEGER,
    errors_count INTEGER,
    
    status VARCHAR(50), -- Running, Completed, Failed
    error_log TEXT,
    
    created_at TIMESTAMP DEFAULT NOW()
);

-- Data Source Attribution
CREATE TABLE data_sources (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    data_field VARCHAR(100), -- 'incorporation_date', 'revenue_usd', etc.
    source_name VARCHAR(100), -- 'SEC EDGAR 10-K', 'Crunchbase', 'Company Website'
    source_url TEXT,
    source_date DATE,
    
    confidence_score DECIMAL(3,2), -- 0.00 to 1.00
    
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

-- Companies
CREATE INDEX idx_companies_ticker ON companies(ticker_symbol);
CREATE INDEX idx_companies_sector ON companies(primary_sector, primary_subsector);
CREATE INDEX idx_companies_jurisdiction ON companies(incorporation_jurisdiction);
CREATE INDEX idx_companies_tier ON companies(data_tier);

-- Lines of Business
CREATE INDEX idx_lob_company ON lines_of_business(company_id, fiscal_year);
CREATE INDEX idx_lob_department ON lines_of_business(department_ownership);

-- Governance
CREATE INDEX idx_governance_score ON governance_scores(company_id, fiscal_year);
CREATE INDEX idx_governance_risk ON governance_scores(activist_risk_level, regulatory_risk_level);

-- Regulatory Compliance
CREATE INDEX idx_compliance_status ON regulatory_compliance(company_id, compliance_status);
CREATE INDEX idx_compliance_jurisdiction ON regulatory_compliance(jurisdiction);

-- ============================================
-- ROW LEVEL SECURITY (For Tiered Access)
-- ============================================

-- Enable RLS
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE lines_of_business ENABLE ROW LEVEL SECURITY;
ALTER TABLE governance_scores ENABLE ROW LEVEL SECURITY;

-- Policy: Free users can see up to 10 companies
CREATE POLICY "free_user_limit" ON companies
FOR SELECT
USING (
    auth.jwt() ->> 'user_tier' = 'free' AND
    id IN (
        SELECT id FROM companies
        ORDER BY data_quality_score DESC
        LIMIT 10
    )
    OR auth.jwt() ->> 'user_tier' IN ('pro', 'team', 'enterprise')
);

-- Policy: Pro/Team/Enterprise users see all
CREATE POLICY "paid_users_full_access" ON companies
FOR SELECT
USING (auth.jwt() ->> 'user_tier' IN ('pro', 'team', 'enterprise'));

-- ============================================
-- HELPER FUNCTIONS
-- ============================================

-- Calculate Department with Most Revenue Sway
CREATE OR REPLACE FUNCTION get_dominant_department(p_company_id UUID)
RETURNS TABLE(department VARCHAR, revenue_share DECIMAL, power_score DECIMAL) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        lob.department_ownership,
        SUM(lob.revenue_percentage),
        (SUM(lob.revenue_percentage) * AVG(lob.operating_margin))::DECIMAL(5,2)
    FROM lines_of_business lob
    WHERE lob.company_id = p_company_id
    AND lob.fiscal_year = (SELECT MAX(fiscal_year) FROM lines_of_business WHERE company_id = p_company_id)
    GROUP BY lob.department_ownership
    ORDER BY power_score DESC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;

-- Calculate Governance Risk Score for RiskAnchor
CREATE OR REPLACE FUNCTION calculate_riskanchor_vendor_score(p_company_id UUID)
RETURNS INTEGER AS $$
DECLARE
    v_score INTEGER := 100;
    v_board RECORD;
    v_comp RECORD;
BEGIN
    -- Get latest governance data
    SELECT * INTO v_board FROM board_composition_annual 
    WHERE company_id = p_company_id 
    ORDER BY fiscal_year DESC LIMIT 1;
    
    -- Deduct points for governance red flags
    IF v_board.independent_directors::FLOAT / v_board.total_directors < 0.5 THEN
        v_score := v_score - 15; -- Board not majority independent
    END IF;
    
    IF NOT v_board.has_ai_oversight_committee THEN
        v_score := v_score - 20; -- Critical for AI vendors
    END IF;
    
    IF v_board.ceo_is_board_chair THEN
        v_score := v_score - 10; -- CEO/Chair overlap
    END IF;
    
    -- Check say-on-pay
    SELECT * INTO v_comp FROM executive_compensation_annual
    WHERE company_id = p_company_id AND role = 'CEO'
    ORDER BY fiscal_year DESC LIMIT 1;
    
    IF v_comp.say_on_pay_percentage < 70 THEN
        v_score := v_score - 15; -- Low shareholder support
    END IF;
    
    RETURN GREATEST(0, v_score);
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- SAMPLE QUERIES FOR RISKANCHOR INTEGRATION
-- ============================================

-- Query: AI Vendors with Weak Governance
COMMENT ON TABLE governance_scores IS 
'Sample Query for RiskAnchor:
SELECT 
    c.company_name,
    c.primary_subsector,
    gs.ai_governance_score,
    gs.overall_governance_score,
    calculate_riskanchor_vendor_score(c.id) AS vendor_risk_score
FROM companies c
JOIN governance_scores gs ON c.id = gs.company_id
WHERE c.primary_sector = ''AI & Machine Learning''
AND gs.fiscal_year = 2025
ORDER BY vendor_risk_score ASC
LIMIT 20;';

-- Query: Companies by Department Power
COMMENT ON VIEW department_influence IS
'Sample Query for Analysis:
SELECT * FROM department_influence
WHERE company_name = ''OpenAI''
ORDER BY department_power_score DESC;';

-- ============================================
-- SHAREHOLDER PROPOSALS
-- ============================================

CREATE TABLE shareholder_proposals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
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

CREATE INDEX idx_proposals_company_id ON shareholder_proposals(company_id);

-- ============================================
-- NEWS & MONITORING
-- ============================================

-- News Tracker
CREATE TABLE governance_news (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
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
CREATE INDEX idx_news_company ON governance_news(company_id);
CREATE INDEX idx_news_published ON governance_news(published_at DESC);
CREATE INDEX idx_news_type ON governance_news(news_type);
CREATE INDEX idx_news_fulltext ON governance_news USING gin(to_tsvector('english', headline || ' ' || COALESCE(summary, '')));

-- Alert subscriptions
CREATE TABLE news_alerts (
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

CREATE INDEX idx_alerts_user ON news_alerts(user_email);

-- Monitoring stats
CREATE TABLE news_collection_stats (
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
