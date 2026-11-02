-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties on minimum amount_settled (with both distinct and duplicate amount_claimed, plus a NULL amount_claimed to test ORDER BY NULLS LAST), and ensures non-minimum rows are filtered out.
-- Also includes disconnected/distinct rows in Settlements, Customer_Policies, and Payments to kill incorrect table or join mutations.
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (1, 'Cust 1');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (10, 1, 'AUTO', '2020-01-01', '2021-01-01');
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (101, 10, '2020-02-01', '2020-03-01', 500, 100);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (102, 10, '2020-02-05', '2020-03-05', 200, 100);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (103, 10, '2020-02-06', '2020-03-06', 200, 100);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (104, 10, '2020-02-07', '2020-03-07', NULL, 100);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (105, 10, '2020-02-10', '2020-03-10', 100, 300);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (106, 10, '2020-02-12', '2020-03-12', 400, NULL);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (1001, 105, '2020-02-10', '2020-03-10', 999, 50, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minamount_settled AS amount_settled, amount_claimed FROM (SELECT LHS.claim_id AS claim_id, LHS.policy_id AS policy_id, LHS.date_claim_made AS date_claim_made, LHS.date_claim_settled AS date_claim_settled, LHS.amount_claimed AS amount_claimed, LHS.amount_settled AS amount_settled, LHS.minamount_settled AS minamount_settled, RHS.policy_id AS policy_id_other, RHS.date_claim_made AS date_claim_made_other, RHS.date_claim_settled AS date_claim_settled_other, RHS.amount_claimed AS amount_claimed_other FROM (SELECT claim_id, policy_id, date_claim_made, date_claim_settled, amount_claimed, amount_settled, MIN(amount_settled) OVER () AS minamount_settled FROM claims) AS LHS INNER JOIN claims AS RHS ON (LHS.claim_id = RHS.claim_id AND LHS.minamount_settled = RHS.amount_settled)) ORDER BY amount_settled, amount_claimed NULLS LAST;

/*
Gold Result:
(100, 200)
(100, 200)
(100, 500)
(100, None)
*/

-- Prediction Query
SELECT Amount_Settled, Amount_Claimed FROM Claims ORDER BY Amount_Settled ASC, Claims.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, 400)
*/