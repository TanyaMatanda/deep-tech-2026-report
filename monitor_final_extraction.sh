#!/bin/bash
# Monitor final compensation extraction

echo "📊 Final Compensation Extraction Monitor"
echo "=========================================="
echo ""

# Check if process is running
if ps -p 54079 > /dev/null 2>&1; then
    echo "✅ Extraction RUNNING (PID: 54079)"
    uptime_info=$(ps -p 54079 -o etime | tail -1)
    echo "   Runtime: $uptime_info"
else
    echo "⚠️  Extraction COMPLETED or STOPPED"
fi

echo ""
echo "📈 Progress Statistics:"
echo "----------------------"

# Combined stats from both runs
echo "Batch 1 (completed):"
if [ -f production_extraction.log ]; then
    batch1_companies=$(grep -c '=============' production_extraction.log 2>/dev/null || echo "0")
    batch1_proxies=$(grep -c '✓ Downloaded proxy' production_extraction.log 2>/dev/null || echo "0")
    batch1_records=$(grep -c '✅ Saved' production_extraction.log 2>/dev/null || echo "0")
    echo "  Companies: $batch1_companies"
    echo "  Proxies: $batch1_proxies"
    echo "  Records: $batch1_records"
fi

echo ""
echo "Batch 2 (current):"
if [ -f production_extraction_final.log ]; then
    batch2_companies=$(grep -c '=============' production_extraction_final.log 2>/dev/null || echo "0")
    batch2_proxies=$(grep -c '✓ Downloaded proxy' production_extraction_final.log 2>/dev/null || echo "0")
    batch2_records=$(grep -c '✅ Saved' production_extraction_final.log 2>/dev/null || echo "0")
    echo "  Companies: $batch2_companies"
    echo "  Proxies: $batch2_proxies"
    echo "  Records: $batch2_records"
    
    echo ""
    echo "Latest activity:"
    tail -5 production_extraction_final.log | grep -E '(Processing|✓ CEO|✅ Saved)' | tail -3
fi

echo ""
echo "📊 Database Stats:"
echo "------------------"
python3 -c "
from supabase import create_client, ClientOptions
import toml

try:
    secrets = toml.load('.streamlit/secrets.toml')
    options = ClientOptions(schema='vendor_governance')
    s = create_client(secrets['SUPABASE_URL'], secrets['SUPABASE_KEY'], options=options)
    
    total = s.table('executive_compensation_annual').select('id', count='exact').execute()
    print(f'Total records in database: {total.count}')
except Exception as e:
    print(f'Error checking database: {e}')
"

echo ""
echo "💡 Commands:"
echo "  Watch live: tail -f production_extraction_final.log"
echo "  Re-run monitor: ./monitor_final_extraction.sh"
