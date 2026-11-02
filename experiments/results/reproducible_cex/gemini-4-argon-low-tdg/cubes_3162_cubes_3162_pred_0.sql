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
-- DATASET 2
-- Tests ORDER BY and NULLS LAST behavior, along with multiple distinct policy types for "Dayana Robel".
INSERT INTO "Customers" ("Customer_ID", "Customer_name") VALUES (1, 'Dayana Robel');
INSERT INTO "Customers" ("Customer_ID", "Customer_name") VALUES (2, 'Dayana Robel');
INSERT INTO "Customers" ("Customer_ID", "Customer_name") VALUES (3, 'Dayana Robel');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (101, 'ZEBRA', '555-0201');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (102, 'ALPHA', '555-0202');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (103, NULL, '555-0203');
INSERT INTO "Customers_Policies" ("Customer_ID", "Policy_ID", "Date_Opened", "Date_Closed") VALUES (1, 101, '2021-01-01', NULL);
INSERT INTO "Customers_Policies" ("Customer_ID", "Policy_ID", "Date_Opened", "Date_Closed") VALUES (2, 102, '2021-02-01', NULL);
INSERT INTO "Customers_Policies" ("Customer_ID", "Policy_ID", "Date_Opened", "Date_Closed") VALUES (3, 103, '2021-03-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "policy_type_code" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."policy_id" AS "policy_id", "LHS"."policy_type_code" AS "policy_type_code", "LHS"."customer_phone" AS "customer_phone", "LHS"."date_opened" AS "date_opened", "LHS"."date_closed" AS "date_closed" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."policy_id" AS "policy_id", "LHS"."policy_type_code" AS "policy_type_code", "LHS"."customer_phone" AS "customer_phone", "RHS"."date_opened" AS "date_opened", "RHS"."date_closed" AS "date_closed" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "RHS"."policy_id" AS "policy_id", "RHS"."policy_type_code" AS "policy_type_code", "RHS"."customer_phone" AS "customer_phone" FROM "customers" AS "LHS" CROSS JOIN "available_policies" AS "RHS") AS "LHS" INNER JOIN "customers_policies" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id" AND "LHS"."policy_id" = "RHS"."policy_id")) AS "LHS" INNER JOIN (SELECT * FROM "customers" WHERE ("customer_name" = 'Dayana Robel')) AS RHS ON (LHS.customer_id = RHS.customer_id AND LHS.customer_name = RHS.customer_name)) ORDER BY policy_type_code, "policy_type_code" NULLS LAST;

/*
Gold Result:
(None,)
('ALPHA',)
('ZEBRA',)
*/

-- Prediction Query
SELECT DISTINCT t3.policy_type_code FROM customers AS t1 JOIN customers_policies AS t2 ON t1.customer_id = t2.customer_id JOIN available_policies AS t3 ON t2.policy_id = t3.policy_id WHERE t1.customer_name = 'Dayana Robel';

/*
Prediction Result:
('ZEBRA',)
('ALPHA',)
(None,)
*/