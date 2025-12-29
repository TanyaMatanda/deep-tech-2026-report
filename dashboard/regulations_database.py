"""
Regulatory Database for Combined Regulatory Risk Dashboard

Comprehensive database of Canadian and US federal regulations applicable to deep tech companies.
"""

from datetime import date
from typing import List, Dict, Any

# Regulation structure
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
        severity_score: int = 5,  # 1-10
        listing_type: str = "Both",  # Both, Public, Private
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
        self.severity_score = severity_score
        self.listing_type = listing_type
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
        sectors=["All"],
        requirements=[
            "Report material cybersecurity incidents within 4 business days via Form 8-K",
            "Disclose cybersecurity risk management policies in annual Form 10-K",
            "Describe board oversight of cybersecurity risks in Form 10-K"
        ],
        penalties="SEC enforcement action; potential securities fraud liability; investor lawsuits",
        risk_level="High",
        severity_score=9,
        listing_type="Public",
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
        effective_date=None,
        scope=["Large accelerated filers, accelerated filers, and others (phased)"],
        sectors=["All"],
        requirements=[
            "Disclose Scope 1 and Scope 2 GHG emissions if material",
            "Describe climate-related risks and their material impacts",
            "Disclose climate-related targets and transition plans"
        ],
        penalties="SEC enforcement; potential greenwashing liability",
        risk_level="Medium",
        severity_score=6,
        listing_type="Public",
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
        effective_date=date(2018, 8, 13),
        scope=["Companies exporting emerging/foundational technologies"],
        sectors=["Semiconductors", "AI", "Quantum", "Biotechnology", "Advanced Materials"],
        requirements=[
            "Classify products under ECCN (Export Control Classification Number)",
            "Obtain licenses for exports to restricted entities/countries",
            "Monitor Entity List and Denied Persons List updates"
        ],
        penalties="Up to $1 million per violation; criminal penalties; denial of export privileges",
        risk_level="High",
        severity_score=8,
        listing_type="Both",
        investor_impact="Export restrictions can eliminate revenue from major markets (e.g., China)",
        action_items=[
            "Conduct ECCN classification for all products",
            "Implement automated Entity List screening",
            "Establish export compliance training program"
        ],
        deadline_type="Ongoing",
        deadline_description="Continuous compliance; license applications as needed"
    ),

    Regulation(
        id="usa_ccpa_cpra",
        name="California CCPA / CPRA",
        jurisdiction="USA",
        status="Active",
        effective_date=date(2023, 1, 1),
        scope=["Businesses with $25M+ revenue or processing 100k+ records in CA"],
        sectors=["All"],
        requirements=[
            "Provide 'Do Not Sell or Share My Information' links",
            "Allow consumers to correct inaccurate personal data",
            "Limit use and disclosure of sensitive personal information",
            "Maintain reasonable security procedures for sensitive data"
        ],
        penalties="$2,500 per unintentional violation; $7,500 per intentional violation; Private right of action for data breaches",
        risk_level="High",
        severity_score=8,
        listing_type="Both",
        investor_impact="Heavy fines for data mishandling; high litigation risk due to private right of action",
        action_items=[
            "Perform data mapping for California residents",
            "Update privacy notices and website 'opt-out' links",
            "Audit third-party data sharing agreements"
        ],
        deadline_type="Ongoing",
        deadline_description="Continuous compliance; Annual privacy policy updates"
    ),

    Regulation(
        id="usa_va_cdpa",
        name="Virginia CDPA",
        jurisdiction="USA",
        status="Active",
        effective_date=date(2023, 1, 1),
        scope=["Businesses with 100k+ VA consumers or 25k+ if selling data"],
        sectors=["All"],
        requirements=[
            "Obtain opt-in consent for sensitive data processing",
            "Conduct Data Protection Assessments (DPAs) for high-risk processing",
            "Honor consumer rights: access, correct, delete, and port data"
        ],
        penalties="Up to $7,500 per violation via Attorney General; 30-day cure period",
        risk_level="Medium",
        severity_score=6,
        listing_type="Both",
        investor_impact="Regulatory burden increases with state-level patchwork",
        action_items=[
            "Implement sensitive data consent workflows",
            "Establish Data Protection Assessment process",
            "Sync privacy requests with CA/EU workflows"
        ],
        deadline_type="Ongoing",
        deadline_description="Continuous compliance"
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
        severity_score=7,
        listing_type="Both",
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
        name="Fighting Against Forced Labour Act",
        jurisdiction="Canada",
        status="Active",
        effective_date=date(2024, 1, 1),
        scope=["Listed on Canadian exchange OR $20M+ assets/$40M+ revenue"],
        sectors=["All sectors producing, importing, or distributing goods"],
        requirements=[
            "Submit annual report by May 31 detailing steps to prevent forced/child labour",
            "Board of Directors approval of report",
            "Publish report on company website"
        ],
        penalties="Up to $250,000 CAD; criminal liability for officers/directors",
        risk_level="Medium",
        severity_score=6,
        listing_type="Both",
        investor_impact="Supply chain transparency requirements; reputational risk",
        action_items=[
            "Conduct supply chain risk assessment",
            "Establish Board approval process for May 31 deadline",
            "Submit mandatory online questionnaire"
        ],
        deadline_type="Annual",
        deadline_description="Report due May 31 each year"
    ),
    
    Regulation(
        id="can_pipeda",
        name="PIPEDA (Canada Privacy)",
        jurisdiction="Canada",
        status="Active",
        effective_date=date(2001, 1, 1),
        scope=["All organizations in commercial activities"],
        sectors=["All"],
        requirements=[
            "Obtain meaningful consent for data collection",
            "Implement privacy management program",
            "Report privacy breaches to Commissioner if significant harm likely"
        ],
        penalties="Federal Court orders for damages; Privacy Commissioner findings",
        risk_level="Medium",
        severity_score=5,
        listing_type="Both",
        investor_impact="Privacy breaches can damage customer trust and brand reputation",
        action_items=[
            "Implement privacy management framework",
            "Establish breach notification procedures",
            "Conduct privacy impact assessments"
        ],
        deadline_type="Ongoing",
        deadline_description="Breach reporting 'as soon as feasible'"
    ),
    
    Regulation(
        id="can_csa_cfr",
        name="CSA Client-Focused Reforms",
        jurisdiction="Canada",
        status="Active",
        effective_date=date(2021, 6, 30),
        scope=["Registered dealers, advisers, and fund managers"],
        sectors=["Financial Services", "Investment Management"],
        requirements=[
            "Address conflicts of interest in client's best interest",
            "Know Your Client (KYC) and suitability requirements",
            "Relationship disclosure and cost reporting"
        ],
        penalties="OSC/CSA enforcement; registration suspension",
        risk_level="High",
        severity_score=8,
        listing_type="Both",
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
            "No rehypothecation of client crypto assets",
            "Discontinue fiat-backed crypto assets by late 2024"
        ],
        penalties="Registration suspension; enforcement action",
        risk_level="High",
        severity_score=9,
        listing_type="Both",
        investor_impact="Strict custody rules aim to prevent exchange failures",
        action_items=[
            "Complete registration as restricted dealer",
            "Implement custody audit trail",
            "Phase out fiat-backed crypto products"
        ],
        deadline_type="Ongoing",
        deadline_description="Oct 31, 2024 deadline for fiat-backed crypto discontinuation"
    ),
    
    Regulation(
        id="can_aida_principles",
        name="AIDA Voluntary AI Principles",
        jurisdiction="Canada",
        status="Voluntary Guidance",
        effective_date=None,
        scope=["AI developers (voluntary)"],
        sectors=["AI", "Machine Learning"],
        requirements=[
            "Conduct risk assessments for high-impact AI systems",
            "Implement human oversight mechanisms",
            "Publish plain-language descriptions of AI use"
        ],
        penalties="None (voluntary)",
        risk_level="Low",
        severity_score=3,
        listing_type="Both",
        investor_impact="Industry self-regulation; precursor to mandatory rules",
        action_items=[
            "Monitor for new federal AI legislation",
            "Adopt voluntary principles as investor-facing best practice"
        ],
        deadline_type="N/A",
        deadline_description="Advisory only"
    ),
]

# ============================================
# EUROPEAN UNION REGULATIONS
# ============================================

EU_REGULATIONS = [
    Regulation(
        id="eu_gdpr",
        name="EU GDPR",
        jurisdiction="European Union",
        status="Active",
        effective_date=date(2018, 5, 25),
        scope=["Any company processing personal data of EU residents"],
        sectors=["All"],
        requirements=[
            "Process data lawfully, fairly, and transparently",
            "Report data breaches within 72 hours",
            "Appoint a Data Protection Officer (DPO) if large-scale processing",
            "Right to erasure ('Right to be forgotten') and data portability"
        ],
        penalties="Up to €20 million or 4% of global annual turnover, whichever is higher",
        risk_level="High",
        severity_score=10,
        listing_type="Both",
        investor_impact="Extremely high fines; significant operational impact for non-EU firms",
        action_items=[
            "Establish international data transfer safeguards (SCCs)",
            "Maintain processing activity records (Article 30)",
            "Automate 72-hour breach notification workflow"
        ],
        deadline_type="Ongoing",
        deadline_description="Continuous compliance; 72-hour reporting windows"
    ),

    Regulation(
        id="eu_ai_act",
        name="EU AI Act",
        jurisdiction="European Union",
        status="Phased Implementation",
        effective_date=date(2024, 8, 1),
        scope=["Providers and users of AI systems in the EU"],
        sectors=["AI", "Autonomous Systems", "Biotechnology", "Financial Services"],
        requirements=[
            "Ban on prohibited AI (social scoring, behavior manipulation)",
            "High-risk AI: Conformity assessments and risk management",
            "Technical documentation and CE marking for high-risk systems",
            "Transparency for limited risk AI (chatbots, deepfakes)"
        ],
        penalties="Up to €35 million or 7% of global turnover (prohibited practices)",
        risk_level="High",
        severity_score=9,
        listing_type="Both",
        investor_impact="World's first comprehensive AI law; will define global standards",
        action_items=[
            "Inventory AI systems and classify by risk level",
            "Phase out any 'unacceptable risk' applications by Feb 2025",
            "Establish AI Governance Board to oversee compliance"
        ],
        deadline_type="Phased",
        deadline_description="Feb 2025 (Prohibitions); Aug 2025 (GPAI); Aug 2026 (Full implementation)"
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
        effective_date=date(1976, 5, 28),
        scope=["Medical device manufacturers"],
        sectors=["Biotechnology", "Medical Devices"],
        requirements=[
            "Premarket approval (PMA) or 510(k) clearance",
            "Quality System Regulation (QSR) compliance",
            "Adverse event reporting (MDR)"
        ],
        penalties="Warning letters, recall orders, product seizure, criminal prosecution",
        risk_level="High",
        severity_score=9,
        listing_type="Both",
        investor_impact="FDA delays or rejections can halt revenue; safety issues halt trials",
        action_items=[
            "Maintain QSR compliance program",
            "Track adverse events and submit MDRs",
            "Prepare for site inspections"
        ],
        deadline_type="Ongoing",
        deadline_description="Surveillance reporting and pre-market submissions"
    ),
    
    Regulation(
        id="usa_faa_drone",
        name="FAA Part 107 (Drones)",
        jurisdiction="USA",
        status="Active",
        effective_date=date(2016, 8, 29),
        scope=["Commercial drone operators"],
        sectors=["Autonomous Systems", "Space and Aerospace"],
        requirements=[
            "Remote Pilot Certificate required",
            "Maintain Visual Line of Sight (VLOS)",
            "Drone registration and Remote ID compliance"
        ],
        penalties="Civil penalties up to $32k; loss of pilot certificate",
        risk_level="Medium",
        severity_score=4,
        listing_type="Both",
        investor_impact="Operating limits restrict scale of delivery/survey businesses",
        action_items=[
            "Verify pilot certifications",
            "Register all flight assets with FAA DroneZone",
            "Monitor new Remote ID broadcast requirements"
        ],
        deadline_type="Ongoing",
        deadline_description="Certificates expire every 24 months"
    ),

    Regulation(
        id="usa_faa_space",
        name="FAA Part 450 (Space Launch)",
        jurisdiction="USA",
        status="Active/Transitioning",
        effective_date=date(2021, 3, 21),
        scope=["Commercial space launch and reentry operators"],
        sectors=["Space and Aerospace"],
        requirements=[
            "Launch dynamic and trajectory analysis",
            "Public safety/population risk thresholds",
            "Policy and payload reviews for national security"
        ],
        penalties="License revocation; multi-million dollar fines; launch grounding",
        risk_level="High",
        severity_score=8,
        listing_type="Both",
        investor_impact="Launch delays due to licensing backlog affect satellite deployment ROI",
        action_items=[
            "Ensure transition to Part 450 by March 2026",
            "Submit payload reviews early to avoid scheduling delays",
            "Implement safety management systems (SMS)"
        ],
        deadline_type="Deadline",
        deadline_description="March 10, 2026: Mandatory transition to Part 450 for all licenses"
    ),

    Regulation(
        id="usa_doe_battery",
        name="DOE Battery Supply Chain (IRA)",
        jurisdiction="USA",
        status="Active",
        effective_date=date(2022, 8, 16),
        scope=["Battery manufacturers receiving federal credits"],
        sectors=["Energy and Climate", "Advanced Materials"],
        requirements=[
            "Domestic sourcing requirements for critical minerals",
            "Ban on 'Foreign Entities of Concern' (FEOC) components",
            "Environmental review for construction in developed areas"
        ],
        penalties="Loss of Section 30D/45X tax credits; loan acceleration",
        risk_level="Medium",
        severity_score=7,
        listing_type="Both",
        investor_impact="Tax credit eligibility is key to competitive pricing vs. China",
        action_items=[
            "Audit supply chain for FEOC (China, Russia, etc.)",
            "Maintain mineral sourcing documentation for tax audits",
            "Apply for TCF or SBIR grants if applicable"
        ],
        deadline_type="Annual",
        deadline_description="Annual certification of mineral sourcing"
    ),
]

# Combine all regulations
ALL_REGULATIONS = USA_REGULATIONS + CANADA_REGULATIONS + EU_REGULATIONS + SECTOR_REGULATIONS

# ============================================
# HELPER FUNCTIONS
# ============================================

def get_regulations_for_company(jurisdiction: str, sectors: List[str], listing_type: str = "Both") -> List[Regulation]:
    """
    Get applicable regulations for a company based on jurisdiction, sectors, and listing type.
    
    Args:
        jurisdiction: 'USA', 'Canada', or 'European Union'
        sectors: List of sectors (e.g., ['Semiconductors', 'AI'])
        listing_type: 'Public', 'Private', or 'Both'
    
    Returns:
        List of applicable Regulation objects, sorted by severity_score (descending)
    """
    applicable = []
    
    # Normalize inputs
    search_jurisdictions = [jurisdiction]
    if jurisdiction == "USA":
        # US companies may also be subject to EU rules if they process EU data (GDPR default)
        search_jurisdictions.append("European Union")
    elif jurisdiction == "Canada":
        search_jurisdictions.append("European Union")

    for reg in ALL_REGULATIONS:
        # 1. Check jurisdiction match
        if reg.jurisdiction not in search_jurisdictions:
            continue
        
        # 2. Check listing type (Public/Private filtering)
        if reg.listing_type != "Both" and listing_type != "Both":
            if reg.listing_type != listing_type:
                continue

        # 3. Check if regulation applies to any of the company's sectors
        is_sector_match = False
        if "All" in reg.sectors:
            is_sector_match = True
        else:
            for company_sector in sectors:
                if not company_sector:
                    continue
                for reg_sector in reg.sectors:
                    # Partial match for sectors (e.g. 'AI' matches 'Artificial Intelligence')
                    if reg_sector.lower() in company_sector.lower() or company_sector.lower() in reg_sector.lower():
                        is_sector_match = True
                        break
                if is_sector_match:
                    break
        
        if is_sector_match:
            applicable.append(reg)
    
    # Sort by severity score (10 down to 1)
    applicable.sort(key=lambda x: x.severity_score, reverse=True)
    
    return applicable

def get_jurisdictional_comparison() -> Dict[str, Dict[str, Any]]:
    """
    Generate jurisdictional comparison table for EU vs USA vs Canada.
    
    Returns:
        Dictionary with comparison categories
    """
    return {
        "AI Regulation": {
            "European Union": "Comprehensive risk-based rules (EU AI Act) - Effective 2024",
            "USA": "State-level patchwork (CA/NY) + Federal Executive Orders",
            "Canada": "Voluntary principles (AIDA); mandatory rules stalled"
        },
        "Data Privacy": {
            "European Union": "Gold standard (GDPR); high global extraterritorial reach",
            "USA": "No federal law; complex state-wide laws (CCPA, VA CDPA)",
            "Canada": "Uniform federal standard (PIPEDA); modernization pending"
        },
        "Cybersecurity": {
            "European Union": "NIS2 Directive (infrastructure) + DORA (finance)",
            "USA": "SEC mandatory 4-day material incident reporting",
            "Canada": "Proposed Bill C-26; general governance disclosures"
        },
        "Climate/ESG": {
            "European Union": "CSRD mandatory double-materiality reporting",
            "USA": "SEC rules stayed pending major litigation",
            "Canada": "Mandatory climate disclosures currently paused"
        },
        "Supply Chain": {
            "European Union": "CSDDD (Corporate Sustainability Due Diligence)",
            "USA": "Sector-specific (Conflict Minerals, Uyghur Forced Labor Act)",
            "Canada": "Federal Forced & Child Labour Act (Active Jan 2024)"
        }
    }
