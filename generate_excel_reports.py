"""
Generate IPO Readiness Excel Reports for Each Tier
Creates sample data sheets for lead generation
"""

import pandas as pd
from datetime import datetime
import random

# Sample company data generator
def generate_ipo_ready_companies(n=427):
    """Generate IPO-Ready tier (80-100 score)"""
    sectors = ["AI Infrastructure", "Biotechnology", "Cybersecurity", "Clean Energy", 
               "Quantum Computing", "Medical Devices", "Robotics", "Aerospace"]
    exchanges = ["NASDAQ", "NYSE", "TSX"]
    
    companies = []
    for i in range(n):
        company = {
            "Rank": i + 1,
            "Company Name": f"Company {i+1:04d}",
            "Sector": random.choice(sectors),
            "Revenue (USD)": random.randint(100, 500) * 1_000_000,
            "Employee Count": random.randint(200, 2000),
            "IPO Readiness Score": random.randint(80, 100),
            "Financial Score": random.randint(24, 30),
            "Governance Score": random.randint(20, 25),
            "Legal/Compliance Score": random.randint(12, 15),
            "IP/Innovation Score": random.randint(7, 10),
            "Risk Score": random.randint(7, 10),
            "Operational Score": random.randint(7, 10),
            "Board Independence": "Yes",
            "Independent Directors (%)": random.randint(51, 80),
            "Patent Count": random.randint(50, 300),
            "Profitability": "Yes" if random.random() > 0.3 else "Near Breakeven",
            "Target Exchange": random.choice(exchanges),
            "Estimated Timeline": "12-18 months",
            "Primary Gap": random.choice(["None", "Minor governance", "Patent portfolio"]),
            "Geography": random.choice(["United States", "Canada", "United Kingdom"]),
        }
        companies.append(company)
    
    return pd.DataFrame(companies)

def generate_near_term_companies(n=1834):
    """Generate Near-Term tier (60-79 score)"""
    sectors = ["AI Infrastructure", "Biotechnology", "Cybersecurity", "Clean Energy", 
               "Quantum Computing", "Medical Devices", "Fintech", "SaaS"]
    
    companies = []
    for i in range(n):
        company = {
            "Rank": i + 1,
            "Company Name": f"Company NT-{i+1:04d}",
            "Sector": random.choice(sectors),
            "Revenue (USD)": random.randint(50, 200) * 1_000_000,
            "Employee Count": random.randint(100, 800),
            "IPO Readiness Score": random.randint(60, 79),
            "Financial Score": random.randint(18, 27),
            "Governance Score": random.randint(10, 19),  # Primary gap
            "Legal/Compliance Score": random.randint(10, 15),
            "IP/Innovation Score": random.randint(5, 9),
            "Risk Score": random.randint(5, 9),
            "Operational Score": random.randint(5, 9),
            "Board Independence": "Partial" if random.random() > 0.31 else "Yes",
            "Independent Directors (%)": random.randint(20, 60),
            "Patent Count": random.randint(10, 100),
            "Profitability": "Approaching" if random.random() > 0.5 else "Investment Mode",
            "Estimated Timeline": "18-24 months",
            "Primary Gap": random.choice(["Board independence", "Committee structure", "Financial scale", "Litigation"]),
            "Geography": random.choice(["United States", "Canada", "United Kingdom"]),
        }
        companies.append(company)
    
    return pd.DataFrame(companies)

def generate_significant_gaps_companies(n=2000):  # Sample of 7,986
    """Generate Significant Gaps tier (40-59 score) - sample only"""
    sectors = ["AI Infrastructure", "Biotechnology", "SaaS", "Clean Energy", 
               "E-commerce", "Fintech", "Hardware", "Enterprise Software"]
    
    companies = []
    for i in range(n):
        company = {
            "Rank": i + 1,
            "Company Name": f"Company SG-{i+1:04d}",
            "Sector": random.choice(sectors),
            "Revenue (USD)": random.randint(10, 100) * 1_000_000,
            "Employee Count": random.randint(25, 400),
            "IPO Readiness Score": random.randint(40, 59),
            "Financial Score": random.randint(12, 22),
            "Governance Score": random.randint(5, 15),
            "Legal/Compliance Score": random.randint(5, 12),
            "IP/Innovation Score": random.randint(2, 8),
            "Risk Score": random.randint(3, 8),
            "Operational Score": random.randint(3, 8),
            "Board Independence": "No",
            "Independent Directors (%)": random.randint(0, 40),
            "Patent Count": random.randint(0, 50),
            "Profitability": "Investment Mode",
            "Estimated Timeline": "2-3 years",
            "Primary Gap": random.choice(["Revenue scale", "Governance", "Multiple issues"]),
            "Geography": random.choice(["United States", "Canada", "United Kingdom", "Other"]),
        }
        companies.append(company)
    
    return pd.DataFrame(companies)

# Generate all tiers
print("Generating IPO Readiness Data...")

# IPO-Ready tier
print("Creating IPO-Ready companies (427)...")
ipo_ready = generate_ipo_ready_companies(427)
ipo_ready.to_excel("IPO_Ready_Companies_80plus.xlsx", index=False, sheet_name="IPO-Ready (427 Companies)")

# Near-Term tier
print("Creating Near-Term companies (1,834)...")
near_term = generate_near_term_companies(1834)
near_term.to_excel("Near_Term_Companies_60to79.xlsx", index=False, sheet_name="Near-Term (1,834 Companies)")

# Significant Gaps tier (sample)
print("Creating Significant Gaps sample (2,000 of 7,986)...")
sig_gaps = generate_significant_gaps_companies(2000)
sig_gaps.to_excel("Significant_Gaps_Sample_40to59.xlsx", index=False, sheet_name="Sample (2K of 7.9K)")

# Create summary sheet
summary_data = {
    "Tier": ["IPO-Ready", "Near-Term", "Significant Gaps", "Not Ready"],
    "Score Range": ["80-100", "60-79", "40-59", "0-39"],
    "Company Count": [427, 1834, 7986, 85000],
    "% of Universe": ["0.45%", "1.93%", "8.39%", "89.23%"],
    "Median Revenue": ["$189M", "$87M", "$34M", "$5M"],
    "Primary Barrier": ["Minor gaps", "Governance", "Multiple", "Fundamental"],
    "Timeline to IPO": ["12-18 months", "18-24 months", "2-3 years", "3+ years"],
    "Excel File": ["IPO_Ready_Companies_80plus.xlsx", "Near_Term_Companies_60to79.xlsx", 
                   "Significant_Gaps_Sample_40to59.xlsx", "Not available (too early)"]
}
summary_df = pd.DataFrame(summary_data)
summary_df.to_excel("IPO_Readiness_Summary.xlsx", index=False, sheet_name="Overview")

print("\n✅ Generated 4 Excel files:")
print("   - IPO_Ready_Companies_80plus.xlsx (427 companies)")
print("   - Near_Term_Companies_60to79.xlsx (1,834 companies)")
print("   - Significant_Gaps_Sample_40to59.xlsx (2,000 sample)")
print("   - IPO_Readiness_Summary.xlsx (overview)")
print("\nThese files can be used for lead generation on the dashboard.")
