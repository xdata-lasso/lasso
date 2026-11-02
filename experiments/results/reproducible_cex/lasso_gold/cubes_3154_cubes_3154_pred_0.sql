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
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1016, 'difficult', '+1-329-397-3763');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1017, 'difficult', '+1-565-966-7010x65133');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1018, 'difficult', '(362)247-3178');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1019, 'difficult', '+1-880-213-2677x3602');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1023, 'in', '+1-329-397-3763');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1020, 'in', '+1-329-397-3763');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1021, 'in', '+1-329-397-3763');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1022, 'in', '+1-329-397-3763');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT policy_id, policy_type_code, COUNT(*) AS n FROM available_policies GROUP BY policy_id, policy_type_code) ORDER BY policy_id DESC) LIMIT 1);

/*
Gold Result:
('in',)
*/

-- Prediction Query
SELECT policy_type_code FROM available_policies GROUP BY policy_type_code ORDER BY COUNT(*) DESC, policy_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('difficult',)
*/