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
-- Tests join condition (LHS.claim_id = RHS.settlement_id vs LHS.claim_id = RHS.claim_id),
-- column selection (LHS.effective_date vs RHS.effective_date), and outer join mutations (LEFT/RIGHT JOIN).
INSERT INTO "Customers" ("Customer_ID", "Customer_name") VALUES (1, 'Alice');
INSERT INTO "Services" ("Service_ID", "Service_name") VALUES (1, 'Auto Repair');
INSERT INTO "Available_Policies" ("Policy_ID", "policy_type_code", "Customer_Phone") VALUES (1, 'AUTO', '555-0101');
INSERT INTO "Customers_Policies" ("Customer_ID", "Policy_ID", "Date_Opened", "Date_Closed") VALUES (1, 1, '2020-01-01', '2025-01-01');
INSERT INTO "First_Notification_of_Loss" ("FNOL_ID", "Customer_ID", "Policy_ID", "Service_ID") VALUES (1, 1, 1, 1);
INSERT INTO "Claims" ("Claim_ID", "FNOL_ID", "Effective_Date") VALUES (10, 1, '2023-05-01');
INSERT INTO "Claims" ("Claim_ID", "FNOL_ID", "Effective_Date") VALUES (20, 1, '2023-01-01');
INSERT INTO "Claims" ("Claim_ID", "FNOL_ID", "Effective_Date") VALUES (30, 1, '2023-09-01');
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Effective_Date", "Settlement_Amount") VALUES (10, 20, '2023-12-01', 500.0);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Effective_Date", "Settlement_Amount") VALUES (20, 30, '2023-11-01', 1500.0);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Effective_Date", "Settlement_Amount") VALUES (40, 10, '2023-10-01', 2500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT effective_date FROM (SELECT claim_id, fnol_id, effective_date, claim_id_other, effective_date_other, settlement_amount, claim_id AS settlement_id FROM (SELECT LHS.claim_id AS claim_id, LHS.fnol_id AS fnol_id, LHS.effective_date AS effective_date, RHS.claim_id AS claim_id_other, RHS.effective_date AS effective_date_other, RHS.settlement_amount AS settlement_amount FROM claims AS LHS INNER JOIN settlements AS RHS ON (LHS.claim_id = RHS.settlement_id))) ORDER BY effective_date;

/*
Gold Result:
('2023-01-01',)
('2023-05-01',)
*/

-- Prediction Query
SELECT t1.Effective_Date FROM claims AS t1 JOIN settlements AS t2 ON t1.claim_id = t2.claim_id GROUP BY t1.claim_id ORDER BY SUM(t2.settlement_amount) DESC, t1.Effective_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2023-05-01',)
*/