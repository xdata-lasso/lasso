-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (16, '24');
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (15, '24');
INSERT INTO "Customer_Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (18, 15, '24', '1000-01-25', '1000-01-25');
INSERT INTO "Customer_Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (17, 15, '24', '1000-01-25', '1000-01-25');
INSERT INTO "Claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (24, NULL, NULL, '1000-02-01', NULL, 35);
INSERT INTO "Claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (23, NULL, NULL, '1000-02-14', NULL, NULL);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (22, 23, '1000-02-06', '1000-02-02', 37, 38, 39);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (21, 24, NULL, '1000-02-01', 41, NULL, NULL);
INSERT INTO "Payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (26, 21, '24', '1000-01-25', 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, claim_id FROM (SELECT amount_claimed, claim_id, COUNT(*) AS n FROM (SELECT LHS.claim_id AS claim_id, LHS.policy_id AS policy_id, LHS.date_claim_made AS date_claim_made, LHS.date_claim_settled AS date_claim_settled, LHS.amount_claimed AS amount_claimed, LHS.amount_settled AS amount_settled, RHS.settlement_id AS settlement_id, RHS.date_claim_made AS date_claim_made_other, RHS.amount_claimed AS amount_claimed_other, RHS.amount_settled AS amount_settled_other, RHS.customer_policy_id AS customer_policy_id FROM claims AS LHS INNER JOIN settlements AS RHS ON (LHS.claim_id = RHS.claim_id AND LHS.date_claim_settled = RHS.date_claim_settled)) GROUP BY amount_claimed, claim_id) ORDER BY count___, claim_id NULLS LAST;

/*
Gold Result:
(1, 24)
*/

-- Prediction Query
SELECT COUNT(*), T1.claim_id FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id = T2.claim_id GROUP BY T1.claim_id ORDER BY T1.Date_Claim_Settled DESC, COUNT(*) NULLS LAST, T1.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 23)
*/