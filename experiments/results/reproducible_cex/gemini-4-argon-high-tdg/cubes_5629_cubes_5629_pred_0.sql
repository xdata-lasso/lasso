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
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (1, '2010-01-01 00:00:00', 'Alpha_Min_Org', 'VAT001');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (2, '2011-01-01 00:00:00', 'Beta_Avg_Count_Org', 'VAT002');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (3, '2012-01-01 00:00:00', 'Gamma_Target_Max_Org', 'VAT003');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (4, '2013-01-01 00:00:00', 'Delta_Sum_Total_Org', 'VAT004');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (10, '2014-01-01 00:00:00', 'Epsilon_Contacted_1', 'VAT010');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (20, '2015-01-01 00:00:00', 'Zeta_Contacted_2', 'VAT020');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (30, '2016-01-01 00:00:00', 'Eta_Contacted_3', 'VAT030');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (100, '2017-01-01 00:00:00', 'Theta_Ind100_ID_Org', 'VAT100');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (200, '2018-01-01 00:00:00', 'Iota_Ind200_ID_Org', 'VAT200');
INSERT INTO Individuals (individual_id, individual_first_name, individual_middle_name, inidividual_phone, individual_email, individual_address, individual_last_name) VALUES (100, 'Alice', 'A', '111-1111', 'alice@example.com', '1 First St', 'Smith');
INSERT INTO Individuals (individual_id, individual_first_name, individual_middle_name, inidividual_phone, individual_email, individual_address, individual_last_name) VALUES (200, 'Bob', 'B', '222-2222', 'bob@example.com', '2 Second St', 'Jones');
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id, date_contact_from, date_contact_to) VALUES (100, 10, '2020-01-01 00:00:00', '2020-12-31 00:00:00');
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id, date_contact_from, date_contact_to) VALUES (200, 10, '2020-02-01 00:00:00', '2020-12-31 00:00:00');
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id, date_contact_from, date_contact_to) VALUES (200, 20, '2020-03-01 00:00:00', '2020-12-31 00:00:00');
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id, date_contact_from, date_contact_to) VALUES (200, 30, '2020-04-01 00:00:00', '2020-12-31 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT organization_name FROM (SELECT LHS.organization_id AS organization_id, LHS.date_formed AS date_formed, LHS.organization_name AS organization_name, LHS.uk_vat_number AS uk_vat_number, RHS.individual_id AS individual_id FROM organizations AS LHS INNER JOIN (SELECT individual_id, MAX(n) OVER () AS n FROM (SELECT individual_id, COUNT(*) AS n FROM organization_contact_individuals GROUP BY individual_id)) AS RHS ON (LHS.organization_id = RHS.n)) ORDER BY organization_name;

/*
Gold Result:
('Gamma_Target_Max_Org',)
*/

-- Prediction Query
SELECT t1.organization_name FROM organizations AS t1 JOIN organization_contact_individuals AS t2 ON t1.organization_id = t2.organization_id GROUP BY t1.organization_name ORDER BY COUNT(*) DESC, t1.organization_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Epsilon_Contacted_1',)
*/