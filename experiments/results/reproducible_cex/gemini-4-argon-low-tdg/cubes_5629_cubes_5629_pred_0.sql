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
-- Tests standard semantic mistakes vs the literal Reference Query:
-- 1) Joining LHS.organization_id = RHS.n (max count per individual = 2), where Org 2 has 0 contacts.
-- 2) Distinguishes grouping by individual_id vs organization_id (Org 10 has 3 contacts, max per individual is 2).
-- 3) Tests DISTINCT by having multiple individuals in Organization_Contact_Individuals (which all get n=2 in RHS).
-- 4) Tests MIN vs MAX (Ind 2 has count 1, Org 1 exists).
INSERT INTO Individuals (individual_id, individual_first_name, individual_last_name) VALUES (1, 'Alice', 'Smith');
INSERT INTO Individuals (individual_id, individual_first_name, individual_last_name) VALUES (2, 'Bob', 'Jones');
INSERT INTO Individuals (individual_id, individual_first_name, individual_last_name) VALUES (3, 'Charlie', 'Brown');
INSERT INTO Organizations (organization_id, organization_name) VALUES (1, 'MinCountOrg');
INSERT INTO Organizations (organization_id, organization_name) VALUES (2, 'TargetMaxIndCountOrg');
INSERT INTO Organizations (organization_id, organization_name) VALUES (3, 'MaxOrgCountOrg');
INSERT INTO Organizations (organization_id, organization_name) VALUES (10, 'MostContactsOrg');
INSERT INTO Organizations (organization_id, organization_name) VALUES (20, 'SecondOrgForInd1');
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id) VALUES (1, 10);
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id) VALUES (1, 20);
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id) VALUES (2, 10);
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id) VALUES (3, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT organization_name FROM (SELECT LHS.organization_id AS organization_id, LHS.date_formed AS date_formed, LHS.organization_name AS organization_name, LHS.uk_vat_number AS uk_vat_number, RHS.individual_id AS individual_id FROM organizations AS LHS INNER JOIN (SELECT individual_id, MAX(n) OVER () AS n FROM (SELECT individual_id, COUNT(*) AS n FROM organization_contact_individuals GROUP BY individual_id)) AS RHS ON (LHS.organization_id = RHS.n)) ORDER BY organization_name;

/*
Gold Result:
('TargetMaxIndCountOrg',)
*/

-- Prediction Query
SELECT t1.organization_name FROM organizations AS t1 JOIN organization_contact_individuals AS t2 ON t1.organization_id = t2.organization_id GROUP BY t1.organization_name ORDER BY COUNT(*) DESC, t1.organization_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('MostContactsOrg',)
*/