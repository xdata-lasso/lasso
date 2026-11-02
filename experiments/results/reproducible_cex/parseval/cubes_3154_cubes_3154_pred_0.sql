-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_name" TEXT(40));

CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_name" TEXT(40));

CREATE TABLE "Available_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "policy_type_code" TEXT(15), "Customer_Phone" TEXT(255));

CREATE TABLE "Customers_Policies" ("Customer_ID" INTEGER UNIQUE, "Policy_ID" INTEGER UNIQUE, "Date_Opened" DATE, "Date_Closed" DATE, PRIMARY KEY ("Customer_ID", "Policy_ID"), FOREIGN KEY ("Policy_ID") REFERENCES "Available_Policies" ("Policy_ID"), FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "First_Notification_of_Loss" ("FNOL_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_ID" INTEGER, "Service_ID" INTEGER, FOREIGN KEY ("Customer_ID") REFERENCES "Customers_Policies" ("Customer_ID"), FOREIGN KEY ("Policy_ID") REFERENCES "Customers_Policies" ("Policy_ID"), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "FNOL_ID" INTEGER, "Effective_Date" DATE, FOREIGN KEY ("FNOL_ID") REFERENCES "First_Notification_of_Loss" ("FNOL_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Effective_Date" DATE, "Settlement_Amount" REAL, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: available_policies --
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483648, 'ava_d9a9df', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483647, 'ava_d9a9df', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483646, 'ava_d9a9df', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (2, 'ava_d9a9df', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (3, 'ava_d9a9df', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483645, 'ava_d9a9df', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483642, 'O', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483641, 'O', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483640, 'A', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483639, 'U', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483638, 'U', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483637, '!', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483636, 'O', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483635, 'O', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483634, 'A', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483633, 'G', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483632, 'G', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483631, 'A', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483630, 'ava_d9a9df', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483629, 'ava_d9a9df', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483628, 'ava_d9a9df', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483627, NULL, 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483626, NULL, 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483625, NULL, 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (5, 'ava_688954', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (4, 'ava_688954', 'ava_89bb8a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT policy_id, policy_type_code, COUNT(*) AS n FROM available_policies GROUP BY policy_id, policy_type_code) ORDER BY policy_id DESC) LIMIT 1);

/*
Gold Result:
('ava_688954',)
*/

-- Prediction Query
SELECT policy_type_code FROM available_policies GROUP BY policy_type_code ORDER BY COUNT(*) DESC, policy_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('ava_d9a9df',)
*/