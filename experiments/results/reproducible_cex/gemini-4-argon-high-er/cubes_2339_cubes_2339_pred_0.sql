-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (1, 'Customer A');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (1, 1, 'AUTO', '2020-01-01', '2021-01-01');
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (1, 1, '2020-02-01', '2020-02-10', 100, 100);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (1, 1, '2020-02-01', '2020-02-10', 100, 100, 1);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (2, 1, '2020-02-01', '2020-02-10', 200, 100, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT claim_id, n AS count___ FROM (SELECT claim_id, policy_id, COUNT(*) AS n FROM (SELECT LHS.settlement_id AS settlement_id, LHS.claim_id AS claim_id, LHS.date_claim_made AS date_claim_made, LHS.date_claim_settled AS date_claim_settled, LHS.amount_claimed AS amount_claimed, LHS.amount_settled AS amount_settled, LHS.customer_policy_id AS customer_policy_id, RHS.policy_id AS policy_id FROM settlements AS LHS LEFT JOIN claims AS RHS ON (LHS.claim_id = RHS.claim_id AND LHS.date_claim_made = RHS.date_claim_made AND LHS.date_claim_settled = RHS.date_claim_settled AND LHS.amount_claimed = RHS.amount_claimed AND LHS.amount_settled = RHS.amount_settled)) GROUP BY claim_id, policy_id) ORDER BY claim_id, count___ NULLS LAST;

/*
Gold Result:
(1, 1)
(1, 1)
*/

-- Prediction Query
SELECT T1.Claim_id, COUNT(*) FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id = T2.claim_id GROUP BY T1.claim_id;

/*
Prediction Result:
(1, 2)
*/