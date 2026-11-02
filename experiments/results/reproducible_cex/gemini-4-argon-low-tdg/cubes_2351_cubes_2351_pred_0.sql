-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests join conditions (claim_id AND date_claim_settled), inner vs outer joins (unmatched claims), and ordering (by count then claim_id)
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (1, 'Cust 1');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (10, 1, 'AUTO', '2020-01-01', '2025-01-01');
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (1, 10, '2021-01-01', '2021-02-01', 1000, 900);
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (2, 10, '2021-01-01', '2021-02-01', 2000, 1800);
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (3, 10, '2021-01-01', '2021-02-01', 1000, 900);
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (4, 10, '2021-01-01', '2021-02-01', 3000, 2500);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (101, 1, '2021-01-05', '2021-02-01', 9999, 8888, 99);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (102, 1, '2021-01-01', '2021-02-01', 1000, 900, 10);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (103, 1, '2021-01-01', '2021-03-01', 1000, 900, 10);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (104, 2, '2021-01-02', '2021-02-01', 5000, 4000, 88);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (105, 3, '2021-01-03', '2021-02-01', 7000, 6000, 77);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, claim_id FROM (SELECT amount_claimed, claim_id, COUNT(*) AS n FROM (SELECT LHS.claim_id AS claim_id, LHS.policy_id AS policy_id, LHS.date_claim_made AS date_claim_made, LHS.date_claim_settled AS date_claim_settled, LHS.amount_claimed AS amount_claimed, LHS.amount_settled AS amount_settled, RHS.settlement_id AS settlement_id, RHS.date_claim_made AS date_claim_made_other, RHS.amount_claimed AS amount_claimed_other, RHS.amount_settled AS amount_settled_other, RHS.customer_policy_id AS customer_policy_id FROM claims AS LHS INNER JOIN settlements AS RHS ON (LHS.claim_id = RHS.claim_id AND LHS.date_claim_settled = RHS.date_claim_settled)) GROUP BY amount_claimed, claim_id) ORDER BY count___, claim_id NULLS LAST;

/*
Gold Result:
(1, 2)
(1, 3)
(2, 1)
*/

-- Prediction Query
SELECT COUNT(*), T1.claim_id FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id = T2.claim_id GROUP BY T1.claim_id ORDER BY T1.Date_Claim_Settled DESC, COUNT(*) NULLS LAST, T1.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 2)
*/