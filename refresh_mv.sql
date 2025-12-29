-- Refresh Materialized View
-- This script refreshes the materialized view to update scores based on the new data and logic.

BEGIN;
REFRESH MATERIALIZED VIEW vendor_governance.mv_company_scores;
COMMIT;
