#!/bin/bash

# Quick Deploy Script for Streamlit Cloud
# This script prepares your files for GitHub deployment

echo "🚀 Preparing Streamlit Cloud Deployment..."

# 1. Create .gitignore
cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
.venv

# IDE
.vscode/
.idea/
*.swp
*.swo

# Data files (too large for Git)
*.sql
*.csv
collectors/

# Credentials
.env
*.key
secrets.toml

# OS
.DS_Store
Thumbs.db
EOF

#2. Stage the essential files for dashboard
git add dashboard/app.py
git add dashboard/regulations_database.py
git add dashboard/combined_regulatory_dashboard.py
git add dashboard/db_connection.py
git add dashboard/requirements.txt
git add dashboard/.streamlit/

# 3. Check git status
echo ""
echo "📋 Files staged for commit:"
git status --short

# 4. Commit
echo ""
echo "💾 Creating commit..."
git commit -m "Add combined regulatory risk dashboard with accurate Canada/USA regulations"

echo ""
echo "✅ Git commit created!"
echo ""
echo "📌 Next Steps:"
echo "1. Create a GitHub repository (if you haven't already)"
echo "2. Add remote: git remote add origin <your-github-repo-url>"
echo "3. Push: git push -u origin main"
echo "4. In Streamlit Cloud, connect your GitHub repo"
echo "5. Streamlit will auto-deploy when you push!"
echo""
echo "OR manually upload these 3 files to Streamlit Cloud:"
echo "  - dashboard/regulations_database.py"
echo "  - dashboard/combined_regulatory_dashboard.py"
echo "  - dashboard/app.py"
