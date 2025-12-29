-- TSX/TSX-V Canadian Deep Tech Companies
-- Total companies: 54
-- Generated: 2025-12-13 13:07:36.884515

SET search_path TO vendor_governance, public;

-- Coveo Solutions Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Coveo Solutions Inc.', 'CVO', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Kinaxis Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Kinaxis Inc.', 'KXS', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- OpenText Corporation
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'OpenText Corporation', 'OTEX', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Constellation Software Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Constellation Software Inc.', 'CSU', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Lightspeed Commerce Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Lightspeed Commerce Inc.', 'LSPD', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Topicus.com Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Topicus.com Inc.', 'TOI', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Descartes Systems Group
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Descartes Systems Group', 'DSG', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Docebo Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Docebo Inc.', 'DCBO', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- BlackBerry Limited
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'BlackBerry Limited', 'BB', 'CAN', 'Ontario',
    'Cybersecurity', 'Public', 'TSX/NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Shopify Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Shopify Inc.', 'SHOP', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- D-Wave Quantum Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'D-Wave Quantum Inc.', 'QBTS', 'CAN', 'Ontario',
    'Quantum Computing', 'Public', 'NYSE (Canadian HQ)', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Xanadu Quantum Technologies
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Xanadu Quantum Technologies', NULL, 'CAN', 'Ontario',
    'Quantum Computing', 'Private', NULL, 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- 01 Quantum Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    '01 Quantum Inc.', 'ONE', 'CAN', 'Ontario',
    'Quantum Computing', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- BTQ Technologies
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'BTQ Technologies', 'BTQ', 'CAN', 'Ontario',
    'Quantum Computing', 'Public', 'NEO', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- TenX Protocols Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'TenX Protocols Inc.', 'TNX', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Kraken Robotics Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Kraken Robotics Inc.', 'PNG', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Sierra Wireless
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Sierra Wireless', 'SW', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX (Acquired)', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Celestica Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Celestica Inc.', 'CLS', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Enablence Technologies Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Enablence Technologies Inc.', 'ENA', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- AbCellera Biologics Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'AbCellera Biologics Inc.', 'ABCL', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'NASDAQ (Canadian)', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Arbutus Biopharma Corporation
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Arbutus Biopharma Corporation', 'ABUS', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Aurinia Pharmaceuticals Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Aurinia Pharmaceuticals Inc.', 'AUPH', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Zymeworks Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Zymeworks Inc.', 'ZYME', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Bellus Health Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Bellus Health Inc.', 'BLU', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Fusion Pharmaceuticals
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Fusion Pharmaceuticals', 'FUSN', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Repare Therapeutics
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Repare Therapeutics', 'RPTX', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Chinook Therapeutics
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Chinook Therapeutics', 'KDNY', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Canadian Solar Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Canadian Solar Inc.', 'CSIQ', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Ballard Power Systems
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Ballard Power Systems', 'BLDP', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Li-Cycle Holdings Corp.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Li-Cycle Holdings Corp.', 'LICY', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Nano One Materials Corp.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Nano One Materials Corp.', 'NANO', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- PyroGenesis Canada Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'PyroGenesis Canada Inc.', 'PYR', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Thermal Energy International
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Thermal Energy International', 'TMG', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Abound Energy Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Abound Energy Inc.', 'ABND', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'CSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Cybeats Technologies Corp.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Cybeats Technologies Corp.', 'CYBT', 'CAN', 'Ontario',
    'Cybersecurity', 'Public', 'CSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Draganfly Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Draganfly Inc.', 'DPRO', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'CSE/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- VersaBank
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'VersaBank', 'VBNK', 'CAN', 'Ontario',
    'Cybersecurity', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Magnet Forensics
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Magnet Forensics', 'MAGT', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX (Acquired)', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Evertz Technologies
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Evertz Technologies', 'ET', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Hut 8 Mining Corp
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Hut 8 Mining Corp', 'HUT', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Bitfarms Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Bitfarms Ltd.', 'BITF', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Hive Digital Technologies
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Hive Digital Technologies', 'HIVE', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX-V/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- DMG Blockchain Solutions
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'DMG Blockchain Solutions', 'DMGI', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Poet Technologies
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Poet Technologies', 'PTK', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Quisitive Technology Solutions
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Quisitive Technology Solutions', 'QUIS', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Boardwalktech Software
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Boardwalktech Software', 'BWLK', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Nubeva Technologies
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Nubeva Technologies', 'NBVA', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- SSC Security Services
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'SSC Security Services', 'SECU', 'CAN', 'Ontario',
    'Cybersecurity', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- EQ Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'EQ Inc.', 'EQ', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- ARway Corp.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'ARway Corp.', 'ARWY', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'CSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- NextGen Digital
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'NextGen Digital', 'NX', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'CSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Generative AI Solutions
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Generative AI Solutions', 'AICO', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'CSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Rocket Doctor AI
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Rocket Doctor AI', 'DOCT', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'CSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Verses AI Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Verses AI Inc.', 'VERS', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'NEO', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

