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
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (14, '-388');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (13, '-388');
INSERT INTO "Services" ("service_id", "service_name") VALUES (16, '-388');
INSERT INTO "Services" ("service_id", "service_name") VALUES (15, '-388');
INSERT INTO "Available_Policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (12, '-388', '-388');
INSERT INTO "Customers_Policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (13, 12, '0998-12-09', '0998-12-09');
INSERT INTO "First_Notification_of_Loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (17, 13, 12, 15);
INSERT INTO "Claims" ("claim_id", "fnol_id", "effective_date") VALUES (18, 17, '0998-12-09');
INSERT INTO "Settlements" ("settlement_id", "claim_id", "effective_date", "settlement_amount") VALUES (20, 18, '1000-01-22', NULL);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "effective_date", "settlement_amount") VALUES (19, 18, '0998-12-09', -388);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(settlement_amount) OVER () AS max_settlement_amount_, minsettlement_amount AS min_settlement_amount_ FROM (SELECT settlement_id, claim_id, effective_date, settlement_amount, MIN(settlement_amount) OVER () AS minsettlement_amount FROM settlements) ORDER BY max_settlement_amount_, min_settlement_amount_ NULLS LAST;

/*
Gold Result:
(-388.0, -388.0)
*/

-- Prediction Query
SELECT MAX(settlement_amount), MIN(settlement_amount) FROM settlements;

/*
Prediction Result:
(-388.0, -388.0)
*/