# AI Disclosure Gap Dashboard - Project Documentation

**Project Date**: January 2, 2026  
**Dashboard URL**: [https://tanyamatanda.github.io/deep-tech-2026-report/AI_Disclosure_Gap_Dashboard.html](https://tanyamatanda.github.io/deep-tech-2026-report/AI_Disclosure_Gap_Dashboard.html)  
**Repository**: [TanyaMatanda/deep-tech-2026-report](https://github.com/TanyaMatanda/deep-tech-2026-report)

---

## Executive Summary

Enhanced the AI Disclosure Gap Dashboard by adding 5 new data visualizations exposing the "140x Problem" (companies mentioning AI infrastructure 140x more than model-specific risks), improving chart readability with percentage labels and better styling, and adding design attribution. All changes deployed to GitHub Pages.

---

## Work Completed

### Phase 1: New Data Visualizations (Previously Completed)

Added 5 charts based on analysis of 1,687 SEC 10-K filings:

#### 1. The 140x Problem: Infrastructure vs Model Risk
- **Type**: Horizontal bar chart with logarithmic scale
- **Data**: Infrastructure keywords (11,352) vs Model-specific risks (81)
- **Key Finding**: 140:1 ratio revealing systematic disclosure gap
- **Chart ID**: `ratio140xChart`

#### 2. The Agentic AI Disclosure Gap
- **Type**: Vertical bar chart
- **Data**: LLM/GenAI mentions (2,612) vs Agentic/Autonomous mentions (520 total)
- **Key Finding**: Companies avoid disclosing autonomous AI capabilities
- **Chart ID**: `agenticGapChart`

#### 3. Human Oversight Invisibility
- **Type**: Doughnut chart
- **Data**: 83% of companies don't disclose human oversight
- **Key Finding**: Critical governance gap in EU AI Act compliance
- **Chart ID**: `humanOversightChart`

#### 4. Socioeconomic Risk Silence
- **Type**: Vertical bar chart
- **Data**: Automation vs labor disruption mentions
- **Key Finding**: 10.9% acknowledge workforce impact despite automation focus
- **Chart ID**: `socioeconomicChart`

#### 5. Disclosure Leaders vs. Laggards
- **Type**: Horizontal bar chart
- **Data**: Named companies (IREN, NVIDIA, Sprinklr vs generic disclosers)
- **Key Finding**: Demonstrates quality disclosure benchmarks
- **Chart ID**: `leadersLaggardsChart`

### Phase 2: Chart Visibility Enhancements (This Session)

#### Enhancement 1: Added Percentage Labels
- **Library**: Chart.js Datalabels Plugin v2.2.0
- **Implementation**: Configured datalabels plugin for doughnut/pie charts only
- **Format**: Percentage with 1 decimal point (e.g., "87.7%")
- **Charts Updated**: 
  - Volume Gap (doughnut)
  - Disclosure Quality Distribution (pie)

#### Enhancement 2: Improved Text Styling
- **Legend labels**: White, bold, 14px
- **Chart titles**: White, bold, 18px  
- **Data labels**: White, bold, 14px
- **Padding**: Increased spacing (20px for legends/titles)

#### Enhancement 3: Fixed Label Overlap
- **Issue**: Percentage labels overlapping with chart slices
- **Solution**: 
  - Semi-transparent backgrounds (`rgba(0, 0, 0, 0.6)`)
  - 4px rounded corners
  - 6px padding around labels
  - Conditional display (only show labels for slices >3%)
  - Centered anchor/align positioning

#### Enhancement 4: Design Attribution
- **Addition**: "Dashboard style inspired by Zaha Hadid design principles"
- **Location**: Footer (below disclaimer)
- **Styling**: 85% font size, 80% opacity for subtle presentation

---

## Process & Methodology

### 1. Planning Phase
- Reviewed existing dashboard structure
- Identified data source (`SEC_AI_Extraction_FINAL.csv`)
- Analyzed analysis document (`FINAL_BOARD_REPORT_AI_DISCLOSURE.md`)
- Created implementation plan with specific chart types and data points
- User reviewed and approved plan

### 2. Implementation Phase
- **HTML Structure**: Added new `<div>` and `<canvas>` elements for each chart
- **JavaScript**: Implemented Chart.js initialization within `initializeCharts()` function
- **Data Integration**: Used actual counts from CSV analysis
- **Chart Configuration**: Set up colors, scales (including logarithmic), tooltips, and legends

### 3. Iteration & Refinement
- **Issue 1**: Text visibility on charts
  - **Solution**: Increased font sizes, changed colors to white, added contrast
- **Issue 2**: Label overlap on doughnut/pie charts
  - **Solution**: Added datalabels plugin with backgrounds and conditional display
- **Issue 3**: Needed design attribution
  - **Solution**: Added footer line with Zaha Hadid reference

### 4. Deployment & Verification
- Committed changes to Git with descriptive messages
- Pushed to GitHub (triggers automatic GitHub Pages deployment)
- Instructed user on hard refresh to bypass cache
- Documented all changes in walkthrough artifact

---

## Technical Decisions

### Why Chart.js?
- Already integrated in dashboard
- Rich plugin ecosystem (datalabels)
- Good performance with multiple charts
- Responsive by default

### Why Logarithmic Scale for 140x Chart?
- Linear scale would make smaller values (81 mentions) invisible
- Logarithmic scale shows both values clearly while maintaining ratio visibility
- Industry standard for data with large magnitude differences

### Why Conditional Label Display (>3% threshold)?
- Prevents clutter on small slices
- Improves readability
- Users can still see exact percentages in tooltips
- Common UX pattern in data visualization

### Why Plugin Registration Per-Chart vs Global?
- Global registration would add labels to ALL charts (including bar charts)
- Per-chart registration gives precise control
- Cleaner implementation for selective enhancement

---

## Git Commit History

| Commit | Date | Description |
|--------|------|-------------|
| `7b3ef9c` | Jan 2, 2026 | Add enhanced dashboard with 5 new charts |
| `0fbe163` | Jan 2, 2026 | Trigger GitHub Pages rebuild |
| `8de6ebd` | Jan 2, 2026 | Improve doughnut chart visibility with percentage labels |
| `23f4604` | Jan 2, 2026 | Fix chart label overlap with backgrounds and padding |
| `857a051` | Jan 2, 2026 | Add Zaha Hadid design attribution to footer |

---

## Data Sources

### Primary Data
- **File**: `SEC_AI_Extraction_FINAL.csv`
- **Companies**: 1,687 publicly traded deep tech companies
- **Fiscal Year**: 2024-2025
- **Section Analyzed**: Item 1A (Risk Factors)
- **Keywords**: 35+ AI-related terms across 7 risk categories

### Analysis Framework
- MIT AI Risk Repository taxonomy
- NIST AI Risk Management Framework
- EU AI Act regulatory categories
- Custom disclosure quality metrics

---

## Lessons Learned

### What Worked Well
1. **Incremental deployment**: Pushing changes in logical chunks made debugging easier
2. **User feedback loop**: Screenshot-based communication identified issues quickly
3. **Documentation-first**: Creating implementation plan prevented scope creep
4. **Git workflow**: Descriptive commits made rollback easier if needed

### What Could Be Improved
1. **Testing**: Should have tested datalabels plugin in local environment first
2. **Cache strategy**: Could have added cache-busting query parameters to CSS/JS
3. **Responsive testing**: Should verify charts look good on mobile before deployment
4. **Accessibility**: Need to add ARIA labels for screen readers

### Technical Challenges
1. **GitHub Pages caching**: Required hard refresh and force rebuild
2. **Label overlap**: Initial implementation didn't account for small slices
3. **Plugin integration**: Had to register ChartDataLabels selectively, not globally

---

## Future Improvements

### Short-Term (Next Update)

#### 1. Responsive Design Enhancements
- Test all charts on mobile devices (320px - 768px)
- Implement responsive font sizes using `clamp()` or media queries
- Consider stacking charts vertically on small screens
- Test touch interactions for tooltips

#### 2. Accessibility (WCAG 2.1 AA Compliance)
- Add `aria-label` to all chart containers
- Ensure color contrast meets 4.5:1 minimum
- Add keyboard navigation for chart interactions
- Provide text alternatives for chart data (tables)
- Test with screen readers (NVDA, JAWS, VoiceOver)

#### 3. Performance Optimization
- Lazy load charts (only render when scrolled into view)
- Consider using Chart.js tree-shaking to reduce bundle size
- Optimize CSV data loading (load incrementally if needed)
- Add loading states/skeletons for charts

#### 4. Interactive Features
- Add "Download Chart as PNG" buttons
- Implement chart filtering (by sector, by risk category)
- Add date range selector for temporal analysis
- Enable drill-down from summary charts to detail views

### Medium-Term (Next Quarter)

#### 5. Advanced Analytics
- Add trend analysis (compare YoY disclosure changes)
- Implement peer comparison tool (select companies to benchmark)
- Create "AI Disclosure Score" calculator
- Add predictive analytics (disclosure likelihood based on company profile)

#### 6. Data Updates
- Automate CSV data refresh from SEC EDGAR API
- Add timestamp showing last data update
- Implement change detection (highlight newly disclosed risks)
- Create historical archive of disclosure snapshots

#### 7. Export & Sharing
- Generate PDF reports with charts embedded
- Create shareable chart URLs with pre-selected filters
- Add social media preview cards (Open Graph tags)
- Enable embedding charts in external sites (iframe)

#### 8. Additional Visualizations
- Heatmap: Risk category coverage by sector
- Network graph: Keyword co-occurrence analysis
- Timeline: Disclosure evolution by quarter
- Geographic map: Disclosure quality by jurisdiction

### Long-Term (Next Year)

#### 9. Platform Migration
- Consider migrating from single HTML to React/Vue framework
- Implement backend API for dynamic data queries
- Add user authentication for custom dashboards
- Enable collaborative annotations on charts

#### 10. Machine Learning Integration
- NLP analysis of disclosure quality (beyond keyword matching)
- Automatic risk category classification
- Anomaly detection for disclosure outliers
- Sentiment analysis of risk language

#### 11. Governance Features
- Create "Board Briefing" mode with executive summary
- Add regulatory compliance checklist generator
- Implement risk matrix visualization
- Enable scenario modeling ("what-if" analysis)

---

## Maintenance Checklist

### Monthly
- [ ] Update SEC filing data from EDGAR
- [ ] Review GitHub Issues for bug reports
- [ ] Check analytics for usage patterns
- [ ] Test dashboard in latest browser versions

### Quarterly
- [ ] Review and update keyword taxonomy
- [ ] Analyze new regulatory frameworks (EU AI Act updates)
- [ ] Refresh company classification (new IPOs, delistings)
- [ ] User feedback survey and prioritization

### Annually
- [ ] Comprehensive accessibility audit
- [ ] Performance benchmark and optimization
- [ ] Security review (dependencies, XSS prevention)
- [ ] Design refresh alignment with brand guidelines

---

## Technical Reference

### Key Files
- **Dashboard**: `AI_Disclosure_Gap_Dashboard.html`
- **Data**: `SEC_AI_Extraction_FINAL.csv`
- **Analysis**: `FINAL_BOARD_REPORT_AI_DISCLOSURE.md`
- **References**: `140x_Problem_References.md`

### Dependencies
- Chart.js v4.4.0
- Chart.js Datalabels Plugin v2.2.0
- Marked.js (Markdown rendering)

### Chart Configuration Patterns

```javascript
// Standard doughnut chart with labels
new Chart(ctx, {
    type: 'doughnut',
    plugins: [ChartDataLabels],
    data: { ... },
    options: {
        responsive: true,
        cutout: '50%',
        plugins: {
            datalabels: {
                color: '#ffffff',
                font: { size: 14, weight: 'bold' },
                anchor: 'center',
                align: 'center',
                backgroundColor: 'rgba(0, 0, 0, 0.6)',
                borderRadius: 4,
                padding: 6,
                formatter: (value, context) => {
                    const total = context.dataset.data.reduce((a, b) => a + b, 0);
                    const pct = ((value / total) * 100).toFixed(1);
                    return pct < 3 ? '' : pct + '%';
                }
            }
        }
    }
});
```

### Deployment Process
```bash
# 1. Make changes
git add AI_Disclosure_Gap_Dashboard.html

# 2. Commit with descriptive message
git commit -m "Descriptive message of changes"

# 3. Push to GitHub
git push origin main

# 4. Wait 2-3 minutes for GitHub Pages rebuild
# 5. Hard refresh browser (Cmd+Shift+R or Ctrl+Shift+R)
```

---

## Contact & Support

**Project Owner**: Tanya Matanda  
**GitHub Repository**: [TanyaMatanda/deep-tech-2026-report](https://github.com/TanyaMatanda/deep-tech-2026-report)  
**Live Dashboard**: [https://tanyamatanda.github.io/deep-tech-2026-report/AI_Disclosure_Gap_Dashboard.html](https://tanyamatanda.github.io/deep-tech-2026-report/AI_Disclosure_Gap_Dashboard.html)

---

## Appendix: Chart Specifications

### Chart 1: The 140x Problem
- **Canvas ID**: `ratio140xChart`
- **Type**: Horizontal bar, logarithmic scale
- **Data**: [11352, 81]
- **Colors**: ['#8b5cf6', '#f87171']

### Chart 2: Agentic AI Gap
- **Canvas ID**: `agenticGapChart`
- **Type**: Vertical bar
- **Data**: [2612, 480, 15, 25]
- **Colors**: ['#8b5cf6', '#a855f7', '#f87171', '#f87171']

### Chart 3: Human Oversight
- **Canvas ID**: `humanOversightChart`
- **Type**: Doughnut
- **Data**: [1400, 287]
- **Colors**: ['#1e293b', '#8b5cf6']

### Chart 4: Socioeconomic Silence
- **Canvas ID**: `socioeconomicChart`
- **Type**: Vertical bar
- **Data**: [709, 184]
- **Colors**: ['#8b5cf6', '#f87171']

### Chart 5: Leaders vs Laggards
- **Canvas ID**: `leadersLaggardsChart`
- **Type**: Horizontal bar
- **Data**: [128, 107, 89, 11, 8, 6]
- **Colors**: ['#22c55e', '#22c55e', '#22c55e', '#f87171', '#f87171', '#f87171']

---

*Document created: January 2, 2026*  
*Last updated: January 2, 2026*  
*Version: 1.0*
