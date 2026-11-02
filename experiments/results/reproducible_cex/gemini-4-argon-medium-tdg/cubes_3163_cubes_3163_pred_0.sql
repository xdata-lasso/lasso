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
INSERT INTO "Customers" ("Customer_ID", "Customer_name") VALUES (1, 'Charlie');
INSERT INTO "Services" ("Service_ID", "Service_name") VALUES (1, 'Glass');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (1, 'AUTO', '555-6666');
INSERT INTO "Customers_Policies" ("Customer_ID", "Policy_ID", "Date_Opened", "Date_Closed") VALUES (1, 1, '2021-01-01', '2022-01-01');
INSERT INTO "First_Notification_of_Loss" ("FNOL_ID", "Customer_ID", "Policy_ID", "Service_ID") VALUES (1, 1, 1, 1);
INSERT INTO "Claims" ("Claim_ID", "FNOL_ID", "Effective_Date") VALUES (1, 1, '2021-02-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM(settlement_amount) OVER () AS sum_settlement_amount_, meansettlement_amount AS avg_settlement_amount_ FROM (SELECT settlement_id, claim_id, effective_date, settlement_amount, AVG(settlement_amount) OVER () AS meansettlement_amount FROM settlements) ORDER BY sum_settlement_amount_, avg_settlement_amount_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(settlement_amount), AVG(settlement_amount) FROM settlements;

/*
Prediction Result:
(None, None)
*/