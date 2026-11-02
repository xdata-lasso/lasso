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
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1001, 'purpose', '804-233-2181');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1002, 'Daniel Wagner');
INSERT INTO "services" ("service_id", "service_name") VALUES (1003, 'Cristian Santos');
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (1002, 1001, '1970-01-01', '1971-02-02');
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1004, 1002, 1001, 1003);
INSERT INTO "claims" ("claim_id", "fnol_id", "effective_date") VALUES (1005, 1004, '1972-03-03');
INSERT INTO "claims" ("claim_id", "fnol_id", "effective_date") VALUES (1006, NULL, NULL);
INSERT INTO "settlements" ("settlement_id", "claim_id", "effective_date", "settlement_amount") VALUES (1005, 1006, '1973-04-04', 1007.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT effective_date FROM (SELECT effective_date, MAX(sumsettlement_amount) AS maxsumsettlement_amount FROM (SELECT effective_date, settlement_id, SUM(settlement_amount) AS sumsettlement_amount FROM (SELECT claim_id, fnol_id, effective_date, claim_id_other, effective_date_other, settlement_amount, claim_id AS settlement_id FROM (SELECT LHS.claim_id AS claim_id, LHS.fnol_id AS fnol_id, LHS.effective_date AS effective_date, RHS.claim_id AS claim_id_other, RHS.effective_date AS effective_date_other, RHS.settlement_amount AS settlement_amount FROM claims AS LHS INNER JOIN settlements AS RHS ON (LHS.claim_id = RHS.settlement_id))) GROUP BY effective_date, settlement_id) GROUP BY effective_date) ORDER BY effective_date;

/*
Gold Result:
('1972-03-03',)
*/

-- Prediction Query
SELECT t1.Effective_Date FROM claims AS t1 JOIN settlements AS t2 ON t1.claim_id = t2.claim_id GROUP BY t1.claim_id ORDER BY SUM(t2.settlement_amount) DESC, t1.Effective_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/