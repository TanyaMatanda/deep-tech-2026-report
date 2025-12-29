-- Initial Data Population: Top 20 Deep Tech Companies
-- For RiskAnchor Vendor Governance Database
-- Tier 1: Public Companies (Full Data Available)

SET search_path TO vendor_governance, public;

-- ============================================
-- QUANTUM COMPUTING
-- ============================================

-- 1. IonQ (IONQ) - Trapped Ion Quantum
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'IonQ', 'IonQ, Inc.', 'IONQ', '0001865243',
    '2015-10-01', 2015, 'Delaware', 'USA',
    'Quantum Computing', 'Trapped Ion Quantum Hardware',
    ARRAY['quantum computing', 'trapped ion', 'quantum cloud'],
    'College Park', 'Maryland', 'USA',
    'https://ionq.com', 'Public', 'NYSE', 1
);

-- 2. Rigetti Computing (RGTI) - Superconducting Quantum
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'Rigetti Computing', 'Rigetti Computing, Inc.', 'RGTI', '0001910074',
    '2013-07-12', 2013, 'Delaware', 'USA',
    'Quantum Computing', 'Superconducting Quantum Hardware',
    ARRAY['quantum computing', 'superconducting qubits', 'quantum cloud'],
    'Berkeley', 'California', 'USA',
    'https://rigetti.com', 'Public', 'NASDAQ', 1
);

-- 3. D-Wave Quantum (QBTS) - Quantum Annealing
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'D-Wave Quantum', 'D-Wave Quantum Inc.', 'QBTS', '0001829166',
    '1999-01-01', 1999, 'British Columbia', 'CAN',
    'Quantum Computing', 'Quantum Annealing Hardware',
    ARRAY['quantum computing', 'quantum annealing', 'optimization'],
    'Burnaby', 'British Columbia', 'CAN',
    'https://dwavesys.com', 'Public', 'NYSE', 1
);

-- ============================================
-- AI & MACHINE LEARNING
-- ============================================

-- 4. C3.ai (AI) - Enterprise AI
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'C3.ai', 'C3.ai, Inc.', 'AI', '0001577526',
    '2009-04-01', 2009, 'Delaware', 'USA',
    'AI & Machine Learning', 'Enterprise AI Platform',
    ARRAY['AI', 'machine learning', 'enterprise software', 'predictive analytics'],
    'Redwood City', 'California', 'USA',
    'https://c3.ai', 'Public', 'NYSE', 1
);

-- 5. Palantir Technologies (PLTR) - AI/Data Analytics
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'Palantir Technologies', 'Palantir Technologies Inc.', 'PLTR', '0001321655',
    '2003-05-06', 2003, 'Delaware', 'USA',
    'AI & Machine Learning', 'AI Data Analytics Platform',
    ARRAY['AI', 'big data', 'analytics', 'government tech'],
    'Denver', 'Colorado', 'USA',
    'https://palantir.com', 'Public', 'NYSE', 1
);

-- 6. SoundHound AI (SOUN) - Voice AI
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'SoundHound AI', 'SoundHound AI, Inc.', 'SOUN', '0001840856',
    '2005-01-01', 2005, 'Delaware', 'USA',
    'AI & Machine Learning', 'Voice AI & Conversational Intelligence',
    ARRAY['AI', 'voice recognition', 'NLP', 'conversational AI'],
    'Santa Clara', 'California', 'USA',
    'https://soundhound.com', 'Public', 'NASDAQ', 1
);

-- ============================================
-- BIOTECHNOLOGY & GENOMICS
-- ============================================

-- 7. Ginkgo Bioworks (DNA) - Synthetic Biology
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'Ginkgo Bioworks', 'Ginkgo Bioworks Holdings, Inc.', 'DNA', '0001840281',
    '2008-09-11', 2008, 'Delaware', 'USA',
    'Biotechnology', 'Synthetic Biology Platform',
    ARRAY['synthetic biology', 'bioengineering', 'biomanufacturing'],
    'Boston', 'Massachusetts', 'USA',
    'https://ginkgobioworks.com', 'Public', 'NYSE', 1
);

-- 8. CRISPR Therapeutics (CRSP) - Gene Editing
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'CRISPR Therapeutics', 'CRISPR Therapeutics AG', 'CRSP', '0001674416',
    '2013-10-01', 2013, 'Switzerland', 'CHE',
    'Biotechnology', 'Gene Editing & Cell Therapy',
    ARRAY['CRISPR', 'gene editing', 'cell therapy', 'therapeutics'],
    'Zug', 'Zug', 'CHE',
    'https://crisprtx.com', 'Public', 'NASDAQ', 1
);

-- 9. Recursion Pharmaceuticals (RXRX) - AI Drug Discovery
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'Recursion Pharmaceuticals', 'Recursion Pharmaceuticals, Inc.', 'RXRX', '0001601527',
    '2013-01-01', 2013, 'Delaware', 'USA',
    'Biotechnology', 'AI-Driven Drug Discovery',
    ARRAY['AI', 'drug discovery', 'machine learning', 'biotechnology'],
    'Salt Lake City', 'Utah', 'USA',
    'https://recursion.com', 'Public', 'NASDAQ', 1
);

-- ============================================
-- ROBOTICS & AUTONOMOUS SYSTEMS
-- ============================================

-- 10. UiPath (PATH) - Robotic Process Automation
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'UiPath', 'UiPath, Inc.', 'PATH', '0001787760',
    '2005-01-01', 2005, 'Delaware', 'USA',
    'AI & Machine Learning', 'Robotic Process Automation',
    ARRAY['RPA', 'automation', 'AI', 'enterprise software'],
    'New York', 'New York', 'USA',
    'https://uipath.com', 'Public', 'NYSE', 1
);

-- ============================================
-- ENERGY & CLIMATE TECH
-- ============================================

-- 11. QuantumScape (QS) - Solid-State Batteries
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'QuantumScape', 'QuantumScape Corporation', 'QS', '0001811414',
    '2010-01-01', 2010, 'Delaware', 'USA',
    'Energy & Climate', 'Solid-State Battery Technology',
    ARRAY['batteries', 'energy storage', 'electric vehicles', 'materials science'],
    'San Jose', 'California', 'USA',
    'https://quantumscape.com', 'Public', 'NYSE', 1
);

-- 12. Plug Power (PLUG) - Hydrogen Fuel Cells
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'Plug Power', 'Plug Power Inc.', 'PLUG', '0001093691',
    '1997-06-27', 1997, 'Delaware', 'USA',
    'Energy & Climate', 'Hydrogen Fuel Cell Systems',
    ARRAY['hydrogen', 'fuel cells', 'clean energy', 'energy storage'],
    'Latham', 'New York', 'USA',
    'https://plugpower.com', 'Public', 'NASDAQ', 1
);

-- ============================================
-- SEMICONDUCTORS & ADVANCED COMPUTING
-- ============================================

-- 13. NVIDIA (NVDA) - AI Chips & GPUs
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'NVIDIA', 'NVIDIA Corporation', 'NVDA', '0001045810',
    '1993-04-05', 1993, 'Delaware', 'USA',
    'Advanced Computing', 'AI Accelerators & GPU Computing',
    ARRAY['AI', 'GPUs', 'semiconductors', 'data center', 'gaming'],
    'Santa Clara', 'California', 'USA',
    'https://nvidia.com', 'Public', 'NASDAQ', 1
);

-- 14. AMD (AMD) - High-Performance Computing
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'AMD', 'Advanced Micro Devices, Inc.', 'AMD', '0000002488',
    '1969-05-01', 1969, 'Delaware', 'USA',
    'Advanced Computing', 'High-Performance Processors',
    ARRAY['semiconductors', 'processors', 'GPUs', 'data center'],
    'Santa Clara', 'California', 'USA',
    'https://amd.com', 'Public', 'NASDAQ', 1
);

-- ============================================
-- CYBERSECURITY
-- ============================================

-- 15. CrowdStrike (CRWD) - AI-Powered Cybersecurity
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'CrowdStrike', 'CrowdStrike Holdings, Inc.', 'CRWD', '0001535527',
    '2011-11-08', 2011, 'Delaware', 'USA',
    'Cybersecurity', 'Cloud-Native Endpoint Security',
    ARRAY['cybersecurity', 'AI', 'threat detection', 'endpoint protection'],
    'Austin', 'Texas', 'USA',
    'https://crowdstrike.com', 'Public', 'NASDAQ', 1
);

-- 16. Palo Alto Networks (PANW) - Network Security
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'Palo Alto Networks', 'Palo Alto Networks, Inc.', 'PANW', '0001327567',
    '2005-03-01', 2005, 'Delaware', 'USA',
    'Cybersecurity', 'Network Security Platform',
    ARRAY['cybersecurity', 'firewall', 'cloud security', 'threat intelligence'],
    'Santa Clara', 'California', 'USA',
    'https://paloaltonetworks.com', 'Public', 'NASDAQ', 1
);

-- ============================================
-- SPACE TECHNOLOGY
-- ============================================

-- 17. Rocket Lab (RKLB) - Small Satellite Launch
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'Rocket Lab', 'Rocket Lab USA, Inc.', 'RKLB', '0001819810',
    '2006-01-01', 2006, 'Delaware', 'USA',
    'Space Technology', 'Small Satellite Launch Services',
    ARRAY['space', 'rockets', 'satellite launch', 'aerospace'],
    'Long Beach', 'California', 'USA',
    'https://rocketlabusa.com', 'Public', 'NASDAQ', 1
);

-- ============================================
-- CANADIAN DEEP TECH
-- ============================================

-- 18. Shopify (SHOP) - E-commerce AI/ML
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'Shopify', 'Shopify Inc.', 'SHOP', '0001594805',
    '2004-09-28', 2004, 'Ontario', 'CAN',
    'AI & Machine Learning', 'E-commerce & AI Platform',
    ARRAY['e-commerce', 'AI', 'machine learning', 'SaaS'],
    'Ottawa', 'Ontario', 'CAN',
    'https://shopify.com', 'Public', 'NYSE', 1
);

-- 19. BlackBerry (BB) - Cybersecurity & IoT
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'BlackBerry', 'BlackBerry Limited', 'BB', '0001070235',
    '1984-03-07', 1984, 'Ontario', 'CAN',
    'Cybersecurity', 'Endpoint Security & IoT Platform',
    ARRAY['cybersecurity', 'IoT', 'QNX', 'endpoint security'],
    'Waterloo', 'Ontario', 'CAN',
    'https://blackberry.com', 'Public', 'NYSE', 1
);

-- 20. Matterport (MTTR) - Spatial AI
INSERT INTO companies (
    company_name, legal_name, ticker_symbol, cik,
    incorporation_date, incorporation_year, incorporation_jurisdiction, incorporation_country,
    primary_sector, primary_subsector, technology_tags,
    headquarters_city, headquarters_state_province, headquarters_country,
    website_url, listing_type, stock_exchange, data_tier
) VALUES (
    'Matterport', 'Matterport, Inc.', 'MTTR', '0001859690',
    '2011-01-01', 2011, 'Delaware', 'USA',
    'AI & Machine Learning', 'Spatial Computing & 3D AI',
    ARRAY['AI', '3D imaging', 'computer vision', 'spatial computing'],
    'Sunnyvale', 'California', 'USA',
    'https://matterport.com', 'Public', 'NASDAQ', 1
);

-- ============================================
-- VERIFICATION QUERY
-- ============================================

-- Check that all 20 companies were inserted
SELECT 
    company_name,
    ticker_symbol,
    primary_sector,
    headquarters_city,
    headquarters_country
FROM companies
ORDER BY primary_sector, company_name;
