-- Grant usage on the schema to API roles
GRANT USAGE ON SCHEMA vendor_governance TO anon, authenticated, service_role;

-- Grant access to all tables in the schema
GRANT ALL ON ALL TABLES IN SCHEMA vendor_governance TO anon, authenticated, service_role;

-- Grant access to sequences (for ID generation)
GRANT ALL ON ALL SEQUENCES IN SCHEMA vendor_governance TO anon, authenticated, service_role;

-- Ensure future tables are also accessible
ALTER DEFAULT PRIVILEGES IN SCHEMA vendor_governance GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA vendor_governance GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;
