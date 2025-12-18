# Governance Explorer - Real SEC Filing Data

This page displays **actual governance factors** extracted from SEC proxy statements and annual reports, not composite scores.

## Overview

**Purpose**: Search, filter, and export governance data for public companies based on real SEC filings

**Data Sources**: DEF 14A (Proxy Statements), 10-K (Annual Reports)

**Coverage**: 1,272 public companies with extracted governance factors

## Available Governance Factors

### Board Composition
- **Board Independence %**: Percentage of independent directors
- **Board Diversity %**: Gender and ethnic diversity on board
- **Split Chair/CEO**: Whether Chairman and CEO roles are separate
- **Overboarded Directors**: Number of directors serving on >4 public boards
- **Average Director Tenure**: Average years of board service

### Executive Compensation
- **Say-on-Pay Support %**: Shareholder approval of executive compensation
- **CEO Pay Ratio**: Ratio of CEO pay to median employee pay
- **Has Clawback Policy**: Whether company has executive comp clawback provisions
- **Pay-for-Performance Alignment**: Alignment between pay and company performance

### AI & Technology Governance
- **Has AI Ethics Board**: Dedicated AI ethics committee or oversight
- **Board AI Expertise**: Whether board has members with AI/ML background
- **AI Risk Mentions**: Number of AI-related risk factors disclosed
- **Has Technology Committee**: Dedicated board technology committee

### Cybersecurity
- **Cyber Oversight**: Explicit board cybersecurity oversight
- **CISO Reporting Line**: Who the Chief Information Security Officer reports to
- **Breach History**: Whether company disclosed data breaches

### Shareholder Rights  
- **Dual Class Stock**: Whether company has multi-class voting structure
- **Special Meeting Threshold**: % ownership needed to call special meeting
- **Written Consent**: Whether shareholders can act by written consent

### Risk & ESG
- **Climate Risk Mentions**: Number of climate-related risk disclosures
- **Supply Chain Risk Mentions**: Supply chain risk disclosures
- **Total Risk Factors**: Total number of risk factors in Item 1A
- **Has Sustainability Committee**: Dedicated ESG/sustainability committee
- **Climate Oversight**: Board-level climate risk oversight

## Using the Explorer

**Search**: Use the company search to find specific companies  
**Filter**: Apply multiple filters to find companies matching criteria  
**Sort**: Click column headers to sort by any governance factor  
**Export**: Download filtered results as CSV for further analysis

## Data Freshness

Last Updated: Check the `last_updated` field for each company  
Update Frequency: Daily automated extraction from latest SEC filings  

## Interpretation Guide

### Board Independence
- **\u003e80%**: Strong independence (OECD best practice)
- **50-80%**: Moderate independence
- **\u003c50%**: Weak independence (governance risk)

### Say-on-Pay Support
- **\u003e90%**: Strong shareholder support
- **70-90%**: Moderate support
- **\u003c70%**: Low support (compensation concerns)

### CEO Pay Ratio
- **\u003c100**: Relatively equitable
- **100-300**: Industry standard
- **\u003e300**: High disparity (potential risk)

### AI Risk Mentions
- **0**: No disclosed AI risks
- **1-5**: Limited AI risk awareness
- **5+**: Comprehensive AI risk disclosure

---

**Note**: This dashboard prioritizes **raw governance data** over composite scores. Scores are provided as optional reference only.
