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
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (10, 'SVC_ALPHA', 'Alpha Service', 'Desc Alpha');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (20, 'SVC_BETA', 'Beta Service', 'Desc Beta');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (100, 'CARD', '555-0100', 'p100@example.com');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (1, 10, 'TYPE_Z', 'F-900', 'Zebra Form', 'Desc Z');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (2, 10, 'TYPE_A', 'F-100', 'Alpha Form', 'Desc A1');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (3, 20, 'TYPE_A', 'F-200', 'Beta Form', 'Desc A2');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (4, 20, 'TYPE_M', 'F-050', 'Middle Form', 'Desc M');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (100, 2, '2023-01-01 09:00:00', 'STATUS_DONE', '2023-01-02 10:00:00');
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