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
INSERT INTO "individuals" ("individual_id", "individual_first_name", "individual_middle_name", "inidividual_phone", "individual_email", "individual_address", "individual_last_name") VALUES (1, 'lhs_2876ad', 'lhs_ccee55', 'lhs_8654d9', 'lhs_d79ad3', 'lhs_1dc451', 'lhs_9cad58');

INSERT INTO "individuals" ("individual_id", "individual_first_name", "individual_middle_name", "inidividual_phone", "individual_email", "individual_address", "individual_last_name") VALUES (-2147483648, 'lhs_d82305', 'lhs_d11418', 'lhs_52815f', 'lhs_77b7bd', 'lhs_11bc7c', 'lhs_e3add2');

INSERT INTO "individuals" ("individual_id", "individual_first_name", "individual_middle_name", "inidividual_phone", "individual_email", "individual_address", "individual_last_name") VALUES (-2147483646, 'ind_17b2f1', 'ind_b2ef51', 'ind_2cff7c', 'ind_c0e5f6', 'ind_e323f4', 'q_0_c213e1');

INSERT INTO "individuals" ("individual_id", "individual_first_name", "individual_middle_name", "inidividual_phone", "individual_email", "individual_address", "individual_last_name") VALUES (-2147483645, 'ind_17b2f1', 'ind_b2ef51', 'ind_2cff7c', 'ind_c0e5f6', 'ind_e323f4', 'q_0_c213e1');

INSERT INTO "individuals" ("individual_id", "individual_first_name", "individual_middle_name", "inidividual_phone", "individual_email", "individual_address", "individual_last_name") VALUES (2, 'ind_17b2f1', 'ind_b2ef51', 'ind_2cff7c', 'ind_c0e5f6', 'ind_e323f4', 'ind_319cc6');

INSERT INTO "individuals" ("individual_id", "individual_first_name", "individual_middle_name", "inidividual_phone", "individual_email", "individual_address", "individual_last_name") VALUES (3, 'ind_17b2f1', 'ind_b2ef51', 'ind_2cff7c', 'ind_c0e5f6', 'ind_e323f4', 'ind_319cc6');

-- Inserting into table: organizations --
INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483648, '2024-12-15 00:56:33+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483647, '2021-05-28 17:00:04+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483646, '2023-01-16 20:10:41+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483645, '2022-06-28 11:34:24+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483644, '2025-02-21 23:30:13+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483643, '2022-02-14 19:27:39+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483642, '2024-06-06 00:28:47+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483641, '2024-02-11 16:43:27+00:00', 'org_b71921', 'org_d47799');

INSERT INTO "organizations" ("organization_id", "date_formed", "organization_name", "uk_vat_number") VALUES (-2147483640, '2021-02-21 20:09:01+00:00', 'org_b71921', 'org_d47799');

-- Inserting into table: organization_contact_individuals --
INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483648, '2025-11-23 07:28:46+00:00', '2025-10-14 06:39:08+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483647, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483646, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483645, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483644, '2024-07-26 19:47:18+00:00', '2020-04-30 23:22:06+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483643, '2020-11-05 04:59:51+00:00', '2025-11-08 19:01:33+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483642, '2022-10-19 03:44:42+00:00', '2020-09-25 19:25:33+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483641, '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (1, -2147483640, '2020-01-15 18:18:33+00:00', '2023-10-02 15:43:02+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (2, -2147483642, '2022-01-21 14:23:36+00:00', '2022-10-06 13:20:05+00:00');

INSERT INTO "organization_contact_individuals" ("individual_id", "organization_id", "date_contact_from", "date_contact_to") VALUES (3, -2147483642, '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT individual_last_name FROM (SELECT * FROM individuals AS LHS WHERE EXISTS(SELECT 1 FROM organization_contact_individuals AS RHS WHERE (LHS.individual_id = RHS.individual_id))) ORDER BY individual_last_name;

/*
Gold Result:
('ind_319cc6',)
('ind_319cc6',)
('lhs_9cad58',)
*/

-- Prediction Query
SELECT DISTINCT t1.individual_last_name FROM individuals AS t1 JOIN organization_contact_individuals AS t2 ON t1.individual_id = t2.individual_id;

/*
Prediction Result:
('lhs_9cad58',)
('ind_319cc6',)
*/