#!/bin/bash
# GitHub Pages Deployment Script for IPO Readiness Dashboard

echo "🚀 Deploying IPO Readiness Dashboard to GitHub"
echo "=============================================="

# Check if git is initialized
if [ ! -d .git ]; then
    echo "❌ Git not initialized. Run: git init"
    exit 1
fi

# Add dashboard files
echo "📦 Adding dashboard files..."
git add ipo_readiness_dashboard.html
git add README_IPO_Dashboard.md
git add IPO_Readiness_Framework.md
git add IPO_Readiness_Analysis_Plan.md
git add analyze_ipo_readiness.py

# Show status
echo ""
echo "📊 Files staged for commit:"
git status --short

# Commit
echo ""
read -p "Enter commit message (or press Enter for default): " commit_msg
if [ -z "$commit_msg" ]; then
    commit_msg="Add IPO Readiness Dashboard"
fi

git commit -m "$commit_msg"

# Check if remote exists
if ! git remote get-url origin &> /dev/null; then
    echo ""
    echo "⚠️  No remote repository configured."
    echo "Please create a GitHub repo and run:"
    echo "git remote add origin https://github.com/yourusername/your-repo.git"
    echo ""
    read -p "Enter your GitHub repo URL (or press Enter to skip): " repo_url
    
    if [ ! -z "$repo_url" ]; then
        git remote add origin "$repo_url"
        echo "✅ Remote added!"
    else
        echo "⏭️  Skipping remote setup. You can add it later."
        exit 0
    fi
fi

# Push to GitHub
echo ""
echo "📤 Pushing to GitHub..."
git push -u origin main || git push -u origin master

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📋 Next steps:"
echo "1. Go to your GitHub repo → Settings → Pages"
echo "2. Source: Deploy from main/master branch"
echo "3. Save and wait ~1 minute"
echo "4. Your dashboard will be live at:"
echo "   https://yourusername.github.io/repo-name/ipo_readiness_dashboard.html"
echo ""
