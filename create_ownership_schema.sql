-- Phase 13: Ownership Analytics

-- 1. Create Ownership Structure Table
CREATE TABLE IF NOT EXISTS vendor_governance.ownership_structure (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID REFERENCES vendor_governance.companies(id) ON DELETE CASCADE,
    fiscal_year INTEGER,
    founder_pct DECIMAL(5,2),
    vc_pct DECIMAL(5,2),
    institutional_pct DECIMAL(5,2),
    public_float_pct DECIMAL(5,2),
    strategic_corp_pct DECIMAL(5,2),
    govt_univ_pct DECIMAL(5,2),
    employee_other_pct DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(company_id, fiscal_year)
);

-- 2. Populate Data based on Archetypes
-- We will generate data for 2024 and 2025
DO $$
DECLARE
    r RECORD;
    y INTEGER;
    v_founder DECIMAL;
    v_vc DECIMAL;
    v_inst DECIMAL;
    v_public DECIMAL;
    v_strategic DECIMAL;
    v_govt DECIMAL;
    v_employee DECIMAL;
    v_rem DECIMAL;
BEGIN
    FOR r IN SELECT id, ownership_archetype FROM vendor_governance.companies WHERE ownership_archetype IS NOT NULL LOOP
        FOR y IN 2024..2025 LOOP
            -- Reset values
            v_founder := 0; v_vc := 0; v_inst := 0; v_public := 0; v_strategic := 0; v_govt := 0; v_employee := 0;
            
            IF r.ownership_archetype = 'Venture-Backed' THEN
                v_founder := (random() * 20 + 20); -- 20-40%
                v_vc := (random() * 20 + 40); -- 40-60%
                v_strategic := (random() * 10); -- 0-10%
                v_govt := 0;
                v_inst := 0;
                v_public := 0;
                
            ELSIF r.ownership_archetype = 'Academic Spinout' THEN
                v_founder := (random() * 20 + 30); -- 30-50%
                v_govt := (random() * 10 + 10); -- 10-20% (Univ/Govt)
                v_vc := (random() * 20 + 10); -- 10-30%
                v_strategic := (random() * 10 + 10); -- 10-20%
                v_inst := 0;
                v_public := 0;
                
            ELSIF r.ownership_archetype = 'Megacap Subsidiary' THEN
                v_strategic := 100; -- Parent Company owns 100%
                
            ELSE -- Public Pure-Play
                v_inst := (random() * 30 + 40); -- 40-70%
                v_public := (random() * 20 + 20); -- 20-40%
                v_founder := (random() * 10 + 5); -- 5-15%
                v_vc := (random() * 5); -- 0-5%
                v_strategic := 0;
                v_govt := 0;
            END IF;
            
            -- Calculate Remainder for Employee/Other
            v_rem := 100 - (v_founder + v_vc + v_inst + v_public + v_strategic + v_govt);
            IF v_rem < 0 THEN v_rem := 0; END IF;
            v_employee := v_rem;
            
            -- Insert
            INSERT INTO vendor_governance.ownership_structure (
                company_id, fiscal_year, founder_pct, vc_pct, institutional_pct, 
                public_float_pct, strategic_corp_pct, govt_univ_pct, employee_other_pct
            ) VALUES (
                r.id, y, 
                ROUND(v_founder, 1), 
                ROUND(v_vc, 1), 
                ROUND(v_inst, 1), 
                ROUND(v_public, 1), 
                ROUND(v_strategic, 1), 
                ROUND(v_govt, 1), 
                ROUND(v_employee, 1)
            )
            ON CONFLICT (company_id, fiscal_year) DO UPDATE SET
                founder_pct = EXCLUDED.founder_pct,
                vc_pct = EXCLUDED.vc_pct,
                institutional_pct = EXCLUDED.institutional_pct,
                public_float_pct = EXCLUDED.public_float_pct,
                strategic_corp_pct = EXCLUDED.strategic_corp_pct,
                govt_univ_pct = EXCLUDED.govt_univ_pct,
                employee_other_pct = EXCLUDED.employee_other_pct;
                
        END LOOP;
    END LOOP;
END $$;
