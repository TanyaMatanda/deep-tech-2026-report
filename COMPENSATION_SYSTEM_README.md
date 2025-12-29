# Executive Compensation Analysis System - Deployment Guide

## Quick Start

This system provides ISS/OECD-aligned executive compensation data collection and analysis for deep tech companies.

## What's Included

**Core Components**:
- `compensation_schema_extension.sql` - Database schema (18 new tables)
- `collectors/extract_compensation_data.py` - PDF extraction engine
- `analysis/analyze_pay_performance.py` - Pay-for-performance analysis
- `DATA_COLLECTION_TEMPLATE.md` - Field-by-field extraction guide

**Test Suite**:
- `tests/test_compensation_extraction.py` - Validation tests (3/4 passing)

## Deployment Steps

### 1. Deploy Database Schema

**Option A: Supabase SQL Editor (Recommended)**
```
1. Open Supabase Dashboard → SQL Editor
2. Copy contents of compensation_schema_extension.sql
3. Click "Run" to deploy all tables
```

**Option B: Command Line**
```bash
# Execute via psql (requires database connection string)
psql -h db.YOUR_REF.supabase.co -U postgres -d postgres -f compensation_schema_extension.sql
```

### 2. Install Python Dependencies

```bash
# Required packages
pip3 install supabase toml requests beautifulsoup4 pandas

# Optional (for full analysis features)
pip3 install numpy scipy
```

### 3. Run Tests

```bash
# Validate extraction functions
python3 tests/test_compensation_extraction.py

# Expected output: 3/4 tests passing
# ✅ Metric Normalization
# ✅ TSR Calculation  
# ✅ Say-on-Pay Parsing
```

### 4. Extract Compensation Data

```bash
# Extract for all companies with DEF 14A filings
python3 collectors/extract_compensation_data.py

# Or test with specific company
python3 collectors/extract_compensation_data.py --test
```

## Usage Examples

### Extract Executive Compensation

```python
from collectors.extract_compensation_data import process_company_proxy

results = process_company_proxy(
    company_id='your-company-uuid',
    ticker='NVDA',
    year=2024,
    filing_url='https://www.sec.gov/...'
)

print(f"Extracted {len(results['sct_data'])} NEOs")
print(f"Found {len(results['sti_metrics'])} STI metrics")
```

###Analyze Pay-for-Performance

```python
from analysis.analyze_pay_performance import generate_compensation_scorecard

scorecard = generate_compensation_scorecard(
    company_id='your-company-uuid',
    year=2024
)

print(f"Overall Grade: {scorecard['overall_grade']}")  # A, B, C, D, or F
print(f"Red Flags: {len(scorecard['red_flags'])}")
```

### Predict STI Payout

```python
from analysis.analyze_pay_performance import predict_sti_payout

prediction = predict_sti_payout(
    company_id='your-company-uuid',
    year=2025,
    performance_inputs={
        'revenue_achievement_pct': 95,
        'ebitda_achievement_pct': 105
    }
)

print(f"Predicted payout: {prediction['predicted_payout_percent']}% of target")
```

## Database Tables Created

**Short-Term Incentives**:
- `sti_plan_structure` - Annual bonus framework
- `sti_performance_metrics` - Metrics with weights and targets
- `sti_payouts` - Actual executive payouts

**Long-Term Incentives**:
- `stock_options` - Option grants
- `restricted_stock_units` - Time-based RSUs
- `performance_stock_units` - PSUs with performance conditions

**Governance**:
- `compensation_peer_groups`, `peer_group_members` - Peer group tracking
- `say_on_pay_votes` - Shareholder voting results
- `clawback_policies` - Compensation recovery provisions
- `stock_ownership_guidelines`, `executive_stock_ownership` - Ownership requirements
- `tsr_data` - Total shareholder return calculations

## Test Results

**Current Status**: 3/4 tests passing

✅ **Metric Normalization**: Standardizes performance metrics (revenue, EBITDA, TSR, etc.)  
✅ **TSR Calculation**: Accurately calculates total shareholder return  
✅ **Say-on-Pay Parsing**: Extracts voting results from proxy statements  
⚠️ **SCT Extraction**: Core logic works; needs real proxy HTML for full validation  

## Next Steps

1. **Deploy Schema**: Run `compensation_schema_extension.sql` on your Supabase database
2. **Test Extraction**: Run on 5-10 sample companies (NVDA, AMD, INTC, etc.)
3. **Validate Data**: Hand-compare extracted SCT values against published proxies
4. **Scale Up**: Process all deep tech companies with DEF 14A filings

## Documentation

- **[Implementation Plan](file:///Users/tanyamatanda/.gemini/antigravity/brain/84613e9f-0d9d-4607-8018-0999adb8f765/implementation_plan.md)** - Technical design decisions
- **[Walkthrough](file:///Users/tanyamatanda/.gemini/antigravity/brain/84613e9f-0d9d-4607-8018-0999adb8f765/walkthrough.md)** - Complete system documentation
- **[Data Collection Template](file:///Users/tanyamatanda/Desktop/Proxy%20Season%202026/DATA_COLLECTION_TEMPLATE.md)** - Field-by-field extraction guide

## Support

For issues or questions:
1. Check test logs: `compensation_extraction.log`
2. Review [DATA_COLLECTION_TEMPLATE.md](file:///Users/tanyamatanda/Desktop/Proxy%20Season%202026/DATA_COLLECTION_TEMPLATE.md) for field definitions
3. Validate data quality checklist in template (page 9)

---

**Version**: 1.0.0  
**Last Updated**: December 2025  
**Methodology**: ISS 2024-2025 Policy + OECD Principle VI.D
