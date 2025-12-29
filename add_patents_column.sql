ALTER TABLE vendor_governance.companies 
ADD COLUMN IF NOT EXISTS patents_count INTEGER DEFAULT 0;

COMMENT ON COLUMN vendor_governance.companies.patents_count IS 'Number of patents held by the company';
