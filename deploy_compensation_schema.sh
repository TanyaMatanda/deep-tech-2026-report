#!/bin/bash
# Deploy Compensation Schema Extension to Supabase
# Usage: ./deploy_compensation_schema.sh

set -e

echo "======================================"
echo "Deploying Compensation Schema Extension"
echo "======================================"

# Load Supabase credentials
if [ -f ".streamlit/secrets.toml" ]; then
    echo "✓ Found Supabase credentials"
else
    echo "❌ Error: .streamlit/secrets.toml not found"
    exit 1
fi

# Check if SQL file exists
if [ ! -f "compensation_schema_extension.sql" ]; then
    echo "❌ Error: compensation_schema_extension.sql not found"
    exit 1
fi

echo ""
echo "Step 1: Creating analysis directory..."
mkdir -p analysis

echo ""
echo "Step 2: Schema deployment options:"
echo "  Option 1: Use Supabase SQL Editor (recommended for first deployment)"
echo "  Option 2: Use psql command line (requires database connection string)"
echo ""
echo "For Supabase deployment:"
echo "1. Open Supabase Dashboard > SQL Editor"
echo "2. Copy contents of compensation_schema_extension.sql"
echo "3. Run the SQL script"
echo ""
echo "Or run via psql:"
echo "  psql -h db.YOUR_PROJECT_REF.supabase.co -U postgres -d postgres -f compensation_schema_extension.sql"
echo ""
echo "✅ Deployment preparation complete!"
echo ""
echo "Next steps:"
echo "  1. Deploy schema using Supabase SQL Editor"
echo "  2. Run test extraction: python collectors/extract_compensation_data.py --test"
echo "  3. Validate data: python tests/test_compensation_extraction.py"
