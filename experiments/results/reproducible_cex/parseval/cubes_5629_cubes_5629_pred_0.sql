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
-- Inserting into table: individuals --
INSERT INTO "individuals" ("individual_id", "individual_first_name", "individual_middle_name", "inidividual_phone", "individual_email", "individual_address", "individual_last_name") VALUES (1, 'ind_17b2f1', 'ind_b2ef51', 'ind_2cff7c', 'ind_c0e5f6', 'ind_e323f4', 'ind_319cc6');

-- Inserting into table: organizations --
INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (1, '2024-06-15 00:00:00+00:00', 'lhs_f04f11', 'lhs_9b7da9');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483647, '2022-12-08 21:38:59+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483646, '2020-10-31 07:51:16+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483645, '2024-09-28 03:06:45+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483644, '2024-01-16 07:29:50+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483643, '2024-06-06 00:28:47+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483642, '2024-02-11 16:43:27+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483641, '2021-02-21 20:09:01+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483640, '2022-01-21 14:23:36+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483639, '2022-07-05 02:28:20+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483638, '2020-04-05 14:43:51+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483637, '2021-07-31 11:04:01+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483636, '2020-06-20 11:35:06+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483635, '2021-01-23 18:11:33+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483634, '2021-10-06 00:40:57+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483633, '2025-09-01 05:13:03+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483632, '2021-12-08 15:32:00+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483631, '2021-01-29 03:06:29+00:00', 'org_b71921', 'org_d47799');

-- Inserting into table: organization_contact_individuals --
INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, 1, '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483647, '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483646, '2022-06-28 11:34:24+00:00', '2021-06-17 14:22:38+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483645, '2021-10-04 22:30:57+00:00', '2025-02-21 23:30:13+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483644, '2022-02-14 19:27:39+00:00', '2020-11-05 04:59:51+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483643, '2022-10-19 03:44:42+00:00', '2020-09-25 19:25:33+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483642, '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483641, '2020-01-15 18:18:33+00:00', '2023-10-02 15:43:02+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483640, '2022-10-06 13:20:05+00:00', '2023-05-25 17:04:36+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483639, '2025-08-22 00:34:24+00:00', '2022-04-13 09:01:25+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483638, '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483637, '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483636, '2021-07-11 07:27:32+00:00', '2022-07-30 13:34:14+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483635, '2021-07-20 10:41:36+00:00', '2020-03-11 00:23:16+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483634, '2022-01-18 15:57:55+00:00', '2022-04-12 01:47:28+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483633, '2025-03-03 08:26:45+00:00', '2020-05-25 18:19:31+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483632, '2025-04-09 18:22:58+00:00', '2022-06-07 16:30:43+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483631, '2020-08-22 06:30:10+00:00', '2024-02-29 12:08:41+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT organization_name FROM (SELECT LHS.organization_id AS organization_id, LHS.date_formed AS date_formed, LHS.organization_name AS organization_name, LHS.uk_vat_number AS uk_vat_number, RHS.individual_id AS individual_id FROM organizations AS LHS INNER JOIN (SELECT individual_id, MAX(n) OVER () AS n FROM (SELECT individual_id, COUNT(*) AS n FROM organization_contact_individuals GROUP BY individual_id)) AS RHS ON (LHS.organization_id = RHS.n)) ORDER BY organization_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT t1.organization_name FROM organizations AS t1 JOIN organization_contact_individuals AS t2 ON t1.organization_id = t2.organization_id GROUP BY t1.organization_name ORDER BY COUNT(*) DESC, t1.organization_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('org_b71921',)
*/