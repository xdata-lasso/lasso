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
-- Inserting into table: parties --
INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483648, 'par_1d0fc7', 'par_830ef5', 'par_eb0d0b');

-- Inserting into table: services --
INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483648, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (1, 'ser_e717b2', 't1__7c8a70', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (2, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (3, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483646, 'ser_e717b2', 't1__73f2fd', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483643, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483642, 'ser_e717b2', 'ser_877dc9', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483641, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483640, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483639, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483638, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483637, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483636, 'ser_e717b2', 'ser_036160', 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (-2147483635, 'ser_e717b2', NULL, 'ser_2958f0');

INSERT INTO "services" ("service_id", "service_type_code", "service_name", "service_descriptio") VALUES (4, 'ser_e717b2', NULL, 'ser_2958f0');

-- Inserting into table: party_services --
INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, -55602865, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, 1258409369, '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, 247012447, '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 2, -106629402, '2020-11-05 04:59:51+00:00', '2025-11-08 19:01:33+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 2, 89267185, '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 3, 1160656988, '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 3, 1268590800, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 3, 1644814318, '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, 906324270, '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, 13244799, '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, 1526238907, '2021-07-11 07:27:32+00:00', '2022-07-30 13:34:14+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, -1610064545, '2020-03-11 00:23:16+00:00', '2025-02-07 06:53:31+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, 462974032, '2021-12-31 07:20:26+00:00', '2021-12-08 15:32:00+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, -1576219117, '2020-08-22 06:30:10+00:00', '2024-02-29 12:08:41+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 1, 1861536320, '2022-12-10 02:38:39+00:00', '2024-05-04 23:07:19+00:00');

INSERT INTO "party_services" ("customer_id", "service_id", "booking_id", "service_datetime", "booking_made_date") VALUES (-2147483648, 4, -1437333179, '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT service_name FROM (SELECT * FROM services AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT LHS.booking_id AS booking_id, LHS.customer_id AS customer_id, LHS.service_id AS service_id, LHS.service_datetime AS service_datetime, LHS.booking_made_date AS booking_made_date, RHS.service_type_code AS service_type_code, RHS.service_name AS service_name, RHS.service_descriptio AS service_descriptio FROM party_services AS LHS LEFT JOIN services AS RHS ON (LHS.service_id = RHS.service_id)) AS RHS WHERE (LHS.service_name = RHS.service_name))) ORDER BY service_name;

/*
Gold Result:
(None,)
('ser_877dc9',)
('t1__73f2fd',)
*/

-- Prediction Query
SELECT service_name FROM services EXCEPT SELECT t1.service_name FROM services AS t1 JOIN party_services AS t2 ON t1.service_id = t2.service_id;

/*
Prediction Result:
('ser_877dc9',)
('t1__73f2fd',)
*/