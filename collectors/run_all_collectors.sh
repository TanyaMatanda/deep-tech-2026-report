#!/bin/bash

# Master Data Collection Orchestrator
# Runs all 3 collectors in sequence
# Estimated total runtime: 10-12 hours

set -e  # Exit on error

echo "=========================================="
echo "DEEP TECH DATABASE COLLECTION PIPELINE"
echo "=========================================="
echo ""
echo "Target: 70,000+ companies"
echo "Estimated runtime: 10-12 hours"
echo ""
echo "Collection phases:"
echo "  1. Google Patents (40K companies, 2 hours)"
echo "  2. SEC EDGAR (500 companies, 6-8 hours)"
echo "  3. SBIR Grants (20K companies, 2 hours)"
echo ""
echo "=========================================="
echo ""

# Set up directories
BASE_DIR="/Users/tanyamatanda/Desktop/Proxy Season 2026"
COLLECTORS_DIR="$BASE_DIR/collectors"
OUTPUT_DIR="$BASE_DIR/collected_data"

mkdir -p "$OUTPUT_DIR"
cd "$COLLECTORS_DIR"

# Check Python dependencies
echo "🔍 Checking dependencies..."
python3 -c "import pandas, google.cloud.bigquery, requests, bs4" 2>/dev/null || {
    echo "❌ Missing dependencies. Installing..."
    pip3 install --quiet pandas google-cloud-bigquery requests beautifulsoup4 lxml
}
echo "✅ Dependencies OK"
echo ""

# ==========================================
# PHASE 1: Google Patents (2 hours)
# ==========================================
echo "=========================================="
echo "PHASE 1: Google Patents BigQuery"
echo "=========================================="
echo "Target: 40,000-50,000 companies"
echo "Estimated time: 2 hours"
echo ""

START_TIME=$(date +%s)

python3 1_google_patents_collector.py

if [ $? -eq 0 ]; then
    echo "✅ Phase 1 complete!"
    mv google_patents_companies.csv "$OUTPUT_DIR/"
    mv patent_companies_insert.sql "$OUTPUT_DIR/"
else
    echo "❌ Phase 1 failed. Check logs."
    exit 1
fi

PHASE1_END=$(date +%s)
PHASE1_DURATION=$((PHASE1_END - START_TIME))
echo "⏱️  Phase 1 completed in $((PHASE1_DURATION / 60)) minutes"
echo ""

# ==========================================
# PHASE 2: SEC EDGAR (6-8 hours)
# ==========================================
echo "=========================================="
echo "PHASE 2: SEC EDGAR Public Companies"
echo "=========================================="
echo "Target: 500 companies"
echo "Estimated time: 6-8 hours"
echo ""

python3 2_sec_edgar_collector.py

if [ $? -eq 0 ]; then
    echo "✅ Phase 2 complete!"
    mv sec_deep_tech_companies.csv "$OUTPUT_DIR/"
    mv sec_companies_insert.sql "$OUTPUT_DIR/"
else
    echo "❌ Phase 2 failed. Check logs."
    exit 1
fi

PHASE2_END=$(date +%s)
PHASE2_DURATION=$((PHASE2_END - PHASE1_END))
echo "⏱️  Phase 2 completed in $((PHASE2_DURATION / 60)) minutes"
echo ""

# ==========================================
# PHASE 3: SBIR Grants (2 hours)
# ==========================================
echo "=========================================="
echo "PHASE 3: SBIR/STTR Grant Recipients"
echo "=========================================="
echo "Target: 20,000+ companies"
echo "Estimated time: 2 hours"
echo ""

python3 3_sbir_grant_collector.py

if [ $? -eq 0 ]; then
    echo "✅ Phase 3 complete!"
    mv sbir_deep_tech_companies.csv "$OUTPUT_DIR/"
    mv sbir_companies_insert.sql "$OUTPUT_DIR/"
else
    echo "❌ Phase 3 failed. Check logs."
    exit 1
fi

PHASE3_END=$(date +%s)
PHASE3_DURATION=$((PHASE3_END - PHASE2_END))
echo "⏱️  Phase 3 completed in $((PHASE3_DURATION / 60)) minutes"
echo ""

# ==========================================
# FINAL SUMMARY
# ==========================================
END_TIME=$(date +%s)
TOTAL_DURATION=$((END_TIME - START_TIME))

echo "=========================================="
echo "✅ COLLECTION PIPELINE COMPLETE!"
echo "=========================================="
echo ""
echo "📊 Summary:"
echo "  • Total runtime: $((TOTAL_DURATION / 3600)) hours $((TOTAL_DURATION % 3600 / 60)) minutes"
echo "  • Output directory: $OUTPUT_DIR"
echo ""
echo "📁 Generated files:"
ls -lh "$OUTPUT_DIR"
echo ""
echo "📈 Estimated company count:"
echo "  • Google Patents: ~45,000 companies"
echo "  • SEC EDGAR: ~500 companies"
echo "  • SBIR Grants: ~20,000 companies"
echo "  • TOTAL: ~65,000-70,000 companies"
echo ""
echo "=========================================="
echo "Next Steps:"
echo "=========================================="
echo "1. Review CSV files in $OUTPUT_DIR"
echo "2. Combine SQL files:"
echo "   cat $OUTPUT_DIR/*_insert.sql > $OUTPUT_DIR/combined_companies.sql"
echo "3. Run in Supabase SQL Editor:"
echo "   Copy/paste combined_companies.sql"
echo "4. Verify:"
echo "   SELECT COUNT(*), primary_sector FROM companies GROUP BY primary_sector;"
echo ""
echo "🎉 Ready for RiskAnchor integration!"
echo ""
