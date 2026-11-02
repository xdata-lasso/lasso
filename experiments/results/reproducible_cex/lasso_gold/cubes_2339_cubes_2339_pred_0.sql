-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1001, 'purpose');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1008, 'purpose');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1002, 1001, 'brother', '1970-01-01', '1971-02-02');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1009, 1001, 'brother', '1970-01-01', '1971-02-02');
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1003, 1002, '1972-03-03', '1973-04-04', 1004, 1005);
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1011, 1002, NULL, NULL, NULL, NULL);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1006, 1003, '1972-03-03', '1973-04-04', 1004, 1005, 1007);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1012, NULL, NULL, NULL, NULL, NULL, 1007);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT claim_id, n AS count___ FROM (SELECT claim_id, policy_id, COUNT(*) AS n FROM (SELECT LHS.settlement_id AS settlement_id, LHS.claim_id AS claim_id, LHS.date_claim_made AS date_claim_made, LHS.date_claim_settled AS date_claim_settled, LHS.amount_claimed AS amount_claimed, LHS.amount_settled AS amount_settled, LHS.customer_policy_id AS customer_policy_id, RHS.policy_id AS policy_id FROM settlements AS LHS LEFT JOIN claims AS RHS ON (LHS.claim_id = RHS.claim_id AND LHS.date_claim_made = RHS.date_claim_made AND LHS.date_claim_settled = RHS.date_claim_settled AND LHS.amount_claimed = RHS.amount_claimed AND LHS.amount_settled = RHS.amount_settled)) GROUP BY claim_id, policy_id) ORDER BY claim_id, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(1003, 1)
*/

-- Prediction Query
SELECT T1.Claim_id, COUNT(*) FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id = T2.claim_id GROUP BY T1.claim_id;

/*
Prediction Result:
(1003, 1)
*/