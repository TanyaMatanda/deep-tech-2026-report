# Executive Compensation Data Collection Template

## ISS/OECD Methodology - Field-by-Field Guide

### Purpose
This template provides a systematic approach to extracting executive compensation data from proxy circulars (DEF 14A, Management Information Circular) for analysis of incentive structures and pay-for-performance alignment.

---

## Section 1: Summary Compensation Table (SCT)

**Source**: Summary Compensation Table (typically Item 11 in DEF 14A)

**For each Named Executive Officer (NEO):**

| Field | Data Type | Extract From | Notes |
|-------|-----------|--------------|-------|
| Executive Name | Text | SCT Column 1 | Full legal name |
| Title/Role | Text | SCT Column 2 | CEO, CFO, CTO, etc. |
| Fiscal Year | Integer | SCT Column 3 | 3 years typically shown |
| Base Salary | USD | SCT "Salary" column | Current cash compensation |
| Bonus | USD | SCT "Bonus" column | Discretionary annual cash bonus |
| Stock Awards | USD | SCT "Stock Awards" column | RSUs + PSUs grant date fair value |
| Option Awards | USD | SCT "Option Awards" column | Black-Scholes value at grant |
| Non-Equity Incentive | USD | SCT "Non-Equity Incentive Plan" | STI payout for the year |
| Pension Change | USD | SCT "Change in Pension Value" | Actuarial increase |
| All Other Compensation | USD | SCT "All Other Compensation" | Perks, 401(k) match, etc. |
| **Total Compensation** | USD | SCT "Total" column | **Sum of all components** |

**Validation**: Total should equal sum of components ±$1 (rounding)

---

## Section 2: Short-Term Incentive (STI) Plan

**Source**: Compensation Discussion & Analysis (CD&A), typically within first 20 pages

### 2.1 Plan Structure

| Field | Data Type | Extract From | Example |
|-------|-----------|--------------|---------|
| Plan Name | Text | CD&A heading | "Annual Incentive Plan" |
| Target % of Salary | Integer | CD&A disclosure | CEO: 100%, CFO: 75% |
| Threshold % of Salary | Integer | Payout range section | 50% |
| Maximum % of Salary | Integer | Payout range section | 200% |
| Performance Period | Date Range | Plan description | Jan 1 - Dec 31, 2024 |

### 2.2 Performance Metrics

**Extract each metric separately:**

| Metric Name | Weight % | Threshold | Target | Maximum | Actual | Achievement % | Payout % |
|-------------|----------|-----------|--------|---------|--------|---------------|----------|
| Revenue | 40% | $950M | $1B | $1.1B | $1.02B | 102% | 110% |
| Adj. EBITDA | 40% | $180M | $200M | $220M | $195M | 97.5% | 85% |
| Strategic Goals | 20% | — | Qualitative | — | "Achieved" | 100% | 100% |

**Metric Categories** (ISS taxonomy):
- **Financial**: Revenue, EBITDA, EPS, Free Cash Flow, ROIC
- **Market**: TSR, Stock Price
- **Operational**: Customer Growth, Market Share, Product Launches
- **Strategic**: Strategic Objectives, Innovation Milestones
- **ESG**: Safety (LTIR), Diversity, Sustainability

### 2.3 Actual Payout

| Executive | Target Bonus | Formula Calculated | Discretionary Adj | Final Payout | % of Target |
|-----------|--------------|-------------------|-------------------|--------------|-------------|
| CEO | $1,500,000 | $1,425,000 | $0 | $1,425,000 | 95% |

---

## Section 3: Long-Term Incentive Plans (LTIP)

**Source**: Grants of Plan-Based Awards Table + Outstanding Equity Awards Table

### 3.1 Stock Options

| Field | Data Type | Extract From | Notes |
|-------|-----------|--------------|-------|
| Grant Date | Date | Grants table | Actual date options granted |
| # of Options | Integer | Grants table | Number of shares under option |
| Exercise Price | USD/share | Grants table | Strike price |
| Grant Date Fair Value | USD | Grants table | Black-Scholes value |
| Vesting Schedule | Text | Footnotes | "25% per year over 4 years" |
| Performance Conditions | Text | Footnotes | Time-based vs. performance |
| Expiration Date | Date | Footnotes or Outstanding table | Typically 10 years from grant |

### 3.2 Restricted Stock Units (RSUs)

| Field | Data Type | Extract From | Notes |
|-------|-----------|--------------|-------|
| Grant Date | Date | Grants table | |
| # of Units | Integer | Grants table | Target shares |
| Grant Date Fair Value/Unit | USD | Grants table | Stock price on grant date |
| Total Grant Value | USD | Grants table | Calculated |
| Vesting Schedule | Text | Footnotes | "25% per year over 4 years" |

### 3.3 Performance Stock Units (PSUs)

| Field | Data Type | Extract From | Notes |
|-------|-----------|--------------|-------|
| Grant Date | Date | Grants table | |
| Target # of Units | Integer | Grants table | At 100% performance |
| Threshold Units | Integer | Grants table or footnotes | At minimum (typically 50%) |
| Maximum Units | Integer | Grants table or footnotes | At maximum (typically 200%) |
| Performance Period | Date Range | Footnotes | Typically 3 years |
| **Performance Metric 1** | Text | CD&A or footnotes | e.g., "Relative TSR vs. S&P 500" |
| Metric 1 Weight % | Decimal | CD&A | Typically 50-100% |
| Metric 1 Threshold | Value | CD&A | e.g., "25th percentile" |
| Metric 1 Target | Value | CD&A | e.g., "50th percentile" |
| Metric 1 Maximum | Value | CD&A | e.g., "75th percentile" |
| **Performance Metric 2** | Text | (if applicable) | e.g., "Revenue CAGR" |
| Metric 2 Weight % | Decimal | | |
| Has Cliff Provision | Boolean | CD&A | TRUE if <threshold = 0% |
| Cliff Threshold | Percentile | CD&A | e.g., 25th percentile |

---

## Section 4: Peer Group Analysis

**Source**: CD&A section on "Competitive Positioning" or "Benchmarking"

### 4.1 Peer Group Identification

| Peer Company Name | Ticker | Inclusion Rationale | Appropriate? | Notes |
|-------------------|--------|---------------------|--------------|-------|
| Adobe Inc. | ADBE | Software, similar market cap | ✓ Yes | Good match |
| Salesforce Inc. | CRM | Software, larger revenue | ⚠ Partial | Revenue mismatch |

**Validation Criteria**:
- Similar sector/industry
- Market cap within 0.5x - 2x range
- Similar business model

### 4.2 Peer Group Usage

| Peer Group Name | Purpose | # of Peers |
|-----------------|---------|------------|
| Compensation Peer Group | CEO pay benchmarking | 15-25 |
| Performance Peer Group | Relative TSR measurement | 10-20 |

---

## Section 5: Say-on-Pay Voting

**Source**: Proxy statement voting results OR Form 8-K filed after annual meeting

| Field | Data Type | Extract From | Example |
|-------|-----------|--------------|---------|
| Meeting Date | Date | 8-K or proxy cover | May 15, 2024 |
| Votes FOR | Integer | Voting results table | 125,450,000 |
| Votes AGAINST | Integer | Voting results table | 15,200,000 |
| Abstentions | Integer | Voting results table | 3,100,000 |
| Broker Non-Votes | Integer | Voting results table | 8,500,000 |
| **Approval %** | Decimal | Calculate: FOR / (FOR + AGAINST) | **89.2%** |
| Support Level | Text | Categorize | Strong (>90%), Moderate (70-90%), Weak (<70%) |

**ISS/Glass Lewis Recommendations** (if disclosed):
- ISS Recommendation: FOR / AGAINST
- Glass Lewis Recommendation: FOR / AGAINST

---

## Section 6: Clawback Policies

**Source**: CD&A "Clawback Policy" section or Corporate Governance Guidelines

| Field | Data Type | Extract From | Notes |
|-------|-----------|--------------|-------|
| Has Clawback Policy | Boolean | CD&A | SEC Rule 10D-1 now mandatory |
| Policy Type | Text | CD&A | "SEC-Mandated" or "Voluntary Enhanced" |
| Applies to Roles | Text Array | Policy doc | ['CEO', 'CFO', 'All NEOs'] |
| Applies to Comp Types | Text Array | Policy doc | ['Cash Bonus', 'Equity'] |
| **Trigger: Restatement** | Boolean | Policy doc | Financial restatement |
| **Trigger: Misconduct** | Boolean | Policy doc | Individual misconduct |
| Lookback Period (years) | Integer | Policy doc | Typically 3 years |
| Has Been Enforced | Boolean | CD&A or 8-K | Any past enforcement? |

---

## Section 7: Stock Ownership Guidelines

**Source**: CD&A "Stock Ownership Guidelines" section

| Role | Required Ownership | Measurement | Years to Comply | Holding Requirement |
|------|-------------------|-------------|-----------------|---------------------|
| CEO | 6x base salary | $9M | 5 years | 50% net shares for 1 year post-vest |
| CFO | 3x base salary | $1.5M | 5 years | — |
| Other NEOs | 2x base salary | Varies | 5 years | — |

**What Counts Toward Ownership:**
- ✓ Directly owned shares
- ✓ Unvested RSUs (some companies)
- ✗ Unvested PSUs (most companies)
- ✗ Unexercised options (most companies)

---

## Section 8: Total Shareholder Return (TSR) Data

**Source**: Company's stock price history (Yahoo Finance, Bloomberg) OR proxy "Performance Graph"

### 8.1 TSR Calculation

**Formula**: TSR = ((End Price + Dividends - Start Price) / Start Price) × 100

| Period | Start Date | End Date | Start Price | End Price | Dividends | TSR % |
|--------|-----------|----------|-------------|-----------|-----------|-------|
| 1-Year | 12/31/2023 | 12/31/2024 | $150.00 | $165.00 | $2.50 | 11.7% |
| 3-Year | 12/31/2021 | 12/31/2024 | $120.00 | $165.00 | $7.25 | 43.5% |

### 8.2 Relative TSR (vs. Peer Group or Index)

| Period | Company TSR% | Peer Median TSR% | S&P 500 TSR% | Percentile Rank vs. Peers |
|--------|--------------|------------------|--------------|---------------------------|
| 3-Year | 43.5% | 38.2% | 42.1% | 65th percentile |

---

## Section 9: Red Flags Checklist

**ISS Governance Concerns** (check if present):

- [ ] **Mega-Grant**: Equity grant >$50M without performance conditions
- [ ] **Failed Say-on-Pay**: Approval <50%
- [ ] **Weak Say-on-Pay**: Approval <70%
- [ ] **Option Repricing**: Underwater options repriced or exchanged
- [ ] **No Clawback Policy**: Missing mandatory clawback
- [ ] **Weak Performance Metrics**: >50% weight on discretionary/strategic goals
- [ ] **Short Performance Period**: PSUs vest in <2 years
- [ ] **Excessive Severance**: >3x salary + bonus change-in-control
- [ ] **Tax Gross-Ups**: Company pays executive's taxes
- [ ] **Single-Trigger CIC**: Severance paid on change-in-control without termination
- [ ] **CEO/Chair Duality**: CEO also serves as Board Chair (without lead independent director)

---

## Section 10: Historical Trends Analysis

**Multi-Year Tracking** (for predictive modeling):

### CEO Compensation Growth

| Year | Total Comp | YoY Growth % | Revenue | Revenue Growth % | TSR % | Comp/Revenue Ratio |
|------|-----------|--------------|---------|------------------|-------|--------------------|
| 2022 | $15.2M | — | $5.0B | — | 12% | 0.30% |
| 2023 | $18.5M | 21.7% | $5.5B | 10% | -5% | 0.34% |
| 2024 | $22.1M | 19.5% | $6.1B | 10.9% | 15% | 0.36% |

**Analysis Questions**:
1. Is CEO pay growth >2x revenue growth? (ISS concern)
2. Did CEO pay increase while TSR was negative? (Misalignment)
3. Is comp/revenue ratio increasing over time? (Dilution concern)

---

## Data Quality Validation

**Before finalizing, check:**

1. ✓ SCT total matches sum of components
2. ✓ STI metric weights sum to 100%
3. ✓ Peer group size is reasonable (10-25 companies)
4. ✓ TSR calculations match public data sources
5. ✓ Say-on-pay % calculated correctly (FOR / (FOR + AGAINST))
6. ✓ Grant date fair values match stock price on grant date
7. ✓ Performance metrics are clearly defined (not vague)

---

## Output Format

**For database ingestion, export as:**

- **CSV**: For bulk import to `executive_compensation_annual`, `sti_performance_metrics`, etc.
- **JSON**: For API integration
- **Excel**: For manual review with formulas/validation

**Example JSON Structure**:

```json
{
  "company_id": "uuid-here",
  "fiscal_year": 2024,
  "executives": [
    {
      "name": "Jane Doe",
      "role": "CEO",
      "total_compensation": 22100000,
      "base_salary": 1500000,
      "sti_payout": 1425000,
      "stock_awards": 15000000,
      "option_awards": 0
    }
  ],
  "sti_plan": {
    "metrics": [
      {
        "metric_name": "Revenue",
        "weight_percent": 40,
        "target_value": 1000000000,
        "actual_value": 1020000000,
        "achievement_percent": 102
      }
    ]
  },
  "say_on_pay": {
    "approval_percentage": 89.2,
    "votes_for": 125450000,
    "votes_against": 15200000
  }
}
```

---

## References

- **ISS Proxy Voting Guidelines**: Pay-for-Performance Methodology
- **Glass Lewis**: Executive Compensation Grading Framework
- **OECD**: Principle VI.D - Remuneration aligned with long-term interests
- **SEC**: Item 402 of Regulation S-K (compensation disclosure requirements)
- **SEC Rule 10D-1**: Mandatory clawback policies (effective 2023)

---

**Last Updated**: December 2025
**Methodology Version**: ISS 2024-2025 Policy Updates
