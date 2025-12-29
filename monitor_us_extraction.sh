#!/bin/bash
# Monitor US Final Extraction Progress

echo "📊 US Compensation Extraction Monitor"
echo "======================================"
echo ""

# Check if process is running
if ps -p 75875 > /dev/null 2>&1; then
    echo "✅ Extraction RUNNING (PID: 75875)"
    uptime_info=$(ps -p 75875 -o etime | tail -1)
    echo "   Runtime: $uptime_info"
else
    echo "⚠️  Extraction COMPLETED or STOPPED"
fi

echo ""
echo "📈 Progress:"
echo "------------"

if [ -f us_extraction_final.log ]; then
    companies=$(grep -c '=============' us_extraction_final.log 2>/dev/null || echo "0")
    proxies=$(grep -c '✓ Downloaded proxy' us_extraction_final.log 2>/dev/null || echo "0")
    xbrl=$(grep -c 'Extracted.*XBRL values' us_extraction_final.log 2>/dev/null || echo "0")
    records=$(grep -c '✅ Saved' us_extraction_final.log 2>/dev/null || echo "0")
    
    echo "  Companies processed: $companies / 1,639"
    echo "  Proxies downloaded: $proxies"
    echo "  XBRL extractions: $xbrl"
    echo "  Records saved: $records"
    
    if [ $companies -gt 0 ]; then
        pct=$((companies * 100 / 1639))
        echo "  Progress: ${pct}%"
    fi
    
    echo ""
    echo "Latest activity:"
    tail -5 us_extraction_final.log | grep -E '(Processing|✓ CEO|✅ Saved)' | tail -3
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
    print(f'Error: {e}')
"

echo ""
echo "💡 Commands:"
echo "  Watch live: tail -f us_extraction_final.log"
echo "  Re-run monitor: ./monitor_us_extraction.sh"
