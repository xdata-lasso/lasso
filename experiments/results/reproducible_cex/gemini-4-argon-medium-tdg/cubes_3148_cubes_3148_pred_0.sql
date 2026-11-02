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
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (1, '2022-01-01 00:00:00', 'Zeta Corp', 'VAT300');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (2, '2020-05-15 00:00:00', 'Alpha Inc', 'VAT100');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (3, '2019-11-20 00:00:00', 'Beta LLC', 'VAT200');
INSERT INTO Organizations (organization_id, date_formed, organization_name, uk_vat_number) VALUES (4, '2021-03-10 00:00:00', 'Beta LLC', 'VAT050');
INSERT INTO Individuals (individual_id, individual_first_name, individual_middle_name, inidividual_phone, individual_email, individual_address, individual_last_name) VALUES (1, 'John', 'A', '123456', 'john@example.com', '123 St', 'Doe');
INSERT INTO Individuals (individual_id, individual_first_name, individual_middle_name, inidividual_phone, individual_email, individual_address, individual_last_name) VALUES (2, 'Jane', 'B', '654321', 'jane@example.com', '456 Ave', 'Smith');
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id, date_contact_from, date_contact_to) VALUES (1, 1, '2022-01-02 00:00:00', '2023-01-01 00:00:00');
INSERT INTO Organization_Contact_Individuals (individual_id, organization_id, date_contact_from, date_contact_to) VALUES (2, 1, '2022-02-01 00:00:00', '2023-02-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organization_name FROM organizations ORDER BY organization_name, organizations.organization_id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Beta LLC',)
('Beta LLC',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT organization_name FROM organizations ORDER BY date_formed ASC, organizations.organization_id NULLS LAST;

/*
Prediction Result:
('Beta LLC',)
('Alpha Inc',)
('Beta LLC',)
('Zeta Corp',)
*/