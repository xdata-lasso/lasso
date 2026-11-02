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
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (1, 'CARD', '555-0001', 'p1_alpha@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (2, 'CASH', '555-0002', 'p2_beta@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (3, 'WIRE', '555-0003', 'p3_gamma@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (4, 'CARD', '555-0004', 'p4_delta@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (6, 'CHECK', '555-0006', 'p6_middle@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (10, 'CARD', '555-0010', 'p10_omega@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (12, 'CASH', '555-0012', 'p12_zeta@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (20, 'WIRE', '555-0020', 'p20_theta@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (30, 'CARD', '555-0030', 'p30_aaaa@example.com');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (1, 'CONSULT', 'Consulting', 'General consulting');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (2, 'AUDIT', 'Auditing', 'Financial audit');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (3, 'TAX', 'Tax Prep', 'Tax preparation');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (4, 'LEGAL', 'Legal Advice', 'Legal advisory');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (5, 'PAYROLL', 'Payroll', 'Payroll processing');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (6, 'ADVISORY', 'Advisory', 'Strategic advisory');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (10, 1, 101, '2023-01-01 10:00:00', '2022-12-01 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (10, 2, 102, '2023-01-02 10:00:00', '2022-12-02 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (20, 1, 201, '2023-02-01 10:00:00', '2023-01-01 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (20, 2, 202, '2023-02-02 10:00:00', '2023-01-02 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (20, 3, 203, '2023-02-03 10:00:00', '2023-01-03 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (20, 4, 204, '2023-02-04 10:00:00', '2023-01-04 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (30, 1, 301, '2023-03-01 10:00:00', '2023-02-01 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (30, 2, 302, '2023-03-02 10:00:00', '2023-02-02 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (30, 3, 303, '2023-03-03 10:00:00', '2023-02-03 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (30, 4, 304, '2023-03-04 10:00:00', '2023-02-04 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (30, 5, 305, '2023-03-05 10:00:00', '2023-02-05 09:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (30, 6, 306, '2023-03-06 10:00:00', '2023-02-06 09:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_email FROM (SELECT LHS.party_id AS party_id, LHS.payment_method_code AS payment_method_code, LHS.party_phone AS party_phone, LHS.party_email AS party_email FROM parties AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT customer_id, COUNT(*) AS n FROM party_services GROUP BY customer_id)) AS RHS ON (LHS.party_id = RHS.n)) ORDER BY party_email;

/*
Gold Result:
('p6_middle@example.com',)
*/

-- Prediction Query
SELECT t1.party_email FROM parties AS t1 JOIN party_services AS t2 ON t1.party_id = t2.customer_id GROUP BY t1.party_email ORDER BY COUNT(*) DESC, t1.party_email NULLS LAST LIMIT 1;

/*
Prediction Result:
('p30_aaaa@example.com',)
*/