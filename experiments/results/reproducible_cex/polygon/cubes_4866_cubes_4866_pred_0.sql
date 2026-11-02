-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (15, '-550');
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (14, '-550');
INSERT INTO "Customer_Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (18, 14, '-550', '0998-06-30', '0998-06-30');
INSERT INTO "Claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (17, 18, '1000-01-24', '1000-01-25', -550, NULL);
INSERT INTO "Claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (16, 18, '0998-06-30', '0998-06-30', -550, NULL);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (19, 16, '0998-06-30', '0998-06-30', -550, -550, -550);
INSERT INTO "Payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (22, 19, '-550', '0998-06-30', -550);
INSERT INTO "Payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (21, NULL, '-550', '0998-06-30', -550);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT amount_settled, maxamount_claimed AS amount_claimed FROM (SELECT claim_id, policy_id, date_claim_made, date_claim_settled, amount_claimed, amount_settled, amount_claimed AS maxamount_claimed, claim_id_other, policy_id_other, date_claim_made_other, date_claim_settled_other, amount_settled_other FROM (SELECT LHS.claim_id AS claim_id, LHS.policy_id AS policy_id, LHS.date_claim_made AS date_claim_made, LHS.date_claim_settled AS date_claim_settled, LHS.amount_claimed AS amount_claimed, LHS.amount_settled AS amount_settled, LHS.maxamount_claimed AS maxamount_claimed, RHS.claim_id AS claim_id_other, RHS.policy_id AS policy_id_other, RHS.date_claim_made AS date_claim_made_other, RHS.date_claim_settled AS date_claim_settled_other, RHS.amount_settled AS amount_settled_other FROM (SELECT claim_id, policy_id, date_claim_made, date_claim_settled, amount_claimed, amount_settled, MAX(amount_claimed) OVER () AS maxamount_claimed FROM claims) AS LHS INNER JOIN (SELECT claim_id, policy_id, date_claim_made, date_claim_settled, amount_claimed, amount_settled, MAX(amount_claimed) OVER () AS maxamount_claimed FROM claims) AS RHS ON (LHS.amount_claimed = RHS.maxamount_claimed AND LHS.maxamount_claimed = RHS.amount_claimed))) ORDER BY amount_settled, amount_claimed NULLS LAST;

/*
Gold Result:
(None, -550)
(None, -550)
(None, -550)
(None, -550)
*/

-- Prediction Query
SELECT Amount_Settled, Amount_Claimed FROM Claims ORDER BY Amount_Claimed DESC, Claims.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, -550)
*/