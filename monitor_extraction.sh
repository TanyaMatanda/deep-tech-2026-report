#!/bin/bash
# Monitor compensation extraction progress

echo "📊 Compensation Extraction Monitor"
echo "===================================="
echo ""

# Check if process is running
if ps -p 68701 > /dev/null 2>&1; then
    echo "✅ Extraction process is RUNNING (PID: 68701)"
else
    echo "⚠️  Extraction process has STOPPED"
fi

echo ""
echo "Recent log entries:"
echo "-------------------"
tail -30 compensation_extraction.log

echo ""
echo "Statistics:"
echo "-----------"
echo "Total lines processed: $(wc -l < compensation_extraction.log)"
echo "Companies processed: $(grep 'Processing' compensation_extraction.log | wc -l)"
echo "NEOs extracted: $(grep '✅ Saved' compensation_extraction.log | wc -l)"
echo "Errors: $(grep 'ERROR' compensation_extraction.log | wc -l)"

echo ""
echo "To watch live:"
echo "  tail -f compensation_extraction.log"
