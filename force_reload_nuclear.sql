-- Force PostgREST Schema Cache Reload via DDL
-- Sometimes NOTIFY isn't enough. Creating/Dropping a table forces a cache rebuild.

-- 1. Create a dummy table
CREATE TABLE IF NOT EXISTS vendor_governance._cache_buster (
    id serial primary key
);

-- 2. Notify just in case
NOTIFY pgrst, 'reload schema';

-- 3. Drop the dummy table
DROP TABLE IF EXISTS vendor_governance._cache_buster;

-- 4. Grant permissions again just to be sure
GRANT SELECT ON vendor_governance.view_company_scores TO authenticated;
GRANT SELECT ON vendor_governance.view_company_scores TO service_role;
