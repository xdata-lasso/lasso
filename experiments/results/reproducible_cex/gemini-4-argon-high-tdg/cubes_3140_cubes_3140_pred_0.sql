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
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (10, 'SVC_X', 'Tax Filing', 'Annual tax filing service');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (20, 'SVC_Y', 'Audit Review', 'Financial audit service');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (30, 'SVC_Z', 'Legal Consult', 'General legal consultation');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (1, 10, 'Basic', 'F-300', 'Mid Form', 'Description B1');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (2, 30, 'Zeta', 'F-100', 'Early Form', 'Description Z1');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (3, 20, 'Alpha', 'F-200', 'Late Form', 'Description A1');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (4, 10, 'Basic', 'F-301', 'Mid Form', 'Description B2');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (5, 20, 'Basic', 'F-302', 'Other Form', 'Description B3');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (6, 20, 'Alpha', 'F-201', 'Late Form', 'Description A2');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (100, 'CREDIT', '555-0100', 'party1@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (200, 'CASH', '555-0200', 'party2@example.com');
INSERT INTO Addresses (address_id, line_1_number_building, town_city, zip_postcode, state_province_county, country) VALUES (1, '10 Main St', 'London', 'SW1A 1AA', 'Greater London', 'UK');
INSERT INTO Party_Addresses (party_id, address_id, date_address_from, address_type_code, date_address_to) VALUES (100, 1, '2020-01-01 00:00:00', 'HOME', '2023-01-01 00:00:00');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (100, 1, '2022-01-01 09:00:00', 'COMPLETED', '2022-01-02 10:00:00');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (200, 3, '2022-02-01 09:00:00', 'PENDING', NULL);
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (100, 10, 501, '2022-03-01 14:00:00', '2022-02-15 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT form_type_code FROM forms ORDER BY form_type_code;

/*
Gold Result:
('Alpha',)
('Basic',)
('Zeta',)
*/

-- Prediction Query
SELECT DISTINCT form_type_code FROM forms;

/*
Prediction Result:
('Basic',)
('Zeta',)
('Alpha',)
*/