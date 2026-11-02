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
INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483648, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483647, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483646, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483645, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483644, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483643, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483642, NULL, 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483641, NULL, 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483640, NULL, 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483639, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483638, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483637, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483636, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483635, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483634, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483633, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483632, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483631, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483630, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483629, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483628, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483627, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483626, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483625, 'par_82b73f', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483624, 'q_2_bf5c7a', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483623, 'q_2_bf5c7a', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (-2147483622, 'q_2_bf5c7a', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (2, 'par_1d0fc7', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (3, 'par_1d0fc7', 'par_830ef5', 'par_eb0d0b');

INSERT INTO "parties" ("party_id", "payment_method_code", "party_phone", "party_email") VALUES (4, 'par_1d0fc7', 'par_830ef5', 'par_eb0d0b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT * FROM (SELECT * FROM (SELECT payment_method_code, COUNT(*) AS n FROM parties GROUP BY payment_method_code) ORDER BY n DESC) LIMIT 3);

/*
Gold Result:
('par_82b73f',)
(None,)
('par_1d0fc7',)
*/

-- Prediction Query
SELECT payment_method_code FROM parties GROUP BY payment_method_code HAVING COUNT(*) > 3;

/*
Prediction Result:
('par_82b73f',)
*/