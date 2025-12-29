# GitHub Pages Setup & Lead Integration Guide

## Step 1: Enable GitHub Pages

1. **Go to Settings**
   - Navigate to: https://github.com/TanyaMatanda/deep-tech-2026-report/settings/pages
   - (You'll need to log into GitHub first)

2. **Configure Pages**
   - Under "Build and deployment"
   - Source: Select **Deploy from a branch**
   - Branch: Select **main** and **/ (root)**
   - Click **Save**

3. **Wait for Build** (~1-2 minutes)
   - Your site will be live at: `https://TanyaMatanda.github.io/deep-tech-2026-report/ipo_readiness_dashboard.html`

---

## Step 2: Connect to Email Service

### Option A: Formspree (Easiest - No Code Required)

**Setup:**
1. Go to https://formspree.io and create free account
2. Create a new form called "IPO Data Requests"
3. Get your form endpoint (looks like: `https://formspree.io/f/YOUR_FORM_ID`)
4. Update dashboard HTML (see code below)

**HTML Update:**
Replace line in `ipo_readiness_dashboard.html`:
```html
<form id="contact-form" onsubmit="handleFormSubmit(event)">
```

With:
```html
<form id="contact-form" action="https://formspree.io/f/YOUR_FORM_ID" method="POST" onsubmit="handleFormSubmit(event)">
<input type="hidden" name="_subject" value="IPO Data Request">
<input type="hidden" name="dataset" id="dataset-field">
```

**Pros:** Free tier (50 submissions/month), email notifications, spam protection
**Cons:** Limited to email, no automation

---

### Option B: Zapier (Best for Automation)

**Setup:**
1. Create Zapier account (zapier.com)
2. Create a Webhook trigger
3. Get webhook URL: `https://hooks.zapier.com/hooks/catch/YOUR_WEBHOOK/`

**Workflow:**
- **Trigger:** Webhook receives form data
- **Actions:**
  1. Send email with template (Gmail/Outlook)
  2. Add to Google Sheets (lead tracking)
  3. Create contact in CRM (HubSpot/Salesforce)
  4. Send email attachment (Google Drive link to Excel file)

**Dashboard Update:**
In `handleFormSubmit()` function, add:
```javascript
// Send to Zapier
fetch('https://hooks.zapier.com/hooks/catch/YOUR_WEBHOOK/', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
        name: name,
        email: email,
        company: company,
        role: role,
        dataset: requestedDataset,
        timestamp: new Date().toISOString()
    })
});
```

**Pros:** Full automation, CRM integration, email + attachment
**Cons:** Paid ($20/month for automation)

---

### Option C: SendGrid + Custom Backend (Most Control)

**Setup:**
1. Create SendGrid account (free tier: 100 emails/day)
2. Get API key
3. Host simple backend (Vercel, Netlify Functions, or AWS Lambda)

**Backend Function (Node.js):**
```javascript
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(process.env.SENDGRID_API_KEY);

export default async function handler(req, res) {
    const { name, email, company, role, dataset } = req.body;
    
    // Map dataset to file URL
    const files = {
        'ipo-ready': 'https://yourdomain.com/IPO_Ready_Companies_80plus.xlsx',
        'near-term': 'https://yourdomain.com/Near_Term_Companies_60to79.xlsx',
        'sig-gaps': 'https://yourdomain.com/Significant_Gaps_Sample_40to59.xlsx',
        'summary': 'https://yourdomain.com/IPO_Readiness_Summary.xlsx'
    };
    
    const msg = {
        to: email,
        from: 'tanya@governanceiq.com',
        subject: 'Your IPO Readiness Data',
        text: `Hi ${name},\n\nThank you for requesting our ${dataset} dataset.\n\nDownload: ${files[dataset]}\n\nBest regards,\nTanya`,
        html: `<p>Hi ${name},</p><p>Thank you for requesting our <strong>${dataset}</strong> dataset.</p><p><a href="${files[dataset]}">Download Now</a></p>`
    };
    
    await sgMail.send(msg);
    
    // Log to CRM (optional)
    await logToCRM({ name, email, company, role, dataset });
    
    res.status(200).json({ success: true });
}
```

**Pros:** Full control, custom branding, scalable
**Cons:** Requires backend hosting, more technical

---

## Step 3: Host Excel Files

### Option 1: GitHub Releases (Free)
1. Go to: https://github.com/TanyaMatanda/deep-tech-2026-report/releases/new
2. Tag version: `v1.0-data`
3. Upload 4 Excel files
4. Publish release
5. Get direct download links (right-click file → Copy link address)

### Option 2: Google Drive (Easy)
1. Upload Excel files to Google Drive
2. Right-click → Share → Anyone with link can view
3. Get sharing link
4. Convert to direct download: Change `/view?` to `/uc?export=download&`

Example:
```
Original: https://drive.google.com/file/d/FILE_ID/view?usp=sharing
Direct:   https://drive.google.com/uc?export=download&id=FILE_ID
```

---

## Step 4: CRM Integration Options

### Free/Low-Cost CRMs:
1. **HubSpot (Free tier)**
   - API integration via Zapier
   - Auto-create contacts from form
   - Track engagement

2. **Google Sheets**
   - Simple lead tracking
   - Zapier auto-append rows
   - Easy to analyze

3. **Airtable**
   - Forms + database combined
   - Webhooks for automation
   - Free tier: 1,200 records

### Premium CRMs:
- Salesforce (Zapier integration)
- Pipedrive (native API)
- Close.io (sales-focused)

---

## Step 5: Complete Implementation Checklist

### Immediate (Manual Process):
- [ ] Enable GitHub Pages
- [ ] Upload Excel files to GitHub Releases
- [ ] Set up Formspree for email notifications
- [ ] Manually send email with download link when form submitted

### Automated (Recommended):
- [ ] Set up Zapier account
- [ ] Create Zap: Webhook → Send Email (with attachment link)
- [ ] Add Google Sheets logging action
- [ ] Update dashboard with webhook URL
- [ ] Test form submission end-to-end

### Advanced (Full System):
- [ ] Deploy backend function (Vercel/Netlify)
- [ ] Integrate SendGrid API
- [ ] Connect to HubSpot CRM
- [ ] Set up email automation sequence
- [ ] Add analytics tracking (Google Analytics)
- [ ] A/B test form copy

---

## Recommended Quick Start (30 minutes)

**For fastest time to live:**

1. **Enable GitHub Pages** (5 min)
2. **Upload Excel files to GitHub Releases** (5 min)
3. **Create Zapier account** (3 min)
4. **Set up Zap:** Webhook → Gmail (send email with Drive link) → Google Sheets (10 min)
5. **Update dashboard with Zapier webhook** (5 min)
6. **Test** (2 min)

**Result:** Fully functional lead capture with automated email delivery!

---

## Contact for Help

**Zapier Template:** I can create a ready-to-use Zap if you share your:
- Gmail address (for sending emails)
- Google Sheets URL (for lead tracking)

**Questions?** tanya@governanceiq.com
