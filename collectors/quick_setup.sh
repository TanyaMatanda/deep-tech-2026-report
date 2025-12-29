#!/bin/bash
# Quick Setup Script - No Google Cloud Required
# This sets up everything needed to run SEC EDGAR and SBIR collectors

set -e

echo "=========================================="
echo "QUICK SETUP (No Google Cloud Required)"
echo "=========================================="
echo ""

# Check Python
echo "✓ Checking Python..."
python3 --version || {
    echo "❌ Python 3 not found. Please install Python 3 first."
    exit 1
}

# Install Python dependencies (you already did this!)
echo ""
echo "✓ Python dependencies already installed!"
echo ""

# Setup email for SEC
echo "=========================================="
echo "SEC EDGAR CONFIGURATION"
echo "=========================================="
echo ""
echo "The SEC requires your contact information."
echo "Please enter your email address:"
read -p "Email: " USER_EMAIL

if [ -z "$USER_EMAIL" ]; then
    echo "❌ Email is required"
    exit 1
fi

# Update SEC collector with email
echo "Updating SEC collector with your email..."
sed -i '' "s/your.email@example.com/$USER_EMAIL/" 2_sec_edgar_collector.py
echo "✓ SEC collector configured"

echo ""
echo "=========================================="
echo "SETUP COMPLETE!"
echo "=========================================="
echo ""
echo "You can now run:"
echo ""
echo "Option 1 - SBIR Grants Only (20K companies, 1-2 hours, NO Google Cloud needed):"
echo "  python3 3_sbir_grant_collector.py"
echo ""
echo "Option 2 - SEC EDGAR Only (500 companies, 6-8 hours, NO Google Cloud needed):"
echo "  python3 2_sec_edgar_collector.py"
echo ""
echo "Option 3 - Run both SBIR + SEC (skip Google Patents for now):"
echo "  bash run_sec_and_sbir_only.sh"
echo ""
echo "Note: Google Patents collector requires Google Cloud setup."
echo "You can add that later if needed."
echo ""
