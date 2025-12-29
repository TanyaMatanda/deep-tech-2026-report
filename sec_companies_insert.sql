-- SEC EDGAR Public Companies
-- Total: 50
-- Generated: 2025-12-15 16:01:29.136405

SET search_path TO vendor_governance, public;

-- META: Meta Platforms, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Meta Platforms, Inc.', 'META', '0001326801', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001326801-25-000040', 'DEF 14A', '2025-04-17', 'https://www.sec.gov/Archives/edgar/data/1326801/000132680125000040/0001326801-25-000040-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'META'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001326801-24-000034', 'DEF 14A', '2024-04-19', 'https://www.sec.gov/Archives/edgar/data/1326801/000132680124000034/0001326801-24-000034-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'META'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001326801-23-000050', 'DEF 14A', '2023-04-14', 'https://www.sec.gov/Archives/edgar/data/1326801/000132680123000050/0001326801-23-000050-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'META'
ON CONFLICT (accession_number) DO NOTHING;

-- PLTR: Palantir Technologies Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Palantir Technologies Inc.', 'PLTR', '0001321655', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001321655-25-000057', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1321655/000132165525000057/0001321655-25-000057-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PLTR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001321655-24-000059', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1321655/000132165524000059/0001321655-24-000059-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PLTR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001321655-23-000033', 'DEF 14A', '2023-04-26', 'https://www.sec.gov/Archives/edgar/data/1321655/000132165523000033/0001321655-23-000033-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PLTR'
ON CONFLICT (accession_number) DO NOTHING;

-- AMD: ADVANCED MICRO DEVICES INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ADVANCED MICRO DEVICES INC', 'AMD', '0000002488', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-25-067170', 'DEF 14A', '2025-03-28', 'https://www.sec.gov/Archives/edgar/data/2488/000119312525067170/0001193125-25-067170-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-076513', 'DEF 14A', '2024-03-25', 'https://www.sec.gov/Archives/edgar/data/2488/000119312524076513/0001193125-24-076513-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-23-088096', 'DEF 14A', '2023-03-31', 'https://www.sec.gov/Archives/edgar/data/2488/000119312523088096/0001193125-23-088096-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMD'
ON CONFLICT (accession_number) DO NOTHING;

-- CSCO: CISCO SYSTEMS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CISCO SYSTEMS, INC.', 'CSCO', '0000858877', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000858877-25-000150', 'DEF 14A', '2025-10-28', 'https://www.sec.gov/Archives/edgar/data/858877/000085887725000150/0000858877-25-000150-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CSCO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-24-109859', 'DEF 14A', '2024-10-18', 'https://www.sec.gov/Archives/edgar/data/858877/000110465924109859/0001104659-24-109859-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CSCO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-23-109641', 'DEF 14A', '2023-10-17', 'https://www.sec.gov/Archives/edgar/data/858877/000110465923109641/0001104659-23-109641-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CSCO'
ON CONFLICT (accession_number) DO NOTHING;

-- GE: GENERAL ELECTRIC CO
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERAL ELECTRIC CO', 'GE', '0000040545', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-25-000114', 'DEF 14A', '2025-03-13', 'https://www.sec.gov/Archives/edgar/data/40545/000130817925000114/0001308179-25-000114-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-24-000139', 'DEF 14A', '2024-03-14', 'https://www.sec.gov/Archives/edgar/data/40545/000130817924000139/0001308179-24-000139-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GE'
ON CONFLICT (accession_number) DO NOTHING;

-- UNH: UNITEDHEALTH GROUP INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'UNITEDHEALTH GROUP INC', 'UNH', '0000731766', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-25-036829', 'DEF 14A', '2025-04-21', 'https://www.sec.gov/Archives/edgar/data/731766/000110465925036829/0001104659-25-036829-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'UNH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-24-050055', 'DEF 14A', '2024-04-22', 'https://www.sec.gov/Archives/edgar/data/731766/000110465924050055/0001104659-24-050055-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'UNH'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-23-048439', 'DEF 14A', '2023-04-21', 'https://www.sec.gov/Archives/edgar/data/731766/000110465923048439/0001104659-23-048439-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'UNH'
ON CONFLICT (accession_number) DO NOTHING;

-- CYATY: Contemporary Amperex Technology Co., Limited/ADR
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Contemporary Amperex Technology Co., Limited/ADR', 'CYATY', '0002070829', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- MU: MICRON TECHNOLOGY INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'MICRON TECHNOLOGY INC', 'MU', '0000723125', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000723125-25-000038', 'DEF 14A', '2025-11-25', 'https://www.sec.gov/Archives/edgar/data/723125/000072312525000038/0000723125-25-000038-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MU'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000723125-24-000039', 'DEF 14A', '2024-11-26', 'https://www.sec.gov/Archives/edgar/data/723125/000072312524000039/0000723125-24-000039-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MU'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000723125-23-000065', 'DEF 14A', '2023-11-29', 'https://www.sec.gov/Archives/edgar/data/723125/000072312523000065/0000723125-23-000065-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MU'
ON CONFLICT (accession_number) DO NOTHING;

-- TMUS: T-Mobile US, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'T-Mobile US, Inc.', 'TMUS', '0001283699', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-25-085753', 'DEF 14A', '2025-04-18', 'https://www.sec.gov/Archives/edgar/data/1283699/000119312525085753/0001193125-25-085753-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TMUS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-117940', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1283699/000119312524117940/0001193125-24-117940-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TMUS'
ON CONFLICT (accession_number) DO NOTHING;

-- AMAT: APPLIED MATERIALS INC /DE
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'APPLIED MATERIALS INC /DE', 'AMAT', '0000006951', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-25-010409', 'DEF 14A', '2025-01-22', 'https://www.sec.gov/Archives/edgar/data/6951/000119312525010409/0001193125-25-010409-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMAT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-014287', 'DEF 14A', '2024-01-24', 'https://www.sec.gov/Archives/edgar/data/6951/000119312524014287/0001193125-24-014287-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMAT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-23-015198', 'DEF 14A', '2023-01-25', 'https://www.sec.gov/Archives/edgar/data/6951/000119312523015198/0001193125-23-015198-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AMAT'
ON CONFLICT (accession_number) DO NOTHING;

-- ISRG: INTUITIVE SURGICAL INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'INTUITIVE SURGICAL INC', 'ISRG', '0001035267', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001035267-25-000098', 'DEF 14A', '2025-03-14', 'https://www.sec.gov/Archives/edgar/data/1035267/000103526725000098/0001035267-25-000098-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ISRG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001035267-24-000116', 'DEF 14A', '2024-03-08', 'https://www.sec.gov/Archives/edgar/data/1035267/000103526724000116/0001035267-24-000116-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ISRG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001035267-23-000083', 'DEF 14A', '2023-03-10', 'https://www.sec.gov/Archives/edgar/data/1035267/000103526723000083/0001035267-23-000083-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ISRG'
ON CONFLICT (accession_number) DO NOTHING;

-- UBER: Uber Technologies, Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Uber Technologies, Inc', 'UBER', '0001543151', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-25-000210', 'DEF 14A', '2025-03-24', 'https://www.sec.gov/Archives/edgar/data/1543151/000130817925000210/0001308179-25-000210-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'UBER'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001552781-24-000177', 'DEF 14A', '2024-03-25', 'https://www.sec.gov/Archives/edgar/data/1543151/000155278124000177/0001552781-24-000177-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'UBER'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001552781-23-000193', 'DEF 14A', '2023-03-28', 'https://www.sec.gov/Archives/edgar/data/1543151/000155278123000193/0001552781-23-000193-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'UBER'
ON CONFLICT (accession_number) DO NOTHING;

-- VZ: VERIZON COMMUNICATIONS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'VERIZON COMMUNICATIONS INC', 'VZ', '0000732712', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-25-000404', 'DEF 14A', '2025-04-07', 'https://www.sec.gov/Archives/edgar/data/732712/000130817925000404/0001308179-25-000404-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VZ'
ON CONFLICT (accession_number) DO NOTHING;

-- NEE: NEXTERA ENERGY INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NEXTERA ENERGY INC', 'NEE', '0000753308', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-25-030590', 'DEF 14A', '2025-04-01', 'https://www.sec.gov/Archives/edgar/data/753308/000110465925030590/0001104659-25-030590-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NEE'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-24-041966', 'DEF 14A', '2024-04-01', 'https://www.sec.gov/Archives/edgar/data/753308/000110465924041966/0001104659-24-041966-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NEE'
ON CONFLICT (accession_number) DO NOTHING;

-- ANET: Arista Networks, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Arista Networks, Inc.', 'ANET', '0001596532', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-25-082860', 'DEF 14A', '2025-04-16', 'https://www.sec.gov/Archives/edgar/data/1596532/000119312525082860/0001193125-25-082860-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ANET'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-110073', 'DEF 14A', '2024-04-24', 'https://www.sec.gov/Archives/edgar/data/1596532/000119312524110073/0001193125-24-110073-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ANET'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-23-126846', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1596532/000119312523126846/0001193125-23-126846-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ANET'
ON CONFLICT (accession_number) DO NOTHING;

-- PANW: Palo Alto Networks Inc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Palo Alto Networks Inc', 'PANW', '0001327567', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-25-000624', 'DEF 14A', '2025-11-07', 'https://www.sec.gov/Archives/edgar/data/1327567/000130817925000624/0001308179-25-000624-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PANW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-24-000770', 'DEF 14A', '2024-10-29', 'https://www.sec.gov/Archives/edgar/data/1327567/000130817924000770/0001308179-24-000770-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PANW'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-23-001049', 'DEF 14A', '2023-10-27', 'https://www.sec.gov/Archives/edgar/data/1327567/000130817923001049/0001308179-23-001049-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'PANW'
ON CONFLICT (accession_number) DO NOTHING;

-- SPOT: Spotify Technology S.A.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Spotify Technology S.A.', 'SPOT', '0001639920', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CEG: Constellation Energy Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Constellation Energy Corp', 'CEG', '0001868275', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001552781-25-000090', 'DEF 14A', '2025-03-19', 'https://www.sec.gov/Archives/edgar/data/1868275/000155278125000090/0001552781-25-000090-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CEG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001552781-24-000159', 'DEF 14A', '2024-03-20', 'https://www.sec.gov/Archives/edgar/data/1868275/000155278124000159/0001552781-24-000159-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CEG'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001552781-23-000110', 'DEF 14A', '2023-03-14', 'https://www.sec.gov/Archives/edgar/data/1868275/000155278123000110/0001552781-23-000110-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CEG'
ON CONFLICT (accession_number) DO NOTHING;

-- VRTX: VERTEX PHARMACEUTICALS INC / MA
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'VERTEX PHARMACEUTICALS INC / MA', 'VRTX', '0000875320', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000875320-25-000160', 'DEF 14A', '2025-04-03', 'https://www.sec.gov/Archives/edgar/data/875320/000087532025000160/0000875320-25-000160-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VRTX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-24-000452', 'DEF 14A', '2024-04-04', 'https://www.sec.gov/Archives/edgar/data/875320/000130817924000452/0001308179-24-000452-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VRTX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-23-000591', 'DEF 14A', '2023-04-06', 'https://www.sec.gov/Archives/edgar/data/875320/000130817923000591/0001308179-23-000591-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VRTX'
ON CONFLICT (accession_number) DO NOTHING;

-- HCA: HCA Healthcare, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'HCA Healthcare, Inc.', 'HCA', '0000860730', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-25-054832', 'DEF 14A', '2025-03-14', 'https://www.sec.gov/Archives/edgar/data/860730/000119312525054832/0001193125-25-054832-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HCA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-069180', 'DEF 14A', '2024-03-15', 'https://www.sec.gov/Archives/edgar/data/860730/000119312524069180/0001193125-24-069180-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HCA'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-23-067645', 'DEF 14A', '2023-03-10', 'https://www.sec.gov/Archives/edgar/data/860730/000119312523067645/0001193125-23-067645-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HCA'
ON CONFLICT (accession_number) DO NOTHING;

-- ADP: AUTOMATIC DATA PROCESSING INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'AUTOMATIC DATA PROCESSING INC', 'ADP', '0000008670', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- CVS: CVS HEALTH Corp
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CVS HEALTH Corp', 'CVS', '0000064803', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-25-000386', 'DEF 14A', '2025-04-04', 'https://www.sec.gov/Archives/edgar/data/64803/000130817925000386/0001308179-25-000386-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CVS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-24-000463', 'DEF 14A', '2024-04-05', 'https://www.sec.gov/Archives/edgar/data/64803/000130817924000463/0001308179-24-000463-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CVS'
ON CONFLICT (accession_number) DO NOTHING;

-- DELL: Dell Technologies Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Dell Technologies Inc.', 'DELL', '0001571996', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-25-121698', 'DEF 14A', '2025-05-16', 'https://www.sec.gov/Archives/edgar/data/1571996/000119312525121698/0001193125-25-121698-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DELL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-141729', 'DEF 14A', '2024-05-17', 'https://www.sec.gov/Archives/edgar/data/1571996/000119312524141729/0001193125-24-141729-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DELL'
ON CONFLICT (accession_number) DO NOTHING;

-- GD: GENERAL DYNAMICS CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'GENERAL DYNAMICS CORP', 'GD', '0000040533', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-25-000291', 'DEF 14A', '2025-03-28', 'https://www.sec.gov/Archives/edgar/data/40533/000130817925000291/0001308179-25-000291-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-24-000257', 'DEF 14A', '2024-03-22', 'https://www.sec.gov/Archives/edgar/data/40533/000130817924000257/0001308179-24-000257-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GD'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-23-000367', 'DEF 14A', '2023-03-24', 'https://www.sec.gov/Archives/edgar/data/40533/000130817923000367/0001308179-23-000367-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GD'
ON CONFLICT (accession_number) DO NOTHING;

-- CDNS: CADENCE DESIGN SYSTEMS INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'CADENCE DESIGN SYSTEMS INC', 'CDNS', '0000813672', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-25-062605', 'DEF 14A', '2025-03-25', 'https://www.sec.gov/Archives/edgar/data/813672/000119312525062605/0001193125-25-062605-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CDNS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-073902', 'DEF 14A', '2024-03-21', 'https://www.sec.gov/Archives/edgar/data/813672/000119312524073902/0001193125-24-073902-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CDNS'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-23-076688', 'DEF 14A', '2023-03-22', 'https://www.sec.gov/Archives/edgar/data/813672/000119312523076688/0001193125-23-076688-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'CDNS'
ON CONFLICT (accession_number) DO NOTHING;

-- TT: Trane Technologies plc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Trane Technologies plc', 'TT', '0001466258', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001466258-25-000114', 'DEF 14A', '2025-04-24', 'https://www.sec.gov/Archives/edgar/data/1466258/000146625825000114/0001466258-25-000114-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001466258-24-000155', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/1466258/000146625824000155/0001466258-24-000155-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TT'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001466258-23-000108', 'DEF 14A', '2023-04-21', 'https://www.sec.gov/Archives/edgar/data/1466258/000146625823000108/0001466258-23-000108-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'TT'
ON CONFLICT (accession_number) DO NOTHING;

-- DUK: Duke Energy CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Duke Energy CORP', 'DUK', '0001326160', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-25-023754', 'DEF 14A', '2025-03-14', 'https://www.sec.gov/Archives/edgar/data/1326160/000110465925023754/0001104659-25-023754-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DUK'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-24-037589', 'DEF 14A', '2024-03-22', 'https://www.sec.gov/Archives/edgar/data/1326160/000110465924037589/0001104659-24-037589-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DUK'
ON CONFLICT (accession_number) DO NOTHING;

-- ELV: Elevance Health, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Elevance Health, Inc.', 'ELV', '0001156039', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001156039-25-000046', 'DEF 14A', '2025-03-28', 'https://www.sec.gov/Archives/edgar/data/1156039/000115603925000046/0001156039-25-000046-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ELV'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001156039-24-000050', 'DEF 14A', '2024-03-29', 'https://www.sec.gov/Archives/edgar/data/1156039/000115603924000050/0001156039-24-000050-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ELV'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001156039-23-000050', 'DEF 14A', '2023-03-31', 'https://www.sec.gov/Archives/edgar/data/1156039/000115603923000050/0001156039-23-000050-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ELV'
ON CONFLICT (accession_number) DO NOTHING;

-- ORLY: O REILLY AUTOMOTIVE INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'O REILLY AUTOMOTIVE INC', 'ORLY', '0000898173', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000898173-25-000017', 'DEF 14A', '2025-03-31', 'https://www.sec.gov/Archives/edgar/data/898173/000089817325000017/0000898173-25-000017-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORLY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000898173-24-000013', 'DEF 14A', '2024-03-29', 'https://www.sec.gov/Archives/edgar/data/898173/000089817324000013/0000898173-24-000013-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORLY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000898173-23-000015', 'DEF 14A', '2023-03-31', 'https://www.sec.gov/Archives/edgar/data/898173/000089817323000015/0000898173-23-000015-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ORLY'
ON CONFLICT (accession_number) DO NOTHING;

-- REGN: REGENERON PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'REGENERON PHARMACEUTICALS, INC.', 'REGN', '0000872589', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-25-000518', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/872589/000130817925000518/0001308179-25-000518-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'REGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-24-000577', 'DEF 14A', '2024-04-25', 'https://www.sec.gov/Archives/edgar/data/872589/000130817924000577/0001308179-24-000577-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'REGN'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-23-000728', 'DEF 14A', '2023-04-21', 'https://www.sec.gov/Archives/edgar/data/872589/000130817923000728/0001308179-23-000728-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'REGN'
ON CONFLICT (accession_number) DO NOTHING;

-- HWM: Howmet Aerospace Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Howmet Aerospace Inc.', 'HWM', '0000004281', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-25-035530', 'DEF 14A', '2025-04-16', 'https://www.sec.gov/Archives/edgar/data/4281/000110465925035530/0001104659-25-035530-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-24-044630', 'DEF 14A', '2024-04-08', 'https://www.sec.gov/Archives/edgar/data/4281/000110465924044630/0001104659-24-044630-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-23-038944', 'DEF 14A', '2023-03-30', 'https://www.sec.gov/Archives/edgar/data/4281/000110465923038944/0001104659-23-038944-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'HWM'
ON CONFLICT (accession_number) DO NOTHING;

-- EMR: EMERSON ELECTRIC CO
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'EMERSON ELECTRIC CO', 'EMR', '0000032604', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000032604-25-000103', 'DEF 14A', '2025-12-12', 'https://www.sec.gov/Archives/edgar/data/32604/000003260425000103/0000032604-25-000103-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'EMR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000032604-24-000057', 'DEF 14A', '2024-12-13', 'https://www.sec.gov/Archives/edgar/data/32604/000003260424000057/0000032604-24-000057-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'EMR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-23-291718', 'DEF 14A', '2023-12-08', 'https://www.sec.gov/Archives/edgar/data/32604/000119312523291718/0001193125-23-291718-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'EMR'
ON CONFLICT (accession_number) DO NOTHING;

-- MRVL: Marvell Technology, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Marvell Technology, Inc.', 'MRVL', '0001835632', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-25-043088', 'DEF 14A', '2025-05-01', 'https://www.sec.gov/Archives/edgar/data/1835632/000110465925043088/0001104659-25-043088-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MRVL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-24-058658', 'DEF 14A', '2024-05-08', 'https://www.sec.gov/Archives/edgar/data/1835632/000110465924058658/0001104659-24-058658-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MRVL'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-23-055484', 'DEF 14A', '2023-05-03', 'https://www.sec.gov/Archives/edgar/data/1835632/000110465923055484/0001104659-23-055484-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MRVL'
ON CONFLICT (accession_number) DO NOTHING;

-- GM: General Motors Co
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'General Motors Co', 'GM', '0001467858', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001467858-25-000084', 'DEF 14A', '2025-04-22', 'https://www.sec.gov/Archives/edgar/data/1467858/000146785825000084/0001467858-25-000084-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-108581', 'DEF 14A', '2024-04-24', 'https://www.sec.gov/Archives/edgar/data/1467858/000119312524108581/0001193125-24-108581-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GM'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-23-126270', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1467858/000119312523126270/0001193125-23-126270-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'GM'
ON CONFLICT (accession_number) DO NOTHING;

-- NET: Cloudflare, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Cloudflare, Inc.', 'NET', '0001477333', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001477333-25-000065', 'DEF 14A', '2025-04-21', 'https://www.sec.gov/Archives/edgar/data/1477333/000147733325000065/0001477333-25-000065-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NET'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001477333-24-000036', 'DEF 14A', '2024-04-19', 'https://www.sec.gov/Archives/edgar/data/1477333/000147733324000036/0001477333-24-000036-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NET'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001477333-23-000033', 'DEF 14A', '2023-04-20', 'https://www.sec.gov/Archives/edgar/data/1477333/000147733323000033/0001477333-23-000033-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NET'
ON CONFLICT (accession_number) DO NOTHING;

-- STX: Seagate Technology Holdings plc
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Seagate Technology Holdings plc', 'STX', '0001137789', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001137789-25-000211', 'DEF 14A', '2025-09-09', 'https://www.sec.gov/Archives/edgar/data/1137789/000113778925000211/0001137789-25-000211-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'STX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001137789-24-000085', 'DEF 14A', '2024-09-03', 'https://www.sec.gov/Archives/edgar/data/1137789/000113778924000085/0001137789-24-000085-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'STX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001137789-23-000062', 'DEF 14A', '2023-09-05', 'https://www.sec.gov/Archives/edgar/data/1137789/000113778923000062/0001137789-23-000062-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'STX'
ON CONFLICT (accession_number) DO NOTHING;

-- BAESY: BAE SYSTEMS PLC /FI/
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'BAE SYSTEMS PLC /FI/', 'BAESY', '0000895564', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- WDC: WESTERN DIGITAL CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'WESTERN DIGITAL CORP', 'WDC', '0000106040', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001628280-25-044298', 'DEF 14A', '2025-10-06', 'https://www.sec.gov/Archives/edgar/data/106040/000162828025044298/0001628280-25-044298-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WDC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-24-000755', 'DEF 14A', '2024-10-07', 'https://www.sec.gov/Archives/edgar/data/106040/000130817924000755/0001308179-24-000755-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WDC'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-082058', 'DEF 14A', '2024-03-29', 'https://www.sec.gov/Archives/edgar/data/106040/000119312524082058/0001193125-24-082058-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'WDC'
ON CONFLICT (accession_number) DO NOTHING;

-- MSI: Motorola Solutions, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Motorola Solutions, Inc.', 'MSI', '0000068505', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-25-064714', 'DEF 14A', '2025-03-27', 'https://www.sec.gov/Archives/edgar/data/68505/000119312525064714/0001193125-25-064714-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MSI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-079648', 'DEF 14A', '2024-03-28', 'https://www.sec.gov/Archives/edgar/data/68505/000119312524079648/0001193125-24-079648-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MSI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-23-084527', 'DEF 14A', '2023-03-30', 'https://www.sec.gov/Archives/edgar/data/68505/000119312523084527/0001193125-23-084527-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'MSI'
ON CONFLICT (accession_number) DO NOTHING;

-- AEP: AMERICAN ELECTRIC POWER CO INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'AMERICAN ELECTRIC POWER CO INC', 'AEP', '0000004904', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000004904-25-000043', 'DEF 14A', '2025-03-13', 'https://www.sec.gov/Archives/edgar/data/4904/000000490425000043/0000004904-25-000043-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AEP'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0000004904-24-000023', 'DEF 14A', '2024-03-13', 'https://www.sec.gov/Archives/edgar/data/4904/000000490424000023/0000004904-24-000023-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'AEP'
ON CONFLICT (accession_number) DO NOTHING;

-- NXPI: NXP Semiconductors N.V.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'NXP Semiconductors N.V.', 'NXPI', '0001413447', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001413447-25-000035', 'DEF 14A', '2025-04-29', 'https://www.sec.gov/Archives/edgar/data/1413447/000141344725000035/0001413447-25-000035-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NXPI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001413447-24-000033', 'DEF 14A', '2024-04-15', 'https://www.sec.gov/Archives/edgar/data/1413447/000141344724000033/0001413447-24-000033-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NXPI'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001413447-23-000014', 'DEF 14A', '2023-04-10', 'https://www.sec.gov/Archives/edgar/data/1413447/000141344723000014/0001413447-23-000014-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'NXPI'
ON CONFLICT (accession_number) DO NOTHING;

-- TRP: TC ENERGY CORP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'TC ENERGY CORP', 'TRP', '0001232384', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- ET: Energy Transfer LP
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Energy Transfer LP', 'ET', '0001276187', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- IFNNY: INFINEON TECHNOLOGIES AG
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'INFINEON TECHNOLOGIES AG', 'IFNNY', '0001107457', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- DLR: DIGITAL REALTY TRUST, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'DIGITAL REALTY TRUST, INC.', 'DLR', '0001297996', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-25-000509', 'DEF 14A', '2025-04-25', 'https://www.sec.gov/Archives/edgar/data/1297996/000130817925000509/0001308179-25-000509-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DLR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-24-000607', 'DEF 14A', '2024-04-26', 'https://www.sec.gov/Archives/edgar/data/1297996/000130817924000607/0001308179-24-000607-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DLR'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001308179-23-000815', 'DEF 14A', '2023-04-28', 'https://www.sec.gov/Archives/edgar/data/1297996/000130817923000815/0001308179-23-000815-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'DLR'
ON CONFLICT (accession_number) DO NOTHING;

-- RKT: Rocket Companies, Inc.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'Rocket Companies, Inc.', 'RKT', '0001805284', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001805284-25-000071', 'DEF 14A', '2025-05-29', 'https://www.sec.gov/Archives/edgar/data/1805284/000180528425000071/0001805284-25-000071-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'RKT'
ON CONFLICT (accession_number) DO NOTHING;

-- ALNY: ALNYLAM PHARMACEUTICALS, INC.
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'ALNYLAM PHARMACEUTICALS, INC.', 'ALNY', '0001178670', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001178670-25-000040', 'DEF 14A', '2025-03-24', 'https://www.sec.gov/Archives/edgar/data/1178670/000117867025000040/0001178670-25-000040-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ALNY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-24-083454', 'DEF 14A', '2024-04-01', 'https://www.sec.gov/Archives/edgar/data/1178670/000119312524083454/0001193125-24-083454-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ALNY'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001193125-23-089611', 'DEF 14A', '2023-04-03', 'https://www.sec.gov/Archives/edgar/data/1178670/000119312523089611/0001193125-23-089611-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'ALNY'
ON CONFLICT (accession_number) DO NOTHING;

-- LHX: L3HARRIS TECHNOLOGIES, INC. /DE/
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'L3HARRIS TECHNOLOGIES, INC. /DE/', 'LHX', '0000202058', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001558370-25-002451', 'DEF 14A', '2025-03-07', 'https://www.sec.gov/Archives/edgar/data/202058/000155837025002451/0001558370-25-002451-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LHX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-24-032435', 'DEF 14A', '2024-03-08', 'https://www.sec.gov/Archives/edgar/data/202058/000110465924032435/0001104659-24-032435-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LHX'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001104659-23-031160', 'DEF 14A', '2023-03-10', 'https://www.sec.gov/Archives/edgar/data/202058/000110465923031160/0001104659-23-031160-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'LHX'
ON CONFLICT (accession_number) DO NOTHING;

-- SU: SUNCOR ENERGY INC
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'SUNCOR ENERGY INC', 'SU', '0000311337', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

-- VLO: VALERO ENERGY CORP/TX
INSERT INTO companies (
    company_name, ticker_symbol, cik, listing_type, data_tier
) VALUES (
    'VALERO ENERGY CORP/TX', 'VLO', '0001035002', 'Public', 1
) ON CONFLICT (company_name, incorporation_jurisdiction) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001035002-25-000010', 'DEF 14A', '2025-03-18', 'https://www.sec.gov/Archives/edgar/data/1035002/000103500225000010/0001035002-25-000010-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VLO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001035002-24-000014', 'DEF 14A', '2024-03-26', 'https://www.sec.gov/Archives/edgar/data/1035002/000103500224000014/0001035002-24-000014-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VLO'
ON CONFLICT (accession_number) DO NOTHING;

INSERT INTO sec_filings (company_id, accession_number, filing_type, filing_date, filing_url, processing_status)
SELECT id, '0001035002-23-000040', 'DEF 14A', '2023-03-22', 'https://www.sec.gov/Archives/edgar/data/1035002/000103500223000040/0001035002-23-000040-index.htm', 'pending'
FROM companies WHERE ticker_symbol = 'VLO'
ON CONFLICT (accession_number) DO NOTHING;

