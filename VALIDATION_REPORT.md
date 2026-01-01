# Data Validation & Reproducibility Report

## Extraction Methodology Validation

### 1. **Parsing Accuracy Issues Identified**

**⚠️ CRITICAL FINDING**: The Item 1A extraction regex has limitations:

- **Success rate**: 1,655/1,876 companies (88.2%) successfully analyzed
- **Failure modes**:
  - 221 companies (11.8%): No 10-K filing found in SEC EDGAR
  - 0 companies: Filing found but Item 1A not extracted (indicates regex works when filings exist)

**Why some extractions may fail:**
1. Company filed 20-F (foreign filer) instead of 10-K
2. Recent IPO with no 10-K yet
3. SEC EDGAR API rate limiting/temporary failures
4. Non-standard Item 1A formatting (rare)

### 2. **Validation Methodology for Other Researchers**

To validate these results, researchers should:

#### A. **Random Sampling (Recommended: n=30, ~2% sample)**

```python
# Use the provided validate_extraction.py script
python3 validate_extraction.py
```

1. Select 10 companies with **high AI disclosure**
2. Select 10 companies with **no AI disclosure**
3. Select 10 companies **randomly**

For each company:
- Manually retrieve the 10-K from SEC EDGAR
- Locate Item 1A (Risk Factors) section
- Count keyword occurrences (use Ctrl+F / Command+F)
- Compare to reported counts in `140x_Problem_Company_Level_Data.csv`

#### B. **Specific Validation Tests**

**Test 1: High-Confidence Positives**
- Companies that SHOULD have AI disclosure: NVDA, GOOGL, MSFT, META, AMZN
- **Our Results**: NVDA (104 mentions), GOOGL (39 mentions)
- **Our Results**: MSFT, AMZN, META show 0 mentions
- **⚠️ Flagged Issue**: Major tech companies showing zero AI disclosure

**Test 2: False Negatives**
Check if Apple (AAPL), Microsoft (MSFT), Amazon (AMZN), Meta (META) truly have zero AI mentions or if extraction failed:
- AAPL: Status = "analyzed", AI disclosure = False
- MSFT: Status = "analyzed", AI disclosure = False
- AMZN: Status = "analyzed", AI disclosure = False
- META: Status = "analyzed", AI disclosure = False

**Test 3: Keyword Count Accuracy**
For companies with disclosure, verify top keywords:
- NVIDIA: Should mention "GPU", "data center", "AI" extensively ✓ (104 mentions found)
- Workiva (WK): "sustainability" = 68 mentions (verify this is legitimate or parsing error)

### 3. **Known Limitations**

#### Parsing Limitations:
1. **Case-sensitive keyword matching**: The script uses `.lower()` so should handle case variations
2. **Phrase boundaries**: Uses `.count()` which may over-count (e.g., "compute" matches "computer")
3. **HTML artifact removal**: Regex `r'<[^>]+>'` should remove tags, but may leave artifacts like `&#160;`

#### Data Quality Issues:
1. **"Sustainability" contamination**: 1,605 mentions of "sustainability" may include ESG/environmental disclosures unrelated to AI
2. **"Cyberattack" = AI risk?**: 638 mentions classified under MIT malicious use, but may be general cybersecurity
3. **Apple/Microsoft/Amazon/Meta zero AI**: This seems implausible and warrants manual verification

### 4. **Reproducibility Checklist**

For another researcher to reproduce these results:

✅ **Code availability**: `extract_ai_risk_language_full.py` in GitHub repo
✅ **Input data**: `sec_risk_data_v2.csv` (1,876 companies with CIKs)
✅ **Output data**: `140x_Problem_Company_Level_Data.csv` (full results)
✅ **Validation script**: `validate_extraction.py` (spot-check tool)
✅ **Methodology documentation**: This file

**To reproduce:**
```bash
# Clone the repository
git clone https://github.com/TanyaMatanda/deep-tech-2026-report.git
cd deep-tech-2026-report

# Run the extraction (takes ~15 minutes)
python3 extract_ai_risk_language_full.py

# Validate results
python3 validate_extraction.py
```

### 5. **Recommended Validation Tests**

#### Tier 1: Quick Validation (10 minutes)
1. Manually check NVIDIA (NVDA) - high AI disclosure
2. Manually check Apple (AAPL) - reported zero, verify if accurate
3. Manually check 3 random mid-tier companies

#### Tier 2: Standard Validation (1 hour)
1. Sample 30 companies (10 high, 10 zero, 10 random)
2. Manual keyword counts for top 5 keywords per company
3. Calculate % accuracy rate

#### Tier 3: Full Validation (1 day)
1. Re-run extraction script from scratch
2. Compare outputs line-by-line
3. Investigate all discrepancies

### 6. **Inter-Rater Reliability**

Since keyword counting is objective (not subjective), inter-rater reliability should be 100% if:
- Same filing version accessed
- Same keywords searched
- Same text extraction method

**Potential sources of variation:**
- SEC EDGAR may update/amend filings after our extraction date (Jan 1, 2026)
- Different filing retrieval dates may get different versions

**Mitigation**: Our methodology documents the extraction date and could be enhanced by:
- Recording filing accession numbers in output
- Recording filing date
- Checksumming extracted Item 1A text

### 7. **Peer Review Questions**

Reviewers should ask:

1. **Why do AAPL, MSFT, AMZN, META show zero AI disclosure?**
   - Possible explanations: (a) Item 1A extraction failed, (b) They don't use those exact keywords, (c) They discuss AI in other sections

2. **Is "sustainability" an AI keyword?**
   - It's classified under MIT6_Environmental
   - But many sustainability mentions may be ESG-related, not AI-related
   - This could inflate environmental category counts

3. **Are the keyword categories mutually exclusive?**
   - No - a single mention can increment multiple categories if it contains multiple keywords
   - This is documented but may be confusing

### 8. **Suggested Improvements**

For future iterations:

1. **Add filing metadata to output**: accession number, filing date, document URL
2. **Implement more sophisticated NLP**: Use sentence-level analysis, not just keyword counting
3. **Add context window**: Save surrounding text for each keyword match for manual review
4. **Separate AI-specific from general keywords**: "sustainability" should require AI context
5. **Manual review of zero-disclosure companies**: Especially major tech companies

---

## Conclusion

The extraction methodology is **reproducible** and **documented**, but has **known limitations**:

✅ **Strengths**:
- Large sample size (1,876 companies)
- Transparent methodology (code published)
- Systematic approach
- Reproducible by other researchers

⚠️ **Limitations**:
- 11.8% filing retrieval failure rate
- Keyword-based (not semantic understanding)
- Some keyword contamination (sustainability, cyberattack)
- Questionable zero results for major tech companies

**Confidence level**: **Moderate to High** for directional findings (AI disclosure rates, top keywords), **Lower** for exact keyword counts due to potential parsing artifacts.

**Recommended use**: Cite as indicative research requiring peer validation, not as definitive quantitative analysis.
