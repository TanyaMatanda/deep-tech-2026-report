-- SEC EDGAR Public Companies
-- Total: 386
-- Generated: 2025-12-02 19:05:11.550199

SET search_path TO vendor_governance, public;

-- GE: GENERAL ELECTRIC CO
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERAL ELECTRIC CO', 'GE', '0000040545', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-13', 'https://www.sec.gov/Archives/edgar/data/40545/000130817925000114/0001308179-25-000114-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-14', 'https://www.sec.gov/Archives/edgar/data/40545/000130817924000139/0001308179-24-000139-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GE'
ON CONFLICT (accession_number) DO NOTHING;

-- VRTX: VERTEX PHARMACEUTICALS INC / MA
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'VERTEX PHARMACEUTICALS INC / MA', 'VRTX', '0000875320', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-03', 'https://www.sec.gov/Archives/edgar/data/875320/000087532025000160/0000875320-25-000160-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VRTX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-04', 'https://www.sec.gov/Archives/edgar/data/875320/000130817924000452/0001308179-24-000452-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VRTX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-06', 'https://www.sec.gov/Archives/edgar/data/875320/000130817923000591/0001308179-23-000591-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VRTX'
ON CONFLICT (accession_number) DO NOTHING;

-- GD: GENERAL DYNAMICS CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERAL DYNAMICS CORP', 'GD', '0000040533', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-28', 'https://www.sec.gov/Archives/edgar/data/40533/000130817925000291/0001308179-25-000291-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-22', 'https://www.sec.gov/Archives/edgar/data/40533/000130817924000257/0001308179-24-000257-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-24', 'https://www.sec.gov/Archives/edgar/data/40533/000130817923000367/0001308179-23-000367-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GD'
ON CONFLICT (accession_number) DO NOTHING;

-- HWM: Howmet Aerospace Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Howmet Aerospace Inc.', 'HWM', '0000004281', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-16', 'https://www.sec.gov/Archives/edgar/data/4281/000110465925035530/0001104659-25-035530-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-08', 'https://www.sec.gov/Archives/edgar/data/4281/000110465924044630/0001104659-24-044630-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-30', 'https://www.sec.gov/Archives/edgar/data/4281/000110465923038944/0001104659-23-038944-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM'
ON CONFLICT (accession_number) DO NOTHING;

-- REGN: REGENERON PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'REGENERON PHARMACEUTICALS, INC.', 'REGN', '0000872589', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/872589/000130817925000518/0001308179-25-000518-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'REGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/872589/000130817924000577/0001308179-24-000577-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'REGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-21', 'https://www.sec.gov/Archives/edgar/data/872589/000130817923000728/0001308179-23-000728-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'REGN'
ON CONFLICT (accession_number) DO NOTHING;

-- GM: General Motors Co
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'General Motors Co', 'GM', '0001467858', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/1467858/000146785825000084/0001467858-25-000084-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-24', 'https://www.sec.gov/Archives/edgar/data/1467858/000119312524108581/0001193125-24-108581-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1467858/000119312523126270/0001193125-23-126270-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GM'
ON CONFLICT (accession_number) DO NOTHING;

-- ALNY: ALNYLAM PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ALNYLAM PHARMACEUTICALS, INC.', 'ALNY', '0001178670', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-24', 'https://www.sec.gov/Archives/edgar/data/1178670/000117867025000040/0001178670-25-000040-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ALNY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-01', 'https://www.sec.gov/Archives/edgar/data/1178670/000119312524083454/0001193125-24-083454-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ALNY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-03', 'https://www.sec.gov/Archives/edgar/data/1178670/000119312523089611/0001193125-23-089611-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ALNY'
ON CONFLICT (accession_number) DO NOTHING;

-- TAK: TAKEDA PHARMACEUTICAL CO LTD
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TAKEDA PHARMACEUTICAL CO LTD', 'TAK', '0001395064', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- NXPI: NXP Semiconductors N.V.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NXP Semiconductors N.V.', 'NXPI', '0001413447', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1413447/000141344725000035/0001413447-25-000035-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NXPI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-15', 'https://www.sec.gov/Archives/edgar/data/1413447/000141344724000033/0001413447-24-000033-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NXPI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-10', 'https://www.sec.gov/Archives/edgar/data/1413447/000141344723000014/0001413447-23-000014-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NXPI'
ON CONFLICT (accession_number) DO NOTHING;

-- RKT: Rocket Companies, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Rocket Companies, Inc.', 'RKT', '0001805284', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-29', 'https://www.sec.gov/Archives/edgar/data/1805284/000180528425000071/0001805284-25-000071-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RKT'
ON CONFLICT (accession_number) DO NOTHING;

-- CMG: CHIPOTLE MEXICAN GRILL INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CHIPOTLE MEXICAN GRILL INC', 'CMG', '0001058090', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1058090/000114036125015614/0001140361-25-015614-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CMG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-23', 'https://www.sec.gov/Archives/edgar/data/1058090/000114036124021181/0001140361-24-021181-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CMG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-10', 'https://www.sec.gov/Archives/edgar/data/1058090/000119312523095757/0001193125-23-095757-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CMG'
ON CONFLICT (accession_number) DO NOTHING;

-- EXR: Extra Space Storage Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Extra Space Storage Inc.', 'EXR', '0001289490', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-01', 'https://www.sec.gov/Archives/edgar/data/1289490/000162828025015917/0001628280-25-015917-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'EXR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-03', 'https://www.sec.gov/Archives/edgar/data/1289490/000162828024014598/0001628280-24-014598-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'EXR'
ON CONFLICT (accession_number) DO NOTHING;

-- TEVA: TEVA PHARMACEUTICAL INDUSTRIES LTD
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TEVA PHARMACEUTICAL INDUSTRIES LTD', 'TEVA', '0000818686', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-09', 'https://www.sec.gov/Archives/edgar/data/818686/000119312525076829/0001193125-25-076829-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TEVA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-16', 'https://www.sec.gov/Archives/edgar/data/818686/000119312524097745/0001193125-24-097745-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TEVA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-19', 'https://www.sec.gov/Archives/edgar/data/818686/000119312523106453/0001193125-23-106453-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TEVA'
ON CONFLICT (accession_number) DO NOTHING;

-- MCHP: MICROCHIP TECHNOLOGY INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MICROCHIP TECHNOLOGY INC', 'MCHP', '0000827054', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-07', 'https://www.sec.gov/Archives/edgar/data/827054/000082705425000099/0000827054-25-000099-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCHP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-08', 'https://www.sec.gov/Archives/edgar/data/827054/000082705424000128/0000827054-24-000128-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCHP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-07', 'https://www.sec.gov/Archives/edgar/data/827054/000082705423000104/0000827054-23-000104-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCHP'
ON CONFLICT (accession_number) DO NOTHING;

-- FSLR: FIRST SOLAR, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'FIRST SOLAR, INC.', 'FSLR', '0001274494', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-04', 'https://www.sec.gov/Archives/edgar/data/1274494/000127449425000023/0001274494-25-000023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FSLR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-28', 'https://www.sec.gov/Archives/edgar/data/1274494/000127449424000018/0001274494-24-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FSLR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-30', 'https://www.sec.gov/Archives/edgar/data/1274494/000127449423000004/0001274494-23-000004-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FSLR'
ON CONFLICT (accession_number) DO NOTHING;

-- GIS: GENERAL MILLS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERAL MILLS INC', 'GIS', '0000040704', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-11', 'https://www.sec.gov/Archives/edgar/data/40704/000130817925000581/0001308179-25-000581-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-08-12', 'https://www.sec.gov/Archives/edgar/data/40704/000130817924000692/0001308179-24-000692-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-08-14', 'https://www.sec.gov/Archives/edgar/data/40704/000130817923000968/0001308179-23-000968-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIS'
ON CONFLICT (accession_number) DO NOTHING;

-- RPRX: Royalty Pharma plc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Royalty Pharma plc', 'RPRX', '0001802768', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/1802768/000114036124022029/0001140361-24-022029-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RPRX'
ON CONFLICT (accession_number) DO NOTHING;

-- DG: DOLLAR GENERAL CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'DOLLAR GENERAL CORP', 'DG', '0000029534', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-08', 'https://www.sec.gov/Archives/edgar/data/29534/000110465925033041/0001104659-25-033041-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-05', 'https://www.sec.gov/Archives/edgar/data/29534/000110465924044304/0001104659-24-044304-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-11', 'https://www.sec.gov/Archives/edgar/data/29534/000110465923044057/0001104659-23-044057-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DG'
ON CONFLICT (accession_number) DO NOTHING;

-- RKLB: Rocket Lab Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Rocket Lab Corp', 'RKLB', '0001819994', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-11', 'https://www.sec.gov/Archives/edgar/data/1819994/000162828025034791/0001628280-25-034791-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RKLB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-24', 'https://www.sec.gov/Archives/edgar/data/1819994/000095017024047569/0000950170-24-047569-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RKLB'
ON CONFLICT (accession_number) DO NOTHING;

-- CASY: CASEYS GENERAL STORES INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CASEYS GENERAL STORES INC', 'CASY', '0000726958', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-23', 'https://www.sec.gov/Archives/edgar/data/726958/000114036125026947/0001140361-25-026947-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CASY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-17', 'https://www.sec.gov/Archives/edgar/data/726958/000114036124033386/0001140361-24-033386-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CASY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-26', 'https://www.sec.gov/Archives/edgar/data/726958/000114036123036246/0001140361-23-036246-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CASY'
ON CONFLICT (accession_number) DO NOTHING;

-- WST: WEST PHARMACEUTICAL SERVICES INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'WEST PHARMACEUTICAL SERVICES INC', 'WST', '0000105770', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-21', 'https://www.sec.gov/Archives/edgar/data/105770/000155837025003461/0001558370-25-003461-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WST'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-13', 'https://www.sec.gov/Archives/edgar/data/105770/000155837024003056/0001558370-24-003056-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WST'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-15', 'https://www.sec.gov/Archives/edgar/data/105770/000155837023003783/0001558370-23-003783-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WST'
ON CONFLICT (accession_number) DO NOTHING;

-- ON: ON SEMICONDUCTOR CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ON SEMICONDUCTOR CORP', 'ON', '0001097864', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-03', 'https://www.sec.gov/Archives/edgar/data/1097864/000109786425000008/0001097864-25-000008-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ON'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-04', 'https://www.sec.gov/Archives/edgar/data/1097864/000109786424000001/0001097864-24-000001-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ON'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-06', 'https://www.sec.gov/Archives/edgar/data/1097864/000109786423000006/0001097864-23-000006-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ON'
ON CONFLICT (accession_number) DO NOTHING;

-- ASTS: AST SpaceMobile, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'AST SpaceMobile, Inc.', 'ASTS', '0001780312', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-28', 'https://www.sec.gov/Archives/edgar/data/1780312/000149315225019825/0001493152-25-019825-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASTS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1780312/000164117225006182/0001641172-25-006182-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASTS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-30', 'https://www.sec.gov/Archives/edgar/data/1780312/000149315224029625/0001493152-24-029625-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASTS'
ON CONFLICT (accession_number) DO NOTHING;

-- ASND: Ascendis Pharma A/S
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Ascendis Pharma A/S', 'ASND', '0001612042', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- BBIO: BridgeBio Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'BridgeBio Pharma, Inc.', 'BBIO', '0001743881', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1743881/000114036125016452/0001140361-25-016452-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BBIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/1743881/000114036124022023/0001140361-24-022023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BBIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1743881/000119312523127256/0001193125-23-127256-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BBIO'
ON CONFLICT (accession_number) DO NOTHING;

-- MDGL: MADRIGAL PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MADRIGAL PHARMACEUTICALS, INC.', 'MDGL', '0001157601', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1157601/000110465925041254/0001104659-25-041254-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MDGL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1157601/000119312524122657/0001193125-24-122657-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MDGL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-01', 'https://www.sec.gov/Archives/edgar/data/1157601/000119312523128960/0001193125-23-128960-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MDGL'
ON CONFLICT (accession_number) DO NOTHING;

-- IONS: IONIS PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'IONIS PHARMACEUTICALS INC', 'IONS', '0000874015', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/874015/000114036125015771/0001140361-25-015771-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IONS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/874015/000114036124022103/0001140361-24-022103-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IONS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/874015/000114036123019309/0001140361-23-019309-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IONS'
ON CONFLICT (accession_number) DO NOTHING;

-- TTIPF: Thiogenesis Therapeutics, Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Thiogenesis Therapeutics, Corp.', 'TTIPF', '0001877778', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- JAZZ: Jazz Pharmaceuticals plc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Jazz Pharmaceuticals plc', 'JAZZ', '0001232524', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-06-06', 'https://www.sec.gov/Archives/edgar/data/1232524/000123252425000043/0001232524-25-000043-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'JAZZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-06-14', 'https://www.sec.gov/Archives/edgar/data/1232524/000123252424000049/0001232524-24-000049-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'JAZZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-06-16', 'https://www.sec.gov/Archives/edgar/data/1232524/000119312523168992/0001193125-23-168992-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'JAZZ'
ON CONFLICT (accession_number) DO NOTHING;

-- TSEM: TOWER SEMICONDUCTOR LTD
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TOWER SEMICONDUCTOR LTD', 'TSEM', '0000928876', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- BMRN: BIOMARIN PHARMACEUTICAL INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'BIOMARIN PHARMACEUTICAL INC', 'BMRN', '0001048477', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-08', 'https://www.sec.gov/Archives/edgar/data/1048477/000104847725000045/0001048477-25-000045-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BMRN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-09', 'https://www.sec.gov/Archives/edgar/data/1048477/000104847724000058/0001048477-24-000058-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BMRN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-11', 'https://www.sec.gov/Archives/edgar/data/1048477/000130817923000635/0001308179-23-000635-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BMRN'
ON CONFLICT (accession_number) DO NOTHING;

-- LSCC: LATTICE SEMICONDUCTOR CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LATTICE SEMICONDUCTOR CORP', 'LSCC', '0000855658', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-20', 'https://www.sec.gov/Archives/edgar/data/855658/000119312525058963/0001193125-25-058963-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LSCC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-21', 'https://www.sec.gov/Archives/edgar/data/855658/000119312524073834/0001193125-24-073834-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LSCC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-23', 'https://www.sec.gov/Archives/edgar/data/855658/000119312523077842/0001193125-23-077842-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LSCC'
ON CONFLICT (accession_number) DO NOTHING;

-- GNRC: GENERAC HOLDINGS INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERAC HOLDINGS INC.', 'GNRC', '0001474735', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1474735/000110465925040848/0001104659-25-040848-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GNRC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1474735/000110465924053993/0001104659-24-053993-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GNRC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1474735/000110465923052898/0001104659-23-052898-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GNRC'
ON CONFLICT (accession_number) DO NOTHING;

-- QBTS: D-Wave Quantum Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'D-Wave Quantum Inc.', 'QBTS', '0001907982', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/1907982/000114036125014910/0001140361-25-014910-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QBTS'
ON CONFLICT (accession_number) DO NOTHING;

-- QS: QuantumScape Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'QuantumScape Corp', 'QS', '0001811414', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-24', 'https://www.sec.gov/Archives/edgar/data/1811414/000095017025058125/0000950170-25-058125-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1811414/000114036124022958/0001140361-24-022958-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1811414/000114036123021023/0001140361-23-021023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QS'
ON CONFLICT (accession_number) DO NOTHING;

-- RYTM: RHYTHM PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'RHYTHM PHARMACEUTICALS, INC.', 'RYTM', '0001649904', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1649904/000155837025005818/0001558370-25-005818-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RYTM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1649904/000110465924052915/0001104659-24-052915-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RYTM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1649904/000110465923051469/0001104659-23-051469-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RYTM'
ON CONFLICT (accession_number) DO NOTHING;

-- SHTPY: SCHOTT Pharma AG & Co. KGaA/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SCHOTT Pharma AG & Co. KGaA/ADR', 'SHTPY', '0002018852', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- POR: PORTLAND GENERAL ELECTRIC CO /OR/
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'PORTLAND GENERAL ELECTRIC CO /OR/', 'POR', '0000784977', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-05', 'https://www.sec.gov/Archives/edgar/data/784977/000078497725000055/0000784977-25-000055-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'POR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-06', 'https://www.sec.gov/Archives/edgar/data/784977/000078497724000065/0000784977-24-000065-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'POR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-07', 'https://www.sec.gov/Archives/edgar/data/784977/000078497723000034/0000784977-23-000034-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'POR'
ON CONFLICT (accession_number) DO NOTHING;

-- ARWR: ARROWHEAD PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ARROWHEAD PHARMACEUTICALS, INC.', 'ARWR', '0000879407', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-01-29', 'https://www.sec.gov/Archives/edgar/data/879407/000162828025002848/0001628280-25-002848-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ARWR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-01-26', 'https://www.sec.gov/Archives/edgar/data/879407/000162828024002375/0001628280-24-002375-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ARWR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-01-30', 'https://www.sec.gov/Archives/edgar/data/879407/000162828023001743/0001628280-23-001743-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ARWR'
ON CONFLICT (accession_number) DO NOTHING;

-- MCY: MERCURY GENERAL CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MERCURY GENERAL CORP', 'MCY', '0000064996', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-01', 'https://www.sec.gov/Archives/edgar/data/64996/000006499625000022/0000064996-25-000022-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-26', 'https://www.sec.gov/Archives/edgar/data/64996/000006499624000014/0000064996-24-000014-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-28', 'https://www.sec.gov/Archives/edgar/data/64996/000006499623000020/0000064996-23-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCY'
ON CONFLICT (accession_number) DO NOTHING;

-- ENLT: Enlight Renewable Energy Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Enlight Renewable Energy Ltd.', 'ENLT', '0001922641', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- NAMS: NewAmsterdam Pharma Co N.V.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NewAmsterdam Pharma Co N.V.', 'NAMS', '0001936258', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-08', 'https://www.sec.gov/Archives/edgar/data/1936258/000119312525115995/0001193125-25-115995-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NAMS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-09', 'https://www.sec.gov/Archives/edgar/data/1936258/000119312524135282/0001193125-24-135282-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NAMS'
ON CONFLICT (accession_number) DO NOTHING;

-- CNTA: Centessa Pharmaceuticals plc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Centessa Pharmaceuticals plc', 'CNTA', '0001847903', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-06', 'https://www.sec.gov/Archives/edgar/data/1847903/000199937125005478/0001999371-25-005478-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CNTA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-09', 'https://www.sec.gov/Archives/edgar/data/1847903/000183988224014966/0001839882-24-014966-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CNTA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-15', 'https://www.sec.gov/Archives/edgar/data/1847903/000138713123006494/0001387131-23-006494-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CNTA'
ON CONFLICT (accession_number) DO NOTHING;

-- CRNX: Crinetics Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Crinetics Pharmaceuticals, Inc.', 'CRNX', '0001658247', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-23', 'https://www.sec.gov/Archives/edgar/data/1658247/000095017025057452/0000950170-25-057452-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CRNX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/1658247/000095017024048438/0000950170-24-048438-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CRNX'
ON CONFLICT (accession_number) DO NOTHING;

-- LGND: LIGAND PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIGAND PHARMACEUTICALS INC', 'LGND', '0000886163', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/886163/000088616325000025/0000886163-25-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGND'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/886163/000088616324000020/0000886163-24-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGND'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/886163/000088616323000018/0000886163-23-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGND'
ON CONFLICT (accession_number) DO NOTHING;

-- WGS: GeneDx Holdings Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GeneDx Holdings Corp.', 'WGS', '0001818331', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1818331/000181833125000075/0001818331-25-000075-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WGS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1818331/000181833124000025/0001818331-24-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WGS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1818331/000181833123000033/0001818331-23-000033-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WGS'
ON CONFLICT (accession_number) DO NOTHING;

-- ACAD: ACADIA PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ACADIA PHARMACEUTICALS INC', 'ACAD', '0001070494', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1070494/000095017025058827/0000950170-25-058827-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ACAD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1070494/000095017024049182/0000950170-24-049182-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ACAD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-01', 'https://www.sec.gov/Archives/edgar/data/1070494/000095017023015969/0000950170-23-015969-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ACAD'
ON CONFLICT (accession_number) DO NOTHING;

-- AMRX: Amneal Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Amneal Pharmaceuticals, Inc.', 'AMRX', '0001723128', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-25', 'https://www.sec.gov/Archives/edgar/data/1723128/000130817925000220/0001308179-25-000220-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-22', 'https://www.sec.gov/Archives/edgar/data/1723128/000130817924000231/0001308179-24-000231-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-24', 'https://www.sec.gov/Archives/edgar/data/1723128/000130817923000351/0001308179-23-000351-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMRX'
ON CONFLICT (accession_number) DO NOTHING;

-- MIRM: Mirum Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Mirum Pharmaceuticals, Inc.', 'MIRM', '0001759425', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-14', 'https://www.sec.gov/Archives/edgar/data/1759425/000175942525000022/0001759425-25-000022-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MIRM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-23', 'https://www.sec.gov/Archives/edgar/data/1759425/000175942524000011/0001759425-24-000011-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MIRM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-01', 'https://www.sec.gov/Archives/edgar/data/1759425/000114036123022054/0001140361-23-022054-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MIRM'
ON CONFLICT (accession_number) DO NOTHING;

-- TARS: Tarsus Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Tarsus Pharmaceuticals, Inc.', 'TARS', '0001819790', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1819790/000181979025000070/0001819790-25-000070-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TARS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1819790/000181979024000056/0001819790-24-000056-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TARS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-26', 'https://www.sec.gov/Archives/edgar/data/1819790/000181979023000014/0001819790-23-000014-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TARS'
ON CONFLICT (accession_number) DO NOTHING;

-- CATY: CATHAY GENERAL BANCORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CATHAY GENERAL BANCORP', 'CATY', '0000861842', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-10', 'https://www.sec.gov/Archives/edgar/data/861842/000143774925011577/0001437749-25-011577-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CATY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-11', 'https://www.sec.gov/Archives/edgar/data/861842/000143774924011784/0001437749-24-011784-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CATY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-06', 'https://www.sec.gov/Archives/edgar/data/861842/000143774923009676/0001437749-23-009676-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CATY'
ON CONFLICT (accession_number) DO NOTHING;

-- KNSA: Kiniksa Pharmaceuticals International, plc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Kiniksa Pharmaceuticals International, plc', 'KNSA', '0001730430', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-21', 'https://www.sec.gov/Archives/edgar/data/1730430/000110465925036852/0001104659-25-036852-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KNSA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-23', 'https://www.sec.gov/Archives/edgar/data/1730430/000110465924050621/0001104659-24-050621-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KNSA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1730430/000110465923051434/0001104659-23-051434-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KNSA'
ON CONFLICT (accession_number) DO NOTHING;

-- XENE: Xenon Pharmaceuticals Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Xenon Pharmaceuticals Inc.', 'XENE', '0001582313', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-24', 'https://www.sec.gov/Archives/edgar/data/1582313/000095017025058086/0000950170-25-058086-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XENE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1582313/000095017024049198/0000950170-24-049198-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XENE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1582313/000095017023015260/0000950170-23-015260-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XENE'
ON CONFLICT (accession_number) DO NOTHING;

-- RARE: Ultragenyx Pharmaceutical Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Ultragenyx Pharmaceutical Inc.', 'RARE', '0001515673', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-28', 'https://www.sec.gov/Archives/edgar/data/1515673/000130817925000296/0001308179-25-000296-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RARE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1515673/000130817924000609/0001308179-24-000609-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RARE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-24', 'https://www.sec.gov/Archives/edgar/data/1515673/000130817923000757/0001308179-23-000757-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RARE'
ON CONFLICT (accession_number) DO NOTHING;

-- SEI: Solaris Energy Infrastructure, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Solaris Energy Infrastructure, Inc.', 'SEI', '0001697500', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-04', 'https://www.sec.gov/Archives/edgar/data/1697500/000114036125012376/0001140361-25-012376-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SEI'
ON CONFLICT (accession_number) DO NOTHING;

-- TLX: Telix Pharmaceuticals Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Telix Pharmaceuticals Ltd', 'TLX', '0002007191', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- AAPG: ASCENTAGE PHARMA GROUP INTERNATIONAL
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ASCENTAGE PHARMA GROUP INTERNATIONAL', 'AAPG', '0002023311', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- EYUBY: Electricity Generating Public Co Limited/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Electricity Generating Public Co Limited/ADR', 'EYUBY', '0001562294', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CPRX: CATALYST PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CATALYST PHARMACEUTICALS, INC.', 'CPRX', '0001369568', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-11', 'https://www.sec.gov/Archives/edgar/data/1369568/000119312525079097/0001193125-25-079097-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CPRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-10', 'https://www.sec.gov/Archives/edgar/data/1369568/000119312524091926/0001193125-24-091926-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CPRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-12', 'https://www.sec.gov/Archives/edgar/data/1369568/000119312523185962/0001193125-23-185962-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CPRX'
ON CONFLICT (accession_number) DO NOTHING;

-- FLY: Firefly Aerospace Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Firefly Aerospace Inc.', 'FLY', '0001860160', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SUPN: SUPERNUS PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SUPERNUS PHARMACEUTICALS, INC.', 'SUPN', '0001356576', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1356576/000110465925042531/0001104659-25-042531-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SUPN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1356576/000110465924054023/0001104659-24-054023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SUPN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-01', 'https://www.sec.gov/Archives/edgar/data/1356576/000110465923054333/0001104659-23-054333-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SUPN'
ON CONFLICT (accession_number) DO NOTHING;

-- APLS: Apellis Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Apellis Pharmaceuticals, Inc.', 'APLS', '0001492422', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-23', 'https://www.sec.gov/Archives/edgar/data/1492422/000095017025056966/0000950170-25-056966-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'APLS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1492422/000095017024049098/0000950170-24-049098-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'APLS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-21', 'https://www.sec.gov/Archives/edgar/data/1492422/000095017023013761/0000950170-23-013761-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'APLS'
ON CONFLICT (accession_number) DO NOTHING;

-- TERN: Terns Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Terns Pharmaceuticals, Inc.', 'TERN', '0001831363', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1831363/000095017025060138/0000950170-25-060138-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TERN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/1831363/000095017024048289/0000950170-24-048289-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TERN'
ON CONFLICT (accession_number) DO NOTHING;

-- QUBT: Quantum Computing Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantum Computing Inc.', 'QUBT', '0001758009', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-08', 'https://www.sec.gov/Archives/edgar/data/1758009/000121390025041135/0001213900-25-041135-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QUBT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-01', 'https://www.sec.gov/Archives/edgar/data/1758009/000121390024093562/0001213900-24-093562-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QUBT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-09-27', 'https://www.sec.gov/Archives/edgar/data/1758009/000121390023079965/0001213900-23-079965-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QUBT'
ON CONFLICT (accession_number) DO NOTHING;

-- AVDL: AVADEL PHARMACEUTICALS PLC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'AVADEL PHARMACEUTICALS PLC', 'AVDL', '0001012477', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-06-18', 'https://www.sec.gov/Archives/edgar/data/1012477/000110465925060465/0001104659-25-060465-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AVDL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-06-18', 'https://www.sec.gov/Archives/edgar/data/1012477/000110465924072563/0001104659-24-072563-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AVDL'
ON CONFLICT (accession_number) DO NOTHING;

-- TXG: 10x Genomics, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    '10x Genomics, Inc.', 'TXG', '0001770787', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-14', 'https://www.sec.gov/Archives/edgar/data/1770787/000177078725000018/0001770787-25-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TXG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1770787/000177078724000029/0001770787-24-000029-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TXG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1770787/000177078723000021/0001770787-23-000021-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TXG'
ON CONFLICT (accession_number) DO NOTHING;

-- SMNR: Semnur Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Semnur Pharmaceuticals, Inc.', 'SMNR', '0001913577', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-27', 'https://www.sec.gov/Archives/edgar/data/1913577/000101376225003461/0001013762-25-003461-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SMNR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-06-28', 'https://www.sec.gov/Archives/edgar/data/1913577/000121390024057300/0001213900-24-057300-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SMNR'
ON CONFLICT (accession_number) DO NOTHING;

-- RXRX: RECURSION PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'RECURSION PHARMACEUTICALS, INC.', 'RXRX', '0001601830', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1601830/000160183025000062/0001601830-25-000062-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RXRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-23', 'https://www.sec.gov/Archives/edgar/data/1601830/000160183024000040/0001601830-24-000040-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RXRX'
ON CONFLICT (accession_number) DO NOTHING;

-- AUPH: Aurinia Pharmaceuticals Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Aurinia Pharmaceuticals Inc.', 'AUPH', '0001600620', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-17', 'https://www.sec.gov/Archives/edgar/data/1600620/000160062025000032/0001600620-25-000032-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AUPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-03', 'https://www.sec.gov/Archives/edgar/data/1600620/000160062024000064/0001600620-24-000064-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AUPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-18', 'https://www.sec.gov/Archives/edgar/data/1600620/000160062023000005/0001600620-23-000005-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AUPH'
ON CONFLICT (accession_number) DO NOTHING;

-- SEDG: SOLAREDGE TECHNOLOGIES, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SOLAREDGE TECHNOLOGIES, INC.', 'SEDG', '0001419612', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-21', 'https://www.sec.gov/Archives/edgar/data/1419612/000117891325001370/0001178913-25-001370-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SEDG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1419612/000117891324001454/0001178913-24-001454-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SEDG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-21', 'https://www.sec.gov/Archives/edgar/data/1419612/000117891323001490/0001178913-23-001490-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SEDG'
ON CONFLICT (accession_number) DO NOTHING;

-- ZBIO: Zenas BioPharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Zenas BioPharma, Inc.', 'ZBIO', '0001953926', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1953926/000110465925039765/0001104659-25-039765-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ZBIO'
ON CONFLICT (accession_number) DO NOTHING;

-- GEL: GENESIS ENERGY LP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENESIS ENERGY LP', 'GEL', '0001022321', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ANIP: ANI PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ANI PHARMACEUTICALS INC', 'ANIP', '0001023024', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-10', 'https://www.sec.gov/Archives/edgar/data/1023024/000102302425000035/0001023024-25-000035-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ANIP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-05', 'https://www.sec.gov/Archives/edgar/data/1023024/000102302424000037/0001023024-24-000037-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ANIP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-11', 'https://www.sec.gov/Archives/edgar/data/1023024/000110465923044064/0001104659-23-044064-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ANIP'
ON CONFLICT (accession_number) DO NOTHING;

-- GRDN: Guardian Pharmacy Services, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Guardian Pharmacy Services, Inc.', 'GRDN', '0001802255', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-28', 'https://www.sec.gov/Archives/edgar/data/1802255/000119312525066235/0001193125-25-066235-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GRDN'
ON CONFLICT (accession_number) DO NOTHING;

-- NVTS: Navitas Semiconductor Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Navitas Semiconductor Corp', 'NVTS', '0001821769', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-29', 'https://www.sec.gov/Archives/edgar/data/1821769/000162828025028387/0001628280-25-028387-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NVTS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1821769/000182176924000052/0001821769-24-000052-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NVTS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1821769/000182176923000079/0001821769-23-000079-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NVTS'
ON CONFLICT (accession_number) DO NOTHING;

-- PRCT: PROCEPT BioRobotics Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'PROCEPT BioRobotics Corp', 'PRCT', '0001588978', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1588978/000158897825000028/0001588978-25-000028-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PRCT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-22', 'https://www.sec.gov/Archives/edgar/data/1588978/000162828024017167/0001628280-24-017167-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PRCT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-26', 'https://www.sec.gov/Archives/edgar/data/1588978/000162828023013251/0001628280-23-013251-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PRCT'
ON CONFLICT (accession_number) DO NOTHING;

-- OLMA: Olema Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Olema Pharmaceuticals, Inc.', 'OLMA', '0001750284', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1750284/000095017025059348/0000950170-25-059348-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'OLMA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1750284/000095017024049287/0000950170-24-049287-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'OLMA'
ON CONFLICT (accession_number) DO NOTHING;

-- AMLX: Amylyx Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Amylyx Pharmaceuticals, Inc.', 'AMLX', '0001658551', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-24', 'https://www.sec.gov/Archives/edgar/data/1658551/000095017025057665/0000950170-25-057665-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMLX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-24', 'https://www.sec.gov/Archives/edgar/data/1658551/000095017024047243/0000950170-24-047243-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMLX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1658551/000095017023015261/0000950170-23-015261-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMLX'
ON CONFLICT (accession_number) DO NOTHING;

-- SNDX: Syndax Pharmaceuticals Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Syndax Pharmaceuticals Inc', 'SNDX', '0001395937', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-01', 'https://www.sec.gov/Archives/edgar/data/1395937/000095017025048472/0000950170-25-048472-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SNDX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-02', 'https://www.sec.gov/Archives/edgar/data/1395937/000095017024040099/0000950170-24-040099-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SNDX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-07', 'https://www.sec.gov/Archives/edgar/data/1395937/000095017023012189/0000950170-23-012189-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SNDX'
ON CONFLICT (accession_number) DO NOTHING;

-- BCRX: BIOCRYST PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'BIOCRYST PHARMACEUTICALS INC', 'BCRX', '0000882796', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-24', 'https://www.sec.gov/Archives/edgar/data/882796/000162828025019659/0001628280-25-019659-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BCRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/882796/000162828024018175/0001628280-24-018175-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BCRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/882796/000114036123020945/0001140361-23-020945-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BCRX'
ON CONFLICT (accession_number) DO NOTHING;

-- CSIQ: Canadian Solar Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Canadian Solar Inc.', 'CSIQ', '0001375877', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- AGIO: AGIOS PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'AGIOS PHARMACEUTICALS, INC.', 'AGIO', '0001439222', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1439222/000119312525096719/0001193125-25-096719-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AGIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1439222/000119312524117951/0001193125-24-117951-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AGIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-26', 'https://www.sec.gov/Archives/edgar/data/1439222/000119312523118490/0001193125-23-118490-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AGIO'
ON CONFLICT (accession_number) DO NOTHING;

-- COLL: COLLEGIUM PHARMACEUTICAL, INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'COLLEGIUM PHARMACEUTICAL, INC', 'COLL', '0001267565', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-28', 'https://www.sec.gov/Archives/edgar/data/1267565/000155837025003983/0001558370-25-003983-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'COLL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-05', 'https://www.sec.gov/Archives/edgar/data/1267565/000155837024004778/0001558370-24-004778-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'COLL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-11', 'https://www.sec.gov/Archives/edgar/data/1267565/000155837023005728/0001558370-23-005728-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'COLL'
ON CONFLICT (accession_number) DO NOTHING;

-- NEO: NEOGENOMICS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NEOGENOMICS INC', 'NEO', '0001077183', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-08', 'https://www.sec.gov/Archives/edgar/data/1077183/000107718325000068/0001077183-25-000068-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NEO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-08', 'https://www.sec.gov/Archives/edgar/data/1077183/000107718324000042/0001077183-24-000042-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NEO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-07', 'https://www.sec.gov/Archives/edgar/data/1077183/000119312523095194/0001193125-23-095194-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NEO'
ON CONFLICT (accession_number) DO NOTHING;

-- GAM: GENERAL AMERICAN INVESTORS CO INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERAL AMERICAN INVESTORS CO INC', 'GAM', '0000040417', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-02-24', 'https://www.sec.gov/Archives/edgar/data/40417/000183988225010653/0001839882-25-010653-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GAM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-20', 'https://www.sec.gov/Archives/edgar/data/40417/000199937124002520/0001999371-24-002520-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GAM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-18', 'https://www.sec.gov/Archives/edgar/data/40417/000138713123004818/0001387131-23-004818-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GAM'
ON CONFLICT (accession_number) DO NOTHING;

-- JKS: JinkoSolar Holding Co., Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'JinkoSolar Holding Co., Ltd.', 'JKS', '0001481513', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GEMI: Gemini Space Station, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Gemini Space Station, Inc.', 'GEMI', '0002055592', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CSR: CENTERSPACE
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CENTERSPACE', 'CSR', '0000798359', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-04', 'https://www.sec.gov/Archives/edgar/data/798359/000079835925000031/0000798359-25-000031-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CSR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-09', 'https://www.sec.gov/Archives/edgar/data/798359/000079835924000032/0000798359-24-000032-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CSR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-05', 'https://www.sec.gov/Archives/edgar/data/798359/000079835923000042/0000798359-23-000042-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CSR'
ON CONFLICT (accession_number) DO NOTHING;

-- AMPH: Amphastar Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Amphastar Pharmaceuticals, Inc.', 'AMPH', '0001297184', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-14', 'https://www.sec.gov/Archives/edgar/data/1297184/000129718425000018/0001297184-25-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-12', 'https://www.sec.gov/Archives/edgar/data/1297184/000129718424000019/0001297184-24-000019-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-14', 'https://www.sec.gov/Archives/edgar/data/1297184/000129718423000033/0001297184-23-000033-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMPH'
ON CONFLICT (accession_number) DO NOTHING;

-- NNNN: Anbio Biotechnology
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Anbio Biotechnology', 'NNNN', '0001982708', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- URGN: UroGen Pharma Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'UroGen Pharma Ltd.', 'URGN', '0001668243', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-15', 'https://www.sec.gov/Archives/edgar/data/1668243/000143774925022732/0001437749-25-022732-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'URGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-01', 'https://www.sec.gov/Archives/edgar/data/1668243/000143774924021722/0001437749-24-021722-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'URGN'
ON CONFLICT (accession_number) DO NOTHING;

-- SLSR: Solaris Resources Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Solaris Resources Inc.', 'SLSR', '0002019103', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- XERS: Xeris Biopharma Holdings, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Xeris Biopharma Holdings, Inc.', 'XERS', '0001867096', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-23', 'https://www.sec.gov/Archives/edgar/data/1867096/000186709625000068/0001867096-25-000068-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XERS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-23', 'https://www.sec.gov/Archives/edgar/data/1867096/000186709624000053/0001867096-24-000053-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XERS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-26', 'https://www.sec.gov/Archives/edgar/data/1867096/000186709623000056/0001867096-23-000056-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XERS'
ON CONFLICT (accession_number) DO NOTHING;

-- EYPT: EyePoint Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'EyePoint Pharmaceuticals, Inc.', 'EYPT', '0001314102', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1314102/000095017025059290/0000950170-25-059290-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'EYPT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1314102/000095017024049067/0000950170-24-049067-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'EYPT'
ON CONFLICT (accession_number) DO NOTHING;

-- ORIC: Oric Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Oric Pharmaceuticals, Inc.', 'ORIC', '0001796280', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-23', 'https://www.sec.gov/Archives/edgar/data/1796280/000119312525091359/0001193125-25-091359-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORIC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-24', 'https://www.sec.gov/Archives/edgar/data/1796280/000119312524110069/0001193125-24-110069-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORIC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-26', 'https://www.sec.gov/Archives/edgar/data/1796280/000119312523118496/0001193125-23-118496-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORIC'
ON CONFLICT (accession_number) DO NOTHING;

-- TSHA: Taysha Gene Therapies, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Taysha Gene Therapies, Inc.', 'TSHA', '0001806310', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-21', 'https://www.sec.gov/Archives/edgar/data/1806310/000119312525087214/0001193125-25-087214-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TSHA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-18', 'https://www.sec.gov/Archives/edgar/data/1806310/000119312524100792/0001193125-24-100792-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TSHA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-05', 'https://www.sec.gov/Archives/edgar/data/1806310/000119312523251065/0001193125-23-251065-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TSHA'
ON CONFLICT (accession_number) DO NOTHING;

-- NBXG: Neuberger Berman Next Generation Connectivity Fund Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Neuberger Berman Next Generation Connectivity Fund Inc.', 'NBXG', '0001843181', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-06-13', 'https://www.sec.gov/Archives/edgar/data/1843181/000089843225000442/0000898432-25-000442-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NBXG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-08-11', 'https://www.sec.gov/Archives/edgar/data/1843181/000089843223000617/0000898432-23-000617-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NBXG'
ON CONFLICT (accession_number) DO NOTHING;

-- PHAT: Phathom Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Phathom Pharmaceuticals, Inc.', 'PHAT', '0001783183', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-23', 'https://www.sec.gov/Archives/edgar/data/1783183/000095017025057326/0000950170-25-057326-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PHAT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-12', 'https://www.sec.gov/Archives/edgar/data/1783183/000095017024044015/0000950170-24-044015-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PHAT'
ON CONFLICT (accession_number) DO NOTHING;

-- IMOS: CHIPMOS TECHNOLOGIES INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CHIPMOS TECHNOLOGIES INC', 'IMOS', '0001123134', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- IGIC: International General Insurance Holdings Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'International General Insurance Holdings Ltd.', 'IGIC', '0001794338', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- DRSHF: DroneShield Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'DroneShield Ltd', 'DRSHF', '0001671541', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TBPH: Theravance Biopharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Theravance Biopharma, Inc.', 'TBPH', '0001583107', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-10', 'https://www.sec.gov/Archives/edgar/data/1583107/000110465925033819/0001104659-25-033819-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TBPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-05', 'https://www.sec.gov/Archives/edgar/data/1583107/000110465924044282/0001104659-24-044282-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TBPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-28', 'https://www.sec.gov/Archives/edgar/data/1583107/000110465923037712/0001104659-23-037712-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TBPH'
ON CONFLICT (accession_number) DO NOTHING;

-- FLGT: Fulgent Genetics, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Fulgent Genetics, Inc.', 'FLGT', '0001674930', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-25', 'https://www.sec.gov/Archives/edgar/data/1674930/000095017025044407/0000950170-25-044407-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FLGT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-27', 'https://www.sec.gov/Archives/edgar/data/1674930/000095017024037159/0000950170-24-037159-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FLGT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-31', 'https://www.sec.gov/Archives/edgar/data/1674930/000095017023011376/0000950170-23-011376-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FLGT'
ON CONFLICT (accession_number) DO NOTHING;

-- SANA: Sana Biotechnology, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Sana Biotechnology, Inc.', 'SANA', '0001770121', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1770121/000119312525094656/0001193125-25-094656-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SANA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1770121/000119312524115454/0001193125-24-115454-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SANA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1770121/000119312523123965/0001193125-23-123965-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SANA'
ON CONFLICT (accession_number) DO NOTHING;

-- DAWN: Day One Biopharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Day One Biopharmaceuticals, Inc.', 'DAWN', '0001845337', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-11', 'https://www.sec.gov/Archives/edgar/data/1845337/000114036125013462/0001140361-25-013462-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DAWN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-05', 'https://www.sec.gov/Archives/edgar/data/1845337/000114036124018305/0001140361-24-018305-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DAWN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1845337/000114036123021487/0001140361-23-021487-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DAWN'
ON CONFLICT (accession_number) DO NOTHING;

-- AVBP: ArriVent BioPharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ArriVent BioPharma, Inc.', 'AVBP', '0001868279', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1868279/000110465925040214/0001104659-25-040214-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AVBP'
ON CONFLICT (accession_number) DO NOTHING;

-- ABUS: Arbutus Biopharma Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Arbutus Biopharma Corp', 'ABUS', '0001447028', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-04', 'https://www.sec.gov/Archives/edgar/data/1447028/000114036125012305/0001140361-25-012305-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ABUS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-10', 'https://www.sec.gov/Archives/edgar/data/1447028/000114036124019091/0001140361-24-019091-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ABUS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-12', 'https://www.sec.gov/Archives/edgar/data/1447028/000114036123017990/0001140361-23-017990-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ABUS'
ON CONFLICT (accession_number) DO NOTHING;

-- RIGL: RIGEL PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'RIGEL PHARMACEUTICALS INC', 'RIGL', '0001034842', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-10', 'https://www.sec.gov/Archives/edgar/data/1034842/000114036125013250/0001140361-25-013250-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RIGL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-10', 'https://www.sec.gov/Archives/edgar/data/1034842/000114036124019133/0001140361-24-019133-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RIGL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-14', 'https://www.sec.gov/Archives/edgar/data/1034842/000114036123018393/0001140361-23-018393-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RIGL'
ON CONFLICT (accession_number) DO NOTHING;

-- VIR: Vir Biotechnology, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Vir Biotechnology, Inc.', 'VIR', '0001706431', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-17', 'https://www.sec.gov/Archives/edgar/data/1706431/000162828025018119/0001628280-25-018119-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VIR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-19', 'https://www.sec.gov/Archives/edgar/data/1706431/000114036124020684/0001140361-24-020684-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VIR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-07', 'https://www.sec.gov/Archives/edgar/data/1706431/000119312523095213/0001193125-23-095213-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VIR'
ON CONFLICT (accession_number) DO NOTHING;

-- AIO: Virtus Artificial Intelligence & Technology Opportunities Fund
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Virtus Artificial Intelligence & Technology Opportunities Fund', 'AIO', '0001778114', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-08', 'https://www.sec.gov/Archives/edgar/data/1778114/000110465925032992/0001104659-25-032992-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-09', 'https://www.sec.gov/Archives/edgar/data/1778114/000110465924045275/0001104659-24-045275-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-11', 'https://www.sec.gov/Archives/edgar/data/1778114/000110465923044081/0001104659-23-044081-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AIO'
ON CONFLICT (accession_number) DO NOTHING;

-- GILT: GILAT SATELLITE NETWORKS LTD
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GILAT SATELLITE NETWORKS LTD', 'GILT', '0000897322', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- INDI: indie Semiconductor, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'indie Semiconductor, Inc.', 'INDI', '0001841925', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-21', 'https://www.sec.gov/Archives/edgar/data/1841925/000162828025018658/0001628280-25-018658-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INDI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/1841925/000162828024018185/0001628280-24-018185-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INDI'
ON CONFLICT (accession_number) DO NOTHING;

-- SPRY: ARS Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ARS Pharmaceuticals, Inc.', 'SPRY', '0001671858', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1671858/000095017025060075/0000950170-25-060075-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SPRY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1671858/000095017024049071/0000950170-24-049071-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SPRY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-01', 'https://www.sec.gov/Archives/edgar/data/1671858/000119312523130534/0001193125-23-130534-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SPRY'
ON CONFLICT (accession_number) DO NOTHING;

-- KALV: KalVista Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'KalVista Pharmaceuticals, Inc.', 'KALV', '0001348911', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-21', 'https://www.sec.gov/Archives/edgar/data/1348911/000119312525185353/0001193125-25-185353-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KALV'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-08-22', 'https://www.sec.gov/Archives/edgar/data/1348911/000119312524205356/0001193125-24-205356-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KALV'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-08-14', 'https://www.sec.gov/Archives/edgar/data/1348911/000119312523212312/0001193125-23-212312-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KALV'
ON CONFLICT (accession_number) DO NOTHING;

-- ORGO: Organogenesis Holdings Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Organogenesis Holdings Inc.', 'ORGO', '0001661181', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-12', 'https://www.sec.gov/Archives/edgar/data/1661181/000119312525117808/0001193125-25-117808-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORGO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1661181/000119312524122223/0001193125-24-122223-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORGO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-01', 'https://www.sec.gov/Archives/edgar/data/1661181/000119312523130412/0001193125-23-130412-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORGO'
ON CONFLICT (accession_number) DO NOTHING;

-- SERV: Serve Robotics Inc. /DE/
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Serve Robotics Inc. /DE/', 'SERV', '0001832483', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1832483/000114036125015733/0001140361-25-015733-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SERV'
ON CONFLICT (accession_number) DO NOTHING;

-- MYGN: MYRIAD GENETICS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MYRIAD GENETICS INC', 'MYGN', '0000899923', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-09', 'https://www.sec.gov/Archives/edgar/data/899923/000089992325000028/0000899923-25-000028-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MYGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-17', 'https://www.sec.gov/Archives/edgar/data/899923/000089992324000022/0000899923-24-000022-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MYGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-12', 'https://www.sec.gov/Archives/edgar/data/899923/000089992323000023/0000899923-23-000023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MYGN'
ON CONFLICT (accession_number) DO NOTHING;

-- CRVS: Corvus Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Corvus Pharmaceuticals, Inc.', 'CRVS', '0001626971', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1626971/000155837025005552/0001558370-25-005552-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CRVS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1626971/000155837024005898/0001558370-24-005898-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CRVS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1626971/000155837023007172/0001558370-23-007172-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CRVS'
ON CONFLICT (accession_number) DO NOTHING;

-- RR: RICHTECH ROBOTICS INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'RICHTECH ROBOTICS INC.', 'RR', '0001963685', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-16', 'https://www.sec.gov/Archives/edgar/data/1963685/000121390025088233/0001213900-25-088233-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RR'
ON CONFLICT (accession_number) DO NOTHING;

-- ELTP: ELITE PHARMACEUTICALS INC /NV/
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ELITE PHARMACEUTICALS INC /NV/', 'ELTP', '0001053369', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- AOSL: ALPHA & OMEGA SEMICONDUCTOR Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ALPHA & OMEGA SEMICONDUCTOR Ltd', 'AOSL', '0001387467', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-18', 'https://www.sec.gov/Archives/edgar/data/1387467/000138746725000054/0001387467-25-000054-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AOSL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-09-25', 'https://www.sec.gov/Archives/edgar/data/1387467/000138746724000085/0001387467-24-000085-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AOSL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-09-25', 'https://www.sec.gov/Archives/edgar/data/1387467/000138746723000060/0001387467-23-000060-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AOSL'
ON CONFLICT (accession_number) DO NOTHING;

-- TALK: Talkspace, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Talkspace, Inc.', 'TALK', '0001803901', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1803901/000114036125016714/0001140361-25-016714-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TALK'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1803901/000114036124022973/0001140361-24-022973-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TALK'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-09-01', 'https://www.sec.gov/Archives/edgar/data/1803901/000114036123042235/0001140361-23-042235-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TALK'
ON CONFLICT (accession_number) DO NOTHING;

-- IRWD: IRONWOOD PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'IRONWOOD PHARMACEUTICALS INC', 'IRWD', '0001446847', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1446847/000110465925040309/0001104659-25-040309-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IRWD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/1446847/000110465924051992/0001104659-24-051992-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IRWD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1446847/000110465923051441/0001104659-23-051441-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IRWD'
ON CONFLICT (accession_number) DO NOTHING;

-- LXRX: LEXICON PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LEXICON PHARMACEUTICALS, INC.', 'LXRX', '0001062822', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/1062822/000106282225000023/0001062822-25-000023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LXRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-26', 'https://www.sec.gov/Archives/edgar/data/1062822/000106282224000014/0001062822-24-000014-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LXRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-17', 'https://www.sec.gov/Archives/edgar/data/1062822/000106282223000011/0001062822-23-000011-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LXRX'
ON CONFLICT (accession_number) DO NOTHING;

-- ABAT: AMERICAN BATTERY TECHNOLOGY Co
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'AMERICAN BATTERY TECHNOLOGY Co', 'ABAT', '0001576873', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-19', 'https://www.sec.gov/Archives/edgar/data/1576873/000149315225014267/0001493152-25-014267-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ABAT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-04', 'https://www.sec.gov/Archives/edgar/data/1576873/000149315224039470/0001493152-24-039470-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ABAT'
ON CONFLICT (accession_number) DO NOTHING;

-- BNTC: Benitec Biopharma Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Benitec Biopharma Inc.', 'BNTC', '0001808898', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-14', 'https://www.sec.gov/Archives/edgar/data/1808898/000119312525239131/0001193125-25-239131-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BNTC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-22', 'https://www.sec.gov/Archives/edgar/data/1808898/000119312524241155/0001193125-24-241155-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BNTC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-29', 'https://www.sec.gov/Archives/edgar/data/1808898/000119312524187599/0001193125-24-187599-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BNTC'
ON CONFLICT (accession_number) DO NOTHING;

-- ETON: Eton Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Eton Pharmaceuticals, Inc.', 'ETON', '0001710340', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1710340/000143774925013137/0001437749-25-013137-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ETON'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1710340/000143774924013429/0001437749-24-013429-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ETON'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1710340/000149315223013832/0001493152-23-013832-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ETON'
ON CONFLICT (accession_number) DO NOTHING;

-- ENGN: enGene Holdings Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'enGene Holdings Inc.', 'ENGN', '0001980845', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-09', 'https://www.sec.gov/Archives/edgar/data/1980845/000114036125018155/0001140361-25-018155-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-18', 'https://www.sec.gov/Archives/edgar/data/1980845/000095017024045297/0000950170-24-045297-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENGN'
ON CONFLICT (accession_number) DO NOTHING;

-- LBRX: LB PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LB PHARMACEUTICALS INC', 'LBRX', '0001691082', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- EVTL: Vertical Aerospace Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Vertical Aerospace Ltd.', 'EVTL', '0001867102', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PKE: PARK AEROSPACE CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'PARK AEROSPACE CORP', 'PKE', '0000076267', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-06-20', 'https://www.sec.gov/Archives/edgar/data/76267/000117494725000945/0001174947-25-000945-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PKE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-06-20', 'https://www.sec.gov/Archives/edgar/data/76267/000117494724000854/0001174947-24-000854-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PKE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-06-15', 'https://www.sec.gov/Archives/edgar/data/76267/000117494723000867/0001174947-23-000867-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PKE'
ON CONFLICT (accession_number) DO NOTHING;

-- ARQQ: Arqit Quantum Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Arqit Quantum Inc.', 'ARQQ', '0001859690', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- LYEL: Lyell Immunopharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Lyell Immunopharma, Inc.', 'LYEL', '0001806952', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-21', 'https://www.sec.gov/Archives/edgar/data/1806952/000114036125014721/0001140361-25-014721-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LYEL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-22', 'https://www.sec.gov/Archives/edgar/data/1806952/000114036124021008/0001140361-24-021008-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LYEL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1806952/000114036123020919/0001140361-23-020919-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LYEL'
ON CONFLICT (accession_number) DO NOTHING;

-- ENTA: ENANTA PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ENANTA PHARMACEUTICALS INC', 'ENTA', '0001177648', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-01-27', 'https://www.sec.gov/Archives/edgar/data/1177648/000095017025009168/0000950170-25-009168-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENTA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-01-26', 'https://www.sec.gov/Archives/edgar/data/1177648/000095017024007956/0000950170-24-007956-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENTA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-01-20', 'https://www.sec.gov/Archives/edgar/data/1177648/000119312523011979/0001193125-23-011979-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENTA'
ON CONFLICT (accession_number) DO NOTHING;

-- GCO: GENESCO INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENESCO INC', 'GCO', '0000018498', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-16', 'https://www.sec.gov/Archives/edgar/data/18498/000119312525121346/0001193125-25-121346-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GCO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-17', 'https://www.sec.gov/Archives/edgar/data/18498/000119312524141291/0001193125-24-141291-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GCO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-12', 'https://www.sec.gov/Archives/edgar/data/18498/000119312523142978/0001193125-23-142978-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GCO'
ON CONFLICT (accession_number) DO NOTHING;

-- XFOR: X4 Pharmaceuticals, Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'X4 Pharmaceuticals, Inc', 'XFOR', '0001501697', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1501697/000162828025019926/0001628280-25-019926-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XFOR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-24', 'https://www.sec.gov/Archives/edgar/data/1501697/000162828025014535/0001628280-25-014535-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XFOR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1501697/000162828024019056/0001628280-24-019056-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XFOR'
ON CONFLICT (accession_number) DO NOTHING;

-- EPRX: EUPRAXIA PHARMACEUTICALS INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'EUPRAXIA PHARMACEUTICALS INC.', 'EPRX', '0001581178', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- NGNE: Neurogene Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Neurogene Inc.', 'NGNE', '0001404644', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1404644/000140464425000034/0001404644-25-000034-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NGNE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1404644/000140464424000043/0001404644-24-000043-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NGNE'
ON CONFLICT (accession_number) DO NOTHING;

-- NIKA: NIKA PHARMACEUTICALS, INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NIKA PHARMACEUTICALS, INC', 'NIKA', '0001145604', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RCKT: ROCKET PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ROCKET PHARMACEUTICALS, INC.', 'RCKT', '0001281895', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1281895/000114036125016656/0001140361-25-016656-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RCKT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1281895/000114036124023041/0001140361-24-023041-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RCKT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1281895/000114036123021702/0001140361-23-021702-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RCKT'
ON CONFLICT (accession_number) DO NOTHING;

-- VNDA: Vanda Pharmaceuticals Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Vanda Pharmaceuticals Inc.', 'VNDA', '0001347178', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1347178/000162828025019987/0001628280-25-019987-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VNDA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1347178/000121390024036802/0001213900-24-036802-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VNDA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-24', 'https://www.sec.gov/Archives/edgar/data/1347178/000162828023012594/0001628280-23-012594-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VNDA'
ON CONFLICT (accession_number) DO NOTHING;

-- MREO: Mereo BioPharma Group plc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Mereo BioPharma Group plc', 'MREO', '0001719714', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-08', 'https://www.sec.gov/Archives/edgar/data/1719714/000095017025051800/0000950170-25-051800-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MREO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-24', 'https://www.sec.gov/Archives/edgar/data/1719714/000119312524108454/0001193125-24-108454-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MREO'
ON CONFLICT (accession_number) DO NOTHING;

-- ALLO: Allogene Therapeutics, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Allogene Therapeutics, Inc.', 'ALLO', '0001737287', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1737287/000173728725000049/0001737287-25-000049-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ALLO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-23', 'https://www.sec.gov/Archives/edgar/data/1737287/000173728724000032/0001737287-24-000032-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ALLO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-24', 'https://www.sec.gov/Archives/edgar/data/1737287/000173728723000041/0001737287-23-000041-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ALLO'
ON CONFLICT (accession_number) DO NOTHING;

-- QSI: Quantum-Si Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantum-Si Inc', 'QSI', '0001816431', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-20', 'https://www.sec.gov/Archives/edgar/data/1816431/000181643125000024/0001816431-25-000024-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QSI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-01', 'https://www.sec.gov/Archives/edgar/data/1816431/000114036124016945/0001140361-24-016945-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QSI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-29', 'https://www.sec.gov/Archives/edgar/data/1816431/000114036123014533/0001140361-23-014533-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QSI'
ON CONFLICT (accession_number) DO NOTHING;

-- NAUT: Nautilus Biotechnology, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Nautilus Biotechnology, Inc.', 'NAUT', '0001808805', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1808805/000180880525000043/0001808805-25-000043-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NAUT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1808805/000180880524000033/0001808805-24-000033-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NAUT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1808805/000180880523000039/0001808805-23-000039-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NAUT'
ON CONFLICT (accession_number) DO NOTHING;

-- SOPH: SOPHiA GENETICS SA
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SOPHiA GENETICS SA', 'SOPH', '0001840706', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- FENC: FENNEC PHARMACEUTICALS INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'FENNEC PHARMACEUTICALS INC.', 'FENC', '0001211583', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1211583/000155837025005563/0001558370-25-005563-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FENC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-13', 'https://www.sec.gov/Archives/edgar/data/1211583/000155837024007979/0001558370-24-007979-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FENC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1211583/000110465923052994/0001104659-23-052994-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FENC'
ON CONFLICT (accession_number) DO NOTHING;

-- ARMP: Armata Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Armata Pharmaceuticals, Inc.', 'ARMP', '0000921114', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/921114/000110465925040273/0001104659-25-040273-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ARMP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/921114/000110465924054149/0001104659-24-054149-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ARMP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-08-03', 'https://www.sec.gov/Archives/edgar/data/921114/000110465923087321/0001104659-23-087321-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ARMP'
ON CONFLICT (accession_number) DO NOTHING;

-- RXT: Rackspace Technology, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Rackspace Technology, Inc.', 'RXT', '0001810019', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1810019/000181001925000059/0001810019-25-000059-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RXT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1810019/000181001924000075/0001810019-24-000075-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RXT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1810019/000181001923000073/0001810019-23-000073-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RXT'
ON CONFLICT (accession_number) DO NOTHING;

-- PBYI: PUMA BIOTECHNOLOGY, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'PUMA BIOTECHNOLOGY, INC.', 'PBYI', '0001401667', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1401667/000143774925013337/0001437749-25-013337-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PBYI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1401667/000143774924013309/0001437749-24-013309-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PBYI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1401667/000143774923011500/0001437749-23-011500-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PBYI'
ON CONFLICT (accession_number) DO NOTHING;

-- SOCA: Solarius Capital Acquisition Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Solarius Capital Acquisition Corp.', 'SOCA', '0002065948', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- AVIR: Atea Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Atea Pharmaceuticals, Inc.', 'AVIR', '0001593899', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1593899/000119312525104019/0001193125-25-104019-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AVIR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1593899/000095017024049178/0000950170-24-049178-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AVIR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1593899/000095017023015773/0000950170-23-015773-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AVIR'
ON CONFLICT (accession_number) DO NOTHING;

-- GEOS: GEOSPACE TECHNOLOGIES CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GEOSPACE TECHNOLOGIES CORP', 'GEOS', '0001001115', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-12-27', 'https://www.sec.gov/Archives/edgar/data/1001115/000143774924038442/0001437749-24-038442-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GEOS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-01-03', 'https://www.sec.gov/Archives/edgar/data/1001115/000143774924000325/0001437749-24-000325-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GEOS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-01-04', 'https://www.sec.gov/Archives/edgar/data/1001115/000119312523001273/0001193125-23-001273-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GEOS'
ON CONFLICT (accession_number) DO NOTHING;

-- CBIO: CRESCENT BIOPHARMA, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CRESCENT BIOPHARMA, INC.', 'CBIO', '0001253689', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-01', 'https://www.sec.gov/Archives/edgar/data/1253689/000155837024004448/0001558370-24-004448-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CBIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-21', 'https://www.sec.gov/Archives/edgar/data/1253689/000155837023006383/0001558370-23-006383-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CBIO'
ON CONFLICT (accession_number) DO NOTHING;

-- SDSYA: SOUTH DAKOTA SOYBEAN PROCESSORS LLC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SOUTH DAKOTA SOYBEAN PROCESSORS LLC', 'SDSYA', '0001163609', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1163609/000116360925000013/0001163609-25-000013-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SDSYA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1163609/000116360924000008/0001163609-24-000008-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SDSYA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1163609/000116360923000021/0001163609-23-000021-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SDSYA'
ON CONFLICT (accession_number) DO NOTHING;

-- CRBP: Corbus Pharmaceuticals Holdings, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Corbus Pharmaceuticals Holdings, Inc.', 'CRBP', '0001595097', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-01', 'https://www.sec.gov/Archives/edgar/data/1595097/000095017025048603/0000950170-25-048603-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CRBP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-02', 'https://www.sec.gov/Archives/edgar/data/1595097/000095017024040242/0000950170-24-040242-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CRBP'
ON CONFLICT (accession_number) DO NOTHING;

-- MIST: Milestone Pharmaceuticals Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Milestone Pharmaceuticals Inc.', 'MIST', '0001408443', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1408443/000110465925042640/0001104659-25-042640-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MIST'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-15', 'https://www.sec.gov/Archives/edgar/data/1408443/000110465924079878/0001104659-24-079878-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MIST'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1408443/000110465923052993/0001104659-23-052993-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MIST'
ON CONFLICT (accession_number) DO NOTHING;

-- TNXP: Tonix Pharmaceuticals Holding Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Tonix Pharmaceuticals Holding Corp.', 'TNXP', '0001430306', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-31', 'https://www.sec.gov/Archives/edgar/data/1430306/000199937125003527/0001999371-25-003527-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TNXP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-09-23', 'https://www.sec.gov/Archives/edgar/data/1430306/000199937124012276/0001999371-24-012276-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TNXP'
ON CONFLICT (accession_number) DO NOTHING;

-- GNLX: GENELUX Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENELUX Corp', 'GNLX', '0001231457', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-11', 'https://www.sec.gov/Archives/edgar/data/1231457/000164117225018673/0001641172-25-018673-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GNLX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-06-14', 'https://www.sec.gov/Archives/edgar/data/1231457/000149315224023868/0001493152-24-023868-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GNLX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-20', 'https://www.sec.gov/Archives/edgar/data/1231457/000149315223025087/0001493152-23-025087-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GNLX'
ON CONFLICT (accession_number) DO NOTHING;

-- CNTB: Connect Biopharma Holdings Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Connect Biopharma Holdings Ltd', 'CNTB', '0001835268', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- IPHA: Innate Pharma SA
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Innate Pharma SA', 'IPHA', '0001598599', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HYSR: SUNHYDROGEN, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SUNHYDROGEN, INC.', 'HYSR', '0001481028', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SXTC: China SXT Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'China SXT Pharmaceuticals, Inc.', 'SXTC', '0001723980', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- NVCT: Nuvectis Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Nuvectis Pharma, Inc.', 'NVCT', '0001875558', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1875558/000110465925040225/0001104659-25-040225-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NVCT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1875558/000110465924054082/0001104659-24-054082-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NVCT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1875558/000110465923052907/0001104659-23-052907-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NVCT'
ON CONFLICT (accession_number) DO NOTHING;

-- GEVI: General Enterprise Ventures, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'General Enterprise Ventures, Inc.', 'GEVI', '0000894556', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- VLN: Valens Semiconductor Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Valens Semiconductor Ltd.', 'VLN', '0001863006', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ARBE: Arbe Robotics Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Arbe Robotics Ltd.', 'ARBE', '0001861841', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- IMMX: Immix Biopharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Immix Biopharma, Inc.', 'IMMX', '0001873835', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1873835/000164117225006711/0001641172-25-006711-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IMMX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1873835/000149315224017060/0001493152-24-017060-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IMMX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-25', 'https://www.sec.gov/Archives/edgar/data/1873835/000149315223013537/0001493152-23-013537-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IMMX'
ON CONFLICT (accession_number) DO NOTHING;

-- IRD: Opus Genetics, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Opus Genetics, Inc.', 'IRD', '0001228627', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1228627/000114036124023004/0001140361-24-023004-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IRD'
ON CONFLICT (accession_number) DO NOTHING;

-- VOR: Vor Biopharma Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Vor Biopharma Inc.', 'VOR', '0001817229', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-08', 'https://www.sec.gov/Archives/edgar/data/1817229/000114036125029749/0001140361-25-029749-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VOR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-08', 'https://www.sec.gov/Archives/edgar/data/1817229/000119312525075715/0001193125-25-075715-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VOR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-09', 'https://www.sec.gov/Archives/edgar/data/1817229/000119312524090781/0001193125-24-090781-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VOR'
ON CONFLICT (accession_number) DO NOTHING;

-- FTCI: FTC Solar, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'FTC Solar, Inc.', 'FTCI', '0001828161', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-25', 'https://www.sec.gov/Archives/edgar/data/1828161/000119312525164759/0001193125-25-164759-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FTCI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1828161/000095017025061051/0000950170-25-061051-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FTCI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-11', 'https://www.sec.gov/Archives/edgar/data/1828161/000119312524236715/0001193125-24-236715-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'FTCI'
ON CONFLICT (accession_number) DO NOTHING;

-- NBY: NovaBay Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NovaBay Pharmaceuticals, Inc.', 'NBY', '0001389545', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-23', 'https://www.sec.gov/Archives/edgar/data/1389545/000182912625007608/0001829126-25-007608-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NBY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-19', 'https://www.sec.gov/Archives/edgar/data/1389545/000143774925008439/0001437749-25-008439-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NBY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-18', 'https://www.sec.gov/Archives/edgar/data/1389545/000143774924012384/0001437749-24-012384-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NBY'
ON CONFLICT (accession_number) DO NOTHING;

-- INO: INOVIO PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'INOVIO PHARMACEUTICALS, INC.', 'INO', '0001055726', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-07', 'https://www.sec.gov/Archives/edgar/data/1055726/000105572625000018/0001055726-25-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-11', 'https://www.sec.gov/Archives/edgar/data/1055726/000105572624000014/0001055726-24-000014-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-11-28', 'https://www.sec.gov/Archives/edgar/data/1055726/000119312523284277/0001193125-23-284277-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INO'
ON CONFLICT (accession_number) DO NOTHING;

-- QUMS: Quantumsphere Acquisition Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantumsphere Acquisition Corp', 'QUMS', '0002070900', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ELDN: Eledon Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Eledon Pharmaceuticals, Inc.', 'ELDN', '0001404281', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1404281/000095017025060299/0000950170-25-060299-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ELDN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-30', 'https://www.sec.gov/Archives/edgar/data/1404281/000095017024066564/0000950170-24-066564-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ELDN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-01', 'https://www.sec.gov/Archives/edgar/data/1404281/000095017023016306/0000950170-23-016306-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ELDN'
ON CONFLICT (accession_number) DO NOTHING;

-- ZYBT: Zhengye Biotechnology Holding Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Zhengye Biotechnology Holding Ltd', 'ZYBT', '0001975641', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- QMCO: QUANTUM CORP /DE/
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'QUANTUM CORP /DE/', 'QMCO', '0000709283', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-31', 'https://www.sec.gov/Archives/edgar/data/709283/000153949725002829/0001539497-25-002829-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QMCO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-27', 'https://www.sec.gov/Archives/edgar/data/709283/000119312525065483/0001193125-25-065483-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QMCO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-02', 'https://www.sec.gov/Archives/edgar/data/709283/000153949724001359/0001539497-24-001359-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QMCO'
ON CONFLICT (accession_number) DO NOTHING;

-- BAER: Bridger Aerospace Group Holdings, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Bridger Aerospace Group Holdings, Inc.', 'BAER', '0001941536', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1941536/000114036125016366/0001140361-25-016366-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BAER'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1941536/000114036124023081/0001140361-24-023081-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BAER'
ON CONFLICT (accession_number) DO NOTHING;

-- ZNTL: Zentalis Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Zentalis Pharmaceuticals, Inc.', 'ZNTL', '0001725160', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1725160/000172516025000092/0001725160-25-000092-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ZNTL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1725160/000172516024000096/0001725160-24-000096-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ZNTL'
ON CONFLICT (accession_number) DO NOTHING;

-- ORMP: ORAMED PHARMACEUTICALS INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ORAMED PHARMACEUTICALS INC.', 'ORMP', '0001176309', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-16', 'https://www.sec.gov/Archives/edgar/data/1176309/000121390025064755/0001213900-25-064755-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORMP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-06-20', 'https://www.sec.gov/Archives/edgar/data/1176309/000121390024054007/0001213900-24-054007-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORMP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-31', 'https://www.sec.gov/Archives/edgar/data/1176309/000121390023044530/0001213900-23-044530-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORMP'
ON CONFLICT (accession_number) DO NOTHING;

-- HSPT: Horizon Space Acquisition II Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition II Corp.', 'HSPT', '0002032950', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ABOS: Acumen Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Acumen Pharmaceuticals, Inc.', 'ABOS', '0001576885', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-23', 'https://www.sec.gov/Archives/edgar/data/1576885/000157688525000057/0001576885-25-000057-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ABOS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-22', 'https://www.sec.gov/Archives/edgar/data/1576885/000157688524000055/0001576885-24-000055-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ABOS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-27', 'https://www.sec.gov/Archives/edgar/data/1576885/000119312523122267/0001193125-23-122267-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ABOS'
ON CONFLICT (accession_number) DO NOTHING;

-- ANEB: Anebulo Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Anebulo Pharmaceuticals, Inc.', 'ANEB', '0001815974', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-06', 'https://www.sec.gov/Archives/edgar/data/1815974/000149315225009311/0001493152-25-009311-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ANEB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-30', 'https://www.sec.gov/Archives/edgar/data/1815974/000149315223038625/0001493152-23-038625-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ANEB'
ON CONFLICT (accession_number) DO NOTHING;

-- GRWG: GrowGeneration Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GrowGeneration Corp.', 'GRWG', '0001604868', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1604868/000160486825000007/0001604868-25-000007-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GRWG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1604868/000162828024018512/0001628280-24-018512-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GRWG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1604868/000162828023013949/0001628280-23-013949-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GRWG'
ON CONFLICT (accession_number) DO NOTHING;

-- ADAG: Adagene Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Adagene Inc.', 'ADAG', '0001818838', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ELBM: Electra Battery Materials Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Electra Battery Materials Corp', 'ELBM', '0001907184', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- MX: MAGNACHIP SEMICONDUCTOR Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MAGNACHIP SEMICONDUCTOR Corp', 'MX', '0001325702', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1325702/000119312525103977/0001193125-25-103977-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1325702/000119312524122526/0001193125-24-122526-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-17', 'https://www.sec.gov/Archives/edgar/data/1325702/000114036123018669/0001140361-23-018669-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MX'
ON CONFLICT (accession_number) DO NOTHING;

-- IMA: ImageneBio, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ImageneBio, Inc.', 'IMA', '0001835579', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1835579/000114036124022470/0001140361-24-022470-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IMA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-09-25', 'https://www.sec.gov/Archives/edgar/data/1835579/000114036123045091/0001140361-23-045091-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IMA'
ON CONFLICT (accession_number) DO NOTHING;

-- GCTS: GCT Semiconductor Holding, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GCT Semiconductor Holding, Inc.', 'GCTS', '0001851961', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-04', 'https://www.sec.gov/Archives/edgar/data/1851961/000095017025102009/0000950170-25-102009-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GCTS'
ON CONFLICT (accession_number) DO NOTHING;

-- STRO: SUTRO BIOPHARMA, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SUTRO BIOPHARMA, INC.', 'STRO', '0001382101', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1382101/000095017025058774/0000950170-25-058774-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'STRO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1382101/000095017024049207/0000950170-24-049207-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'STRO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1382101/000095017023015762/0000950170-23-015762-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'STRO'
ON CONFLICT (accession_number) DO NOTHING;

-- OKYO: OKYO Pharma Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'OKYO Pharma Ltd', 'OKYO', '0001849296', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PMVP: PMV Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'PMV Pharmaceuticals, Inc.', 'PMVP', '0001699382', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1699382/000114036125015610/0001140361-25-015610-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PMVP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-24', 'https://www.sec.gov/Archives/edgar/data/1699382/000114036124021596/0001140361-24-021596-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PMVP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1699382/000114036123021220/0001140361-23-021220-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PMVP'
ON CONFLICT (accession_number) DO NOTHING;

-- ATYR: aTYR PHARMA INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'aTYR PHARMA INC', 'ATYR', '0001339970', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-19', 'https://www.sec.gov/Archives/edgar/data/1339970/000095017025041992/0000950170-25-041992-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ATYR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-05', 'https://www.sec.gov/Archives/edgar/data/1339970/000095017024042236/0000950170-24-042236-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ATYR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-29', 'https://www.sec.gov/Archives/edgar/data/1339970/000095017023010607/0000950170-23-010607-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ATYR'
ON CONFLICT (accession_number) DO NOTHING;

-- NSRX: Nasus Pharma Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Nasus Pharma Ltd', 'NSRX', '0002029039', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ABVC: ABVC BIOPHARMA, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ABVC BIOPHARMA, INC.', 'ABVC', '0001173313', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-16', 'https://www.sec.gov/Archives/edgar/data/1173313/000121390025044910/0001213900-25-044910-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ABVC'
ON CONFLICT (accession_number) DO NOTHING;

-- ESLA: Estrella Immunopharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Estrella Immunopharma, Inc.', 'ESLA', '0001844417', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-06-16', 'https://www.sec.gov/Archives/edgar/data/1844417/000157587223000970/0001575872-23-000970-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ESLA'
ON CONFLICT (accession_number) DO NOTHING;

-- CHEV: Charging Robotics Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Charging Robotics Inc.', 'CHEV', '0001459188', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- NRXP: NRX Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NRX Pharmaceuticals, Inc.', 'NRXP', '0001719406', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-09-05', 'https://www.sec.gov/Archives/edgar/data/1719406/000143774924028549/0001437749-24-028549-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NRXP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-11', 'https://www.sec.gov/Archives/edgar/data/1719406/000110465924033080/0001104659-24-033080-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NRXP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-11-22', 'https://www.sec.gov/Archives/edgar/data/1719406/000110465923120785/0001104659-23-120785-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NRXP'
ON CONFLICT (accession_number) DO NOTHING;

-- TGE: Generation Essentials Group
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Generation Essentials Group', 'TGE', '0002053456', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- MIRA: MIRA PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MIRA PHARMACEUTICALS, INC.', 'MIRA', '0001904286', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-26', 'https://www.sec.gov/Archives/edgar/data/1904286/000149315224029259/0001493152-24-029259-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MIRA'
ON CONFLICT (accession_number) DO NOTHING;

-- USPCY: USPACE Technology Group Limited/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'USPACE Technology Group Limited/ADR', 'USPCY', '0001939479', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- QTZM: Quantumzyme Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantumzyme Corp.', 'QTZM', '0001663038', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HSPO: Horizon Space Acquisition I Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition I Corp.', 'HSPO', '0001946021', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-14', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998025000665/0001929980-25-000665-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-19', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000565/0001929980-24-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-21', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000037/0001929980-24-000037-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPO'
ON CONFLICT (accession_number) DO NOTHING;

-- SMXT: SolarMax Technology, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SolarMax Technology, Inc.', 'SMXT', '0001519472', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-14', 'https://www.sec.gov/Archives/edgar/data/1519472/000164033425001818/0001640334-25-001818-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SMXT'
ON CONFLICT (accession_number) DO NOTHING;

-- SSGC: SafeSpace Global Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SafeSpace Global Corp', 'SSGC', '0001584693', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TELO: Telomir Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Telomir Pharmaceuticals, Inc.', 'TELO', '0001971532', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- MAXN: Maxeon Solar Technologies, Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Maxeon Solar Technologies, Ltd.', 'MAXN', '0001796898', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- MDCX: Medicus Pharma Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Medicus Pharma Ltd.', 'MDCX', '0001997296', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-06-30', 'https://www.sec.gov/Archives/edgar/data/1997296/000106299325012273/0001062993-25-012273-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MDCX'
ON CONFLICT (accession_number) DO NOTHING;

-- XTIA: XTI Aerospace, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'XTI Aerospace, Inc.', 'XTIA', '0001529113', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-10', 'https://www.sec.gov/Archives/edgar/data/1529113/000121390025098157/0001213900-25-098157-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XTIA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-12-03', 'https://www.sec.gov/Archives/edgar/data/1529113/000121390024105041/0001213900-24-105041-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'XTIA'
ON CONFLICT (accession_number) DO NOTHING;

-- CUE: Cue Biopharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Cue Biopharma, Inc.', 'CUE', '0001645460', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1645460/000095017025058681/0000950170-25-058681-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CUE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-09-10', 'https://www.sec.gov/Archives/edgar/data/1645460/000095017024105104/0000950170-24-105104-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CUE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1645460/000095017024049072/0000950170-24-049072-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CUE'
ON CONFLICT (accession_number) DO NOTHING;

-- PDSB: PDS Biotechnology Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'PDS Biotechnology Corp', 'PDSB', '0001472091', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1472091/000114036125016309/0001140361-25-016309-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PDSB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1472091/000114036124022685/0001140361-24-022685-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PDSB'
ON CONFLICT (accession_number) DO NOTHING;

-- GNTA: Genenta Science S.p.A.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Genenta Science S.p.A.', 'GNTA', '0001838716', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- IBATF: INTERNATIONAL BATTERY METALS LTD.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'INTERNATIONAL BATTERY METALS LTD.', 'IBATF', '0001786318', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ATNM: Actinium Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Actinium Pharmaceuticals, Inc.', 'ATNM', '0001388320', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-05', 'https://www.sec.gov/Archives/edgar/data/1388320/000121390025106706/0001213900-25-106706-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ATNM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-05', 'https://www.sec.gov/Archives/edgar/data/1388320/000121390024094619/0001213900-24-094619-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ATNM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-11-09', 'https://www.sec.gov/Archives/edgar/data/1388320/000121390023085303/0001213900-23-085303-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ATNM'
ON CONFLICT (accession_number) DO NOTHING;

-- VRCA: Verrica Pharmaceuticals Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Verrica Pharmaceuticals Inc.', 'VRCA', '0001660334', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/1660334/000119312525087838/0001193125-25-087838-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VRCA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-19', 'https://www.sec.gov/Archives/edgar/data/1660334/000119312524101650/0001193125-24-101650-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VRCA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-21', 'https://www.sec.gov/Archives/edgar/data/1660334/000119312523109424/0001193125-23-109424-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VRCA'
ON CONFLICT (accession_number) DO NOTHING;

-- LSBCF: LakeShore Biopharma Co., Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LakeShore Biopharma Co., Ltd.', 'LSBCF', '0001946399', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GBIO: Generation Bio Co.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Generation Bio Co.', 'GBIO', '0001733294', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-23', 'https://www.sec.gov/Archives/edgar/data/1733294/000155837025005263/0001558370-25-005263-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GBIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-24', 'https://www.sec.gov/Archives/edgar/data/1733294/000155837024005582/0001558370-24-005582-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GBIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-26', 'https://www.sec.gov/Archives/edgar/data/1733294/000155837023006830/0001558370-23-006830-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GBIO'
ON CONFLICT (accession_number) DO NOTHING;

-- LTRN: Lantern Pharma Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Lantern Pharma Inc.', 'LTRN', '0001763950', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-08', 'https://www.sec.gov/Archives/edgar/data/1763950/000164117225022820/0001641172-25-022820-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LTRN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1763950/000149315224016840/0001493152-24-016840-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LTRN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1763950/000149315223013927/0001493152-23-013927-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LTRN'
ON CONFLICT (accession_number) DO NOTHING;

-- MAIA: MAIA Biotechnology, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MAIA Biotechnology, Inc.', 'MAIA', '0001878313', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-08', 'https://www.sec.gov/Archives/edgar/data/1878313/000114036125012689/0001140361-25-012689-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MAIA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-16', 'https://www.sec.gov/Archives/edgar/data/1878313/000114036124020060/0001140361-24-020060-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MAIA'
ON CONFLICT (accession_number) DO NOTHING;

-- HRGN: Harvard Apparatus Regenerative Technology, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Harvard Apparatus Regenerative Technology, Inc.', 'HRGN', '0001563665', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1563665/000143774925013477/0001437749-25-013477-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HRGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1563665/000149315224016866/0001493152-24-016866-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HRGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-06-05', 'https://www.sec.gov/Archives/edgar/data/1563665/000149315223020090/0001493152-23-020090-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HRGN'
ON CONFLICT (accession_number) DO NOTHING;

-- APUS: Apimeds Pharmaceuticals US, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Apimeds Pharmaceuticals US, Inc.', 'APUS', '0001894525', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PVCT: PROVECTUS BIOPHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'PROVECTUS BIOPHARMACEUTICALS, INC.', 'PVCT', '0000315545', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-01', 'https://www.sec.gov/Archives/edgar/data/315545/000164117225007928/0001641172-25-007928-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PVCT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-06', 'https://www.sec.gov/Archives/edgar/data/315545/000149315224017882/0001493152-24-017882-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PVCT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-01', 'https://www.sec.gov/Archives/edgar/data/315545/000149315223014910/0001493152-23-014910-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PVCT'
ON CONFLICT (accession_number) DO NOTHING;

-- IGC: IGC Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'IGC Pharma, Inc.', 'IGC', '0001326205', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-18', 'https://www.sec.gov/Archives/edgar/data/1326205/000118518525001021/0001185185-25-001021-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IGC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-08', 'https://www.sec.gov/Archives/edgar/data/1326205/000118518524000674/0001185185-24-000674-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IGC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-26', 'https://www.sec.gov/Archives/edgar/data/1326205/000118518523000759/0001185185-23-000759-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'IGC'
ON CONFLICT (accession_number) DO NOTHING;

-- CPIX: CUMBERLAND PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CUMBERLAND PHARMACEUTICALS INC', 'CPIX', '0001087294', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-10', 'https://www.sec.gov/Archives/edgar/data/1087294/000162828025011735/0001628280-25-011735-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CPIX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-13', 'https://www.sec.gov/Archives/edgar/data/1087294/000162828024010960/0001628280-24-010960-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CPIX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-15', 'https://www.sec.gov/Archives/edgar/data/1087294/000162828023007954/0001628280-23-007954-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CPIX'
ON CONFLICT (accession_number) DO NOTHING;

-- LIMN: Liminatus Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Liminatus Pharma, Inc.', 'LIMN', '0001971387', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PYRGF: PyroGenesis Canada Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'PyroGenesis Canada Inc.', 'PYRGF', '0001743344', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- WNDW: SolarWindow Technologies, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SolarWindow Technologies, Inc.', 'WNDW', '0001071840', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SIDU: Sidus Space Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Sidus Space Inc.', 'SIDU', '0001879726', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1879726/000164117225006530/0001641172-25-006530-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SIDU'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-30', 'https://www.sec.gov/Archives/edgar/data/1879726/000149315224017098/0001493152-24-017098-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SIDU'
ON CONFLICT (accession_number) DO NOTHING;

-- LIXT: LIXTE BIOTECHNOLOGY HOLDINGS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIXTE BIOTECHNOLOGY HOLDINGS, INC.', 'LIXT', '0001335105', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-27', 'https://www.sec.gov/Archives/edgar/data/1335105/000149315225019697/0001493152-25-019697-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIXT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-05', 'https://www.sec.gov/Archives/edgar/data/1335105/000149315224043583/0001493152-24-043583-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIXT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-10', 'https://www.sec.gov/Archives/edgar/data/1335105/000149315223036718/0001493152-23-036718-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIXT'
ON CONFLICT (accession_number) DO NOTHING;

-- QNTM: Quantum Biopharma Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantum Biopharma Ltd.', 'QNTM', '0001771885', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PN: Skycorp Solar Group Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Skycorp Solar Group Ltd', 'PN', '0002001288', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GREE: Greenidge Generation Holdings Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Greenidge Generation Holdings Inc.', 'GREE', '0001844971', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1844971/000119380525000565/0001193805-25-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GREE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1844971/000162828024018969/0001628280-24-018969-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GREE'
ON CONFLICT (accession_number) DO NOTHING;

-- AYTU: AYTU BIOPHARMA, INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'AYTU BIOPHARMA, INC', 'AYTU', '0001385818', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-24', 'https://www.sec.gov/Archives/edgar/data/1385818/000143774925031719/0001437749-25-031719-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AYTU'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-28', 'https://www.sec.gov/Archives/edgar/data/1385818/000143774925009836/0001437749-25-009836-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AYTU'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-10', 'https://www.sec.gov/Archives/edgar/data/1385818/000143774924016003/0001437749-24-016003-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AYTU'
ON CONFLICT (accession_number) DO NOTHING;

-- RAPH: Raphael Pharmaceutical Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Raphael Pharmaceutical Inc.', 'RAPH', '0001415397', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CASI: CASI Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CASI Pharmaceuticals, Inc.', 'CASI', '0001962738', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- EVOK: Evoke Pharma Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Evoke Pharma Inc', 'EVOK', '0001403708', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-10', 'https://www.sec.gov/Archives/edgar/data/1403708/000095017025052873/0000950170-25-052873-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'EVOK'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-10', 'https://www.sec.gov/Archives/edgar/data/1403708/000095017024043306/0000950170-24-043306-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'EVOK'
ON CONFLICT (accession_number) DO NOTHING;

-- CTXR: Citius Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Citius Pharmaceuticals, Inc.', 'CTXR', '0001506251', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1506251/000121390025035755/0001213900-25-035755-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CTXR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-01-27', 'https://www.sec.gov/Archives/edgar/data/1506251/000121390025006984/0001213900-25-006984-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CTXR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-01-26', 'https://www.sec.gov/Archives/edgar/data/1506251/000121390024006971/0001213900-24-006971-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CTXR'
ON CONFLICT (accession_number) DO NOTHING;

-- ATHA: Athira Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Athira Pharma, Inc.', 'ATHA', '0001620463', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-14', 'https://www.sec.gov/Archives/edgar/data/1620463/000114036125013769/0001140361-25-013769-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ATHA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-09', 'https://www.sec.gov/Archives/edgar/data/1620463/000114036124018750/0001140361-24-018750-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ATHA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-05', 'https://www.sec.gov/Archives/edgar/data/1620463/000114036123016527/0001140361-23-016527-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ATHA'
ON CONFLICT (accession_number) DO NOTHING;

-- AITX: Artificial Intelligence Technology Solutions Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Artificial Intelligence Technology Solutions Inc.', 'AITX', '0001498148', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- AAQL: Antiaging Quantum Living Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Antiaging Quantum Living Inc.', 'AAQL', '0001672571', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TRAW: Traws Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Traws Pharma, Inc.', 'TRAW', '0001130598', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-08', 'https://www.sec.gov/Archives/edgar/data/1130598/000110465925097926/0001104659-25-097926-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TRAW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-02-06', 'https://www.sec.gov/Archives/edgar/data/1130598/000110465925010117/0001104659-25-010117-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TRAW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-11', 'https://www.sec.gov/Archives/edgar/data/1130598/000110465924107822/0001104659-24-107822-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TRAW'
ON CONFLICT (accession_number) DO NOTHING;

-- BLTH: AMERICAN BATTERY MATERIALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'AMERICAN BATTERY MATERIALS, INC.', 'BLTH', '0001487718', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- QNRX: Quoin Pharmaceuticals, Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quoin Pharmaceuticals, Ltd.', 'QNRX', '0001671502', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-17', 'https://www.sec.gov/Archives/edgar/data/1671502/000110465925068650/0001104659-25-068650-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QNRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-24', 'https://www.sec.gov/Archives/edgar/data/1671502/000110465924111010/0001104659-24-111010-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QNRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-27', 'https://www.sec.gov/Archives/edgar/data/1671502/000110465924027788/0001104659-24-027788-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QNRX'
ON CONFLICT (accession_number) DO NOTHING;

-- PCSA: Processa Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Processa Pharmaceuticals, Inc.', 'PCSA', '0001533743', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-13', 'https://www.sec.gov/Archives/edgar/data/1533743/000149315225011883/0001493152-25-011883-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PCSA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-12', 'https://www.sec.gov/Archives/edgar/data/1533743/000164117225009671/0001641172-25-009671-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PCSA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1533743/000149315224016998/0001493152-24-016998-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PCSA'
ON CONFLICT (accession_number) DO NOTHING;

-- NEWH: NewHydrogen, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NewHydrogen, Inc.', 'NEWH', '0001371128', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- BNGO: Bionano Genomics, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Bionano Genomics, Inc.', 'BNGO', '0001411690', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1411690/000114036125016025/0001140361-25-016025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BNGO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-12-05', 'https://www.sec.gov/Archives/edgar/data/1411690/000114036124048499/0001140361-24-048499-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BNGO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-08-21', 'https://www.sec.gov/Archives/edgar/data/1411690/000114036124038087/0001140361-24-038087-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BNGO'
ON CONFLICT (accession_number) DO NOTHING;

-- KAPA: Kairos Pharma, LTD.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Kairos Pharma, LTD.', 'KAPA', '0001962011', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-01', 'https://www.sec.gov/Archives/edgar/data/1962011/000164117225007922/0001641172-25-007922-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KAPA'
ON CONFLICT (accession_number) DO NOTHING;

-- ZSPC: zSpace, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'zSpace, Inc.', 'ZSPC', '0001637147', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-02', 'https://www.sec.gov/Archives/edgar/data/1637147/000110465925086357/0001104659-25-086357-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ZSPC'
ON CONFLICT (accession_number) DO NOTHING;

-- PHIO: Phio Pharmaceuticals Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Phio Pharmaceuticals Corp.', 'PHIO', '0001533040', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-30', 'https://www.sec.gov/Archives/edgar/data/1533040/000168316825005520/0001683168-25-005520-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PHIO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-08', 'https://www.sec.gov/Archives/edgar/data/1533040/000168316824003113/0001683168-24-003113-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PHIO'
ON CONFLICT (accession_number) DO NOTHING;

-- COCP: Cocrystal Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Cocrystal Pharma, Inc.', 'COCP', '0001412486', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-05', 'https://www.sec.gov/Archives/edgar/data/1412486/000164117225008692/0001641172-25-008692-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'COCP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-07', 'https://www.sec.gov/Archives/edgar/data/1412486/000149315224018105/0001493152-24-018105-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'COCP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1412486/000149315223014678/0001493152-23-014678-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'COCP'
ON CONFLICT (accession_number) DO NOTHING;

-- PBSV: Pharma-Bio Serv, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Pharma-Bio Serv, Inc.', 'PBSV', '0001304161', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-21', 'https://www.sec.gov/Archives/edgar/data/1304161/000165495425004485/0001654954-25-004485-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PBSV'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-08', 'https://www.sec.gov/Archives/edgar/data/1304161/000165495424004363/0001654954-24-004363-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PBSV'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-05-01', 'https://www.sec.gov/Archives/edgar/data/1304161/000165495423005509/0001654954-23-005509-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PBSV'
ON CONFLICT (accession_number) DO NOTHING;

-- TNMG: TNL Mediagene
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TNL Mediagene', 'TNMG', '0002013186', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CURX: Curanex Pharmaceuticals Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Curanex Pharmaceuticals Inc', 'CURX', '0002025942', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HKPD: Hong Kong Pharma Digital Technology Holdings Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Hong Kong Pharma Digital Technology Holdings Ltd', 'HKPD', '0002007702', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- DUKR: DUKE Robotics Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'DUKE Robotics Corp.', 'DUKR', '0001638911', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PPCB: Propanc Biopharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Propanc Biopharma, Inc.', 'PPCB', '0001517681', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- EVGN: Evogene Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Evogene Ltd.', 'EVGN', '0001574565', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- INBP: INTEGRATED BIOPHARMA INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'INTEGRATED BIOPHARMA INC', 'INBP', '0001016504', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-28', 'https://www.sec.gov/Archives/edgar/data/1016504/000143774925031864/0001437749-25-031864-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INBP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-28', 'https://www.sec.gov/Archives/edgar/data/1016504/000143774924032295/0001437749-24-032295-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INBP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-27', 'https://www.sec.gov/Archives/edgar/data/1016504/000143774923029180/0001437749-23-029180-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INBP'
ON CONFLICT (accession_number) DO NOTHING;

-- AEON: AEON Biopharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'AEON Biopharma, Inc.', 'AEON', '0001837607', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1837607/000183760725000035/0001837607-25-000035-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AEON'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-01-23', 'https://www.sec.gov/Archives/edgar/data/1837607/000183760725000007/0001837607-25-000007-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AEON'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1837607/000183760724000042/0001837607-24-000042-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AEON'
ON CONFLICT (accession_number) DO NOTHING;

-- STSBF: South Star Battery Metals Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'South Star Battery Metals Corp.', 'STSBF', '0001307926', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ACXP: Acurx Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Acurx Pharmaceuticals, Inc.', 'ACXP', '0001736243', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-04', 'https://www.sec.gov/Archives/edgar/data/1736243/000110465925073623/0001104659-25-073623-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ACXP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-29', 'https://www.sec.gov/Archives/edgar/data/1736243/000110465925054235/0001104659-25-054235-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ACXP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1736243/000110465924054014/0001104659-24-054014-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ACXP'
ON CONFLICT (accession_number) DO NOTHING;

-- CPHI: CHINA PHARMA HOLDINGS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CHINA PHARMA HOLDINGS, INC.', 'CPHI', '0001106644', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-14', 'https://www.sec.gov/Archives/edgar/data/1106644/000121390025110882/0001213900-25-110882-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CPHI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-12', 'https://www.sec.gov/Archives/edgar/data/1106644/000121390024096780/0001213900-24-096780-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CPHI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-11-07', 'https://www.sec.gov/Archives/edgar/data/1106644/000121390023084279/0001213900-23-084279-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CPHI'
ON CONFLICT (accession_number) DO NOTHING;

-- BGLC: BioNexus Gene Lab Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'BioNexus Gene Lab Corp', 'BGLC', '0001737523', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-02-27', 'https://www.sec.gov/Archives/edgar/data/1737523/000147793225001335/0001477932-25-001335-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BGLC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-09-16', 'https://www.sec.gov/Archives/edgar/data/1737523/000147793224005760/0001477932-24-005760-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BGLC'
ON CONFLICT (accession_number) DO NOTHING;

-- GTBP: GT Biopharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GT Biopharma, Inc.', 'GTBP', '0000109657', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-06-11', 'https://www.sec.gov/Archives/edgar/data/109657/000164117225014721/0001641172-25-014721-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GTBP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/109657/000149315224016949/0001493152-24-016949-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GTBP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-11-06', 'https://www.sec.gov/Archives/edgar/data/109657/000149315223039585/0001493152-23-039585-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GTBP'
ON CONFLICT (accession_number) DO NOTHING;

-- ADIL: ADIAL PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ADIAL PHARMACEUTICALS, INC.', 'ADIL', '0001513525', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-06-10', 'https://www.sec.gov/Archives/edgar/data/1513525/000121390025053170/0001213900-25-053170-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ADIL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-09-27', 'https://www.sec.gov/Archives/edgar/data/1513525/000121390024082805/0001213900-24-082805-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ADIL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-12-08', 'https://www.sec.gov/Archives/edgar/data/1513525/000121390023094155/0001213900-23-094155-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ADIL'
ON CONFLICT (accession_number) DO NOTHING;

-- CANF: Can-Fite BioPharma Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Can-Fite BioPharma Ltd.', 'CANF', '0001536196', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- XTLB: XTL BIOPHARMACEUTICALS LTD
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'XTL BIOPHARMACEUTICALS LTD', 'XTLB', '0001023549', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SBFM: Sunshine Biopharma Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Sunshine Biopharma Inc.', 'SBFM', '0001402328', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-23', 'https://www.sec.gov/Archives/edgar/data/1402328/000168316825007747/0001683168-25-007747-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SBFM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-17', 'https://www.sec.gov/Archives/edgar/data/1402328/000168316824007196/0001683168-24-007196-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SBFM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-18', 'https://www.sec.gov/Archives/edgar/data/1402328/000168316823007244/0001683168-23-007244-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SBFM'
ON CONFLICT (accession_number) DO NOTHING;

-- FRSX: Foresight Autonomous Holdings Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Foresight Autonomous Holdings Ltd.', 'FRSX', '0001691221', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- NYMXF: NYMOX PHARMACEUTICAL CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NYMOX PHARMACEUTICAL CORP', 'NYMXF', '0001018735', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- KPRX: KIORA PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'KIORA PHARMACEUTICALS INC', 'KPRX', '0001372514', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1372514/000137251425000038/0001372514-25-000038-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KPRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-25', 'https://www.sec.gov/Archives/edgar/data/1372514/000137251424000030/0001372514-24-000030-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KPRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-21', 'https://www.sec.gov/Archives/edgar/data/1372514/000137251423000110/0001372514-23-000110-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KPRX'
ON CONFLICT (accession_number) DO NOTHING;

-- SNOA: Sonoma Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Sonoma Pharmaceuticals, Inc.', 'SNOA', '0001367083', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-11', 'https://www.sec.gov/Archives/edgar/data/1367083/000168316825005049/0001683168-25-005049-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SNOA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-01', 'https://www.sec.gov/Archives/edgar/data/1367083/000168316824004552/0001683168-24-004552-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SNOA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-27', 'https://www.sec.gov/Archives/edgar/data/1367083/000168316823005122/0001683168-23-005122-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SNOA'
ON CONFLICT (accession_number) DO NOTHING;

-- MTNB: Matinas BioPharma Holdings, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Matinas BioPharma Holdings, Inc.', 'MTNB', '0001582554', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-12', 'https://www.sec.gov/Archives/edgar/data/1582554/000164117225009754/0001641172-25-009754-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MTNB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-03', 'https://www.sec.gov/Archives/edgar/data/1582554/000149315225008921/0001493152-25-008921-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MTNB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-09-19', 'https://www.sec.gov/Archives/edgar/data/1582554/000149315223033102/0001493152-23-033102-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MTNB'
ON CONFLICT (accession_number) DO NOTHING;

-- GIPR: GENERATION INCOME PROPERTIES, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERATION INCOME PROPERTIES, INC.', 'GIPR', '0001651721', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-07', 'https://www.sec.gov/Archives/edgar/data/1651721/000119312525272581/0001193125-25-272581-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIPR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-17', 'https://www.sec.gov/Archives/edgar/data/1651721/000095017024115299/0000950170-24-115299-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIPR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-02', 'https://www.sec.gov/Archives/edgar/data/1651721/000095017023050931/0000950170-23-050931-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIPR'
ON CONFLICT (accession_number) DO NOTHING;

-- KITT: Nauticus Robotics, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Nauticus Robotics, Inc.', 'KITT', '0001849820', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-25', 'https://www.sec.gov/Archives/edgar/data/1849820/000184982025000242/0001849820-25-000242-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KITT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1849820/000184982025000120/0001849820-25-000120-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KITT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-25', 'https://www.sec.gov/Archives/edgar/data/1849820/000184982024000272/0001849820-24-000272-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KITT'
ON CONFLICT (accession_number) DO NOTHING;

-- VEST: Loan Artificial Intelligence Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Loan Artificial Intelligence Corp.', 'VEST', '0001594968', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ASTI: Ascent Solar Technologies, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Ascent Solar Technologies, Inc.', 'ASTI', '0001350102', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1350102/000107997325000719/0001079973-25-000719-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASTI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-06-20', 'https://www.sec.gov/Archives/edgar/data/1350102/000107997324000919/0001079973-24-000919-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASTI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-23', 'https://www.sec.gov/Archives/edgar/data/1350102/000107997323001475/0001079973-23-001475-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASTI'
ON CONFLICT (accession_number) DO NOTHING;

-- SILO: Silo Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Silo Pharma, Inc.', 'SILO', '0001514183', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-05', 'https://www.sec.gov/Archives/edgar/data/1514183/000121390025085119/0001213900-25-085119-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SILO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-09-18', 'https://www.sec.gov/Archives/edgar/data/1514183/000121390024079883/0001213900-24-079883-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SILO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-23', 'https://www.sec.gov/Archives/edgar/data/1514183/000101376223005850/0001013762-23-005850-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SILO'
ON CONFLICT (accession_number) DO NOTHING;

-- ASBP: Aspire Biopharma Holdings, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Aspire Biopharma Holdings, Inc.', 'ASBP', '0001847345', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-23', 'https://www.sec.gov/Archives/edgar/data/1847345/000149315225014523/0001493152-25-014523-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASBP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-01', 'https://www.sec.gov/Archives/edgar/data/1847345/000149315224017415/0001493152-24-017415-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASBP'
ON CONFLICT (accession_number) DO NOTHING;

-- BETRF: BetterLife Pharma Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'BetterLife Pharma Inc.', 'BETRF', '0001464165', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GLMD: Galmed Pharmaceuticals Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Galmed Pharmaceuticals Ltd.', 'GLMD', '0001595353', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SLRX: Salarius Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Salarius Pharmaceuticals, Inc.', 'SLRX', '0001615219', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-07', 'https://www.sec.gov/Archives/edgar/data/1615219/000161521925000152/0001615219-25-000152-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SLRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-27', 'https://www.sec.gov/Archives/edgar/data/1615219/000161521925000057/0001615219-25-000057-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SLRX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-15', 'https://www.sec.gov/Archives/edgar/data/1615219/000161521925000051/0001615219-25-000051-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SLRX'
ON CONFLICT (accession_number) DO NOTHING;

-- PMCB: PharmaCyte Biotech, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'PharmaCyte Biotech, Inc.', 'PMCB', '0001157075', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-06', 'https://www.sec.gov/Archives/edgar/data/1157075/000168316825007435/0001683168-25-007435-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PMCB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-10', 'https://www.sec.gov/Archives/edgar/data/1157075/000168316825001464/0001683168-25-001464-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PMCB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-27', 'https://www.sec.gov/Archives/edgar/data/1157075/000168316824001762/0001683168-24-001762-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PMCB'
ON CONFLICT (accession_number) DO NOTHING;

-- SXTP: 60 DEGREES PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    '60 DEGREES PHARMACEUTICALS, INC.', 'SXTP', '0001946563', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-27', 'https://www.sec.gov/Archives/edgar/data/1946563/000121390025080878/0001213900-25-080878-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SXTP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-15', 'https://www.sec.gov/Archives/edgar/data/1946563/000121390024087749/0001213900-24-087749-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SXTP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-30', 'https://www.sec.gov/Archives/edgar/data/1946563/000121390024047861/0001213900-24-047861-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SXTP'
ON CONFLICT (accession_number) DO NOTHING;

-- ENZN: ENZON PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ENZON PHARMACEUTICALS, INC.', 'ENZN', '0000727510', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-08-08', 'https://www.sec.gov/Archives/edgar/data/727510/000110465924087308/0001104659-24-087308-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENZN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/727510/000110465923047865/0001104659-23-047865-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENZN'
ON CONFLICT (accession_number) DO NOTHING;

-- ORGS: Orgenesis Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Orgenesis Inc.', 'ORGS', '0001460602', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-06', 'https://www.sec.gov/Archives/edgar/data/1460602/000149315224017896/0001493152-24-017896-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORGS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-21', 'https://www.sec.gov/Archives/edgar/data/1460602/000149315223013185/0001493152-23-013185-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORGS'
ON CONFLICT (accession_number) DO NOTHING;

-- CNSP: CNS Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CNS Pharmaceuticals, Inc.', 'CNSP', '0001729427', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-24', 'https://www.sec.gov/Archives/edgar/data/1729427/000168316825007760/0001683168-25-007760-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CNSP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-28', 'https://www.sec.gov/Archives/edgar/data/1729427/000168316824007416/0001683168-24-007416-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CNSP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-10', 'https://www.sec.gov/Archives/edgar/data/1729427/000168316824002244/0001683168-24-002244-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CNSP'
ON CONFLICT (accession_number) DO NOTHING;

-- INM: InMed Pharmaceuticals Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'InMed Pharmaceuticals Inc.', 'INM', '0001728328', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-03', 'https://www.sec.gov/Archives/edgar/data/1728328/000121390025104914/0001213900-25-104914-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-16', 'https://www.sec.gov/Archives/edgar/data/1728328/000121390025044948/0001213900-25-044948-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-28', 'https://www.sec.gov/Archives/edgar/data/1728328/000121390024091222/0001213900-24-091222-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'INM'
ON CONFLICT (accession_number) DO NOTHING;

-- RDHL: RedHill Biopharma Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'RedHill Biopharma Ltd.', 'RDHL', '0001553846', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CPMD: CANNAPHARMARX, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CANNAPHARMARX, INC.', 'CPMD', '0001081938', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SHPH: Shuttle Pharmaceuticals Holdings, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Shuttle Pharmaceuticals Holdings, Inc.', 'SHPH', '0001757499', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-06', 'https://www.sec.gov/Archives/edgar/data/1757499/000164117225008884/0001641172-25-008884-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SHPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-31', 'https://www.sec.gov/Archives/edgar/data/1757499/000164117225001889/0001641172-25-001889-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SHPH'
ON CONFLICT (accession_number) DO NOTHING;

-- BDRX: Biodexa Pharmaceuticals Plc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Biodexa Pharmaceuticals Plc', 'BDRX', '0001643918', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- UPC: Universe Pharmaceuticals INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Universe Pharmaceuticals INC', 'UPC', '0001809616', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- LIPO: LIPELLA PHARMACEUTICALS INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIPELLA PHARMACEUTICALS INC.', 'LIPO', '0001347242', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-12', 'https://www.sec.gov/Archives/edgar/data/1347242/000175392624001848/0001753926-24-001848-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIPO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-08-12', 'https://www.sec.gov/Archives/edgar/data/1347242/000175392624001391/0001753926-24-001391-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIPO'
ON CONFLICT (accession_number) DO NOTHING;

-- PTOS: P2 Solar, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'P2 Solar, Inc.', 'PTOS', '0001172069', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-26', 'https://www.sec.gov/Archives/edgar/data/1172069/000164033425000491/0001640334-25-000491-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PTOS'
ON CONFLICT (accession_number) DO NOTHING;

-- HEPA: Hepion Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Hepion Pharmaceuticals, Inc.', 'HEPA', '0001583771', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1583771/000164117225006440/0001641172-25-006440-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HEPA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-02-07', 'https://www.sec.gov/Archives/edgar/data/1583771/000149315225005322/0001493152-25-005322-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HEPA'
ON CONFLICT (accession_number) DO NOTHING;

-- RMTG: Regenerative Medical Technology Group Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Regenerative Medical Technology Group Inc.', 'RMTG', '0001760026', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- NGCG: New Generation Consumer Group, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'New Generation Consumer Group, Inc.', 'NGCG', '0001061040', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PTPI: Petros Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Petros Pharmaceuticals, Inc.', 'PTPI', '0001815903', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-18', 'https://www.sec.gov/Archives/edgar/data/1815903/000110465925025104/0001104659-25-025104-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PTPI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-25', 'https://www.sec.gov/Archives/edgar/data/1815903/000110465924111512/0001104659-24-111512-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PTPI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-11-30', 'https://www.sec.gov/Archives/edgar/data/1815903/000110465923122417/0001104659-23-122417-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PTPI'
ON CONFLICT (accession_number) DO NOTHING;

-- RGBP: Regen BioPharma Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Regen BioPharma Inc', 'RGBP', '0001589150', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- VINC: Vincerx Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Vincerx Pharma, Inc.', 'VINC', '0001796129', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-12', 'https://www.sec.gov/Archives/edgar/data/1796129/000119312525117863/0001193125-25-117863-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VINC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-12-10', 'https://www.sec.gov/Archives/edgar/data/1796129/000119312524274329/0001193125-24-274329-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VINC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-08', 'https://www.sec.gov/Archives/edgar/data/1796129/000119312524176281/0001193125-24-176281-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VINC'
ON CONFLICT (accession_number) DO NOTHING;

-- CNBX: CNBX Pharmaceuticals Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CNBX Pharmaceuticals Inc.', 'CNBX', '0001343009', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ILPLF: Island Pharmaceuticals Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Island Pharmaceuticals Ltd', 'ILPLF', '0002012855', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SSTR: Solar Strategy Holdings Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Solar Strategy Holdings Ltd', 'SSTR', '0002067602', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GLSA: Green Solar Energy Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Green Solar Energy Ltd', 'GLSA', '0002040733', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HNPHY: Hansoh Pharmaceutical Group Co Limited/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Hansoh Pharmaceutical Group Co Limited/ADR', 'HNPHY', '0002073669', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TSM: TAIWAN SEMICONDUCTOR MANUFACTURING CO LTD
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TAIWAN SEMICONDUCTOR MANUFACTURING CO LTD', 'TSM', '0001046179', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RVPHW: REVIVA PHARMACEUTICALS HOLDINGS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'REVIVA PHARMACEUTICALS HOLDINGS, INC.', 'RVPHW', '0001742927', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-04', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774925033023/0001437749-25-033023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPHW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-28', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774924032297/0001437749-24-032297-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPHW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-04', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774923027676/0001437749-23-027676-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPHW'
ON CONFLICT (accession_number) DO NOTHING;

-- UHL: UNITED HYDROGEN GLOBAL INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'UNITED HYDROGEN GLOBAL INC.', 'UHL', '0002032241', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- INNP: INNOCAN PHARMA Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'INNOCAN PHARMA Corp', 'INNP', '0001889791', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CBPHF: Clover Biopharmaceuticals, Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Clover Biopharmaceuticals, Ltd.', 'CBPHF', '0001856491', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- JHPCY: Jiangsu Hengrui Pharmaceuticals Co., Ltd./ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Jiangsu Hengrui Pharmaceuticals Co., Ltd./ADR', 'JHPCY', '0002071868', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HZRBY: Horizon Robotics, Inc./ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Robotics, Inc./ADR', 'HZRBY', '0002060217', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TSMWF: TAIWAN SEMICONDUCTOR MANUFACTURING CO LTD
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TAIWAN SEMICONDUCTOR MANUFACTURING CO LTD', 'TSMWF', '0001046179', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TKPHF: TAKEDA PHARMACEUTICAL CO LTD
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TAKEDA PHARMACEUTICAL CO LTD', 'TKPHF', '0001395064', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TEVJF: TEVA PHARMACEUTICAL INDUSTRIES LTD
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TEVA PHARMACEUTICAL INDUSTRIES LTD', 'TEVJF', '0000818686', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-09', 'https://www.sec.gov/Archives/edgar/data/818686/000119312525076829/0001193125-25-076829-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TEVJF'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-16', 'https://www.sec.gov/Archives/edgar/data/818686/000119312524097745/0001193125-24-097745-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TEVJF'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-19', 'https://www.sec.gov/Archives/edgar/data/818686/000119312523106453/0001193125-23-106453-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TEVJF'
ON CONFLICT (accession_number) DO NOTHING;

-- ZLDPF: Zealand Pharma A/S/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Zealand Pharma A/S/ADR', 'ZLDPF', '0002068427', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GAM-PB: GENERAL AMERICAN INVESTORS CO INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERAL AMERICAN INVESTORS CO INC', 'GAM-PB', '0000040417', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-02-24', 'https://www.sec.gov/Archives/edgar/data/40417/000183988225010653/0001839882-25-010653-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GAM-PB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-20', 'https://www.sec.gov/Archives/edgar/data/40417/000199937124002520/0001999371-24-002520-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GAM-PB'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-18', 'https://www.sec.gov/Archives/edgar/data/40417/000138713123004818/0001387131-23-004818-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GAM-PB'
ON CONFLICT (accession_number) DO NOTHING;

-- IPHYF: Innate Pharma SA
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Innate Pharma SA', 'IPHYF', '0001598599', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RGBPP: Regen BioPharma Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Regen BioPharma Inc', 'RGBPP', '0001589150', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RVPH: REVIVA PHARMACEUTICALS HOLDINGS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'REVIVA PHARMACEUTICALS HOLDINGS, INC.', 'RVPH', '0001742927', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-04', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774925033023/0001437749-25-033023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-28', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774924032297/0001437749-24-032297-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-04', 'https://www.sec.gov/Archives/edgar/data/1742927/000143774923027676/0001437749-23-027676-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RVPH'
ON CONFLICT (accession_number) DO NOTHING;

-- GBNY: Generations Bancorp NY, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Generations Bancorp NY, Inc.', 'GBNY', '0001823365', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-12', 'https://www.sec.gov/Archives/edgar/data/1823365/000155837024005015/0001558370-24-005015-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GBNY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-14', 'https://www.sec.gov/Archives/edgar/data/1823365/000155837023005956/0001558370-23-005956-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GBNY'
ON CONFLICT (accession_number) DO NOTHING;

-- IMUC: EOM Pharmaceutical Holdings, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'EOM Pharmaceutical Holdings, Inc.', 'IMUC', '0000822411', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GSTX: Graphene & Solar Technologies Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Graphene & Solar Technologies Ltd', 'GSTX', '0001497649', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CUBT: Curative Biotechnology Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Curative Biotechnology Inc', 'CUBT', '0001400271', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HOOK: HOOKIPA Pharma Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'HOOKIPA Pharma Inc.', 'HOOK', '0001760542', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1760542/000110465924052900/0001104659-24-052900-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HOOK'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-13', 'https://www.sec.gov/Archives/edgar/data/1760542/000110465923045017/0001104659-23-045017-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HOOK'
ON CONFLICT (accession_number) DO NOTHING;

-- AGNPF: Algernon Pharmaceuticals Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Algernon Pharmaceuticals Inc.', 'AGNPF', '0001642178', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PHBI: Pharmagreen Biotech Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Pharmagreen Biotech Inc.', 'PHBI', '0001435181', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- PLPL: Plandai Biotechnology, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Plandai Biotechnology, Inc.', 'PLPL', '0001317880', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ARBEW: Arbe Robotics Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Arbe Robotics Ltd.', 'ARBEW', '0001861841', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- LIMNW: Liminatus Pharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Liminatus Pharma, Inc.', 'LIMNW', '0001971387', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RGPX: REGENEREX PHARMA, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'REGENEREX PHARMA, INC.', 'RGPX', '0001357878', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ARQQW: Arqit Quantum Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Arqit Quantum Inc.', 'ARQQW', '0001859690', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HSPTR: Horizon Space Acquisition II Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition II Corp.', 'HSPTR', '0002032950', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HSPTU: Horizon Space Acquisition II Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition II Corp.', 'HSPTU', '0002032950', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SBFMW: Sunshine Biopharma Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Sunshine Biopharma Inc.', 'SBFMW', '0001402328', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-23', 'https://www.sec.gov/Archives/edgar/data/1402328/000168316825007747/0001683168-25-007747-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SBFMW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-17', 'https://www.sec.gov/Archives/edgar/data/1402328/000168316824007196/0001683168-24-007196-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SBFMW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-18', 'https://www.sec.gov/Archives/edgar/data/1402328/000168316823007244/0001683168-23-007244-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SBFMW'
ON CONFLICT (accession_number) DO NOTHING;

-- QSIAW: Quantum-Si Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantum-Si Inc', 'QSIAW', '0001816431', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-20', 'https://www.sec.gov/Archives/edgar/data/1816431/000181643125000024/0001816431-25-000024-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QSIAW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-01', 'https://www.sec.gov/Archives/edgar/data/1816431/000114036124016945/0001140361-24-016945-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QSIAW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-29', 'https://www.sec.gov/Archives/edgar/data/1816431/000114036123014533/0001140361-23-014533-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'QSIAW'
ON CONFLICT (accession_number) DO NOTHING;

-- TLPPF: Telix Pharmaceuticals Ltd
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Telix Pharmaceuticals Ltd', 'TLPPF', '0002007191', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- QUMSU: Quantumsphere Acquisition Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantumsphere Acquisition Corp', 'QUMSU', '0002070900', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- QUMSR: Quantumsphere Acquisition Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Quantumsphere Acquisition Corp', 'QUMSR', '0002070900', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ASBPW: Aspire Biopharma Holdings, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Aspire Biopharma Holdings, Inc.', 'ASBPW', '0001847345', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-23', 'https://www.sec.gov/Archives/edgar/data/1847345/000149315225014523/0001493152-25-014523-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASBPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-01', 'https://www.sec.gov/Archives/edgar/data/1847345/000149315224017415/0001493152-24-017415-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ASBPW'
ON CONFLICT (accession_number) DO NOTHING;

-- TNMWF: TNL Mediagene
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TNL Mediagene', 'TNMWF', '0002013186', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- VLN-WT: Valens Semiconductor Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Valens Semiconductor Ltd.', 'VLN-WT', '0001863006', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- MCHPP: MICROCHIP TECHNOLOGY INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MICROCHIP TECHNOLOGY INC', 'MCHPP', '0000827054', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-07-07', 'https://www.sec.gov/Archives/edgar/data/827054/000082705425000099/0000827054-25-000099-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCHPP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-07-08', 'https://www.sec.gov/Archives/edgar/data/827054/000082705424000128/0000827054-24-000128-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCHPP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-07', 'https://www.sec.gov/Archives/edgar/data/827054/000082705423000104/0000827054-23-000104-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MCHPP'
ON CONFLICT (accession_number) DO NOTHING;

-- BDTB: Bodhi Tree Biotechnology Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Bodhi Tree Biotechnology Inc', 'BDTB', '0002041531', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ESLAW: Estrella Immunopharma, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Estrella Immunopharma, Inc.', 'ESLAW', '0001844417', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-06-16', 'https://www.sec.gov/Archives/edgar/data/1844417/000157587223000970/0001575872-23-000970-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ESLAW'
ON CONFLICT (accession_number) DO NOTHING;

-- ENGNW: enGene Holdings Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'enGene Holdings Inc.', 'ENGNW', '0001980845', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-09', 'https://www.sec.gov/Archives/edgar/data/1980845/000114036125018155/0001140361-25-018155-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENGNW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-18', 'https://www.sec.gov/Archives/edgar/data/1980845/000095017024045297/0000950170-24-045297-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ENGNW'
ON CONFLICT (accession_number) DO NOTHING;

-- GCTS-WT: GCT Semiconductor Holding, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GCT Semiconductor Holding, Inc.', 'GCTS-WT', '0001851961', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-04', 'https://www.sec.gov/Archives/edgar/data/1851961/000095017025102009/0000950170-25-102009-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GCTS-WT'
ON CONFLICT (accession_number) DO NOTHING;

-- LGNDZ: LIGAND PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIGAND PHARMACEUTICALS INC', 'LGNDZ', '0000886163', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/886163/000088616325000025/0000886163-25-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNDZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/886163/000088616324000020/0000886163-24-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNDZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/886163/000088616323000018/0000886163-23-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNDZ'
ON CONFLICT (accession_number) DO NOTHING;

-- LGNXZ: LIGAND PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIGAND PHARMACEUTICALS INC', 'LGNXZ', '0000886163', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/886163/000088616325000025/0000886163-25-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNXZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/886163/000088616324000020/0000886163-24-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNXZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/886163/000088616323000018/0000886163-23-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNXZ'
ON CONFLICT (accession_number) DO NOTHING;

-- LGNYZ: LIGAND PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIGAND PHARMACEUTICALS INC', 'LGNYZ', '0000886163', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/886163/000088616325000025/0000886163-25-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNYZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/886163/000088616324000020/0000886163-24-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNYZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/886163/000088616323000018/0000886163-23-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNYZ'
ON CONFLICT (accession_number) DO NOTHING;

-- LGNZZ: LIGAND PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIGAND PHARMACEUTICALS INC', 'LGNZZ', '0000886163', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/886163/000088616325000025/0000886163-25-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNZZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/886163/000088616324000020/0000886163-24-000020-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNZZ'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/886163/000088616323000018/0000886163-23-000018-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LGNZZ'
ON CONFLICT (accession_number) DO NOTHING;

-- LSBWF: LakeShore Biopharma Co., Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LakeShore Biopharma Co., Ltd.', 'LSBWF', '0001946399', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HWM-P: Howmet Aerospace Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Howmet Aerospace Inc.', 'HWM-P', '0000004281', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-16', 'https://www.sec.gov/Archives/edgar/data/4281/000110465925035530/0001104659-25-035530-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM-P'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-08', 'https://www.sec.gov/Archives/edgar/data/4281/000110465924044630/0001104659-24-044630-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM-P'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-03-30', 'https://www.sec.gov/Archives/edgar/data/4281/000110465923038944/0001104659-23-038944-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM-P'
ON CONFLICT (accession_number) DO NOTHING;

-- SXTPW: 60 DEGREES PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    '60 DEGREES PHARMACEUTICALS, INC.', 'SXTPW', '0001946563', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-08-27', 'https://www.sec.gov/Archives/edgar/data/1946563/000121390025080878/0001213900-25-080878-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SXTPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-15', 'https://www.sec.gov/Archives/edgar/data/1946563/000121390024087749/0001213900-24-087749-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SXTPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-30', 'https://www.sec.gov/Archives/edgar/data/1946563/000121390024047861/0001213900-24-047861-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SXTPW'
ON CONFLICT (accession_number) DO NOTHING;

-- EVTWF: Vertical Aerospace Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Vertical Aerospace Ltd.', 'EVTWF', '0001867102', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- MDCXW: Medicus Pharma Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Medicus Pharma Ltd.', 'MDCXW', '0001997296', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-06-30', 'https://www.sec.gov/Archives/edgar/data/1997296/000106299325012273/0001062993-25-012273-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MDCXW'
ON CONFLICT (accession_number) DO NOTHING;

-- HSPOR: Horizon Space Acquisition I Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition I Corp.', 'HSPOR', '0001946021', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-14', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998025000665/0001929980-25-000665-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-19', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000565/0001929980-24-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-21', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000037/0001929980-24-000037-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOR'
ON CONFLICT (accession_number) DO NOTHING;

-- HSPOU: Horizon Space Acquisition I Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition I Corp.', 'HSPOU', '0001946021', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-14', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998025000665/0001929980-25-000665-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOU'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-19', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000565/0001929980-24-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOU'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-21', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000037/0001929980-24-000037-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOU'
ON CONFLICT (accession_number) DO NOTHING;

-- HSPOW: Horizon Space Acquisition I Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Space Acquisition I Corp.', 'HSPOW', '0001946021', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-14', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998025000665/0001929980-25-000665-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-19', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000565/0001929980-24-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-02-21', 'https://www.sec.gov/Archives/edgar/data/1946021/000192998024000037/0001929980-24-000037-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HSPOW'
ON CONFLICT (accession_number) DO NOTHING;

-- NRXPW: NRX Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NRX Pharmaceuticals, Inc.', 'NRXPW', '0001719406', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-09-05', 'https://www.sec.gov/Archives/edgar/data/1719406/000143774924028549/0001437749-24-028549-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NRXPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-11', 'https://www.sec.gov/Archives/edgar/data/1719406/000110465924033080/0001104659-24-033080-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NRXPW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-11-22', 'https://www.sec.gov/Archives/edgar/data/1719406/000110465923120785/0001104659-23-120785-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NRXPW'
ON CONFLICT (accession_number) DO NOTHING;

-- KITTW: Nauticus Robotics, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Nauticus Robotics, Inc.', 'KITTW', '0001849820', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-09-25', 'https://www.sec.gov/Archives/edgar/data/1849820/000184982025000242/0001849820-25-000242-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KITTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1849820/000184982025000120/0001849820-25-000120-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KITTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-25', 'https://www.sec.gov/Archives/edgar/data/1849820/000184982024000272/0001849820-24-000272-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KITTW'
ON CONFLICT (accession_number) DO NOTHING;

-- GIPRW: GENERATION INCOME PROPERTIES, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERATION INCOME PROPERTIES, INC.', 'GIPRW', '0001651721', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-11-07', 'https://www.sec.gov/Archives/edgar/data/1651721/000119312525272581/0001193125-25-272581-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIPRW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-10-17', 'https://www.sec.gov/Archives/edgar/data/1651721/000095017024115299/0000950170-24-115299-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIPRW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-02', 'https://www.sec.gov/Archives/edgar/data/1651721/000095017023050931/0000950170-23-050931-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GIPRW'
ON CONFLICT (accession_number) DO NOTHING;

-- KPHMW: KIORA PHARMACEUTICALS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'KIORA PHARMACEUTICALS INC', 'KPHMW', '0001372514', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1372514/000137251425000038/0001372514-25-000038-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KPHMW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-03-25', 'https://www.sec.gov/Archives/edgar/data/1372514/000137251424000030/0001372514-24-000030-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KPHMW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-07-21', 'https://www.sec.gov/Archives/edgar/data/1372514/000137251423000110/0001372514-23-000110-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'KPHMW'
ON CONFLICT (accession_number) DO NOTHING;

-- LAAI: Loan Artificial Intelligence Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Loan Artificial Intelligence Corp.', 'LAAI', '0001594968', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- NAMSW: NewAmsterdam Pharma Co N.V.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NewAmsterdam Pharma Co N.V.', 'NAMSW', '0001936258', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-05-08', 'https://www.sec.gov/Archives/edgar/data/1936258/000119312525115995/0001193125-25-115995-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NAMSW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-05-09', 'https://www.sec.gov/Archives/edgar/data/1936258/000119312524135282/0001193125-24-135282-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NAMSW'
ON CONFLICT (accession_number) DO NOTHING;

-- SMNRW: Semnur Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Semnur Pharmaceuticals, Inc.', 'SMNRW', '0001913577', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-03-27', 'https://www.sec.gov/Archives/edgar/data/1913577/000101376225003461/0001013762-25-003461-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SMNRW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-06-28', 'https://www.sec.gov/Archives/edgar/data/1913577/000121390024057300/0001213900-24-057300-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'SMNRW'
ON CONFLICT (accession_number) DO NOTHING;

-- SOCAW: Solarius Capital Acquisition Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Solarius Capital Acquisition Corp.', 'SOCAW', '0002065948', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SOCAU: Solarius Capital Acquisition Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Solarius Capital Acquisition Corp.', 'SOCAU', '0002065948', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- BAERW: Bridger Aerospace Group Holdings, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Bridger Aerospace Group Holdings, Inc.', 'BAERW', '0001941536', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1941536/000114036125016366/0001140361-25-016366-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BAERW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1941536/000114036124023081/0001140361-24-023081-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'BAERW'
ON CONFLICT (accession_number) DO NOTHING;

-- CSCIF: COSCIENS Biopharma Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'COSCIENS Biopharma Inc.', 'CSCIF', '0001113423', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- RCKTW: ROCKET PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ROCKET PHARMACEUTICALS, INC.', 'RCKTW', '0001281895', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1281895/000114036125016656/0001140361-25-016656-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RCKTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1281895/000114036124023041/0001140361-24-023041-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RCKTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1281895/000114036123021702/0001140361-23-021702-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RCKTW'
ON CONFLICT (accession_number) DO NOTHING;

-- WGSWW: GeneDx Holdings Corp.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GeneDx Holdings Corp.', 'WGSWW', '0001818331', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1818331/000181833125000075/0001818331-25-000075-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WGSWW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1818331/000181833124000025/0001818331-24-000025-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WGSWW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1818331/000181833123000033/0001818331-23-000033-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WGSWW'
ON CONFLICT (accession_number) DO NOTHING;

-- HNSPF: Hansoh Pharmaceutical Group Co Limited/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Hansoh Pharmaceutical Group Co Limited/ADR', 'HNSPF', '0002073669', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CTRVP: Hepion Pharmaceuticals, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Hepion Pharmaceuticals, Inc.', 'CTRVP', '0001583771', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1583771/000164117225006440/0001641172-25-006440-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CTRVP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-02-07', 'https://www.sec.gov/Archives/edgar/data/1583771/000149315225005322/0001493152-25-005322-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CTRVP'
ON CONFLICT (accession_number) DO NOTHING;

-- EYGPF: Electricity Generating Public Co Limited/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Electricity Generating Public Co Limited/ADR', 'EYGPF', '0001562294', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- EYUUF: Electricity Generating Public Co Limited/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Electricity Generating Public Co Limited/ADR', 'EYUUF', '0001562294', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SMTGF: SMA Solar Technology AG/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SMA Solar Technology AG/ADR', 'SMTGF', '0001516684', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- LIXTW: LIXTE BIOTECHNOLOGY HOLDINGS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'LIXTE BIOTECHNOLOGY HOLDINGS, INC.', 'LIXTW', '0001335105', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-10-27', 'https://www.sec.gov/Archives/edgar/data/1335105/000149315225019697/0001493152-25-019697-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIXTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-11-05', 'https://www.sec.gov/Archives/edgar/data/1335105/000149315224043583/0001493152-24-043583-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIXTW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-10-10', 'https://www.sec.gov/Archives/edgar/data/1335105/000149315223036718/0001493152-23-036718-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LIXTW'
ON CONFLICT (accession_number) DO NOTHING;

-- TGE-WT: Generation Essentials Group
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Generation Essentials Group', 'TGE-WT', '0002053456', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- GREEL: Greenidge Generation Holdings Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Greenidge Generation Holdings Inc.', 'GREEL', '0001844971', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-28', 'https://www.sec.gov/Archives/edgar/data/1844971/000119380525000565/0001193805-25-000565-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GREEL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1844971/000162828024018969/0001628280-24-018969-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GREEL'
ON CONFLICT (accession_number) DO NOTHING;

-- INNPF: INNOCAN PHARMA Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'INNOCAN PHARMA Corp', 'INNPF', '0001889791', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- HRZRF: Horizon Robotics, Inc./ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Horizon Robotics, Inc./ADR', 'HRZRF', '0002060217', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- SUNXF: Stardust Solar Energy Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Stardust Solar Energy Inc.', 'SUNXF', '0002048958', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TALKW: Talkspace, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Talkspace, Inc.', 'TALKW', '0001803901', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2025-04-30', 'https://www.sec.gov/Archives/edgar/data/1803901/000114036125016714/0001140361-25-016714-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TALKW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2024-04-29', 'https://www.sec.gov/Archives/edgar/data/1803901/000114036124022973/0001140361-24-022973-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TALKW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '', 'DEF 14A', '2023-09-01', 'https://www.sec.gov/Archives/edgar/data/1803901/000114036123042235/0001140361-23-042235-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TALKW'
ON CONFLICT (accession_number) DO NOTHING;

-- STTPF: SCHOTT Pharma AG & Co. KGaA/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SCHOTT Pharma AG & Co. KGaA/ADR', 'STTPF', '0002018852', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- TSX/TSX-V Canadian Deep Tech Companies
-- Total companies: 24
-- Generated: 2025-12-02 19:14:28.677526

SET search_path TO vendor_governance, public;

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

-- BioVectra Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'BioVectra Inc.', NULL, 'CAN', 'Ontario',
    'Biotechnology', 'Private', NULL, 2
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

-- OpenText Corporation
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'OpenText Corporation', 'OTEX', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX/NASDAQ', 2
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

-- Constellation Software Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Constellation Software Inc.', 'CSU.TO', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Kinaxis Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Kinaxis Inc.', 'KXS.TO', 'CAN', 'Ontario',
    'AI & Machine Learning', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Descartes Systems Group
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Descartes Systems Group', 'DSGX', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX/NASDAQ', 2
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

-- Sierra Wireless
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Sierra Wireless', 'SW.TO', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX', 2
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

-- Hydrogenics (Cummins)
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Hydrogenics (Cummins)', 'HYZN', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'Acquired', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- MDA Ltd.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'MDA Ltd.', 'MDA.TO', 'CAN', 'Ontario',
    'Space Technology', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- CAE Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'CAE Inc.', 'CAE.TO', 'CAN', 'Ontario',
    'Advanced Technology', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Absolute Software Corporation
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Absolute Software Corporation', 'ABST.TO', 'CAN', 'Ontario',
    'Cybersecurity', 'Public', 'TSX', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- PyroGenesis Canada Inc.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'PyroGenesis Canada Inc.', 'PYR.TO', 'CAN', 'Ontario',
    'Biotechnology', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Nano One Materials Corp.
INSERT INTO companies (
    company_name, ticker_symbol, incorporation_country, incorporation_jurisdiction,
    primary_sector, listing_type, stock_exchange, data_tier
) VALUES (
    'Nano One Materials Corp.', 'NANO.TO', 'CAN', 'Ontario',
    'Energy & Climate', 'Public', 'TSX-V', 2
) ON CONFLICT (company_name, incorporation_jurisdiction) DO UPDATE SET
    ticker_symbol = EXCLUDED.ticker_symbol,
    stock_exchange = EXCLUDED.stock_exchange;

-- Thermal Energy International
INSERT INTO companies (
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
