#!/bin/bash
# Run SEC EDGAR and SBIR collectors only (no Google Cloud needed)
# Estimated runtime: 8-10 hours
# Output: ~20,500 companies

set -e

echo "=========================================="
echo "RUNNING SEC + SBIR COLLECTORS"
echo "=========================================="
echo "Estimated runtime: 8-10 hours"
echo "Output: ~20,500 companies"
echo ""

BASE_DIR="/Users/tanyamatanda/Desktop/Proxy Season 2026"
OUTPUT_DIR="$BASE_DIR/collected_data"

mkdir -p "$OUTPUT_DIR"
cd "$BASE_DIR/collectors"

# Phase 1: SBIR Grants (2 hours)
echo "=========================================="
echo "PHASE 1: SBIR/STTR Grant Recipients"
echo "=========================================="
echo "Target: 20,000+ companies"
echo "Estimated time: 1-2 hours"
echo ""

START_TIME=$(date +%s)

python3 3_sbir_grant_collector.py

if [ $? -eq 0 ]; then
    echo "✅ Phase 1 complete!"
    mv sbir_deep_tech_companies.csv "$OUTPUT_DIR/" 2>/dev/null || true
    mv sbir_companies_insert.sql "$OUTPUT_DIR/" 2>/dev/null || true
else
    echo "❌ Phase 1 failed"
    exit 1
fi

PHASE1_END=$(date +%s)
echo "⏱️  Completed in $((($PHASE1_END - $START_TIME) / 60)) minutes"
echo ""

# Phase 2: SEC EDGAR (6-8 hours)
echo "=========================================="
echo "PHASE 2: SEC EDGAR Public Companies"
echo "=========================================="
echo "Target: 500 companies"
echo "Estimated time: 6-8 hours"
echo ""

python3 2_sec_edgar_collector.py

if [ $? -eq 0 ]; then
    echo "✅ Phase 2 complete!"
    mv sec_deep_tech_companies.csv "$OUTPUT_DIR/" 2>/dev/null || true
    mv sec_companies_insert.sql "$OUTPUT_DIR/" 2>/dev/null || true
else
    echo "❌ Phase 2 failed"
    exit 1
fi

END_TIME=$(date +%s)
TOTAL_DURATION=$((END_TIME - START_TIME))

echo ""
echo "=========================================="
echo "✅ COLLECTION COMPLETE!"
echo "=========================================="
echo ""
echo "⏱️  Total runtime: $((TOTAL_DURATION / 3600)) hours $((TOTAL_DURATION % 3600 / 60)) minutes"
echo "📁 Output directory: $OUTPUT_DIR"
echo ""
echo "📊 Estimated companies collected:"
echo "  • SBIR Grants: ~20,000"
echo "  • SEC EDGAR: ~500"
echo "  • TOTAL: ~20,500 companies"
echo ""
echo "Next steps:"
echo "1. Combine SQL files:"
echo "   cd '$OUTPUT_DIR'"
echo "   cat sbir_companies_insert.sql sec_companies_insert.sql > combined_companies.sql"
echo ""
echo "2. Load into Supabase:"
echo "   - Open Supabase SQL Editor"
echo "   - Copy/paste combined_companies.sql"
echo "   - Click 'Run'"
echo ""
