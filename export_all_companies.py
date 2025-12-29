from supabase import create_client
import json

SUPABASE_URL = "https://mpabbijfgrmqiqnysiwf.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wYWJiaWpmZ3JtcWlxbnlzaXdmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NDM0MDg3OSwiZXhwIjoyMDc5OTE2ODc5fQ.s0DV0GCUP-LCwn9RhRsQyRm_D-tMSzlHGB8SI17gEB0"

# Create client
supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

print("Fetching all CEO compensation data...")

# Query all CEO compensation data
response = supabase.table('executive_compensation_annual').select(
    'company_id, companies(company_name, sector), fiscal_year, role, '
    'total_compensation, base_salary, bonus, stock_awards, option_awards, '
    'non_equity_incentive, change_in_pension, all_other_compensation'
).eq('role', 'CEO').order('total_compensation', desc=True).execute()

# Format the data
companies = []
for record in response.data:
    company_info = record.get('companies', {})
    total = record.get('total_compensation', 0) or 0
    
    # Skip zero compensation
    if total == 0:
        continue
        
    salary = record.get('base_salary', 0) or 0
    bonus = record.get('bonus', 0) or 0
    stock = record.get('stock_awards', 0) or 0
    option = record.get('option_awards', 0) or 0
    non_equity = record.get('non_equity_incentive', 0) or 0
    other = (record.get('change_in_pension', 0) or 0) + (record.get('all_other_compensation', 0) or 0)
    
    # Calculate equity mix
    equity_mix = ((stock + option) / total * 100) if total > 0 else 0
    equity_mix = min(100, max(0, equity_mix))  # Cap at 0-100%
    
    companies.append({
        'company': company_info.get('company_name', 'Unknown'),
        'sector': company_info.get('sector', 'Other'),
        'total': total,
        'salary': salary,
        'bonus': bonus,
        'stock': stock,
        'option': option,
        'non_equity': non_equity,
        'other': other,
        'equity_mix': round(equity_mix, 1)
    })

# Save to JSON
with open('all_companies_full.json', 'w') as f:
    json.dump(companies, f, indent=2)

print(f'\n✅ Exported {len(companies)} companies to all_companies_full.json')
print(f'File size: {len(json.dumps(companies))} bytes')
