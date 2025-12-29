# IPO Readiness Dashboard

**Live Demo:** Open `ipo_readiness_dashboard.html` in any browser

## Overview

This is a fully static HTML dashboard analyzing 95,000+ private companies for IPO readiness using a comprehensive academic framework based on research from the Journal of Finance, RFS, and Chicago Booth methodology.

## Features

✅ **Standalone HTML/CSS/JS** - No build process, no dependencies  
✅ **Beautiful glassmorphism design** with Tailwind CSS  
✅ **Interactive charts** powered by Chart.js  
✅ **Responsive layout** - works on desktop, tablet, mobile  
✅ **Sample data included** - demonstrating the full framework  
✅ **GitHub Pages ready** - just push and deploy

## What's Included

### 📊 Visualizations
1. IPO Readiness Score Distribution (histogram)
2. Companies by Tier breakdown (donut chart)
3. Top Sectors analysis (horizontal bar)
4. Component Score comparison (bar chart)

### 📈 Key Metrics
- Total companies analyzed
- IPO-Ready count (score 80+)
- Near-Term candidates (score 60-79)
- Median revenue
- Total patent portfolio

### 🏆 Top 20 IPO Candidates Table
Sortable table showing:
- Company name
- Sector
- Annual revenue
- IPO readiness score (0-100)
- Readiness tier
- Target exchange (NYSE/NASDAQ/TSX)

### 💡 Academic Insights
Three key findings based on recent research:
1. **SPAC vs Traditional IPO** performance delta
2. **Canadian CPC program** cost advantages
3. **Governance gaps** blocking IPO readiness

## Scoring Methodology

**Total Score = Weighted Sum:**
- **Financial (30%):** Revenue thresholds, profitability, R&D
- **Governance (25%):** Board independence, expertise
- **Legal (15%):** Litigation, compliance
- **IP/Innovation (10%):** Patent portfolio
- **Risk (10%):** Cyber, customer concentration
- **Operational (10%):** Certifications, exec stability

**Score Tiers:**
- 80-100: IPO-Ready (12-18 months)
- 60-79: Near-Term (18-24 months)
- 40-59: Significant Gaps (2-3 years)
- 0-39: Not Ready (3+ years)

## Deploy to GitHub Pages

### Option 1: Simple Hosting
1. Upload `ipo_readiness_dashboard.html` to your repo
2. Go to Settings → Pages
3. Set source to main branch
4. Dashboard will be live at `https://yourusername.github.io/repo-name/ipo_readiness_dashboard.html`

### Option 2: Custom Domain (Optional)
1. Rename file to `index.html`
2. Add CNAME file with your domain
3. Access at `https://yourdomain.com`

## Customization

### Update with Real Data
Replace the `topCompanies` array in the `<script>` section with your actual database results:

```javascript
const topCompanies = [
    {rank: 1, name: "Your Company", sector: "AI", revenue: "$100M", score: 85, tier: "IPO-Ready (12-18mo)", exchange: "NASDAQ"},
    // ... add your data
];
```

### Modify Colors
Edit the gradient background:
```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

### Add More Charts
Chart.js supports many chart types. Add new visualizations by:
1. Adding a new `<canvas id="yourChart"></canvas>` element
2. Creating the chart in the `<script>` section

## Tech Stack

- **HTML5** - Structure
- **Tailwind CSS** (CDN) - Styling
- **Chart.js 4.4** (CDN) - Visualizations
- **Vanilla JavaScript** - Interactivity

**Zero build process. Zero dependencies. Just works.**

## Browser Compatibility

✅ Chrome/Edge 90+  
✅ Firefox 88+  
✅ Safari 14+  
✅ Mobile browsers (iOS Safari, Chrome Mobile)

## File Size

- **HTML:** ~25 KB
- **External CDNs:** Chart.js (~200 KB), Tailwind (~50 KB)
- **Total first load:** ~275 KB (loads in <1 second)

## Next Steps

**To connect live database:**
1. Use the Python script `generate_dashboard_data.py` to export data as JSON
2. Replace hardcoded arrays with `fetch('data.json')` calls
3. Re-deploy

**For Streamlit version (with live DB):**
- See `ipo_dashboard.py` for interactive version
- Deploy to Streamlit Cloud for free hosting

## License

MIT - Use freely for commercial or personal projects

## Support

For questions or customization requests:
- Open an issue on GitHub
- Email: your-email@example.com

---

**Built with ❤️ based on academic research from Chicago Booth, Journal of Finance, and Review of Financial Studies**
