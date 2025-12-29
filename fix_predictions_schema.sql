-- Fix market_ticker field to accommodate Polymarket condition IDs
-- Polymarket uses 66-character hex strings, Kalshi uses shorter tickers

ALTER TABLE vendor_governance.kalshi_predictions 
ALTER COLUMN market_ticker TYPE VARCHAR(100);

-- Also update related fields that might be too short
ALTER TABLE vendor_governance.kalshi_predictions 
ALTER COLUMN question TYPE TEXT;

ALTER TABLE vendor_governance.kalshi_predictions 
ALTER COLUMN description TYPE TEXT;

-- Add index for better performance
CREATE INDEX IF NOT EXISTS idx_kalshi_predictions_event_type 
ON vendor_governance.kalshi_predictions(event_type);

CREATE INDEX IF NOT EXISTS idx_kalshi_predictions_status 
ON vendor_governance.kalshi_predictions(status);
