# Polymarket Political Risk Setup

## Quick Start (3 steps)

### Step 1: Fix Database Schema

In Supabase SQL Editor, run:

```sql
ALTER TABLE vendor_governance.kalshi_predictions 
ALTER COLUMN market_ticker TYPE VARCHAR(100);

ALTER TABLE vendor_governance.kalshi_predictions 
ALTER COLUMN question TYPE TEXT;

ALTER TABLE vendor_governance.kalshi_predictions 
ALTER COLUMN description TYPE TEXT;
```

### Step 2: Sync Political Risk Data

```bash
cd /Users/tanyamatanda/Desktop/Proxy\ Season\ 2026/collectors
python3 sync_political_risks.py
```

You should see:
```
✓ Initialized Polymarket client
Found 102 political/regulatory markets
✓ Synced: Will Donald J. Trump win the U.S. 2024 Republican...
✓ Synced: Will Congress pass AI safety regulation by end...
...
✅ Sync complete: XX political risk events
```

### Step 3: View in Dashboard

1. Refresh Streamlit dashboard
2. Go to "Market Predictions" page
3. See real political risk data with governance impacts!

---

## What You Get

**Real political prediction markets** mapped to corporate governance requirements:

- **Elections** → Board composition, regulatory environment
- **Regulation** → Compliance requirements, disclosure mandates  
- **Trade Policy** (tariffs) → Supply chain governance, geopolitical risk
- **Monetary Policy** → Valuation impacts, compensation structures

**Example**:
> "Polymarket shows 68% probability of tariff increases. This affects 47 tech companies requiring enhanced supply chain oversight and geopolitical risk disclosure."

---

## Troubleshooting

**"Error syncing market: value too long"**
→ Run Step 1 SQL fix above

**"Found 0 political markets"**
→ Polymarket API may be rate-limited. Wait 5 minutes and retry.

**No data showing in dashboard**
→ Check Supabase table: `SELECT COUNT(*) FROM vendor_governance.kalshi_predictions;`

---

## Automation (Optional)

Schedule daily sync with cron:
```bash
0 8 * * * cd /path/to/collectors && python3 sync_political_risks.py
```

Or GitHub Actions for cloud automation.
