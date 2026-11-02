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
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (21, '26');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (20, '26');
INSERT INTO "Services" ("service_id", "service_name") VALUES (23, '26');
INSERT INTO "Services" ("service_id", "service_name") VALUES (22, '26');
INSERT INTO "Available_Policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (24, '26', '26');
INSERT INTO "Available_Policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (19, '26', '26');
INSERT INTO "Customers_Policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (20, 19, '1000-01-27', '1000-01-27');
INSERT INTO "First_Notification_of_Loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (25, 20, 19, NULL);
INSERT INTO "First_Notification_of_Loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (37, NULL, NULL, 22);
INSERT INTO "Claims" ("claim_id", "fnol_id", "effective_date") VALUES (26, NULL, NULL);
INSERT INTO "Claims" ("claim_id", "fnol_id", "effective_date") VALUES (27, 37, NULL);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "effective_date", "settlement_amount") VALUES (26, 26, NULL, NULL);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "effective_date", "settlement_amount") VALUES (27, 27, '1000-02-08', 649);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT effective_date FROM (SELECT effective_date, MAX(sumsettlement_amount) AS maxsumsettlement_amount FROM (SELECT effective_date, settlement_id, SUM(settlement_amount) AS sumsettlement_amount FROM (SELECT claim_id, fnol_id, effective_date, claim_id_other, effective_date_other, settlement_amount, claim_id AS settlement_id FROM (SELECT LHS.claim_id AS claim_id, LHS.fnol_id AS fnol_id, LHS.effective_date AS effective_date, RHS.claim_id AS claim_id_other, RHS.effective_date AS effective_date_other, RHS.settlement_amount AS settlement_amount FROM claims AS LHS INNER JOIN settlements AS RHS ON (LHS.claim_id = RHS.settlement_id))) GROUP BY effective_date, settlement_id) GROUP BY effective_date) ORDER BY effective_date;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT t1.Effective_Date FROM claims AS t1 JOIN settlements AS t2 ON t1.claim_id = t2.claim_id GROUP BY t1.claim_id ORDER BY SUM(t2.settlement_amount) DESC, t1.Effective_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/