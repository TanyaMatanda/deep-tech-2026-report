#!/usr/bin/env python3
"""
Overnight Monitoring and Auto-Execution Script
Monitors first batch, launches second batch automatically
"""

import os
import sys
import time
import subprocess
from datetime import datetime

def check_process_running(pid):
    """Check if process is still running"""
    try:
        os.kill(int(pid), 0)
        return True
    except OSError:
        return False

def get_board_count():
    """Get current board composition record count"""
    cmd = """python3 -c "import toml; from supabase import create_client, ClientOptions; s = toml.load('dashboard/.streamlit/secrets.toml'); sb = create_client(s['SUPABASE_URL'], s['SUPABASE_KEY'], options=ClientOptions(schema='vendor_governance')); r = sb.table('board_composition_annual').select('id', count='exact').execute(); print(r.count)" """
    
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=10)
        if result.returncode == 0:
            return int(result.stdout.strip())
    except:
        pass
    return None

def main():
    print("=" * 70)
    print("OVERNIGHT MONITORING & AUTO-EXECUTION")
    print("=" * 70)
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print()
    
    FIRST_BATCH_PID = "94299"
    CHECK_INTERVAL = 300  # 5 minutes
    STALL_THRESHOLD = 3  # If no progress for 3 checks (15 min), restart
    
    print(f"📍 Monitoring first batch (PID {FIRST_BATCH_PID})")
    print(f"⏱️  Check interval: {CHECK_INTERVAL}s ({CHECK_INTERVAL/60:.0f} min)")
    print()
    
    last_count = get_board_count()
    stall_count = 0
    
    while True:
        # Check if process running
        is_running = check_process_running(FIRST_BATCH_PID)
        current_count = get_board_count()
        current_time = datetime.now().strftime('%H:%M:%S')
        
        print(f"[{current_time}] Process: {'RUN' if is_running else 'STOP'} | Board records: {current_count:,}", end="")
        
        if current_count and last_count:
            delta = current_count - last_count
            print(f" (+{delta})")
            
            if delta == 0:
                stall_count += 1
                print(f"  ⚠️  No progress ({stall_count}/{STALL_THRESHOLD} checks)")
            else:
                stall_count = 0
        else:
            print()
        
        # Check if stalled
        if stall_count >= STALL_THRESHOLD and is_running:
            print(f"\n🛑 Collection appears stalled. Restarting...")
            os.system(f"kill {FIRST_BATCH_PID}")
            time.sleep(5)
            os.system("cd /Users/tanyamatanda/Desktop/'Proxy Season 2026' && nohup python3 extract_governance_data_enhanced.py > governance_extraction_full.log 2>&1 &")
            print("  ✅ Restarted")
            stall_count = 0
            last_count = current_count
            time.sleep(CHECK_INTERVAL)
            continue
        
        # Check if first batch complete
        if not is_running:
            print(f"\n✅ FIRST BATCH COMPLETE!")
            print(f"  Final count: {current_count:,} board records")
            print(f"  Completed at: {current_time}")
            
            # Wait a bit to ensure completion
            time.sleep(10)
            final_count = get_board_count()
            print(f"  Verified count: {final_count:,}")
            
            # Check if we have enough or need second batch
            if final_count < 4000:
                print(f"\n🚀 LAUNCHING SECOND BATCH")
                print(f"  Target: +3,000 companies")
                print(f"  Goal: 4,500-5,500 total")
                
                # TODO: Launch second batch script here
                # For now, just log
                print("  [Second batch script would launch here]")
            else:
                print(f"\n✅ TARGET REACHED: {final_count:,} ≥ 4,000")
                print("  No second batch needed")
            
            break
        
        last_count = current_count
        time.sleep(CHECK_INTERVAL)
    
    print(f"\n{'=' * 70}")
    print("MONITORING COMPLETE")
    print(f"Ended: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 70)

if __name__ == "__main__":
    main()
