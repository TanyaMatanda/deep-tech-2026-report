# News Tracker - Quick Setup Instructions

## Step 1: Create Database Tables

**Action**: Run this SQL in your Supabase SQL Editor

1. Go to https://supabase.com/dashboard/project/YOUR_PROJECT/sql/new
2. Copy and paste the entire `create_news_tracker_schema.sql` file
3. Click "Run" to execute

**Tables it creates**:
- `governance_news` - Stores all news items
- `news_alerts` - User alert subscriptions  
- `news_collection_stats` - Monitor run statistics

## Step 2: Test SEC Monitor

```bash
cd /Users/tanyamatanda/Desktop/Proxy\ Season\ 2026/collectors
python3 sec_rss_monitor.py
```

**Expected Output**:
```
INFO: ✓ Connected to Supabase
INFO: Fetching latest filings from SEC...
INFO: ✓ Found X governance filings
INFO: ✓ Stored: Microsoft to Acquire...
INFO: ✓ Stored: Activist takes stake in...
INFO: ✅ Collection complete:
INFO:    Collected: X filings
INFO:    Stored: Y new items
```

## Step 3: View Data

**Query in Supabase**:
```sql
SELECT headline, news_type, source, published_at 
FROM vendor_governance.governance_news 
ORDER BY published_at DESC 
LIMIT 10;
```

## Step 4: Schedule Automated Collection

**Option A: Cron (Mac/Linux)**
```bash
# Add to crontab (runs every 15 minutes)
*/15 * * * * cd /Users/tanyamatanda/Desktop/Proxy\ Season\ 2026/collectors && python3 sec_rss_monitor.py >> /tmp/sec_monitor.log 2>&1
```

**Option B: Supabase Edge Function** (recommended for production)
- Deploy as edge function
- Use Supabase cron to trigger every 15 min

## Troubleshooting

**"Table not found" error**:
→ Make sure you ran the SQL in Step 1

**"No filings found"**:
→ Normal if SEC is closed (weekends/after hours)
→ Try again during market hours (9:30am-4pm ET)

**"User-Agent blocked"**:
→ Already fixed in code with proper User-Agent header

---

**Ready to proceed?** Run the SQL, then test the monitor!
