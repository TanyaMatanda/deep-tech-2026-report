# Kalshi Integration Setup Guide

## Step 1: Create Kalshi Account

1. Go to https://kalshi.com
2. Click "Sign Up"
3. Create account (email + password)
4. Verify email

**Note**: Kalshi requires real identity verification (KYC) for trading, but you can browse markets without it.

## Step 2: Get API Credentials

Your credentials are just your login email/password. No separate API key needed.

**Set environment variables**:
```bash
export KALSHI_EMAIL="your-email@example.com"
export KALSHI_PASSWORD="your-password"
```

Or add to `.env` file:
```
KALSHI_EMAIL=your-email@example.com
KALSHI_PASSWORD=your-password
```

## Step 3: Create Database Tables

Run the SQL in Supabase:
```bash
# In Supabase SQL Editor, run:
/Users/tanyamatanda/Desktop/Proxy Season 2026/create_kalshi_schema.sql
```

This creates:
- `kalshi_predictions` - Market data
- `kalshi_price_history` - Price snapshots  
- `kalshi_company_links` - Market-company associations

## Step 4: Test API Connection

```bash
cd /Users/tanyamatanda/Desktop/Proxy\ Season\ 2026/collectors

# Set credentials first
export KALSHI_EMAIL="your-email"
export KALSHI_PASSWORD="your-password"

# Run test
python3 kalshi_client.py
```

**Expected output**:
```
✓ Authenticated with Kalshi
================================================================================
KALSHI CORPORATE EVENT MARKETS
================================================================================

🚀 IPO Markets:
  • Will Databricks IPO by end of 2026?
    Ticker: DATABRICKS-IPO-2026
    Closes: 2026-12-31
    Probability: 34%
    
  • Will OpenAI go public in 2026?
    Ticker: OPENAI-IPO-2026Q4
    Closes: 2026-12-31
    Probability: 12%
```

## Step 5: Run Market Sync

Once credentials are set and tables created:

```bash
cd collectors
python3 sync_kalshi_markets.py
```

This will:
- Fetch all corporate event markets from Kalshi
- Classify by type (IPO, M&A, CEO_Change, etc.)
- Store in database
- Track price changes

## Step 6: View in Dashboard

Navigate to **Predictions** page to see:
- Live market probabilities
- Price trend charts
- Company-linked predictions

---

## Troubleshooting

**"401 Unauthorized" error**:
- Make sure `KALSHI_EMAIL` and `KALSHI_PASSWORD` are set
- Try logging in at kalshi.com to verify credentials

**"No markets found"**:
- Check if any corporate event markets exist on Kalshi
- Market availability varies over time
- Try different search keywords

**"Table not found" error**:
- Run `create_kalshi_schema.sql` in Supabase first

---

## What Markets Are Available?

Kalshi currently has markets for:
- **Tech IPOs**: Databricks, OpenAI, Stripe, Klarna, etc.
- **Earnings**: Quarterly results for major companies
- **Economic indicators**: GDP, unemployment (corporate-relevant)

**Note**: Specific M&A markets may not always be available. When big deals are announced, Kalshi may create markets, but it's not guaranteed.

---

## Next: Build Dashboard Page

Once market data is syncing, create the Predictions dashboard page to display:
- Live probabilities
- Company-linked predictions
- Price trend charts
- Alert when probabilities cross thresholds (e.g., >70% IPO likely)
