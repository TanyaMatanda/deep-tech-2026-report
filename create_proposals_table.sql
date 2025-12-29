-- Create table for Shareholder Proposals
SET search_path TO vendor_governance, public;

CREATE TABLE IF NOT EXISTS shareholder_proposals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
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
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add index for faster lookups
CREATE INDEX IF NOT EXISTS idx_proposals_company_id ON shareholder_proposals(company_id);

-- Enable RLS
ALTER TABLE shareholder_proposals ENABLE ROW LEVEL SECURITY;

-- Create policy for read access
CREATE POLICY "Allow public read access" ON shareholder_proposals
    FOR SELECT USING (true);

-- Create policy for insert/update (service role only)
CREATE POLICY "Allow service role full access" ON shareholder_proposals
    FOR ALL USING (auth.role() = 'service_role');
