# Deep Tech 2026 Proxy Season Dashboard

This is the interactive dashboard for the "Deep Tech 2026 Proxy Season Report".

## Features
*   **Executive Summary:** Key metrics and high-level charts.
*   **Sector Deep Dives:** Interactive exploration of diversity and expertise by sector.
*   **Full Report:** Read the comprehensive report directly in the app.
*   **Download:** Get the full report as a printable HTML/PDF file.

## Deployment Instructions

### 1. Push to GitHub
1.  Create a new repository on GitHub (e.g., `deep-tech-2026-report`).
2.  Push this entire folder to the repository.

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

### 2. Deploy to Streamlit Cloud
1.  Go to [share.streamlit.io](https://share.streamlit.io).
2.  Connect your GitHub account.
3.  Click "New App".
4.  Select your repository (`deep-tech-2026-report`).
5.  Set "Main file path" to `app.py`.
6.  Click "Deploy".

## Local Development
To run locally:
```bash
pip install -r requirements.txt
streamlit run app.py
```

## Data Source
The data is pre-aggregated in `data/stats.json` to ensure security (no database credentials are exposed in this repository).
