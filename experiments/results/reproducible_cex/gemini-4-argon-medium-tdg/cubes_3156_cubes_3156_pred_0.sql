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
-- DATASET 1
-- Tests basic WHERE filtering, duplicate preservation (SELECT vs SELECT DISTINCT), and inverse ordering of Policy_ID vs Customer_Phone.
INSERT INTO "Customers" ("Customer_ID", "Customer_name") VALUES (1, 'Alice Smith');
INSERT INTO "Customers" ("Customer_ID", "Customer_name") VALUES (2, 'Bob Jones');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (10, 'Life Insurance', '555-0200');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (20, 'Auto Insurance', '555-0150');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (30, 'Life Insurance', '555-0100');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (40, 'Life Insurance', '555-0200');
-- Only linking Policy 10 and 20 to Customers_Policies so Policy 30 and 40 remain unlinked (catches unnecessary INNER JOINs with Customers_Policies).
INSERT INTO "Customers_Policies" ("Customer_ID", "Policy_ID", "Date_Opened", "Date_Closed") VALUES (1, 10, '2020-01-01', '2025-01-01');
INSERT INTO "Customers_Policies" ("Customer_ID", "Policy_ID", "Date_Opened", "Date_Closed") VALUES (2, 20, '2021-01-01', '2026-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_phone" FROM "available_policies" WHERE ("policy_type_code" = 'Life Insurance') ORDER BY customer_phone, available_policies.policy_id NULLS LAST;

/*
Gold Result:
('555-0100',)
('555-0200',)
('555-0200',)
*/

-- Prediction Query
SELECT customer_phone FROM available_policies WHERE policy_type_code = 'Life Insurance';

/*
Prediction Result:
('555-0200',)
('555-0100',)
('555-0200',)
*/