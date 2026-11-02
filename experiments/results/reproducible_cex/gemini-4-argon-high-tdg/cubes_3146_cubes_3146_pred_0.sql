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
-- DATASET 8
INSERT INTO Parties (party_id, payment_method_code, party_phone, party_email) VALUES (1, 'CARD', '555-0801', 'p1@example.com');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (1, 'SHARED_CODE', 'Booked Service', 'SHARED_DESC');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (2, 'SHARED_CODE', 'Unbooked Service', 'SHARED_DESC');
INSERT INTO Services (service_id, service_type_code, service_name, service_descriptio) VALUES (3, 'NULL_NAME_CODE', NULL, 'Null Name Desc');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (1, 1, 60, '2023-09-01 10:00:00', '2023-08-15 10:00:00');
INSERT INTO Party_Services (customer_id, service_id, booking_id, service_datetime, booking_made_date) VALUES (1, 3, 61, '2023-09-02 10:00:00', '2023-08-16 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT service_name FROM (SELECT * FROM services AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT LHS.booking_id AS booking_id, LHS.customer_id AS customer_id, LHS.service_id AS service_id, LHS.service_datetime AS service_datetime, LHS.booking_made_date AS booking_made_date, RHS.service_type_code AS service_type_code, RHS.service_name AS service_name, RHS.service_descriptio AS service_descriptio FROM party_services AS LHS LEFT JOIN services AS RHS ON (LHS.service_id = RHS.service_id)) AS RHS WHERE (LHS.service_name = RHS.service_name))) ORDER BY service_name;

/*
Gold Result:
(None,)
('Unbooked Service',)
*/

-- Prediction Query
SELECT service_name FROM services EXCEPT SELECT t1.service_name FROM services AS t1 JOIN party_services AS t2 ON t1.service_id = t2.service_id;

/*
Prediction Result:
('Unbooked Service',)
*/