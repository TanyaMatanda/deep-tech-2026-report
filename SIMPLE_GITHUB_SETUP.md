# Simple GitHub-Only Lead Capture Solution

## How It Works

1. **User clicks "Request Access"** → Opens pre-filled GitHub Issue
2. **User fills out issue template** → Name, Email, Company, Dataset
3. **Issue is created** → You get email notification
4. **You send download link** → Reply to issue with file link
5. **Excel files hosted on GitHub Releases** → Free, permanent hosting

## Benefits
- ✅ **100% GitHub** - No third-party services
- ✅ **Free** - No costs whatsoever
- ✅ **Email notifications** - GitHub emails you when issue created
- ✅ **Built-in CRM** - Issues = leads, labels = dataset type
- ✅ **Privacy-friendly** - Contact info in private repo issues

---

## Step-by-Step Setup

### 1. Create Issue Template (Already done for you!)

File: `.github/ISSUE_TEMPLATE/data_request.yml`

This creates a nice form when someone clicks "Request Access"

### 2. Upload Excel Files to GitHub Releases

```bash
# Go to: https://github.com/TanyaMatanda/deep-tech-2026-report/releases/new
# - Tag: v1.0
# - Title: "IPO Readiness Data - December 2025"
# - Upload all 4 Excel files
# - Publish release
```

**Direct download URLs will be:**
- `https://github.com/TanyaMatanda/deep-tech-2026-report/releases/download/v1.0/IPO_Ready_Companies_80plus.xlsx`
- `https://github.com/TanyaMatanda/deep-tech-2026-report/releases/download/v1.0/Near_Term_Companies_60to79.xlsx`
- `https://github.com/TanyaMatanda/deep-tech-2026-report/releases/download/v1.0/Significant_Gaps_Sample_40to59.xlsx`
- `https://github.com/TanyaMatanda/deep-tech-2026-report/releases/download/v1.0/IPO_Readiness_Summary.xlsx`

### 3. User Journey

1. User clicks **"Request Access"** button on dashboard
2. Redirected to: `https://github.com/TanyaMatanda/deep-tech-2026-report/issues/new?template=data_request.yml&dataset=IPO-Ready`
3. User fills out form (name, email, company, role)
4. User clicks "Submit new issue"
5. **You get email notification** from GitHub
6. You respond to issue with download link
7. User gets email with your response

### 4. Managing Leads

**In GitHub Issues:**
- Filter by label: `dataset: ipo-ready`, `dataset: near-term`, etc.
- Sort by role: `role: investor`, `role: banker`, etc.
- Export to CSV for analysis
- Close issue when data sent

---

## Alternative: Mailto Link (Even Simpler)

If you want zero friction, use `mailto:` links:

**User clicks button** → Opens their email client with pre-filled email:
```
To: tanya@governanceiq.com
Subject: IPO Data Request - [Dataset Name]
Body: 
Name: 
Email:
Company:
Role:
Dataset Requested: [Auto-filled]
```

You reply manually with download link.

**Pros:** Instant, no GitHub account needed
**Cons:** Less structured, harder to track

---

## Which Do You Prefer?

**Option A: GitHub Issues** (Recommended)
- Structured data
- Automatic labeling
- Easy to track and export
- Free CRM essentially

**Option B: Mailto Links**
- Fastest for user
- Goes straight to your email
- Manual tracking

Let me know which you prefer and I'll implement it!
