from supabase import create_client, ClientOptions
import json

SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

print("Connecting to Supabase...")
options = ClientOptions(schema='vendor_governance')
supabase = create_client(SUPABASE_URL, SUPABASE_KEY, options=options)

print("Querying CEO compensation data...")
response = supabase.table('executive_compensation_annual').select(
    'companies(company_name, sector), total_compensation, base_salary, bonus, '
    'stock_awards, option_awards, non_equity_incentive, change_in_pension, all_other_compensation'
).eq('role', 'CEO').execute()

print(f"Found {len(response.data)} records")

companies = []
for record in response.data:
    company_info = record.get('companies') or {}
    total = record.get('total_compensation', 0) or 0
    
    if total == 0:
        continue
    
    salary = record.get('base_salary', 0) or 0
    stock = record.get('stock_awards', 0) or 0
    option = record.get('option_awards', 0) or 0
    equity_mix = ((stock + option) / total * 100) if total > 0 else 0
    
    companies.append({
        'company': company_info.get('company_name', 'Unknown'),
        'sector': company_info.get('sector', 'Other'),
        'total': total,
        'salary': salary,
        'bonus': record.get('bonus', 0) or 0,
        'stock': stock,
        'option': option,
        'non_equity': record.get('non_equity_incentive', 0) or 0,
        'other': (record.get('change_in_pension', 0) or 0) + (record.get('all_other_compensation', 0) or 0),
        'equity_mix': round(min(100, max(0, equity_mix)), 1)
    })

companies.sort(key=lambda x: x['total'], reverse=True)

with open('all_companies_full.json', 'w') as f:
    json.dump(companies, f, indent=2)

print(f"\n✅ Exported {len(companies)} companies")
print(f"📊 File size: {len(json.dumps(companies)) / 1024:.1f} KB")

if companies:
    print(f"\nTop 5 companies:")
    for i, c in enumerate(companies[:5], 1):
        print(f"  {i}. {c['company']}: ${c['total']/1e6:.1f}M ({c['equity_mix']:.0f}% equity)")
