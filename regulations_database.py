"""
Regulatory Database for Combined Regulatory Risk Dashboard

Comprehensive database of Canadian and US federal regulations applicable to deep tech companies.
"""

from datetime import date
from typing import List, Dict, Any

# Regulation structure
class Regulation:
    def __init__(
        self,
        id: str,
        name: str,
        jurisdiction: str,
        status: str,
        effective_date: date,
        scope: List[str],
        sectors: List[str],
        requirements: List[str],
        penalties: str,
        risk_level: str,
        investor_impact: str,
        action_items: List[str],
        deadline_type: str = None,
        deadline_description: str = None
    ):
        self.id = id
        self.name = name
        self.jurisdiction = jurisdiction
        self.status = status
        self.effective_date = effective_date
        self.scope = scope
        self.sectors = sectors
        self.requirements = requirements
        self.penalties = penalties
        self.risk_level = risk_level
        self.investor_impact = investor_impact
        self.action_items = action_items
        self.deadline_type = deadline_type
        self.deadline_description = deadline_description

# ============================================
# UNITED STATES REGULATIONS
# ============================================

USA_REGULATIONS = [
    Regulation(
        id="usa_sec_cyber",
        name="SEC Cybersecurity Disclosure Rules",
        jurisdiction="USA",
        status="Active",
        effective_date=date(2023, 12, 18),
        scope=["All public companies"],
        sectors=["All"],  # Universal
        requirements=[
            "Report material cybersecurity incidents within 4 business days via Form 8-K",
            "Disclose cybersecurity risk management policies in annual Form 10-K",
            "Describe board oversight of cybersecurity risks in Form 10-K"
        ],
        penalties="SEC enforcement action; potential securities fraud liability; investor lawsuits",
        risk_level="High",
        investor_impact="Material incidents may trigger immediate stock price volatility and erode investor confidence",
        action_items=[
            "Formalize CISO reporting lines to Board of Directors",
            "Establish incident materiality assessment framework",
            "Create 4-day incident disclosure process and templates"
        ],
        deadline_type="Ongoing/Annual",
        deadline_description="Incident reporting within 4 days; Annual 10-K disclosure"
    ),
    
    Regulation(
        id="usa_sec_climate",
        name="SEC Climate-Related Disclosure Rules",
        jurisdiction="USA",
        status="Stayed (Litigation Pending)",
        effective_date=None,  # Not yet effective
        scope=["Large accelerated filers, accelerated filers, and others (phased)"],
        sectors=["All"],
        requirements=[
            "Disclose Scope 1 and Scope 2 GHG emissions if material",
            "Describe climate-related risks and their material impacts",
            "Disclose climate-related targets and transition plans"
        ],
        penalties="SEC enforcement; potential greenwashing liability",
        risk_level="Medium",
        investor_impact="Delayed implementation creates regulatory uncertainty; ESG investors monitor closely",
        action_items=[
            "Monitor litigation status and SEC guidance",
            "Begin Scope 1/2 emissions data collection as best practice",
            "Prepare climate risk assessment framework"
        ],
        deadline_type="Pending",
        deadline_description="Currently stayed; monitor for court rulings"
    ),
    
    Regulation(
        id="usa_export_controls",
        name="Export Administration Regulations (EAR) - Advanced Technology",
        jurisdiction="USA",
        status="Active",
        effective_date=date(2018, 8, 13),  # ECRA 2018
        scope=["Companies exporting emerging/foundational technologies"],
        sectors=["Semiconductors", "AI", "Quantum", "Biotechnology", "Advanced Materials"],
        requirements=[
            "Classify products under ECCN (Export Control Classification Number)",
            "Obtain licenses for exports to restricted entities/countries",
            "Monitor Entity List and Denied Persons List updates"
        ],
        penalties="Up to $1 million per violation; criminal penalties; denial of export privileges",
        risk_level="High",
        investor_impact="Export restrictions can eliminate revenue from major markets (e.g., China represents 20%+ revenue for some semiconductor firms)",
        action_items=[
            "Conduct ECCN classification for all products",
            "Implement automated Entity List screening",
            "Establish export compliance training program"
        ],
        deadline_type="Ongoing",
        deadline_description="Continuous compliance; license applications as needed"
    ),
    
    Regulation(
        id="usa_ny_raise_act",
        name="NY RAISE Act (Proposed)",
        jurisdiction="USA",
        status="Pending Governor Approval",
        effective_date=None,
        scope=["AI developers with $100M+ training costs"],
        sectors=["AI", "Machine Learning"],
        requirements=[
            "Implement and publish safety and security protocols",
            "Report safety incidents within 72 hours to NY Attorney General",
            "Conduct risk assessments before deployment"
        ],
        penalties="Up to $10 million first violation; $30 million repeat violations",
        risk_level="Medium",
        investor_impact="First-in-nation AI safety regulation; sets precedent for other states",
        action_items=[
            "Monitor bill status (awaiting Governor Hochul signature)",
            "Prepare AI safety protocol documentation",
            "Establish incident notification process"
        ],
        deadline_type="TBD",
        deadline_description="If enacted, compliance required within months of effective date"
    ),
]

# ============================================
# CANADIAN REGULATIONS
# ============================================

CANADA_REGULATIONS = [
    Regulation(
        id="can_forced_labor",
        name="Fighting Against Forced Labour and Child Labour in Supply Chains Act",
        jurisdiction="Canada",
        status="Active",
        effective_date=date(2024, 1, 1),
        scope=[
            "Listed on Canadian stock exchange OR",
            "Have place of business/assets in Canada AND meet 2 of: $20M+ assets, $40M+ revenue, 250+ employees"
        ],
        sectors=["All sectors producing, importing, or distributing goods"],
        requirements=[
            "Submit annual report by May 31 detailing steps to prevent forced/child labour",
            "Board of Directors approval of report",
            "Publish report on company website",
            "Complete mandatory online questionnaire"
        ],
        penalties="Up to $250,000 CAD; criminal liability for officers/directors",
        risk_level="Medium",
        investor_impact="Supply chain transparency requirements; reputational risk if forced labour found",
        action_items=[
            "Conduct supply chain risk assessment",
            "Prepare annual report template",
            "Establish Board approval process for May 31 deadline"
        ],
        deadline_type="Annual",
        deadline_description="Report due May 31 each year"
    ),
    
    Regulation(
        id="can_pipeda",
        name="Personal Information Protection and Electronic Documents Act (PIPEDA)",
        jurisdiction="Canada",
        status="Active",
        effective_date=date(2001, 1, 1),  # Original act
        scope=["All organizations collecting personal information in commercial activities"],
        sectors=["All"],
        requirements=[
            "Obtain meaningful consent for collection/use/disclosure of personal information",
            "Implement privacy management program",
            "Report privacy breaches to Privacy Commissioner if real risk of significant harm",
            "Provide individuals access to their personal information"
        ],
        penalties="Federal Court can order damages; Privacy Commissioner can publicize findings",
        risk_level="Medium",
        investor_impact="Privacy breaches can damage customer trust and brand reputation",
        action_items=[
            "Implement privacy management framework",
            "Establish breach notification procedures",
            "Conduct privacy impact assessments for new initiatives"
        ],
        deadline_type="Ongoing",
        deadline_description="Breach reporting as soon as feasible; ongoing compliance"
    ),
    
    Regulation(
        id="can_csa_cfr",
        name="CSA Client-Focused Reforms",
        jurisdiction="Canada",
        status="Active",
        effective_date=date(2021, 6, 30),
        scope=["Registered dealers, advisers, and investment fund managers"],
        sectors=["Financial Services", "Investment Management"],
        requirements=[
            "Address conflicts of interest in client's best interest",
            "Know Your Client (KYC) and suitability requirements",
            "Relationship disclosure information must be provided",
            "Total cost reporting to clients"
        ],
        penalties="OSC/CSA enforcement; potential registration suspension",
        risk_level="High",
        investor_impact="Regulatory scrutiny of financial services firms' client treatment",
        action_items=[
            "Document all material conflicts of interest",
            "Implement conflicts management framework",
            "Ensure KYC compliance processes are current"
        ],
        deadline_type="Ongoing",
        deadline_description="Continuous compliance; regular CSA sweeps"
    ),
    
    Regulation(
        id="can_csa_crypto",
        name="CSA Crypto Asset Trading Platform Rules",
        jurisdiction="Canada",
        status="Active",
        effective_date=date(2023, 6, 1),
        scope=["Crypto trading platforms operating in Canada"],
        sectors=["Cryptocurrency", "Fintech"],
        requirements=[
            "Register as restricted dealer with principal regulator",
            "Maintain custody of client crypto assets (no rehypothecation)",
            "Discontinue fiat-backed crypto assets by Oct 31, 2024",
            "Submit Principal Regulator Undertaking (PRU)"
        ],
        penalties="Registration suspension/revocation; enforcement action",
        risk_level="High",
        investor_impact="Regulatory clarity reduces systemic risk in crypto sector",
        action_items=[
            "Complete registration as restricted dealer",
            "Implement custody requirements",
            "Phase out fiat-backed crypto products"
        ],
        deadline_type="Ongoing",
        deadline_description="Oct 31, 2024 deadline for fiat-backed crypto discontinuation"
    ),
    
    Regulation(
        id="can_aida_principles",
        name="AIDA Voluntary Principles (Bill C-27 Stalled)",
        jurisdiction="Canada",
        status="Voluntary Guidance Only",
        effective_date=None,
        scope=["AI developers (voluntary adoption)"],
        sectors=["AI", "Machine Learning"],
        requirements=[
            "Conduct risk assessments for high-impact AI systems (voluntary)",
            "Implement human oversight mechanisms (voluntary)",
            "Publish plain-language descriptions of AI use (voluntary)"
        ],
        penalties="None (voluntary)",
        risk_level="Low",
        investor_impact="AIDA legislation stalled; industry self-regulation continues",
        action_items=[
            "Monitor for new federal AI legislation",
            "Consider voluntary adoption of AIDA principles as best practice",
            "Participate in industry AI governance initiatives"
        ],
        deadline_type="N/A",
        deadline_description="No mandatory requirements; advisory only"
    ),
]

# ============================================
# SECTOR-SPECIFIC REGULATIONS
# ============================================

SECTOR_REGULATIONS = [
    Regulation(
        id="usa_fda_medical",
        name="FDA Medical Device Regulations",
        jurisdiction="USA",
        status="Active",
        effective_date=date(1976, 5, 28),  # Medical Device Amendments
        scope=["Medical device manufacturers"],
        sectors=["Biotechnology", "Medical Devices"],
        requirements=[
            "Premarket approval (PMA) or 510(k) clearance",
            "Quality System Regulation (QSR) compliance",
            "Adverse event reporting (MDR)",
            "Establishment registration and device listing"
        ],
        penalties="Warning letters, consent decrees, product seizure, criminal prosecution",
        risk_level="High",
        investor_impact="FDA delays or rejections can halt revenue; clinical hold stops trials",
        action_items=[
            "Maintain QSR compliance program",
            "Track adverse events and submit MDRs",
            "Plan for FDA inspections (Form 483 responses)"
        ],
        deadline_type="Ongoing",
        deadline_description="Pre-market submissions before commercialization; ongoing post-market surveillance"
    ),
]

# Combine all regulations
ALL_REGULATIONS = USA_REGULATIONS + CANADA_REGULATIONS + SECTOR_REGULATIONS

# ============================================
# HELPER FUNCTIONS
# ============================================

def get_regulations_for_company(jurisdiction: str, sectors: List[str], listing_type: str = None) -> List[Regulation]:
    """
    Get applicable regulations for a company based on jurisdiction and sectors.
    
    Args:
        jurisdiction: 'USA' or 'Canada'
        sectors: List of sectors (e.g., ['Semiconductors', 'AI'])
        listing_type: 'Public' or 'Private' (optional)
    
    Returns:
        List of applicable Regulation objects, sorted by risk_level
    """
    applicable = []
    
    # Define regulations that only apply to public companies
    public_only_regs = [
        'usa_sec_cyber',  # SEC Cybersecurity - public companies only
        'usa_sec_climate',  # SEC Climate - public companies only
    ]
    
    for reg in ALL_REGULATIONS:
        # Check jurisdiction match
        if reg.jurisdiction != jurisdiction:
            continue
        
        # Filter out public-only regulations for private companies
        if listing_type == 'Private' and reg.id in public_only_regs:
            continue
        
        # Check if regulation applies to any of the company's sectors
        if "All" in reg.sectors:
            applicable.append(reg)
        else:
            for company_sector in sectors:
                if not company_sector:
                    continue
                for reg_sector in reg.sectors:
                    if reg_sector.lower() in company_sector.lower() or company_sector.lower() in reg_sector.lower():
                        applicable.append(reg)
                        break
    
    # Sort by risk level (High > Medium > Low)
    risk_order = {"High": 0, "Medium": 1, "Low": 2}
    applicable.sort(key=lambda x: risk_order.get(x.risk_level, 3))
    
    return applicable

def get_jurisdictional_comparison() -> Dict[str, Dict[str, Any]]:
    """
    Generate jurisdictional comparison table for USA vs Canada.
    
    Returns:
        Dictionary with comparison categories
    """
    return {
        "Cybersecurity Disclosure": {
            "USA": "✅ Mandatory 4-day material incident reporting (SEC)",
            "Canada": "⚠️ General risk disclosure requirements (less prescriptive)"
        },
        "Climate Disclosure": {
            "USA": "⏸️ Rules adopted but stayed pending litigation",
            "Canada": "⏸️ Mandatory climate rules paused (April 2025)"
        },
        "Board Diversity": {
            "USA": "⏳ Proposed Oct 2025 (not yet effective)",
            "Canada": "✅ 'Comply or Explain' model (NI 58-101)"
        },
        "AI Governance": {
            "USA": "🔵 State-level activity (NY RAISE Act pending)",
            "Canada": "❌ AIDA legislation stalled (Bill C-27)"
        },
        "Supply Chain Labor": {
            "USA": "⚠️ Sector-specific (Conflict Minerals)",
            "Canada": "✅ Federal Forced & Child Labour Act (Jan 2024)"
        },
        "Privacy/Data Protection": {
            "USA": "🔵 State patchwork (CA CCPA, VA CDPA, etc.)",
            "Canada": "✅ Federal PIPEDA (uniform national standard)"
        }
    }
