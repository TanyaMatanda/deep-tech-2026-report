# SEC Parser Enhancement Plan

## Current Status
**Working well** (~80% accuracy):
- Board independence %
- Board diversity %
- CEO pay ratio
- Clawback policies

**Needs Improvement** (~20% accuracy):
- Split Chair/CEO detection
- Say-on-Pay vote %
- Cyber oversight
- Compensation details (STIP, LTIP, perquisites)

## Enhancement Strategy

### 1. Compensation Improvements

**STIP (Short-Term Incentive Plans)**:
- Add patterns for "annual bonus", "STIP", "short-term incentive"
- Extract target percentages (e.g., "target bonus of 150% of base salary")
- Identify performance metrics (revenue, EBITDA, EPS)

**LTIP (Long-Term Incentive Plans)**:
- Parse "equity awards", "LTIP", "long-term incentive"
- Extract vesting schedules (e.g., "3-year vesting")
- Distinguish performance-based vs. time-based

**Perquisites**:
- Look for "perquisites", "other compensation" in Summary Compensation Table
- Common perks: personal aircraft, car allowance, club memberships
- Extract total perquisite value

### 2. Better Contextual Parsing

**Current**: Simple regex on entire document
**Improved**: Section-aware parsing

```python
# Find specific sections first
sections = {
    'board_leadership': extract_section(filing, r'board leadership'),
    'compensation_discussion': extract_section(filing, r'compensation discussion'),
    'summary_comp_table': extract_section(filing, r'summary compensation table'),
}

# Then apply targeted patterns
```

### 3. Table Extraction

Many factors are in tables (Summary Compensation Table, Director Compensation, etc.)

**Approach**:
- Use BeautifulSoup to parse HTML tables
- Extract structured data from `<table>` tags
- Map column headers to data fields

### 4. Multi-Pattern Matching

Instead of failing on first pattern miss, try multiple variations:

```python
def extract_with_fallbacks(filing_text, patterns_list):
    for pattern in patterns_list:
        result = try_pattern(filing_text, pattern)
        if result:
            return result
    return None
```

### 5. Confidence Scoring

Add confidence scores to extracted data:

```python
{
    'board_independence_pct': 85.0,
    'confidence': 0.95  # High confidence if found in table
}
```

## Implementation Priority

**Phase 1** (This session):
1. ✅ Add STIP extraction
2. ✅ Add LTIP extraction  
3. ✅ Add perquisites extraction
4. ✅ Improve say-on-pay patterns
5. ✅ Improve split chair/CEO detection
6. ✅ Improve cyber oversight patterns

**Phase 2** (Next):
1. Add section-aware parsing
2. Implement table extraction for Summary Compensation Table
3. Add stock ownership requirements
4. Add severance multiples

**Phase 3** (Future):
1. Add machine learning classification
2. Implement confidence scores
3. Historical data for validation

## Testing Approach

1. **Test companies**: Microsoft, Apple, Google, Meta, Amazon
2. **Manual verification**: Compare extracted data vs actual proxy
3. **Accuracy metrics**: % of fields successfully extracted
4. **Regression testing**: Ensure new patterns don't break existing ones

---

**Next Steps**: Integrate enhanced patterns into `sec_filing_parser.py` and test with Microsoft proxy
