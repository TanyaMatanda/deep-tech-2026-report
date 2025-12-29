-- Reload PostgREST Schema Cache
-- Run this to fix "Could not find table in schema cache" errors
NOTIFY pgrst, 'reload schema';
