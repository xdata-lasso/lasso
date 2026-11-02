-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "town_city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Services" ("service_id" INTEGER PRIMARY KEY, "service_type_code" TEXT(15), "service_name" TEXT(80), "service_descriptio" TEXT(255));

CREATE TABLE "Forms" ("form_id" INTEGER PRIMARY KEY, "service_id" INTEGER, "form_type_code" TEXT(15), "form_number" TEXT(50), "form_name" TEXT(80), "form_description" TEXT(255), FOREIGN KEY ("service_id") REFERENCES "Services" ("service_id"));

CREATE TABLE "Individuals" ("individual_id" INTEGER PRIMARY KEY, "individual_first_name" TEXT(80), "individual_middle_name" TEXT(80), "inidividual_phone" TEXT(80), "individual_email" TEXT(80), "individual_address" TEXT(255), "individual_last_name" TEXT(80));

CREATE TABLE "Organizations" ("organization_id" INTEGER PRIMARY KEY, "date_formed" DATETIME, "organization_name" TEXT(255), "uk_vat_number" TEXT(20));

CREATE TABLE "Parties" ("party_id" INTEGER PRIMARY KEY, "payment_method_code" TEXT(15), "party_phone" TEXT(80), "party_email" TEXT(80));

CREATE TABLE "Organization_Contact_Individuals" ("individual_id" INTEGER, "organization_id" INTEGER, "date_contact_from" DATETIME, "date_contact_to" DATETIME, PRIMARY KEY ("individual_id", "organization_id"), FOREIGN KEY ("individual_id") REFERENCES "Individuals" ("individual_id"), FOREIGN KEY ("organization_id") REFERENCES "Organizations" ("organization_id"));

CREATE TABLE "Party_Addresses" ("party_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "address_type_code" TEXT(15), "date_address_to" DATETIME, PRIMARY KEY ("party_id", "address_id"), FOREIGN KEY ("party_id") REFERENCES "Parties" ("party_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Party_Forms" ("party_id" INTEGER, "form_id" INTEGER, "date_completion_started" DATETIME, "form_status_code" TEXT(15), "date_fully_completed" DATETIME, PRIMARY KEY ("party_id", "form_id"), FOREIGN KEY ("form_id") REFERENCES "Forms" ("form_id"), FOREIGN KEY ("party_id") REFERENCES "Parties" ("party_id"));

CREATE TABLE "Party_Services" ("customer_id" INTEGER, "service_id" INTEGER, "booking_id" INTEGER, "service_datetime" DATETIME, "booking_made_date" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Parties" ("party_id"), FOREIGN KEY ("service_id") REFERENCES "Services" ("service_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ranking with 5 distinct payment methods, anti-correlated lexicographical order vs count order, and child table joins (0, 1, and multiple child records per party) to catch incorrect joins, ASC/DESC inversions, LIMIT mutations, and column selection errors.
INSERT INTO Addresses (address_id, line_1_number_building, town_city, zip_postcode, state_province_county, country) VALUES (1, '10 Main St', 'London', 'SW1A 1AA', 'Greater London', 'UK');
INSERT INTO Addresses (address_id, line_1_number_building, town_city, zip_postcode, state_province_county, country) VALUES (2, '20 High St', 'Manchester', 'M1 1AA', 'Greater Manchester', 'UK');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (1, 'CONSULT', 'Consulting', 'Basic consulting service');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (1, 1, 'TAX', 'F101', 'Tax Form', 'Annual tax return');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (2, 1, 'REG', 'F102', 'Registration', 'New client registration');
-- 'AMEX': 5 rows (Rank 1)
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (1, 'AMEX', '111-001', 'p1@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (2, 'AMEX', '111-002', 'p2@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (3, 'AMEX', '111-003', 'p3@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (4, 'AMEX', '111-004', 'p4@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (5, 'AMEX', '111-005', 'p5@example.com');
-- 'BITCOIN': 4 rows (Rank 2)
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (6, 'BITCOIN', '222-001', 'p6@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (7, 'BITCOIN', '222-002', 'p7@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (8, 'BITCOIN', '222-003', 'p8@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (9, 'BITCOIN', '222-004', 'p9@example.com');
-- 'CASH': 3 rows (Rank 3)
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (10, 'CASH', '333-001', 'p10@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (11, 'CASH', '333-002', 'p11@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (12, 'CASH', '333-003', 'p12@example.com');
-- 'DEBIT': 2 rows (Rank 4 - excluded by LIMIT 3)
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (13, 'DEBIT', '444-001', 'p13@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (14, 'DEBIT', '444-002', 'p14@example.com');
-- 'ECHECK': 1 row (Rank 5 - excluded by LIMIT 3)
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (15, 'ECHECK', '555-001', 'p15@example.com');
-- Child rows skewed toward lower-ranked payment methods to break mutants that unnecessarily INNER JOIN child tables
INSERT INTO Party_Addresses (party_id, address_id, date_address_from, address_type_code, date_address_to) VALUES (15, 1, '2020-01-01', 'HOME', '2023-01-01');
INSERT INTO Party_Addresses (party_id, address_id, date_address_from, address_type_code, date_address_to) VALUES (15, 2, '2020-01-01', 'WORK', '2023-01-01');
INSERT INTO Party_Addresses (party_id, address_id, date_address_from, address_type_code, date_address_to) VALUES (13, 1, '2021-01-01', 'HOME', '2023-01-01');
INSERT INTO Party_Addresses (party_id, address_id, date_address_from, address_type_code, date_address_to) VALUES (14, 2, '2021-01-01', 'HOME', '2023-01-01');
INSERT INTO Party_Addresses (party_id, address_id, date_address_from, address_type_code, date_address_to) VALUES (1, 1, '2022-01-01', 'HOME', '2023-01-01');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (15, 1, '2022-01-01', 'DONE', '2022-01-02');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (15, 2, '2022-01-03', 'DONE', '2022-01-04');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (10, 1, '2022-02-01', 'OPEN', NULL);
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (15, 1, 101, '2022-05-01', '2022-04-01');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (15, 1, 102, '2022-06-01', '2022-05-01');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (6, 1, 103, '2022-07-01', '2022-06-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT * FROM (SELECT * FROM (SELECT payment_method_code, COUNT(*) AS n FROM parties GROUP BY payment_method_code) ORDER BY n DESC) LIMIT 3);

/*
Gold Result:
('AMEX',)
('BITCOIN',)
('CASH',)
*/

-- Prediction Query
SELECT payment_method_code FROM parties GROUP BY payment_method_code HAVING COUNT(*) > 3;

/*
Prediction Result:
('AMEX',)
('BITCOIN',)
*/