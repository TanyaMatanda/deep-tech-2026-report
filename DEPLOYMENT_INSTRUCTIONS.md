# Deploying Combined Regulatory Dashboard to Streamlit Cloud

## Files That Need to Be Uploaded

You need to upload these 2 new files to your Streamlit Cloud app:

1. **`dashboard/regulations_database.py`** - Regulatory database
2. **`dashboard/combined_regulatory_dashboard.py`** - New combined dashboard page

And update this existing file:

3. **`dashboard/app.py`** - Already modified locally with new navigation

## Deployment Method Options

### Option 1: GitHub Deployment (Recommended if connected)

If your Streamlit app is connected to a GitHub repository:

1. Initialize git in your project (if not already done):
   ```bash
   cd "/Users/tanyamatanda/Desktop/Proxy Season 2026"
   git init
   git add dashboard/regulations_database.py
   git add dashboard/combined_regulatory_dashboard.py
   git add dashboard/app.py
   git commit -m "Add combined regulatory risk dashboard"
   ```

2. Push to your GitHub repository
3. Streamlit Cloud will auto-deploy

### Option 2: Manual File Upload (If no Git connection)

1. Go to https://share.streamlit.io/
2. Find your app "deep-tech-2026-report"
3. Click "Manage app" → "Edit app"
4. Upload the 2 new files:
   - `regulations_database.py`
   - `combined_regulatory_dashboard.py`
5. Update `app.py` with the modified version
6. Click "Reboot app"

### Option 3: Streamlit Cloud CLI

If you have streamlit CLI installed:
```bash
streamlit cloud deploy \
  --app-url deep-tech-2026-report-xsm6sfqipd6b7djs9tvkcw.streamlit.app \
  --main-file dashboard/app.py
```

## Quick Test After Deployment

1. Navigate to: https://deep-tech-2026-report-xsm6sfqipd6b7djs9tvkcw.streamlit.app
2. Check sidebar navigation - should see "Regulatory Risk Dashboard" option
3. Click it and verify the page loads
4. Test searching for "NVIDIA" - should show SEC cyber, export controls, etc.

## Troubleshooting

**If you get import errors:**
- Make sure `regulations_database.py` and `combined_regulatory_dashboard.py` are both in the `dashboard/` directory
- Check that `requirements.txt` includes all necessary packages (streamlit, pandas, datetime are already there)

**If the new page doesn't appear:**
- Clear your browser cache
- Hard refresh (Cmd+Shift+R on Mac)
- Manually reboot the app in Streamlit Cloud dashboard

## Alternative: Keep Local Version Only

If you prefer to keep the deployed version as-is and only use the new dashboard locally:
- Continue using the local version at `http://localhost:8501`
- The deployed version will keep the old separate pages

---

**Note**: Since you don't have a git repository set up, I recommend **Option 2 (Manual Upload)** as the quickest path to deployment.
