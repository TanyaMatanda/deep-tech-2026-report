# Deep Tech Data Collection Pipeline
## Quick Start Guide

### Overview
Automated collection of **70,000+ North American deep tech companies** from 3 free public sources.

**Estimated Runtime:** 10-12 hours  
**Cost:** $0 (all sources are free/public data)

---

## Data Sources

| **Source** | **Companies** | **Data Quality** | **Runtime** |
|-----------|--------------|-----------------|-------------|
| **Google Patents BigQuery** | 45,000 | 30% complete | 2 hrs |
| **SEC EDGAR** | 500 | 95% complete | 6-8 hrs |
| **SBIR/STTR Grants** | 20,000 | 40% complete | 2 hrs |
| **TOTAL** | **~65,000** | **Variable** | **10-12 hrs** |

---

## Prerequisites

### 1. Python Dependencies
```bash
pip3 install pandas google-cloud-bigquery requests beautifulsoup4 lxml
```

### 2. Google Cloud Setup (for BigQuery)
```bash
# Install gcloud CLI
brew install google-cloud-sdk  # macOS

# Authenticate
gcloud auth application-default login

# Enable BigQuery API (free tier: 1 TB/month)
gcloud services enable bigquery.googleapis.com
```

### 3. Update SEC User-Agent
Edit `collectors/2_sec_edgar_collector.py` line 18:
```python
'User-Agent': 'YourName your.email@example.com'  # REQUIRED by SEC
```

---

## Running the Pipeline

### Option 1: Run All at Once (Recommended)
```bash
cd "/Users/tanyamatanda/Desktop/Proxy Season 2026/collectors"
chmod +x run_all_collectors.sh
./run_all_collectors.sh
```

**Leave running overnight.** Output will be in `collected_data/` folder.

### Option 2: Run Individually

**Phase 1: Google Patents (2 hours)**
```bash
python3 1_google_patents_collector.py
```
Output: `google_patents_companies.csv` (45,000 companies)

**Phase 2: SEC EDGAR (6-8 hours)**
```bash
python3 2_sec_edgar_collector.py
```
Output: `sec_deep_tech_companies.csv` (500 companies)

**Phase 3: SBIR Grants (2 hours)**
```bash
python3 3_sbir_grant_collector.py
```
Output: `sbir_deep_tech_companies.csv` (20,000 companies)

---

## Output Files

After completion, you'll have:

```
collected_data/
├── google_patents_companies.csv      # 45K companies
├── patent_companies_insert.sql       # SQL for Supabase
├── sec_deep_tech_companies.csv       # 500 companies
├── sec_companies_insert.sql          # SQL for Supabase
├── sbir_deep_tech_companies.csv      # 20K companies
└── sbir_companies_insert.sql         # SQL for Supabase
```

---

## Loading into Supabase

### 1. Combine SQL Files
```bash
cd collected_data
cat patent_companies_insert.sql sec_companies_insert.sql sbir_companies_insert.sql > combined_all.sql
```

### 2. Run in Supabase
1. Open Supabase SQL Editor
2. Copy/paste `combined_all.sql`
3. Click "Run"
4. Wait ~5-10 minutes for 65K inserts

### 3. Verify
```sql
-- Check total count
SELECT COUNT(*) as total_companies FROM vendor_governance.companies;

-- Breakdown by sector
SELECT primary_sector, COUNT(*) 
FROM vendor_governance.companies 
GROUP BY primary_sector 
ORDER BY COUNT(*) DESC;

-- Check data quality tiers
SELECT data_tier, COUNT(*), 
       ROUND(AVG(CASE WHEN data_quality_score IS NOT NULL THEN data_quality_score ELSE 0.3 END), 2) as avg_quality
FROM vendor_governance.companies
GROUP BY data_tier
ORDER BY data_tier;
```

Expected output:
- Total: ~65,000 companies
- Tier 1 (Public): 500
- Tier 2: 5,000
- Tier 3: 60,000

---

## Troubleshooting

### Google BigQuery Quota Exceeded
- **Cause**: Exceeded 1 TB free tier
- **Solution**: Wait until next month or enable billing ($5/TB)

### SEC EDGAR Rate Limiting
- **Cause**: Too many requests (>10/second)
- **Solution**: Script already has rate limiting. If blocked, wait 24 hours.

### Missing Dependencies
```bash
# Install all at once
pip3 install -r requirements.txt
```

---

## Next Steps

After successful collection:

1. **Review CSV files** for data quality
2. **Run SQL inserts** in Supabase
3. **Add governance data** for top 500 public companies (separate script)
4. **Configure RiskAnchor integration**

---

## Performance Notes

- **Google Patents**: Fast (BigQuery is powerful)
- **SEC EDGAR**: Slow (rate limited to 10 req/sec by SEC)
- **SBIR**: Medium (public API, no authentication)

**Recommendation:** Run overnight, check in the morning.

---

## Support

If errors occur:
1. Check log output
2. Verify internet connection
3. Ensure API quotas not exceeded
4. Check file permissions

**All scripts have error handling and will show helpful messages.**
