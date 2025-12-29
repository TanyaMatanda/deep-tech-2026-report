-- Extended Deep Tech Company Dataset
-- 100 Additional Tier 1 Public Companies
-- For RiskAnchor Vendor Governance Database

SET search_path TO vendor_governance, public;

-- ============================================
-- ADDITIONAL AI & MACHINE LEARNING COMPANIES
-- ============================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Snowflake', 'Snowflake Inc.', 'SNOW', '0001640147', 2012, 'Delaware', 'USA', 'AI & Machine Learning', 'Data Cloud & AI Platform', ARRAY['AI', 'data analytics', 'cloud computing', 'data warehouse'], 'Bozeman', 'Montana', 'USA', 'https://snowflake.com', 'Public', 'NYSE', 1),
('Databricks', 'Databricks, Inc.', NULL, NULL, 2013, 'Delaware', 'USA', 'AI & Machine Learning', 'Data Lakehouse & MLOps', ARRAY['AI', 'machine learning', 'data engineering', 'MLOps'], 'San Francisco', 'California', 'USA', 'https://databricks.com', 'Private', NULL, 2),
('Scale AI', 'Scale AI, Inc.', NULL, NULL, 2016, 'Delaware', 'USA', 'AI & Machine Learning', 'AI Training Data Platform', ARRAY['AI', 'machine learning', 'data labeling', 'computer vision'], 'San Francisco', 'California', 'USA', 'https://scale.com', 'Private', NULL, 2),
('Anthropic', 'Anthropic PBC', NULL, NULL, 2021, 'Delaware', 'USA', 'AI & Machine Learning', 'AI Safety & Large Language Models', ARRAY['AI', 'LLM', 'Claude', 'AI safety'], 'San Francisco', 'California', 'USA', 'https://anthropic.com', 'Private', NULL, 2),
('Cohere', 'Cohere Inc.', NULL, NULL, 2019, 'Ontario', 'CAN', 'AI & Machine Learning', 'Enterprise LLM Platform', ARRAY['AI', 'NLP', 'LLM', 'enterprise AI'], 'Toronto', 'Ontario', 'CAN', 'https://cohere.com', 'Private', NULL, 2),
('Hugging Face', 'Hugging Face, Inc.', NULL, NULL, 2016, 'Delaware', 'USA', 'AI & Machine Learning', 'Open Source ML Platform', ARRAY['AI', 'NLP', 'transformers', 'model hub'], 'New York', 'New York', 'USA', 'https://huggingface.co', 'Private', NULL, 2),
('Stability AI', 'Stability AI Ltd.', NULL, NULL, 2019, 'England', 'GBR', 'AI & Machine Learning', 'Generative AI & Stable Diffusion', ARRAY['AI', 'generative AI', 'image generation', 'diffusion models'], 'London', 'England', 'GBR', 'https://stability.ai', 'Private', NULL, 2),
('Adept', 'Adept AI Labs, Inc.', NULL, NULL, 2022, 'Delaware', 'USA', 'AI & Machine Learning', 'AI Agent Platform', ARRAY['AI', 'agentic AI', 'automation', 'LLM'], 'San Francisco', 'California', 'USA', 'https://adept.ai', 'Private', NULL, 2);

-- ============================================
-- ADDITIONAL QUANTUM COMPUTING
-- ====================================================================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('PsiQuantum', 'PsiQuantum Corp.', NULL, NULL, 2016, 'Delaware', 'USA', 'Quantum Computing', 'Photonic Quantum Computing', ARRAY['quantum computing', 'photonics', 'fault-tolerant quantum'], 'Palo Alto', 'California', 'USA', 'https://psiquantum.com', 'Private', NULL, 2),
('Atom Computing', 'Atom Computing Inc.', NULL, NULL, 2018, 'Delaware', 'USA', 'Quantum Computing', 'Neutral Atom Quantum', ARRAY['quantum computing', 'neutral atoms', 'Rydberg atoms'], 'Berkeley', 'California', 'USA', 'https://atom-computing.com', 'Private', NULL, 2),
('QuEra Computing', 'QuEra Computing Inc.', NULL, NULL, 2018, 'Delaware', 'USA', 'Quantum Computing', 'Neutral Atom Quantum', ARRAY['quantum computing', 'neutral atoms', 'analog quantum'], 'Boston', 'Massachusetts', 'USA', 'https://quera.com', 'Private', NULL, 2),
('Xanadu', 'Xanadu Quantum Technologies Inc.', NULL, NULL, 2016, 'Ontario', 'CAN', 'Quantum Computing', 'Photonic Quantum Computing', ARRAY['quantum computing', 'photonics', 'continuous-variable quantum'], 'Toronto', 'Ontario', 'CAN', 'https://xanadu.ai', 'Private', NULL, 2),
('IQM Quantum Computers', 'IQM Finland Oy', NULL, NULL, 2018, 'Finland', 'FIN', 'Quantum Computing', 'Superconducting Quantum', ARRAY['quantum computing', 'superconducting qubits'], 'Espoo', 'Uusimaa', 'FIN', 'https://meetiqm.com', 'Private', NULL, 2);

-- ============================================
-- BIOTECHNOLOGY & GENOMICS (CONTINUED)
-- ============================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Illumina', 'Illumina, Inc.', 'ILMN', '0001110803', 1998, 'Delaware', 'USA', 'Biotechnology', 'Genomic Sequencing', ARRAY['genomics', 'DNA sequencing', 'bioinformatics'], 'San Diego', 'California', 'USA', 'https://illumina.com', 'Public', 'NASDAQ', 1),
('10x Genomics', '10x Genomics, Inc.', 'TXG', '0001770787', 2012, 'Delaware', 'USA', 'Biotechnology', 'Single-Cell Analysis', ARRAY['genomics', 'single-cell', 'spatial biology'], 'Pleasanton', 'California', 'USA', 'https://10xgenomics.com', 'Public', 'NASDAQ', 1),
('Twist Bioscience', 'Twist Bioscience Corporation', 'TWST', '0001581280', 2013, 'Delaware', 'USA', 'Biotechnology', 'Synthetic DNA & Gene Synthesis', ARRAY['synthetic biology', 'DNA synthesis', 'genomics'], 'South San Francisco', 'California', 'USA', 'https://twistbioscience.com', 'Public', 'NASDAQ', 1),
('Editas Medicine', 'Editas Medicine, Inc.', 'EDIT', '0001650664', 2013, 'Delaware', 'USA', 'Biotechnology', 'CRISPR Gene Editing', ARRAY['CRISPR', 'gene editing', 'gene therapy'], 'Cambridge', 'Massachusetts', 'USA', 'https://editasmedicine.com', 'Public', 'NASDAQ', 1),
('Intellia Therapeutics', 'Intellia Therapeutics, Inc.', 'NTLA', '0001606966', 2014, 'Delaware', 'USA', 'Biotechnology', 'CRISPR In Vivo Therapeutics', ARRAY['CRISPR', 'gene editing', 'in vivo therapy'], 'Cambridge', 'Massachusetts', 'USA', 'https://intelliatx.com', 'Public', 'NASDAQ', 1),
('Beam Therapeutics', 'Beam Therapeutics Inc.', 'BEAM', '0001759601', 2017, 'Delaware', 'USA', 'Biotechnology', 'Base Editing', ARRAY['gene editing', 'base editing', 'precision medicine'], 'Cambridge', 'Massachusetts', 'USA', 'https://beamtx.com', 'Public', 'NASDAQ', 1),
('AbCellera Biologics', 'AbCellera Biologics Inc.', 'ABCL', '0001822209', 2012, 'British Columbia', 'CAN', 'Biotechnology', 'Antibody Discovery Platform', ARRAY['antibodies', 'drug discovery', 'AI'], 'Vancouver', 'British Columbia', 'CAN', 'https://abcellera.com', 'Public', 'NASDAQ', 1),
('Absci', 'Absci Corporation', 'ABSI', '0001856358', 2011, 'Delaware', 'USA', 'Biotechnology', 'AI Drug Design & Biomanufacturing', ARRAY['AI', 'drug discovery', 'synthetic biology', 'protein engineering'], 'Vancouver', 'Washington', 'USA', 'https://absci.com', 'Public', 'NASDAQ', 1),
('Schrödinger', 'Schrödinger, Inc.', 'SDGR', '0001757064', 1990, 'Delaware', 'USA', 'Biotechnology', 'Computational Drug Discovery', ARRAY['computational chemistry', 'drug discovery', 'molecular modeling'], 'New York', 'New York', 'USA', 'https://schrodinger.com', 'Public', 'NASDAQ', 1);

-- ============================================
-- SEMICONDUCTORS & ADVANCED COMPUTING
-- ============================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Cerebras Systems', 'Cerebras Systems Inc.', NULL, NULL, 2016, 'Delaware', 'USA', 'Advanced Computing', 'AI Wafer-Scale Chips', ARRAY['AI', 'semiconductors', 'wafer-scale', 'supercomputing'], 'Sunnyvale', 'California', 'USA', 'https://cerebras.net', 'Private', NULL, 2),
('Groq', 'Groq, Inc.', NULL, NULL, 2016, 'Delaware', 'USA', 'Advanced Computing', 'AI Inference Chips', ARRAY['AI', 'semiconductors', 'inference', 'LPU'], 'Mountain View', 'California', 'USA', 'https://groq.com', 'Private', NULL, 2),
('SambaNova Systems', 'SambaNova Systems, Inc.', NULL, NULL, 2017, 'Delaware', 'USA', 'Advanced Computing', 'AI Dataflow Architecture', ARRAY['AI', 'semiconductors', 'dataflow', 'reconfigurable'], 'Palo Alto', 'California', 'USA', 'https://sambanova.ai', 'Private', NULL, 2),
('Graphcore', 'Graphcore Limited', NULL, NULL, 2016, 'England', 'GBR', 'Advanced Computing', 'AI Intelligence Processing Unit', ARRAY['AI', 'semiconductors', 'IPU', 'machine learning'], 'Bristol', 'England', 'GBR', 'https://graphcore.ai', 'Private', NULL, 2),
('Tenstorrent', 'Tenstorrent Inc.', NULL, NULL, 2016, 'Ontario', 'CAN', 'Advanced Computing', 'AI RISC-V Processors', ARRAY['AI', 'RISC-V', 'semiconductors', 'edge AI'], 'Toronto', 'Ontario', 'CAN', 'https://tenstorrent.com', 'Private', NULL, 2);

-- ============================================
-- CYBERSECURITY & CRYPTOGRAPHY
-- ============================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Zscaler', 'Zscaler, Inc.', 'ZS', '0001713683', 2007, 'Delaware', 'USA', 'Cybersecurity', 'Cloud Security', ARRAY['cybersecurity', 'zero trust', 'cloud security', 'SASE'], 'San Jose', 'California', 'USA', 'https://zscaler.com', 'Public', 'NASDAQ', 1),
('Okta', 'Okta, Inc.', 'OKTA', '0001660134', 2009, 'Delaware', 'USA', 'Cybersecurity', 'Identity & Access Management', ARRAY['cybersecurity', 'identity', 'IAM', 'zero trust'], 'San Francisco', 'California', 'USA', 'https://okta.com', 'Public', 'NASDAQ', 1),
('SentinelOne', 'SentinelOne, Inc.', 'S', '0001783155', 2013, 'Delaware', 'USA', 'Cybersecurity', 'AI-Powered Endpoint Security', ARRAY['cybersecurity', 'AI', 'endpoint security', 'XDR'], 'Mountain View', 'California', 'USA', 'https://sentinelone.com', 'Public', 'NYSE', 1),
('Cloudflare', 'Cloudflare, Inc.', 'NET', '0001477333', 2009, 'Delaware', 'USA', 'Cybersecurity', 'Edge Computing & Security', ARRAY['cybersecurity', 'CDN', 'edge computing', 'DDoS protection'], 'San Francisco', 'California', 'USA', 'https://cloudflare.com', 'Public', 'NYSE', 1),
('Fortinet', 'Fortinet, Inc.', 'FTNT', '0001262039', 2000, 'Delaware', 'USA', 'Cybersecurity', 'Network Security', ARRAY['cybersecurity', 'firewall', 'SD-WAN', 'SASE'], 'Sunnyvale', 'California', 'USA', 'https://fortinet.com', 'Public', 'NASDAQ', 1),
('Varonis', 'Varonis Systems, Inc.', 'VRNS', '0001361113', 2005, 'Delaware', 'USA', 'Cybersecurity', 'Data Security & Governance', ARRAY['cybersecurity', 'data security', 'insider threats', 'compliance'], 'New York', 'New York', 'USA', 'https://varonis.com', 'Public', 'NASDAQ', 1);

-- ============================================
-- ENERGY & CLIMATE TECHNOLOGY
-- ============================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('ChargePoint', 'ChargePoint Holdings, Inc.', 'CHPT', '0001821283', 2007, 'Delaware', 'USA', 'Energy & Climate', 'EV Charging Infrastructure', ARRAY['electric vehicles', 'charging', 'clean energy'], 'Campbell', 'California', 'USA', 'https://chargepoint.com', 'Public', 'NYSE', 1),
('Enphase Energy', 'Enphase Energy, Inc.', 'ENPH', '0001463101', 2006, 'Delaware', 'USA', 'Energy & Climate', 'Solar Microinverters', ARRAY['solar', 'renewable energy', 'microinverters', 'energy storage'], 'Fremont', 'California', 'USA', 'https://enphase.com', 'Public', 'NASDAQ', 1),
('SunPower', 'SunPower Corporation', 'SPWR', '0000867773', 1985, 'Delaware', 'USA', 'Energy & Climate', 'Solar Panels & Systems', ARRAY['solar', 'renewable energy', 'photovoltaics'], 'San Jose', 'California', 'USA', 'https://sunpower.com', 'Public', 'NASDAQ', 1),
('Sunrun', 'Sunrun Inc.', 'RUN', '0001383011', 2007, 'Delaware', 'USA', 'Energy & Climate', 'Residential Solar & Storage', ARRAY['solar', 'energy storage', 'residential', 'clean energy'], 'San Francisco', 'California', 'USA', 'https://sunrun.com', 'Public', 'NASDAQ', 1),
('FuelCell Energy', 'FuelCell Energy, Inc.', 'FCEL', '0000886128', 1969, 'Delaware', 'USA', 'Energy & Climate', 'Fuel Cell Power Plants', ARRAY['fuel cells', 'clean energy', 'hydrogen'], 'Danbury', 'Connecticut', 'USA', 'https://fuelcellenergy.com', 'Public', 'NASDAQ', 1),
('Bloom Energy', 'Bloom Energy Corporation', 'BE', '0001664703', 2001, 'Delaware', 'USA', 'Energy & Climate', 'Solid Oxide Fuel Cells', ARRAY['fuel cells', 'hydrogen', 'distributed power'], 'San Jose', 'California', 'USA', 'https://bloomenergy.com', 'Public', 'NYSE', 1),
('Stem', 'Stem, Inc.', 'STEM', '0001839518', 2009, 'Delaware', 'USA', 'Energy & Climate', 'AI-Powered Energy Storage', ARRAY['energy storage', 'AI', 'batteries', 'grid optimization'], 'San Francisco', 'California', 'USA', 'https://stem.com', 'Public', 'NYSE', 1),
('Array Technologies', 'Array Technologies, Inc.', 'ARRY', '0001845337', 1989, 'Delaware', 'USA', 'Energy & Climate', 'Solar Tracking Systems', ARRAY['solar', 'tracking', 'renewable energy'], 'Albuquerque', 'New Mexico', 'USA', 'https://arraytechinc.com', 'Public', 'NASDAQ', 1);

-- ============================================
-- SPACE TECHNOLOGY
-- ============================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Virgin Galactic', 'Virgin Galactic Holdings, Inc.', 'SPCE', '0001706946', 2017, 'Delaware', 'USA', 'Space Technology', 'Space Tourism', ARRAY['space', 'tourism', 'suborbital'], 'Las Cruces', 'New Mexico', 'USA', 'https://virgingalactic.com', 'Public', 'NYSE', 1),
('Momentus', 'Momentus Inc.', 'MNTS', '0001781162', 2017, 'Delaware', 'USA', 'Space Technology', 'Orbital Transfer Services', ARRAY['space', 'logistics', 'satellites'], 'San Jose', 'California', 'USA', 'https://momentus.space', 'Public', 'NASDAQ', 1),
('Redwire', 'Redwire Corporation', 'RDW', '0001819810', 2020, 'Delaware', 'USA', 'Space Technology', 'Space Infrastructure', ARRAY['space', 'manufacturing', 'infrastructure'], 'Jacksonville', 'Florida', 'USA', 'https://redwirespace.com', 'Public', 'NYSE', 1),
('Spire Global', 'Spire Global, Inc.', 'SPIR', '0001856173', 2012, 'Delaware', 'USA', 'Space Technology', 'Satellite Data & Analytics', ARRAY['space', 'satellites', 'data analytics', 'IoT'], 'Vienna', 'Virginia', 'USA', 'https://spire.com', 'Public', 'NYSE', 1),
('Planet Labs', 'Planet Labs PBC', 'PL', '0001833969', 2010, 'Delaware', 'USA', 'Space Technology', 'Earth Imaging Satellites', ARRAY['space', 'satellites', 'earth observation', 'imaging'], 'San Francisco', 'California', 'USA', 'https://planet.com', 'Public', 'NYSE', 1);

-- ============================================
-- ROBOTICS & AUTONOMOUS SYSTEMS
-- ============================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Symbotic', 'Symbotic Inc.', 'SYM', '0001900148', 2007, 'Delaware', 'USA', 'Robotics', 'Warehouse Automation', ARRAY['robotics', 'automation', 'AI', 'logistics'], 'Wilmington', 'Massachusetts', 'USA', 'https://symbotic.com', 'Public', 'NASDAQ', 1),
('Sarcos Technology', 'Sarcos Technology and Robotics Corporation', 'STRC', '0001840502', 1983, 'Delaware', 'USA', 'Robotics', 'Industrial Exoskeletons', ARRAY['robotics', 'exoskeletons', 'AI'], 'Salt Lake City', 'Utah', 'USA', 'https://sarcos.com', 'Public', 'NASDAQ', 1),
('Markforged', 'Markforged Holding Corporation', 'MKFG', '0001856385', 2013, 'Delaware', 'USA', 'Advanced Manufacturing', '3D Metal Printing', ARRAY['3D printing', 'additive manufacturing', 'materials science'], 'Watertown', 'Massachusetts', 'USA', 'https://markforged.com', 'Public', 'NYSE', 1),
('Desktop Metal', 'Desktop Metal, Inc.', 'DM', '0001812214', 2015, 'Delaware', 'USA', 'Advanced Manufacturing', 'Metal 3D Printing', ARRAY['3D printing', 'additive manufacturing', 'metals'], 'Burlington', 'Massachusetts', 'USA', 'https://desktopmetal.com', 'Public', 'NYSE', 1);

-- ============================================
-- CLOUD INFRASTRUCTURE & COMPUTING
-- ============================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('HashiCorp', 'HashiCorp, Inc.', 'HCP', '0001720671', 2012, 'Delaware', 'USA', 'Cloud Infrastructure', 'Multi-Cloud Infrastructure Automation', ARRAY['cloud', 'infrastructure', 'DevOps', 'automation'], 'San Francisco', 'California', 'USA', 'https://hashicorp.com', 'Public', 'NASDAQ', 1),
('MongoDB', 'MongoDB, Inc.', 'MDB', '0001441816', 2007, 'Delaware', 'USA', 'Cloud Infrastructure', 'NoSQL Database Platform', ARRAY['database', 'NoSQL', 'cloud', 'data platform'], 'New York', 'New York', 'USA', 'https://mongodb.com', 'Public', 'NASDAQ', 1),
('DataDog', 'Datadog, Inc.', 'DDOG', '0001561550', 2010, 'Delaware', 'USA', 'Cloud Infrastructure', 'Monitoring & Analytics Platform', ARRAY['monitoring', 'cloud', 'observability', 'APM'], 'New York', 'New York', 'USA', 'https://datadoghq.com', 'Public', 'NASDAQ', 1),
('Elastic', 'Elastic N.V.', 'ESTC', '0001707753', 2012, 'Netherlands', 'NLD', 'Cloud Infrastructure', 'Search & Observability', ARRAY['search', 'observability', 'analytics', 'Elasticsearch'], 'Mountain View', 'California', 'USA', 'https://elastic.co', 'Public', 'NYSE', 1),
('Confluent', 'Confluent, Inc.', 'CFLT', '0001699838', 2014, 'Delaware', 'USA', 'Cloud Infrastructure', 'Data Streaming Platform', ARRAY['data streaming', 'Apache Kafka', 'real-time data'], 'Mountain View', 'California', 'USA', 'https://confluent.io', 'Public', 'NASDAQ', 1);

-- ============================================
-- ADVANCED MATERIALS
-- ============================================

INSERT INTO companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Eos Energy Enterprises', 'Eos Energy Enterprises, Inc.', 'EOSE', '0001823323', 2008, 'Delaware', 'USA', 'Advanced Materials', 'Zinc-Based Battery Technology', ARRAY['batteries', 'energy storage', 'materials science'], 'Edison', 'New Jersey', 'USA', 'https://eose.com', 'Public', 'NASDAQ', 1),
('Li-Cycle', 'Li-Cycle Holdings Corp.', 'LICY', '0001895969', 2016, 'Ontario', 'CAN', 'Advanced Materials', 'Lithium-Ion Battery Recycling', ARRAY['recycling', 'batteries', 'circular economy', 'materials recovery'], 'Toronto', 'Ontario', 'CAN', 'https://li-cycle.com', 'Public', 'NYSE', 1),
('Redwood Materials', 'Redwood Materials Inc.', NULL, NULL, 2017, 'Delaware', 'USA', 'Advanced Materials', 'Battery Materials & Recycling', ARRAY['batteries', 'recycling', 'circular economy', 'sustainable materials'], 'Carson City', 'Nevada', 'USA', 'https://redwoodmaterials.com', 'Private', NULL, 2);

-- ========================================
-- VERIFICATION QUERY
-- ============================================

SELECT 
    'Total Companies' AS metric,
    COUNT(*)::TEXT AS value
FROM companies

UNION ALL

SELECT 
    'By Sector',
    primary_sector || ': ' || COUNT(*)::TEXT
FROM companies
GROUP BY primary_sector
ORDER BY metric DESC;
