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
INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (1020, NULL, 'Watts, Robinson and Nguyen', 'white');
INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (1021, NULL, 'Perez Inc', 'yes');
INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (1022, NULL, 'Morales-Jones', 'our');
INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (1023, NULL, 'Edwards, Rios and Foster', 'past');
INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (1024, NULL, 'Ellis, Baker and Wright', 'inside');
INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (1025, NULL, 'Ryan, Burgess and Patterson', 'high');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT organization_name FROM (SELECT LHS.organization_id AS organization_id, LHS.date_formed AS date_formed, LHS.organization_name AS organization_name, LHS.uk_vat_number AS uk_vat_number, LHS.maxdate_formed AS maxdate_formed, RHS.organization_id AS organization_id_other, RHS.date_formed AS date_formed_other, RHS.organization_name AS organization_name_other, RHS.uk_vat_number AS uk_vat_number_other, RHS.maxdate_formed AS maxdate_formed_other FROM (SELECT organization_id, date_formed, organization_name, uk_vat_number, MAX(date_formed) OVER () AS maxdate_formed FROM organizations) AS LHS CROSS JOIN (SELECT organization_id, date_formed, organization_name, uk_vat_number, MAX(date_formed) OVER () AS maxdate_formed FROM organizations) AS RHS) WHERE (date_formed >= maxdate_formed_other AND maxdate_formed >= maxdate_formed_other) ORDER BY organization_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT organization_name FROM organizations ORDER BY date_formed DESC, organizations.organization_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Watts, Robinson and Nguyen',)
*/