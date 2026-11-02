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
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (1, 'CARD', '555-0001', 'one@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (2, 'CASH', '555-0002', 'two@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (3, 'BANK', '555-0003', 'three@example.com');
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (4, 'CARD', '555-0004', 'four@example.com');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (10, 'S1', 'Service A', 'Desc A');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (20, 'S2', 'Service B', 'Desc B');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (4, 10, 1001, '2023-01-01', '2022-12-01');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (4, 10, 1002, '2023-01-02', '2022-12-02');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (4, 20, 1003, '2023-01-03', '2022-12-03');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (1, 10, 1004, '2023-01-04', '2022-12-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_email FROM (SELECT LHS.party_id AS party_id, LHS.payment_method_code AS payment_method_code, LHS.party_phone AS party_phone, LHS.party_email AS party_email FROM parties AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT customer_id, COUNT(*) AS n FROM party_services GROUP BY customer_id)) AS RHS ON (LHS.party_id = RHS.n)) ORDER BY party_email;

/*
Gold Result:
('three@example.com',)
*/

-- Prediction Query
SELECT t1.party_email FROM parties AS t1 JOIN party_services AS t2 ON t1.party_id = t2.customer_id GROUP BY t1.party_email ORDER BY COUNT(*) DESC, t1.party_email NULLS LAST LIMIT 1;

/*
Prediction Result:
('four@example.com',)
*/