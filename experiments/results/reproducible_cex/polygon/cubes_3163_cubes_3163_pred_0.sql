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
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (11, '2331');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (12, '2331');
INSERT INTO "Services" ("service_id", "service_name") VALUES (14, '2331');
INSERT INTO "Services" ("service_id", "service_name") VALUES (13, '2331');
INSERT INTO "Available_Policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (16, '2331', '2331');
INSERT INTO "Available_Policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (15, '2331', '2331');
INSERT INTO "Customers_Policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (12, 15, '1006-05-21', '1006-05-21');
INSERT INTO "Customers_Policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (11, 16, '1006-05-21', '1006-05-21');
INSERT INTO "First_Notification_of_Loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (17, 11, 15, 13);
INSERT INTO "Claims" ("claim_id", "fnol_id", "effective_date") VALUES (18, 17, '1006-05-21');
INSERT INTO "Settlements" ("settlement_id", "claim_id", "effective_date", "settlement_amount") VALUES (20, 18, '1000-01-22', NULL);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "effective_date", "settlement_amount") VALUES (19, 18, '1006-05-21', 2331);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM(settlement_amount) OVER () AS sum_settlement_amount_, meansettlement_amount AS avg_settlement_amount_ FROM (SELECT settlement_id, claim_id, effective_date, settlement_amount, AVG(settlement_amount) OVER () AS meansettlement_amount FROM settlements) ORDER BY sum_settlement_amount_, avg_settlement_amount_ NULLS LAST;

/*
Gold Result:
(2331.0, 2331.0)
*/

-- Prediction Query
SELECT SUM(settlement_amount), AVG(settlement_amount) FROM settlements;

/*
Prediction Result:
(2331.0, 2331.0)
*/