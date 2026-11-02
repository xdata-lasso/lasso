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
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (1000, 'CRYPTO', '555-9999', 'crypto1@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (100, 'WIRE', '555-8881', 'wire1@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (101, 'WIRE', '555-8882', 'wire2@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (10, 'CASH', '555-3001', 'cash1@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (11, 'CASH', '555-3002', 'cash2@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (12, 'CASH', '555-3003', 'cash3@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (6, 'PAYPAL', '555-2001', 'pp1@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (7, 'PAYPAL', '555-2001', 'pp1@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (8, 'PAYPAL', NULL, NULL);
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (9, 'PAYPAL', NULL, NULL);
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (1, 'CREDIT', '555-1000', 'credit@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (2, 'CREDIT', '555-1000', 'credit@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (3, 'CREDIT', NULL, NULL);
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (4, 'CREDIT', NULL, NULL);
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (5, 'CREDIT', NULL, NULL);
INSERT INTO Addresses (address_id, line_1_number_building, town_city, zip_postcode, state_province_county, country) VALUES (1, '10 Main St', 'London', 'SW1A 1AA', 'Greater London', 'UK');
INSERT INTO Addresses (address_id, line_1_number_building, town_city, zip_postcode, state_province_county, country) VALUES (2, '20 High St', 'Oxford', 'OX1 1AA', 'Oxfordshire', 'UK');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (1, 'CONSULT', 'Consulting', 'General consulting');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (2, 'AUDIT', 'Auditing', 'Financial auditing');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (1, 1, 'F_TAX', '1040', 'Tax Form', 'Annual tax form');
INSERT INTO Forms (form_id, service_id, form_type_code, form_number, form_name, form_description) VALUES (2, 2, 'F_AUD', '2020', 'Audit Form', 'Audit declaration');
INSERT INTO Party_Addresses (party_id, address_id, date_address_from, address_type_code, date_address_to) VALUES (1000, 1, '2022-01-01', 'BILLING', '2023-01-01');
INSERT INTO Party_Addresses (party_id, address_id, date_address_from, address_type_code, date_address_to) VALUES (1000, 2, '2022-01-01', 'SHIPPING', '2023-01-01');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (1000, 1, '2022-02-01', 'COMPLETE', '2022-02-10');
INSERT INTO Party_Forms (party_id, form_id, date_completion_started, form_status_code, date_fully_completed) VALUES (1000, 2, '2022-03-01', 'COMPLETE', '2022-03-10');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (1000, 1, 501, '2022-04-01', '2022-03-15');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (1000, 2, 502, '2022-04-02', '2022-03-16');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (100, 1, 503, '2022-04-03', '2022-03-17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT * FROM (SELECT * FROM (SELECT payment_method_code, COUNT(*) AS n FROM parties GROUP BY payment_method_code) ORDER BY n DESC) LIMIT 3);

/*
Gold Result:
('CREDIT',)
('PAYPAL',)
('CASH',)
*/

-- Prediction Query
SELECT payment_method_code FROM parties GROUP BY payment_method_code HAVING COUNT(*) > 3;

/*
Prediction Result:
('CREDIT',)
('PAYPAL',)
*/