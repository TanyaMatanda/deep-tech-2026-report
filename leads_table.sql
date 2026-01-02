-- Lead Capture Table for 140x Problem Dashboard
-- Add to Supabase (public schema for anon access)

CREATE TABLE public.leads_140x (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    industry VARCHAR(100),
    role VARCHAR(100),
    intended_use VARCHAR(100),
    download_requested VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW(),
    ip_address VARCHAR(45),
    user_agent TEXT
);

-- Enable Row Level Security
ALTER TABLE public.leads_140x ENABLE ROW LEVEL SECURITY;

-- Policy: Allow anonymous inserts (for the form)
CREATE POLICY "Allow anonymous inserts" ON public.leads_140x
    FOR INSERT 
    TO anon
    WITH CHECK (true);

-- Policy: Only authenticated users can read (for admin)
CREATE POLICY "Only authenticated can read" ON public.leads_140x
    FOR SELECT
    TO authenticated
    USING (true);

-- Index for email lookups
CREATE INDEX idx_leads_140x_email ON public.leads_140x(email);
CREATE INDEX idx_leads_140x_created ON public.leads_140x(created_at DESC);

-- Grant anon insert permission
GRANT INSERT ON public.leads_140x TO anon;
GRANT SELECT ON public.leads_140x TO authenticated;
