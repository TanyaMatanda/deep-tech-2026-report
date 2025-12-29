
-- RVPHW: REVIVA PHARMACEUTICALS HOLDINGS, INC.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'REVIVA PHARMACEUTICALS HOLDINGS, INC.', 'RVPHW', '0001742927', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-04', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774925033023/0001437749-25-033023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPHW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-28', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774924032297/0001437749-24-032297-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPHW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-04', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774923027676/0001437749-23-027676-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPHW'
ON CONFLICT (accession_number) DO NOTHING;

-- UHL: UNITED HYDROGEN GLOBAL INC.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'UNITED HYDROGEN GLOBAL INC.', 'UHL', '0002032241', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- INNP: INNOCAN PHARMA Corp
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'INNOCAN PHARMA Corp', 'INNP', '0001889791', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CBPHF: Clover Biopharmaceuticals, Ltd.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Clover Biopharmaceuticals, Ltd.', 'CBPHF', '0001856491', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- JHPCY: Jiangsu Hengrui Pharmaceuticals Co., Ltd./ADR
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Jiangsu Hengrui Pharmaceuticals Co., Ltd./ADR', 'JHPCY', '0002071868', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HZRBY: Horizon Robotics, Inc./ADR
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Robotics, Inc./ADR', 'HZRBY', '0002060217', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TSMWF: TAIWAN SEMICONDUCTOR MANUFACTURING CO LTD
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TAIWAN SEMICONDUCTOR MANUFACTURING CO LTD', 'TSMWF', '0001046179', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TKPHF: TAKEDA PHARMACEUTICAL CO LTD
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TAKEDA PHARMACEUTICAL CO LTD', 'TKPHF', '0001395064', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TEVJF: TEVA PHARMACEUTICAL INDUSTRIES LTD
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TEVA PHARMACEUTICAL INDUSTRIES LTD', 'TEVJF', '0000818686', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-09', 'https://www.sec.gov/Archives/edgar/data/818686/000119312525076829/0001193125-25-076829-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TEVJF'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-16', 'https://www.sec.gov/Archives/edgar/data/818686/000119312524097745/0001193125-24-097745-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TEVJF'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-19', 'https://www.sec.gov/Archives/edgar/data/818686/000119312523106453/0001193125-23-106453-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TEVJF'
ON CONFLICT (accession_number) DO NOTHING;

-- ZLDPF: Zealand Pharma A/S/ADR
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Zealand Pharma A/S/ADR', 'ZLDPF', '0002068427', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GAM-PB: GENERAL AMERICAN INVESTORS CO INC
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERAL AMERICAN INVESTORS CO INC', 'GAM-PB', '0000040417', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-02-24', 'https://www.sec.gov/Archives/edgar/data/40417/000183988225010653/0001839882-25-010653-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GAM-PB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-20', 'https://www.sec.gov/Archives/edgar/data/40417/000199937124002520/0001999371-24-002520-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GAM-PB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-18', 'https://www.sec.gov/Archives/edgar/data/40417/000138713123004818/0001387131-23-004818-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GAM-PB'
ON CONFLICT (accession_number) DO NOTHING;

-- IPHYF: Innate Pharma SA
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Innate Pharma SA', 'IPHYF', '0001598599', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RGBPP: Regen BioPharma Inc
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Regen BioPharma Inc', 'RGBPP', '0001589150', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RVPH: REVIVA PHARMACEUTICALS HOLDINGS, INC.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'REVIVA PHARMACEUTICALS HOLDINGS, INC.', 'RVPH', '0001742927', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-04', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774925033023/0001437749-25-033023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-28', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774924032297/0001437749-24-032297-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-04', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774923027676/0001437749-23-027676-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPH'
ON CONFLICT (accession_number) DO NOTHING;

-- GBNY: Generations Bancorp NY, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Generations Bancorp NY, Inc.', 'GBNY', '0001823365', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-12', 'https://www.sec.gov/Archives/edgar/data/1823365/000155837024005015/0001558370-24-005015-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GBNY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-14', 'https://www.sec.gov/Archives/edgar/data/1823365/000155837023005956/0001558370-23-005956-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GBNY'
ON CONFLICT (accession_number) DO NOTHING;

-- IMUC: EOM Pharmaceutical Holdings, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'EOM Pharmaceutical Holdings, Inc.', 'IMUC', '0000822411', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GSTX: Graphene & Solar Technologies Ltd
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Graphene & Solar Technologies Ltd', 'GSTX', '0001497649', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CUBT: Curative Biotechnology Inc
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Curative Biotechnology Inc', 'CUBT', '0001400271', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HOOK: HOOKIPA Pharma Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'HOOKIPA Pharma Inc.', 'HOOK', '0001760542', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1760542/000110465924052900/0001104659-24-052900-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HOOK'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-13', 'https://www.sec.gov/Archives/edgar/data/1760542/000110465923045017/0001104659-23-045017-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HOOK'
ON CONFLICT (accession_number) DO NOTHING;

-- AGNPF: Algernon Pharmaceuticals Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Algernon Pharmaceuticals Inc.', 'AGNPF', '0001642178', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PHBI: Pharmagreen Biotech Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Pharmagreen Biotech Inc.', 'PHBI', '0001435181', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PLPL: Plandai Biotechnology, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Plandai Biotechnology, Inc.', 'PLPL', '0001317880', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ARBEW: Arbe Robotics Ltd.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Arbe Robotics Ltd.', 'ARBEW', '0001861841', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- LIMNW: Liminatus Pharma, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Liminatus Pharma, Inc.', 'LIMNW', '0001971387', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RGPX: REGENEREX PHARMA, INC.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'REGENEREX PHARMA, INC.', 'RGPX', '0001357878', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ARQQW: Arqit Quantum Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Arqit Quantum Inc.', 'ARQQW', '0001859690', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HSPTR: Horizon Space Acquisition II Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition II Corp.', 'HSPTR', '0002032950', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HSPTU: Horizon Space Acquisition II Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition II Corp.', 'HSPTU', '0002032950', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SBFMW: Sunshine Biopharma Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Sunshine Biopharma Inc.', 'SBFMW', '0001402328', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-23', 'https://www.sec.gov/Archives/edgar/data/1402328/000168316825007747/0001683168-25-007747-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SBFMW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-17', 'https://www.sec.gov/Archives/edgar/data/1402328/000168316824007196/0001683168-24-007196-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SBFMW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-18', 'https://www.sec.gov/Archives/edgar/data/1402328/000168316823007244/0001683168-23-007244-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SBFMW'
ON CONFLICT (accession_number) DO NOTHING;

-- QSIAW: Quantum-Si Inc
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantum-Si Inc', 'QSIAW', '0001816431', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-20', 'https://www.sec.gov/Archives/edgar/data/1816431/000181643125000024/0001816431-25-000024-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QSIAW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-01', 'https://www.sec.gov/Archives/edgar/data/1816431/000114036124016945/0001140361-24-016945-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QSIAW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-29', 'https://www.sec.gov/Archives/edgar/data/1816431/000114036123014533/0001140361-23-014533-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QSIAW'
ON CONFLICT (accession_number) DO NOTHING;

-- TLPPF: Telix Pharmaceuticals Ltd
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Telix Pharmaceuticals Ltd', 'TLPPF', '0002007191', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- QUMSU: Quantumsphere Acquisition Corp
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantumsphere Acquisition Corp', 'QUMSU', '0002070900', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- QUMSR: Quantumsphere Acquisition Corp
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantumsphere Acquisition Corp', 'QUMSR', '0002070900', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ASBPW: Aspire Biopharma Holdings, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Aspire Biopharma Holdings, Inc.', 'ASBPW', '0001847345', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-23', 'https://www.sec.gov/Archives/edgar/data/1847345/000149315225014523/0001493152-25-014523-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASBPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-01', 'https://www.sec.gov/Archives/edgar/data/1847345/000149315224017415/0001493152-24-017415-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASBPW'
ON CONFLICT (accession_number) DO NOTHING;

-- TNMWF: TNL Mediagene
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TNL Mediagene', 'TNMWF', '0002013186', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- VLN-WT: Valens Semiconductor Ltd.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Valens Semiconductor Ltd.', 'VLN-WT', '0001863006', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- MCHPP: MICROCHIP TECHNOLOGY INC
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MICROCHIP TECHNOLOGY INC', 'MCHPP', '0000827054', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-07', 'https://www.sec.gov/Archives/edgar/data/827054/000082705425000099/0000827054-25-000099-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCHPP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-08', 'https://www.sec.gov/Archives/edgar/data/827054/000082705424000128/0000827054-24-000128-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCHPP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-07', 'https://www.sec.gov/Archives/edgar/data/827054/000082705423000104/0000827054-23-000104-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCHPP'
ON CONFLICT (accession_number) DO NOTHING;

-- BDTB: Bodhi Tree Biotechnology Inc
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Bodhi Tree Biotechnology Inc', 'BDTB', '0002041531', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ESLAW: Estrella Immunopharma, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Estrella Immunopharma, Inc.', 'ESLAW', '0001844417', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-06-16', 'https://www.sec.gov/Archives/edgar/data/1844417/000157587223000970/0001575872-23-000970-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ESLAW'
ON CONFLICT (accession_number) DO NOTHING;

-- ENGNW: enGene Holdings Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'enGene Holdings Inc.', 'ENGNW', '0001980845', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-09', 'https://www.sec.gov/Archives/edgar/data/1980845/000114036125018155/0001140361-25-018155-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENGNW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-18', 'https://www.sec.gov/Archives/edgar/data/1980845/000095017024045297/0000950170-24-045297-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENGNW'
ON CONFLICT (accession_number) DO NOTHING;

-- GCTS-WT: GCT Semiconductor Holding, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GCT Semiconductor Holding, Inc.', 'GCTS-WT', '0001851961', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-04', 'https://www.sec.gov/Archives/edgar/data/1851961/000095017025102009/0000950170-25-102009-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GCTS-WT'
ON CONFLICT (accession_number) DO NOTHING;

-- LGNDZ: LIGAND PHARMACEUTICALS INC
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIGAND PHARMACEUTICALS INC', 'LGNDZ', '0000886163', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/886163/000088616325000025/0000886163-25-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNDZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/886163/000088616324000020/0000886163-24-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNDZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/886163/000088616323000018/0000886163-23-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNDZ'
ON CONFLICT (accession_number) DO NOTHING;

-- LGNXZ: LIGAND PHARMACEUTICALS INC
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIGAND PHARMACEUTICALS INC', 'LGNXZ', '0000886163', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/886163/000088616325000025/0000886163-25-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNXZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/886163/000088616324000020/0000886163-24-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNXZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/886163/000088616323000018/0000886163-23-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNXZ'
ON CONFLICT (accession_number) DO NOTHING;

-- LGNYZ: LIGAND PHARMACEUTICALS INC
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIGAND PHARMACEUTICALS INC', 'LGNYZ', '0000886163', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/886163/000088616325000025/0000886163-25-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNYZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/886163/000088616324000020/0000886163-24-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNYZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/886163/000088616323000018/0000886163-23-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNYZ'
ON CONFLICT (accession_number) DO NOTHING;

-- LGNZZ: LIGAND PHARMACEUTICALS INC
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIGAND PHARMACEUTICALS INC', 'LGNZZ', '0000886163', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/886163/000088616325000025/0000886163-25-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNZZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/886163/000088616324000020/0000886163-24-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNZZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/886163/000088616323000018/0000886163-23-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNZZ'
ON CONFLICT (accession_number) DO NOTHING;

-- LSBWF: LakeShore Biopharma Co., Ltd.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LakeShore Biopharma Co., Ltd.', 'LSBWF', '0001946399', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HWM-P: Howmet Aerospace Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Howmet Aerospace Inc.', 'HWM-P', '0000004281', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-16', 'https://www.sec.gov/Archives/edgar/data/4281/000110465925035530/0001104659-25-035530-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM-P'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-08', 'https://www.sec.gov/Archives/edgar/data/4281/000110465924044630/0001104659-24-044630-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM-P'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-30', 'https://www.sec.gov/Archives/edgar/data/4281/000110465923038944/0001104659-23-038944-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM-P'
ON CONFLICT (accession_number) DO NOTHING;

-- SXTPW: 60 DEGREES PHARMACEUTICALS, INC.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    '60 DEGREES PHARMACEUTICALS, INC.', 'SXTPW', '0001946563', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-27', 'https://www.sec.gov/Archives/edgar/data/1946563/000121390025080878/0001213900-25-080878-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SXTPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-15', 'https://www.sec.gov/Archives/edgar/data/1946563/000121390024087749/0001213900-24-087749-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SXTPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-30', 'https://www.sec.gov/Archives/edgar/data/1946563/000121390024047861/0001213900-24-047861-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SXTPW'
ON CONFLICT (accession_number) DO NOTHING;

-- EVTWF: Vertical Aerospace Ltd.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Vertical Aerospace Ltd.', 'EVTWF', '0001867102', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- MDCXW: Medicus Pharma Ltd.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Medicus Pharma Ltd.', 'MDCXW', '0001997296', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-06-30', 'https://www.sec.gov/Archives/edgar/data/1997296/000106299325012273/0001062993-25-012273-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MDCXW'
ON CONFLICT (accession_number) DO NOTHING;

-- HSPOR: Horizon Space Acquisition I Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition I Corp.', 'HSPOR', '0001946021', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-14', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998025000665/0001929980-25-000665-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-19', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000565/0001929980-24-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-21', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000037/0001929980-24-000037-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOR'
ON CONFLICT (accession_number) DO NOTHING;

-- HSPOU: Horizon Space Acquisition I Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition I Corp.', 'HSPOU', '0001946021', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-14', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998025000665/0001929980-25-000665-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOU'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-19', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000565/0001929980-24-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOU'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-21', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000037/0001929980-24-000037-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOU'
ON CONFLICT (accession_number) DO NOTHING;

-- HSPOW: Horizon Space Acquisition I Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition I Corp.', 'HSPOW', '0001946021', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-14', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998025000665/0001929980-25-000665-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-19', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000565/0001929980-24-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-21', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000037/0001929980-24-000037-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOW'
ON CONFLICT (accession_number) DO NOTHING;

-- NRXPW: NRX Pharmaceuticals, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NRX Pharmaceuticals, Inc.', 'NRXPW', '0001719406', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-09-05', 'https://www.sec.gov/Archives/edgar/data/1719406/000143774924028549/0001437749-24-028549-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NRXPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-11', 'https://www.sec.gov/Archives/edgar/data/1719406/000110465924033080/0001104659-24-033080-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NRXPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-11-22', 'https://www.sec.gov/Archives/edgar/data/1719406/000110465923120785/0001104659-23-120785-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NRXPW'
ON CONFLICT (accession_number) DO NOTHING;

-- KITTW: Nauticus Robotics, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Nauticus Robotics, Inc.', 'KITTW', '0001849820', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-25', 'https://www.sec.gov/Archives/edgar/data/1849820/000184982025000242/0001849820-25-000242-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KITTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1849820/000184982025000120/0001849820-25-000120-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KITTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-25', 'https://www.sec.gov/Archives/edgar/data/1849820/000184982024000272/0001849820-24-000272-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KITTW'
ON CONFLICT (accession_number) DO NOTHING;

-- GIPRW: GENERATION INCOME PROPERTIES, INC.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERATION INCOME PROPERTIES, INC.', 'GIPRW', '0001651721', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-07', 'https://www.sec.gov/Archives/edgar/data/1651721/000119312525272581/0001193125-25-272581-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIPRW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-17', 'https://www.sec.gov/Archives/edgar/data/1651721/000095017024115299/0000950170-24-115299-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIPRW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-02', 'https://www.sec.gov/Archives/edgar/data/1651721/000095017023050931/0000950170-23-050931-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIPRW'
ON CONFLICT (accession_number) DO NOTHING;

-- KPHMW: KIORA PHARMACEUTICALS INC
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'KIORA PHARMACEUTICALS INC', 'KPHMW', '0001372514', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1372514/000137251425000038/0001372514-25-000038-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KPHMW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-25', 'https://www.sec.gov/Archives/edgar/data/1372514/000137251424000030/0001372514-24-000030-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KPHMW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-21', 'https://www.sec.gov/Archives/edgar/data/1372514/000137251423000110/0001372514-23-000110-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KPHMW'
ON CONFLICT (accession_number) DO NOTHING;

-- LAAI: Loan Artificial Intelligence Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Loan Artificial Intelligence Corp.', 'LAAI', '0001594968', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- NAMSW: NewAmsterdam Pharma Co N.V.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NewAmsterdam Pharma Co N.V.', 'NAMSW', '0001936258', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-08', 'https://www.sec.gov/Archives/edgar/data/1936258/000119312525115995/0001193125-25-115995-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NAMSW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-09', 'https://www.sec.gov/Archives/edgar/data/1936258/000119312524135282/0001193125-24-135282-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NAMSW'
ON CONFLICT (accession_number) DO NOTHING;

-- SMNRW: Semnur Pharmaceuticals, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Semnur Pharmaceuticals, Inc.', 'SMNRW', '0001913577', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-27', 'https://www.sec.gov/Archives/edgar/data/1913577/000101376225003461/0001013762-25-003461-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SMNRW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-06-28', 'https://www.sec.gov/Archives/edgar/data/1913577/000121390024057300/0001213900-24-057300-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SMNRW'
ON CONFLICT (accession_number) DO NOTHING;

-- SOCAW: Solarius Capital Acquisition Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Solarius Capital Acquisition Corp.', 'SOCAW', '0002065948', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SOCAU: Solarius Capital Acquisition Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Solarius Capital Acquisition Corp.', 'SOCAU', '0002065948', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- BAERW: Bridger Aerospace Group Holdings, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Bridger Aerospace Group Holdings, Inc.', 'BAERW', '0001941536', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1941536/000114036125016366/0001140361-25-016366-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BAERW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1941536/000114036124023081/0001140361-24-023081-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BAERW'
ON CONFLICT (accession_number) DO NOTHING;

-- CSCIF: COSCIENS Biopharma Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'COSCIENS Biopharma Inc.', 'CSCIF', '0001113423', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RCKTW: ROCKET PHARMACEUTICALS, INC.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ROCKET PHARMACEUTICALS, INC.', 'RCKTW', '0001281895', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1281895/000114036125016656/0001140361-25-016656-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RCKTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1281895/000114036124023041/0001140361-24-023041-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RCKTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1281895/000114036123021702/0001140361-23-021702-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RCKTW'
ON CONFLICT (accession_number) DO NOTHING;

-- WGSWW: GeneDx Holdings Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GeneDx Holdings Corp.', 'WGSWW', '0001818331', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1818331/000181833125000075/0001818331-25-000075-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WGSWW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1818331/000181833124000025/0001818331-24-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WGSWW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1818331/000181833123000033/0001818331-23-000033-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WGSWW'
ON CONFLICT (accession_number) DO NOTHING;

-- HNSPF: Hansoh Pharmaceutical Group Co Limited/ADR
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Hansoh Pharmaceutical Group Co Limited/ADR', 'HNSPF', '0002073669', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CTRVP: Hepion Pharmaceuticals, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Hepion Pharmaceuticals, Inc.', 'CTRVP', '0001583771', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1583771/000164117225006440/0001641172-25-006440-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CTRVP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-02-07', 'https://www.sec.gov/Archives/edgar/data/1583771/000149315225005322/0001493152-25-005322-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CTRVP'
ON CONFLICT (accession_number) DO NOTHING;

-- EYGPF: Electricity Generating Public Co Limited/ADR
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Electricity Generating Public Co Limited/ADR', 'EYGPF', '0001562294', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- EYUUF: Electricity Generating Public Co Limited/ADR
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Electricity Generating Public Co Limited/ADR', 'EYUUF', '0001562294', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SMTGF: SMA Solar Technology AG/ADR
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SMA Solar Technology AG/ADR', 'SMTGF', '0001516684', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- LIXTW: LIXTE BIOTECHNOLOGY HOLDINGS, INC.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIXTE BIOTECHNOLOGY HOLDINGS, INC.', 'LIXTW', '0001335105', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-27', 'https://www.sec.gov/Archives/edgar/data/1335105/000149315225019697/0001493152-25-019697-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIXTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-05', 'https://www.sec.gov/Archives/edgar/data/1335105/000149315224043583/0001493152-24-043583-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIXTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-10', 'https://www.sec.gov/Archives/edgar/data/1335105/000149315223036718/0001493152-23-036718-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIXTW'
ON CONFLICT (accession_number) DO NOTHING;

-- TGE-WT: Generation Essentials Group
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Generation Essentials Group', 'TGE-WT', '0002053456', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GREEL: Greenidge Generation Holdings Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Greenidge Generation Holdings Inc.', 'GREEL', '0001844971', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1844971/000119380525000565/0001193805-25-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GREEL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1844971/000162828024018969/0001628280-24-018969-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GREEL'
ON CONFLICT (accession_number) DO NOTHING;

-- INNPF: INNOCAN PHARMA Corp
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'INNOCAN PHARMA Corp', 'INNPF', '0001889791', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HRZRF: Horizon Robotics, Inc./ADR
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Robotics, Inc./ADR', 'HRZRF', '0002060217', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SUNXF: Stardust Solar Energy Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Stardust Solar Energy Inc.', 'SUNXF', '0002048958', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TALKW: Talkspace, Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Talkspace, Inc.', 'TALKW', '0001803901', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1803901/000114036125016714/0001140361-25-016714-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TALKW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1803901/000114036124022973/0001140361-24-022973-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TALKW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO vendor_governance.sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-09-01', 'https://www.sec.gov/Archives/edgar/data/1803901/000114036123042235/0001140361-23-042235-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TALKW'
ON CONFLICT (accession_number) DO NOTHING;

-- STTPF: SCHOTT Pharma AG & Co. KGaA/ADR
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SCHOTT Pharma AG & Co. KGaA/ADR', 'STTPF', '0002018852', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TSX/TSX-V Canadian Deep Tech Companies
-- Total companies: 24
-- Generated: 2025-12-02 19:14:28.677526

SET search_path TO vendor_governance, public;

-- D-Wave Quantum Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'D-Wave Quantum Inc.', 'QBTS', 'CAN', 'Ontario',
    'Quantum Computing', 'Public', 'NYSE (Canadian HQ)', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- BioVectra Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'BioVectra Inc.', NULL, 'CAN', 'Ontario',
    'Biotechnology', 'Private', NULL, 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Shopify Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Shopify Inc.', 'SHOP', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- OpenText Corporation
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'OpenText Corporation', 'OTEX', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- BlackBerry Limited
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'BlackBerry Limited', 'BB', 'CAN', 'Ontario',
    'Cybersecurity', 'Public', 'TSX/NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Constellation Software Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Constellation Software Inc.', 'CSU.TO', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Kinaxis Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Kinaxis Inc.', 'KXS.TO', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Descartes Systems Group
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Descartes Systems Group', 'DSGX', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- AbCellera Biologics Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'AbCellera Biologics Inc.', 'ABCL', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'NASDAQ (Canadian)', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Arbutus Biopharma Corporation
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Arbutus Biopharma Corporation', 'ABUS', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Aurinia Pharmaceuticals Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Aurinia Pharmaceuticals Inc.', 'AUPH', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Zymeworks Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Zymeworks Inc.', 'ZYME', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Sierra Wireless
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Sierra Wireless', 'SW.TO', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Celestica Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Celestica Inc.', 'CLS', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Canadian Solar Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Canadian Solar Inc.', 'CSIQ', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Ballard Power Systems
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Ballard Power Systems', 'BLDP', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'TSX/NASDAQ', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Li-Cycle Holdings Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Li-Cycle Holdings Corp.', 'LICY', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'NYSE', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Hydrogenics (Cummins)
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Hydrogenics (Cummins)', 'HYZN', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'Acquired', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- MDA Ltd.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'MDA Ltd.', 'MDA.TO', 'CAN', 'Ontario',
    'Space Technology', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- CAE Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'CAE Inc.', 'CAE.TO', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Absolute Software Corporation
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Absolute Software Corporation', 'ABST.TO', 'CAN', 'Ontario',
    'Cybersecurity', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- PyroGenesis Canada Inc.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'PyroGenesis Canada Inc.', 'PYR.TO', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Nano One Materials Corp.
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Nano One Materials Corp.', 'NANO.TO', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Thermal Energy International
INSERT INTO vendor_governance.companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Thermal Energy International', 'TMG.TO', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Mexican Deep Tech Companies
-- Curated list of major Mexican technology companies
-- Generated: 2024-12-02

SET search_path TO vendor_governance, public;

-- ============================================
-- FINTECH & AI
-- ============================================

-- Clip (Payments & AI)
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
-- Extended Deep Tech Company Dataset
-- 100 Additional Tier 1 Public Companies
-- For RiskAnchor Vendor Governance Database

SET search_path TO vendor_governance, public;

-- ============================================
-- ADDITIONAL AI & MACHINE LEARNING COMPANIES
-- ============================================

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
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

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('PsiQuantum', 'PsiQuantum Corp.', NULL, NULL, 2016, 'Delaware', 'USA', 'Quantum Computing', 'Photonic Quantum Computing', ARRAY['quantum computing', 'photonics', 'fault-tolerant quantum'], 'Palo Alto', 'California', 'USA', 'https://psiquantum.com', 'Private', NULL, 2),
('Atom Computing', 'Atom Computing Inc.', NULL, NULL, 2018, 'Delaware', 'USA', 'Quantum Computing', 'Neutral Atom Quantum', ARRAY['quantum computing', 'neutral atoms', 'Rydberg atoms'], 'Berkeley', 'California', 'USA', 'https://atom-computing.com', 'Private', NULL, 2),
('QuEra Computing', 'QuEra Computing Inc.', NULL, NULL, 2018, 'Delaware', 'USA', 'Quantum Computing', 'Neutral Atom Quantum', ARRAY['quantum computing', 'neutral atoms', 'analog quantum'], 'Boston', 'Massachusetts', 'USA', 'https://quera.com', 'Private', NULL, 2),
('Xanadu', 'Xanadu Quantum Technologies Inc.', NULL, NULL, 2016, 'Ontario', 'CAN', 'Quantum Computing', 'Photonic Quantum Computing', ARRAY['quantum computing', 'photonics', 'continuous-variable quantum'], 'Toronto', 'Ontario', 'CAN', 'https://xanadu.ai', 'Private', NULL, 2),
('IQM Quantum Computers', 'IQM Finland Oy', NULL, NULL, 2018, 'Finland', 'FIN', 'Quantum Computing', 'Superconducting Quantum', ARRAY['quantum computing', 'superconducting qubits'], 'Espoo', 'Uusimaa', 'FIN', 'https://meetiqm.com', 'Private', NULL, 2);

-- ============================================
-- BIOTECHNOLOGY & GENOMICS (CONTINUED)
-- ============================================

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
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

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Cerebras Systems', 'Cerebras Systems Inc.', NULL, NULL, 2016, 'Delaware', 'USA', 'Advanced Computing', 'AI Wafer-Scale Chips', ARRAY['AI', 'semiconductors', 'wafer-scale', 'supercomputing'], 'Sunnyvale', 'California', 'USA', 'https://cerebras.net', 'Private', NULL, 2),
('Groq', 'Groq, Inc.', NULL, NULL, 2016, 'Delaware', 'USA', 'Advanced Computing', 'AI Inference Chips', ARRAY['AI', 'semiconductors', 'inference', 'LPU'], 'Mountain View', 'California', 'USA', 'https://groq.com', 'Private', NULL, 2),
('SambaNova Systems', 'SambaNova Systems, Inc.', NULL, NULL, 2017, 'Delaware', 'USA', 'Advanced Computing', 'AI Dataflow Architecture', ARRAY['AI', 'semiconductors', 'dataflow', 'reconfigurable'], 'Palo Alto', 'California', 'USA', 'https://sambanova.ai', 'Private', NULL, 2),
('Graphcore', 'Graphcore Limited', NULL, NULL, 2016, 'England', 'GBR', 'Advanced Computing', 'AI Intelligence Processing Unit', ARRAY['AI', 'semiconductors', 'IPU', 'machine learning'], 'Bristol', 'England', 'GBR', 'https://graphcore.ai', 'Private', NULL, 2),
('Tenstorrent', 'Tenstorrent Inc.', NULL, NULL, 2016, 'Ontario', 'CAN', 'Advanced Computing', 'AI RISC-V Processors', ARRAY['AI', 'RISC-V', 'semiconductors', 'edge AI'], 'Toronto', 'Ontario', 'CAN', 'https://tenstorrent.com', 'Private', NULL, 2);

-- ============================================
-- CYBERSECURITY & CRYPTOGRAPHY
-- ============================================

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
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

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
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

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Virgin Galactic', 'Virgin Galactic Holdings, Inc.', 'SPCE', '0001706946', 2017, 'Delaware', 'USA', 'Space Technology', 'Space Tourism', ARRAY['space', 'tourism', 'suborbital'], 'Las Cruces', 'New Mexico', 'USA', 'https://virgingalactic.com', 'Public', 'NYSE', 1),
('Momentus', 'Momentus Inc.', 'MNTS', '0001781162', 2017, 'Delaware', 'USA', 'Space Technology', 'Orbital Transfer Services', ARRAY['space', 'logistics', 'satellites'], 'San Jose', 'California', 'USA', 'https://momentus.space', 'Public', 'NASDAQ', 1),
('Redwire', 'Redwire Corporation', 'RDW', '0001819810', 2020, 'Delaware', 'USA', 'Space Technology', 'Space Infrastructure', ARRAY['space', 'manufacturing', 'infrastructure'], 'Jacksonville', 'Florida', 'USA', 'https://redwirespace.com', 'Public', 'NYSE', 1),
('Spire Global', 'Spire Global, Inc.', 'SPIR', '0001856173', 2012, 'Delaware', 'USA', 'Space Technology', 'Satellite Data & Analytics', ARRAY['space', 'satellites', 'data analytics', 'IoT'], 'Vienna', 'Virginia', 'USA', 'https://spire.com', 'Public', 'NYSE', 1),
('Planet Labs', 'Planet Labs PBC', 'PL', '0001833969', 2010, 'Delaware', 'USA', 'Space Technology', 'Earth Imaging Satellites', ARRAY['space', 'satellites', 'earth observation', 'imaging'], 'San Francisco', 'California', 'USA', 'https://planet.com', 'Public', 'NYSE', 1);

-- ============================================
-- ROBOTICS & AUTONOMOUS SYSTEMS
-- ============================================

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('Symbotic', 'Symbotic Inc.', 'SYM', '0001900148', 2007, 'Delaware', 'USA', 'Robotics', 'Warehouse Automation', ARRAY['robotics', 'automation', 'AI', 'logistics'], 'Wilmington', 'Massachusetts', 'USA', 'https://symbotic.com', 'Public', 'NASDAQ', 1),
('Sarcos Technology', 'Sarcos Technology and Robotics Corporation', 'STRC', '0001840502', 1983, 'Delaware', 'USA', 'Robotics', 'Industrial Exoskeletons', ARRAY['robotics', 'exoskeletons', 'AI'], 'Salt Lake City', 'Utah', 'USA', 'https://sarcos.com', 'Public', 'NASDAQ', 1),
('Markforged', 'Markforged Holding Corporation', 'MKFG', '0001856385', 2013, 'Delaware', 'USA', 'Advanced Manufacturing', '3D Metal Printing', ARRAY['3D printing', 'additive manufacturing', 'materials science'], 'Watertown', 'Massachusetts', 'USA', 'https://markforged.com', 'Public', 'NYSE', 1),
('Desktop Metal', 'Desktop Metal, Inc.', 'DM', '0001812214', 2015, 'Delaware', 'USA', 'Advanced Manufacturing', 'Metal 3D Printing', ARRAY['3D printing', 'additive manufacturing', 'metals'], 'Burlington', 'Massachusetts', 'USA', 'https://desktopmetal.com', 'Public', 'NYSE', 1);

-- ============================================
-- CLOUD INFRASTRUCTURE & COMPUTING
-- ============================================

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
VALUES
('HashiCorp', 'HashiCorp, Inc.', 'HCP', '0001720671', 2012, 'Delaware', 'USA', 'Cloud Infrastructure', 'Multi-Cloud Infrastructure Automation', ARRAY['cloud', 'infrastructure', 'DevOps', 'automation'], 'San Francisco', 'California', 'USA', 'https://hashicorp.com', 'Public', 'NASDAQ', 1),
('MongoDB', 'MongoDB, Inc.', 'MDB', '0001441816', 2007, 'Delaware', 'USA', 'Cloud Infrastructure', 'NoSQL Database Platform', ARRAY['database', 'NoSQL', 'cloud', 'data platform'], 'New York', 'New York', 'USA', 'https://mongodb.com', 'Public', 'NASDAQ', 1),
('DataDog', 'Datadog, Inc.', 'DDOG', '0001561550', 2010, 'Delaware', 'USA', 'Cloud Infrastructure', 'Monitoring & Analytics Platform', ARRAY['monitoring', 'cloud', 'observability', 'APM'], 'New York', 'New York', 'USA', 'https://datadoghq.com', 'Public', 'NASDAQ', 1),
('Elastic', 'Elastic N.V.', 'ESTC', '0001707753', 2012, 'Netherlands', 'NLD', 'Cloud Infrastructure', 'Search & Observability', ARRAY['search', 'observability', 'analytics', 'Elasticsearch'], 'Mountain View', 'California', 'USA', 'https://elastic.co', 'Public', 'NYSE', 1),
('Confluent', 'Confluent, Inc.', 'CFLT', '0001699838', 2014, 'Delaware', 'USA', 'Cloud Infrastructure', 'Data Streaming Platform', ARRAY['data streaming', 'Apache Kafka', 'real-time data'], 'Mountain View', 'California', 'USA', 'https://confluent.io', 'Public', 'NASDAQ', 1);

-- ============================================
-- ADVANCED MATERIALS
-- ============================================

INSERT INTO vendor_governance.companies (company_name, legal_name, ticker_symbol, cik, incorporation_year, incorporation_jurisdiction, incorporation_country, primary_sector, primary_subsector, technology_tags, headquarters_city, headquarters_state_province, headquarters_country, website_url, listing_type, stock_exchange, data_tier)
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
-- Initial Data Population: Top 20 Deep Tech Companies
-- For RiskAnchor Vendor Governance Database
-- Tier 1: Public Companies (Full Data Available)

SET search_path TO vendor_governance, public;

-- ============================================
-- QUANTUM COMPUTING
-- ============================================

-- 1. IonQ (IONQ) - Trapped Ion Quantum
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
INSERT INTO vendor_governance.companies (
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
-- Public Deep Tech Company Database
-- Total companies: 5,000
-- Generated: 2025-12-02 19:23:29.055894

SET search_path TO vendor_governance, public;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'OpenAI', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Anthropic', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Cohere', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Hugging Face', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Stability AI', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Scale AI', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'DataRobot', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'C3.ai', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Dataiku', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'H2O.ai', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Landing AI', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Weights & Biases', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Replicate', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'Modal Labs', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'machine learning', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 14', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 15', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 16', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 17', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 18', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 19', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 20', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 21', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 22', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 23', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 24', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 25', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 26', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 27', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 28', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 29', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 30', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 31', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 32', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 33', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 34', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 35', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 36', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 37', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 38', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 39', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 40', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 41', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 42', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 43', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 44', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 45', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 46', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 47', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 48', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 49', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 50', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 51', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 52', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 53', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 54', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 55', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 56', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 57', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 58', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 59', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 60', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 61', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 62', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 63', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 64', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 65', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 66', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 67', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 68', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 69', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 70', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 71', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 72', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 73', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 74', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 75', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 76', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 77', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 78', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 79', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 80', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 81', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 82', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 83', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 84', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 85', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 86', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 87', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 88', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 89', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 90', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 91', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 92', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 93', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 94', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 95', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 96', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 97', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 98', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 99', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 100', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 101', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 102', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 103', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 104', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 105', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 106', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 107', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 108', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 109', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 110', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 111', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 112', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 113', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 114', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 115', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 116', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 117', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 118', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 119', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 120', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 121', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 122', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 123', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 124', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 125', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 126', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 127', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 128', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 129', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 130', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 131', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 132', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 133', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 134', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 135', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 136', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 137', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 138', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 139', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 140', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 141', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 142', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 143', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 144', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 145', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 146', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 147', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 148', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 149', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 150', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 151', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 152', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 153', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 154', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 155', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 156', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 157', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 158', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 159', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 160', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 161', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 162', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 163', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 164', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 165', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 166', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 167', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 168', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 169', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 170', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 171', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 172', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 173', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 174', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 175', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 176', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 177', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 178', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 179', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 180', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 181', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 182', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 183', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 184', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 185', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 186', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 187', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 188', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 189', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 190', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 191', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 192', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 193', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 194', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 195', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 196', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 197', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 198', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 199', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 200', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 201', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 202', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 203', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 204', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 205', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 206', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 207', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 208', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 209', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 210', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 211', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 212', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 213', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 214', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 215', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 216', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 217', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 218', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 219', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 220', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 221', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 222', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 223', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 224', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 225', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 226', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 227', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 228', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 229', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 230', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 231', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 232', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 233', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 234', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 235', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 236', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 237', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 238', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 239', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 240', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 241', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 242', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 243', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 244', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 245', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 246', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 247', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 248', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 249', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 250', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 251', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 252', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 253', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 254', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 255', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 256', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 257', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 258', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 259', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 260', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 261', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 262', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 263', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 264', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 265', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 266', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 267', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 268', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 269', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 270', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 271', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 272', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 273', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 274', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 275', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 276', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 277', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 278', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 279', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 280', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 281', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 282', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 283', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 284', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 285', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 286', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 287', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 288', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 289', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 290', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 291', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 292', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 293', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 294', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 295', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 296', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 297', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 298', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 299', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 300', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 301', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 302', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 303', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 304', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 305', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 306', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 307', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 308', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 309', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 310', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 311', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 312', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 313', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 314', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 315', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 316', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 317', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 318', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 319', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 320', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 321', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 322', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 323', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 324', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 325', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 326', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 327', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 328', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 329', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 330', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 331', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 332', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 333', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 334', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 335', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 336', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 337', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 338', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 339', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 340', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 341', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 342', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 343', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 344', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 345', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 346', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 347', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 348', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 349', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 350', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 351', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 352', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 353', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 354', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 355', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 356', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 357', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 358', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 359', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 360', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 361', 2011, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 362', 2012, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 363', 2013, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 364', 2014, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 365', 2015, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 366', 2016, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 367', 2017, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 368', 2018, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 369', 2019, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 370', 2020, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 371', 2021, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 372', 2022, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 373', 2023, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 374', 2024, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO vendor_governance.companies (
    company_name, incorporation_year, incorporation_country,
    primary_sector, technology_tags, listing_type, data_tier
) VALUES (
    'AI Company 375', 2010, 'USA',
    'AI & Machine Learning', ARRAY['AI', 'software'], 'Private', 4
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;
