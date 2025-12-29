# Quick Fix: Filter Stale Polymarket Events

## Problem
Polymarket API returns many closed/historical events from 2023, making the political risk page look outdated.

## Solution Applied
Updated `political_risk_page.py` to filter out events with:
- Date mentions of 2023, 2022
- Specific old dates (March 31, February, etc.)
- Historical event indicators

## Better Long-Term Solution
Polymarket has limited current corporate governance events. Consider:

1. **Use Metaculus** (forecasting platform) - More current, higher quality
2. **Build proprietary model** - Use SEC filings as signals:
   - 8-K surge → M&A probability
   - DEF 14A patterns → Activist campaigns
   - 10-K risk factor changes → Emerging risks
3. **Hybrid**: Polymarket for what exists + proprietary for gaps

## Current Status
- ✅ Political risk page working
- ✅ Company connections functional
- ⚠️ Limited current events from Polymarket
- ✅ Filtering applied to remove stale data

## Recommendation
Focus on **proprietary signals** - you have governance data that prediction markets don't!
