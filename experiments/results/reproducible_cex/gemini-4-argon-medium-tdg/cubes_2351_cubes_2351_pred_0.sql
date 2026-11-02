-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN matching, multiple settlements per claim, and ORDER BY count___ ASC, claim_id ASC.
-- Also tests grouping solely by claim_id vs amount_claimed (Claims 101 and 102 share the same amount_claimed).
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (1, 'Alice Smith');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (10, 1, 'AUTO', '2020-01-01', '2021-01-01');
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (101, 10, '2020-02-01', '2020-03-01', 500, 400);
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (102, 10, '2020-02-05', '2020-03-05', 500, 500);
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (103, 10, '2020-02-10', '2020-03-10', 1000, 900);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (1001, 101, '2020-02-01', '2020-03-01', 500, 200, 10);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (1002, 101, '2020-02-01', '2020-03-01', 500, 200, 10);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (1003, 102, '2020-02-05', '2020-03-05', 500, 500, 10);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (1004, 103, '2020-02-10', '2020-03-10', 1000, 900, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, claim_id FROM (SELECT amount_claimed, claim_id, COUNT(*) AS n FROM (SELECT LHS.claim_id AS claim_id, LHS.policy_id AS policy_id, LHS.date_claim_made AS date_claim_made, LHS.date_claim_settled AS date_claim_settled, LHS.amount_claimed AS amount_claimed, LHS.amount_settled AS amount_settled, RHS.settlement_id AS settlement_id, RHS.date_claim_made AS date_claim_made_other, RHS.amount_claimed AS amount_claimed_other, RHS.amount_settled AS amount_settled_other, RHS.customer_policy_id AS customer_policy_id FROM claims AS LHS INNER JOIN settlements AS RHS ON (LHS.claim_id = RHS.claim_id AND LHS.date_claim_settled = RHS.date_claim_settled)) GROUP BY amount_claimed, claim_id) ORDER BY count___, claim_id NULLS LAST;

/*
Gold Result:
(1, 102)
(1, 103)
(2, 101)
*/

-- Prediction Query
SELECT COUNT(*), T1.claim_id FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id = T2.claim_id GROUP BY T1.claim_id ORDER BY T1.Date_Claim_Settled DESC, COUNT(*) NULLS LAST, T1.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 103)
*/