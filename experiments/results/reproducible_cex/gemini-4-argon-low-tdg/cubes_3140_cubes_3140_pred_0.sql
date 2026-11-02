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
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (10, 'SRV_X', 'Service X', 'Description X');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (20, 'SRV_A', 'Service A', 'Description A');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (100, 'PAY_M', '111-222-3333', 'party1@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (200, 'PAY_B', '444-555-6666', 'party2@example.com');
INSERT INTO Addresses (address_id, line_1_number_building, town_city, zip_postcode, state_province_county, country) VALUES (1, '10 Main St', 'TownA', '10001', 'StateA', 'CountryA');
INSERT INTO Party_Addresses (party_id, address_id, date_address_from, address_type_code, date_address_to) VALUES (100, 1, '2020-01-01', 'ADDR_HOME', '2025-01-01');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (1, 10, 'TYPE_Z', 'FN-003', 'Form Z1', 'Desc Z1');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (2, 10, 'TYPE_A', 'FN-002', 'Form A1', 'Desc A1');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (3, 20, 'TYPE_Z', 'FN-001', 'Form Z2', 'Desc Z2');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (4, 20, 'TYPE_M', 'FN-004', 'Form M1', 'Desc M1');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (5, 20, 'TYPE_A', 'FN-005', 'Form A2', 'Desc A2');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (100, 1, '2023-01-01', 'STAT_COMP', '2023-01-02');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (200, 1, '2023-02-01', 'STAT_PEND', NULL);
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (100, 2, '2023-03-01', 'STAT_COMP', '2023-03-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT form_type_code FROM forms ORDER BY form_type_code;

/*
Gold Result:
('TYPE_A',)
('TYPE_M',)
('TYPE_Z',)
*/

-- Prediction Query
SELECT DISTINCT form_type_code FROM forms;

/*
Prediction Result:
('TYPE_Z',)
('TYPE_A',)
('TYPE_M',)
*/