# Historical Data Coverage Summary
## Deep Tech Governance Database

---

## Overview

The collection pipeline gathers **both current AND historical data** with the following coverage:

---

## Historical Data by Source

### 1. **Google Patents BigQuery**
**Historical Range:** ✅ **15 years (2010-2024)**

**What's Included:**
- All patent filings from 2010 onwards
- Patent grants and continuations
- Inventor names and classifications
- Citation networks (forward and backward citations)

**Why This Range:**
- Captures full deep tech innovation cycle
- Pre-2010 patents mostly expired (20-year term)
- Sufficient to show long-term R&D trajectory

**Example Use:** 
> "IonQ filed 47 quantum computing patents between 2015-2024, with peak activity in 2021 (12 patents)"

---

### 2. **SEC EDGAR (Public Companies)**
**Historical Range:** ⚙️ **Configurable (default: 3 years, can extend to 10+)**

**Current Configuration:** **3 years (2022-2024)**
- 2024: Current governance state
- 2023: Year-over-year comparison  
- 2022: Baseline for trend analysis

**Can Be Extended To:**
- **5 years (2020-2024)**: COVID impact analysis
- **10 years (2015-2024)**: Full governance evolution
- **20 years (2005-2024)**: Complete corporate history

**What's Collected Per Year:**
- DEF 14A (Proxy Statements): Board composition, executive comp
- 10-K (Annual Reports): Financials, risk factors, operational data
- 10-Q (Quarterly Reports): Quarterly financials
- 8-K (Current Events): Material events, executive changes

**To Extend Historical Range:**
Edit `2_sec_edgar_collector.py` line 189:
```python
# Change from:
filings = self.get_company_filings(company['cik'], years_back=3)

# To (for 5 years):
filings = self.get_company_filings(company['cik'], years_back=5)

# Or (for 10 years):
filings = self.get_company_filings(company['cik'], years_back=10)
```

**Data Volume Impact:**
| **Years** | **Filings** | **Storage** | **Runtime** |
|-----------|------------|------------|-------------|
| 3 years | ~10,000 | 25 GB | 6-8 hrs |
| 5 years | ~16,000 | 40 GB | 10-12 hrs |
| 10 years | ~30,000 | 75 GB | 18-24 hrs |

---

### 3. **SBIR/STTR Grants**
**Historical Range:** ✅ **7 years (2018-2024)**

**What's Included:**
- Federal R&D grant awards
- Grant amounts and funding agencies
- Project descriptions and topics
- Company locations and award history

**Why This Range:**
- SBIR API data quality best after 2018
- Captures post-2017 AI/quantum boom
- Shows sustained federal support patterns

**Example Use:**
> "Anthropic received $2.3M in SBIR grants 2019-2022 before Series A funding"

---

## Total Historical Coverage

### **Company Names & Basic Data**
- **70,000+ companies** with founding dates estimated from first patent/grant (2010-2024)

### **Detailed Governance Data (500 public companies)**
- **3 years** of proxy statements per company (default)
- **1,500 proxy statements** total (500 companies × 3 years)
- Can extend to **5-10 years** if needed

### **Patent Activity**
- **15 years** of patent filings (2010-2024)
- **Long-term innovation tracking**

### **Government Grants**
- **7 years** of SBIR/STTR awards (2018-2024)

---

## RiskAnchor Use Cases with Historical Data

### **Trend Analysis**
```sql
-- Show governance improvement over 3 years
SELECT 
    c.company_name,
    gs_2022.overall_governance_score AS score_2022,
    gs_2024.overall_governance_score AS score_2024,
    (gs_2024.overall_governance_score - gs_2022.overall_governance_score) AS improvement
FROM companies c
JOIN governance_scores gs_2022 ON c.id = gs_2022.company_id AND gs_2022.fiscal_year = 2022
JOIN governance_scores gs_2024 ON c.id = gs_2024.company_id AND gs_2024.fiscal_year = 2024
WHERE gs_2024.overall_governance_score > gs_2022.overall_governance_score
ORDER BY improvement DESC;
```

### **Historical Risk Incidents**
```sql
-- Track cybersecurity incidents over time
SELECT 
    c.company_name,
    COUNT(*) as incidents_last_3_years,
    SUM(financial_impact_usd) as total_cost
FROM cybersecurity_incidents ci
JOIN companies c ON ci.company_id = c.id
WHERE ci.incident_date >= CURRENT_DATE - INTERVAL '3 years'
GROUP BY c.company_name
ORDER BY incidents_last_3_years DESC;
```

### **Innovation Trajectory**
```sql
-- Patent activity trend
SELECT 
    EXTRACT(YEAR FROM filing_date) as year,
    COUNT(*) as patents_filed
FROM patents
WHERE company_id = (SELECT id FROM companies WHERE ticker_symbol = 'NVDA')
GROUP BY year
ORDER BY year;
```

---

## Recommendations

### **For Your Use Case (RiskAnchor Vendor Risk):**

**✅ Recommended: 3-year SEC data collection**
- Sufficient for trend analysis
- Manageable data volume (25 GB)
- Fast collection (6-8 hours)
- Shows if governance is improving or declining

**🔧 Optional: Extend to 5 years if:**
- You need COVID-19 impact analysis (2020-2021)
- Analyzing long-term compensation trends
- Tracking multi-year activist campaigns

**📊 Always collect: Full patent history (15 years)**
- Essential for innovation trajectory
- Shows R&D investment patterns
- Identifies technology pivots

---

## Quick Answer

**YES, the collectors include historical data:**

| **Data Type** | **Historical Range** | **Adjustable?** |
|--------------|---------------------|----------------|
| **Patents** | 15 years (2010-2024) | Yes (edit BigQuery query) |
| **SEC Filings** | 3 years (2022-2024) | ✅ **YES - configurable** |
| **SBIR Grants** | 7 years (2018-2024) | Yes (edit API params) |

**To extend SEC historical range:** Modify `years_back` parameter in `2_sec_edgar_collector.py`

---

## Storage Requirements

**Supabase Pro Tier ($25/month):**
- Includes: 8 GB database storage
- After 3-year collection: ~25 GB total
- Overage cost: 17 GB × $0.125/GB = **$2.13/month**
- **Total: ~$27/month for 3-year historical data**

**Supabase Team Tier ($599/month) - recommended for full 75K companies:**
- Handles 100 GB+ easily
- No overage concerns
- Production-ready

---

**Bottom line:** You get 3-15 years of historical data depending on source type, and it's fully configurable if you need more.
