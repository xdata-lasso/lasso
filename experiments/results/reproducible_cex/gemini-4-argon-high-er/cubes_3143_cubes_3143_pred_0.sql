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
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (1, '2020-01-01 00:00:00', 'Org A', 'VAT123');
INSERT INTO Individuals (individual_id, individual_first_name, individual_middle_name, inidividual_phone, individual_email, individual_address, individual_last_name) VALUES (1, 'John', 'A', '123456', 'john@example.com', '123 St', 'Smith');
INSERT INTO Individuals (individual_id, individual_first_name, individual_middle_name, inidividual_phone, individual_email, individual_address, individual_last_name) VALUES (2, 'Jane', 'B', '654321', 'jane@example.com', '456 St', 'Smith');
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id, date_contact_from, date_contact_to) VALUES (1, 1, '2020-01-01 00:00:00', '2021-01-01 00:00:00');
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id, date_contact_from, date_contact_to) VALUES (2, 1, '2020-01-01 00:00:00', '2021-01-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT individual_last_name FROM (SELECT * FROM individuals AS LHS WHERE EXISTS(SELECT 1 FROM organization_contact_individuals AS RHS WHERE (LHS.individual_id = RHS.individual_id))) ORDER BY individual_last_name;

/*
Gold Result:
('Smith',)
('Smith',)
*/

-- Prediction Query
SELECT DISTINCT t1.individual_last_name FROM individuals AS t1 JOIN organization_contact_individuals AS t2 ON t1.individual_id = t2.individual_id;

/*
Prediction Result:
('Smith',)
*/