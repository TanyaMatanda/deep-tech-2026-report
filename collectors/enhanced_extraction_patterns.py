"""
Enhanced SEC Filing Parser - Improved Extraction Patterns
Adds better patterns for compensation (STIP, LTIP, perquisites), governance factors
"""

# New methods to add to SECFilingParser class:

def extract_stip_details(self, filing_text: str) -> Optional[Dict]:
    """Extract Short-Term Incentive Plan details"""
    stip_data = {}
    
    # Look for STIP/annual bonus mentions
    patterns = [
        r'(?:short[- ]term|annual)\s+(?:incentive|bonus).*?(\d+)%.*?target',
        r'target\s+(?:annual\s+)?bonus.*?(\d+)%',
        r'STIP.*?target.*?(\d+)%',
    ]
    
    for pattern in patterns:
        match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
        if match:
            stip_data['target_percentage'] = float(match.group(1))
            break
    
    # Look for performance metrics
    metric_keywords = ['revenue', 'EBITDA', 'EPS', 'operating income', 'cash flow']
    found_metrics = []
    
    for metric in metric_keywords:
        if re.search(f'STIP.*?{metric}|{metric}.*?(?:annual bonus|short[- ]term incentive)', 
                     filing_text, re.IGNORECASE | re.DOTALL):
            found_metrics.append(metric)
    
    if found_metrics:
        stip_data['metrics'] = found_metrics
    
    return stip_data if stip_data else None


def extract_ltip_details(self, filing_text: str) -> Optional[Dict]:
    """Extract Long-Term Incentive Plan details"""
    ltip_data = {}
    
    # LTIP percentage of compensation
    patterns = [
        r'(?:long[- ]term|equity)\s+incentive.*?(\d+)%.*?target',
        r'LTIP.*?target.*?(\d+)%',
        r'equity\s+award.*?(\d+)%.*?total.*?compensation',
    ]
    
    for pattern in patterns:
        match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
        if match:
            ltip_data['target_percentage'] = float(match.group(1))
            break
    
    # Vesting period
    vesting_match = re.search(
        r'(?:vests?|vesting).*?(\d+)[- ]year',
        filing_text,
        re.IGNORECASE
    )
    if vesting_match:
        ltip_data['vesting_years'] = int(vesting_match.group(1))
    
    # Performance vs time-based
    if re.search(r'performance[- ]based.*?(?:RSU|PSU|stock)', filing_text, re.IGNORECASE):
        ltip_data['type'] = 'performance-based'
    elif re.search(r'time[- ]based.*?(?:RSU|stock)', filing_text, re.IGNORECASE):
        ltip_data['type'] = 'time-based'
    
    return ltip_data if ltip_data else None


def extract_perquisites(self, filing_text: str) -> Optional[Dict]:
    """Extract executive perquisites/perks"""
    perqs = {}
    
    # Total perquisite value
    patterns = [
        r'(?:perquisites|perks|other\s+compensation).*?\$\s?([\d,]+)',
        r'all\s+other\s+compensation.*?\$\s?([\d,]+)',
    ]
    
    for pattern in patterns:
        match = re.search(pattern, filing_text, re.IGNORECASE)
        if match:
            value_str = match.group(1).replace(',', '')
            perqs['total_value'] = int(value_str)
            break
    
    # Common perquisite types
    perk_types = {
        'personal aircraft': r'(?:personal|private)\s+(?:aircraft|plane|jet)',
        'car allowance': r'(?:car|auto|vehicle)\s+allowance',
        'club memberships': r'club\s+(?:membership|dues)',
        'financial planning': r'financial\s+(?:planning|counseling)',
        'home security': r'(?:home|residential)\s+security',
        'relocation': r'relocation\s+(?:expenses|costs)',
    }
    
    found_perks = []
    for perk_name, perk_pattern in perk_types.items():
        if re.search(perk_pattern, filing_text, re.IGNORECASE):
            found_perks.append(perk_name)
    
    if found_perks:
        perqs['types'] = found_perks
    
    return perqs if perqs else None


def extract_stock_ownership_requirements(self, filing_text: str) -> Optional[Dict]:
    """Extract stock ownership requirements for executives"""
    ownership = {}
    
    # CEO ownership multiple
    ceo_patterns = [
        r'CEO.*?(?:required|must).*?own.*?(\d+)x.*?base\s+salary',
        r'stock\s+ownership.*?CEO.*?(\d+)x',
    ]
    
    for pattern in ceo_patterns:
        match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
        if match:
            ownership['ceo_multiple'] = int(match.group(1))
            break
    
    # NEO (Named Executive Officer) ownership
    neo_patterns = [
        r'named\s+executive\s+officers.*?(\d+)x.*?base\s+salary',
        r'NEO.*?ownership.*?(\d+)x',
    ]
    
    for pattern in neo_patterns:
        match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
        if match:
            ownership['neo_multiple'] = int(match.group(1))
            break
    
    return ownership if ownership else None


def extract_retirement_benefits(self, filing_text: str) -> Optional[Dict]:
    """Extract retirement/pension benefit details"""
    retirement = {}
    
    # Pension plan
    if re.search(r'defined\s+benefit\s+(?:plan|pension)', filing_text, re.IGNORECASE):
        retirement['has_pension'] = True
    
    # Supplemental retirement
    if re.search(r'(?:SERP|supplemental.*?retirement|nonqualified.*?deferred)', 
                 filing_text, re.IGNORECASE):
        retirement['has_serp'] = True
    
    # 401(k) match
    match_pattern = r'(?:401\(k\)|retirement\s+plan).*?match.*?(\d+)%'
    match = re.search(match_pattern, filing_text, re.IGNORECASE | re.DOTALL)
    if match:
        retirement['401k_match_pct'] = float(match.group(1))
    
    return retirement if retirement else None


def extract_severance_multiples(self, filing_text: str) -> Optional[Dict]:
    """Extract severance/change-in-control multiples"""
    severance = {}
    
    # CIC (Change in Control) multiple
    cic_patterns = [
        r'change[- ]in[- ]control.*?(\d+)x.*?(?:base salary|annual compensation)',
        r'CIC.*?severance.*?(\d+)x',
        r'double[- ]trigger.*?(\d+)x',
    ]
    
    for pattern in cic_patterns:
        match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
        if match:
            severance['cic_multiple'] = int(match.group(1))
            break
    
    # General severance
    sev_patterns = [
        r'(?:^|\s)severance.*?(\d+)x.*?base\s+salary',
        r'termination.*?without\s+cause.*?(\d+)x',
    ]
    
    for pattern in sev_patterns:
        match = re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL)
        if match:
            severance['severance_multiple'] = int(match.group(1))
            break
    
    # Excise tax gross-up
    if re.search(r'(?:excise\s+tax|280G).*?gross[- ]up', filing_text, re.IGNORECASE):
        severance['has_excise_tax_grossup'] = True
    else:
        severance['has_excise_tax_grossup'] = False
    
    return severance if severance else None


# IMPROVED existing methods:

def extract_split_chair_ceo_improved(self, filing_text: str) -> Optional[bool]:
    """Improved Chair/CEO split detection"""
    
    # Look for explicit statements
    if re.search(r'(?:separate|split).*?(?:chair|chairman).*?(?:and|from).*?(?:CEO|chief executive)', 
                 filing_text, re.IGNORECASE | re.DOTALL):
        return True
    
    # Look for "independent chair" or "non-executive chair"
    if re.search(r'(?:independent|non[- ]executive).*?chair(?:man|person|woman)', 
                 filing_text, re.IGNORECASE):
        return True
    
    # Look for combined role
    combined_patterns = [
        r'(?:CEO|chief executive).*?(?:and|,).*?chair(?:man|person)',
        r'chair(?:man|person).*?(?:and|,).*?(?:CEO|chief executive)',
        r'serves\s+as\s+both.*?(?:CEO|chief executive).*?and.*?chair',
    ]
    
    for pattern in combined_patterns:
        if re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL):
            return False
    
    # If we find mention of chairman but can't determine, check governance section
    gov_section = re.search(
        r'board\s+leadership.*?((?:.|\n){500})',
        filing_text,
        re.IGNORECASE
    )
    
    if gov_section:
        section_text = gov_section.group(1)
        if 'separate' in section_text.lower() and 'chair' in section_text.lower():
            return True
    
    return None


def extract_say_on_pay_improved(self, filing_text: str) -> Optional[float]:
    """Improved say-on-pay extraction"""
    
    # Multiple pattern approaches
    patterns = [
        # Pattern 1: "X% voted for"
        r'(?:say[- ]on[- ]pay|advisory vote|executive compensation).*?(\d+\.?\d*)%.*?(?:voted|cast|in\s+favor|for)',
        
        # Pattern 2: "approved with X% support"
        r'(?:compensation|say[- ]on[- ]pay).*?(?:approved|passed).*?(\d+\.?\d*)%',
        
        # Pattern 3: Table format
        r'proposal.*?(?:compensation|say[- ]on[- ]pay).*?(\d+\.?\d*)%.*?for',
        
        # Pattern 4: Results table
        r'votes?\s+for.*?(\d+\.?\d*)%.*?(?:say[- ]on[- ]pay|compensation)',
    ]
    
    for pattern in patterns:
        matches = re.finditer(pattern, filing_text, re.IGNORECASE | re.DOTALL)
        for match in matches:
            pct = float(match.group(1))
            # Validate range
            if 50 <= pct <= 100:  # Say-on-pay typically passes with >50%
                return round(pct, 2)
    
    return None


def has_cyber_oversight_improved(self, filing_text: str) -> Optional[bool]:
    """Improved cybersecurity oversight detection"""
    
    # Explicit oversight statements
    strong_patterns = [
        r'(?:audit|risk)\s+committee.*?(?:responsible|oversee).*?cybersecurity',
        r'board.*?(?:oversees|reviews|monitors).*?(?:cyber|information\s+security)',
        r'cybersecurity\s+(?:oversight|governance).*?board',
        r'CISO.*?reports\s+to.*?(?:audit|risk)\s+committee',
    ]
    
    for pattern in strong_patterns:
        if re.search(pattern, filing_text, re.IGNORECASE | re.DOTALL):
            return True
    
    # Weaker indicators
    weak_patterns = [
        r'board.*?cybersecurity',
        r'cyber.*?risk.*?committee',
    ]
    
    weak_match_count = 0
    for pattern in weak_patterns:
        matches = re.findall(pattern, filing_text, re.IGNORECASE | re.DOTALL)
        weak_match_count += len(matches)
    
    # If multiple weak matches, likely has oversight
    if weak_match_count >= 3:
        return True
    
    return None
