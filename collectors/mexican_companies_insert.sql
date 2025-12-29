-- Mexican Deep Tech Companies
-- Curated list of major Mexican technology companies
-- Generated: 2024-12-02

SET search_path TO vendor_governance, public;

-- ============================================
-- FINTECH & AI
-- ============================================

-- Clip (Payments & AI)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Clip', 2012, 'MEX', 'Ciudad de México',
    'AI & Machine Learning', ARRAY['fintech', 'payments', 'AI', 'mobile payments'],
    'Private', 2,
    'Ciudad de México', 'CDMX', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- Kavak (AI-powered used car marketplace)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Kavak', 2016, 'MEX', 'Ciudad de México',
    'AI & Machine Learning', ARRAY['automotive', 'AI', 'marketplace', 'e-commerce'],
    'Private', 2,
    'Ciudad de México', 'CDMX', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- Bitso (Cryptocurrency exchange)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Bitso', 2014, 'MEX', 'Ciudad de México',
    'Cybersecurity', ARRAY['cryptocurrency', 'blockchain', 'fintech', 'cybersecurity'],
    'Private', 2,
    'Ciudad de México', 'CDMX', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- Konfío (AI lending platform)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Konfío', 2014, 'MEX', 'Ciudad de México',
    'AI & Machine Learning', ARRAY['fintech', 'AI', 'lending', 'SME finance'],
    'Private', 2,
    'Ciudad de México', 'CDMX', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ============================================
-- SOFTWARE & CLOUD
-- ============================================

-- Softtek (IT Services & AI)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Softtek', 1982, 'MEX', 'Nuevo León',
    'AI & Machine Learning', ARRAY['IT services', 'software', 'AI', 'cloud computing'],
    'Private', 2,
    'Monterrey', 'Nuevo León', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- Kueski (AI credit scoring)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Kueski', 2012, 'MEX', 'Jalisco',
    'AI & Machine Learning', ARRAY['fintech', 'AI', 'credit scoring', 'digital lending'],
    'Private', 2,
    'Guadalajara', 'Jalisco', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ============================================
-- BIOTECHNOLOGY & HEALTHCARE
-- ============================================

-- Grünenthal México (Pharmaceuticals)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Grünenthal México', 1960, 'MEX', 'Ciudad de México',
    'Biotechnology', ARRAY['pharmaceuticals', 'pain management', 'biotech'],
    'Private', 2,
    'Ciudad de México', 'CDMX', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- Kitma (Medical devices & robotics)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Kitma', 2018, 'MEX', 'Ciudad de México',
    'Robotics', ARRAY['medical devices', 'robotics', 'healthtech'],
    'Private', 3,
    'Ciudad de México', 'CDMX', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ============================================
-- CLEAN ENERGY & CLIMATE TECH
-- ============================================

-- Enlight (Solar energy)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Enlight', 2013, 'MEX', 'Ciudad de México',
    'Energy & Climate', ARRAY['solar', 'renewable energy', 'clean energy'],
    'Private', 2,
    'Ciudad de México', 'CDMX', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- Solben (Solar projects)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Solben', 2012, 'MEX', 'Sonora',
    'Energy & Climate', ARRAY['solar', 'renewable energy', 'energy storage'],
    'Private', 2,
    'Hermosillo', 'Sonora', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ============================================
-- AEROSPACE & ADVANCED MANUFACTURING
-- ============================================

-- Frisa Aerospace (Advanced manufacturing)
INSERT INTO companies (
    company_name, incorporation_year, incorporation_country, incorporation_jurisdiction,
    primary_sector, technology_tags, listing_type, data_tier,
    headquarters_city, headquarters_state_province, headquarters_country
) VALUES (
    'Frisa Aerospace', 1985, 'MEX', 'Nuevo León',
    'Advanced Manufacturing', ARRAY['aerospace', 'forging', 'advanced materials'],
    'Private', 2,
    'Monterrey', 'Nuevo León', 'MEX'
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ============================================
-- VERIFICATION QUERY
-- ============================================

-- Check Mexican companies
SELECT 
    company_name,
    primary_sector,
    headquarters_city,
    headquarters_country,
    technology_tags
FROM companies
WHERE headquarters_country = 'MEX'
ORDER BY primary_sector, company_name;

-- Summary count
SELECT 
    'Mexican Deep Tech Companies' as category,
    COUNT(*) as total
FROM companies
WHERE headquarters_country = 'MEX';
