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
INSERT INTO "Customers" ("Customer_ID", "Customer_name") VALUES (1, 'Alice Smith');
INSERT INTO "Customers" ("Customer_ID", "Customer_name") VALUES (2, 'Bob Jones');
INSERT INTO "Services" ("Service_ID", "Service_name") VALUES (1, 'Claim Consultation');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (10, 'Life Insurance', '555-0199');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (20, 'Auto Insurance', '555-0100');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (30, 'Life Insurance', '555-0101');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (40, 'Life Insurance', '555-0199');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (50, 'Home Insurance', '555-0150');
INSERT INTO "Customers_Policies" ("Customer_ID", "Policy_ID", "Date_Opened", "Date_Closed") VALUES (1, 10, '2020-01-15', '2025-01-15');
INSERT INTO "Customers_Policies" ("Customer_ID", "Policy_ID", "Date_Opened", "Date_Closed") VALUES (2, 20, '2021-03-10', '2024-03-10');
INSERT INTO "First_Notification_of_Loss" ("FNOL_ID", "Customer_ID", "Policy_ID", "Service_ID") VALUES (100, 1, 10, 1);
INSERT INTO "Claims" ("Claim_ID", "FNOL_ID", "Effective_Date") VALUES (1000, 100, '2022-06-01');
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Effective_Date", "Settlement_Amount") VALUES (5000, 1000, '2022-07-01', 1500.50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_phone" FROM "available_policies" WHERE ("policy_type_code" = 'Life Insurance') ORDER BY customer_phone, available_policies.policy_id NULLS LAST;

/*
Gold Result:
('555-0101',)
('555-0199',)
('555-0199',)
*/

-- Prediction Query
SELECT customer_phone FROM available_policies WHERE policy_type_code = 'Life Insurance';

/*
Prediction Result:
('555-0199',)
('555-0101',)
('555-0199',)
*/