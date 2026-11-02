-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483648, 'cus_8a62ed');

-- Inserting into table: customer_policies --
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483648, -2147483648, 'cus_56250a', '2025-06-17', '2021-11-08');

-- Inserting into table: claims --
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1, -2147483648, '2025-06-13', '2023-03-15', 1, 1);

INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (3, -2147483648, '2022-12-08', '2020-06-07', 1, 1);

INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (0, -2147483648, '2023-04-14', '2021-12-04', 1, 1);

INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (-1, -2147483648, '2025-04-30', '2022-10-19', 1, 1);

INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (2, -2147483648, '2021-11-08', '2025-06-13', -921145356, NULL);

INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (4, -2147483648, '2022-12-08', '2020-06-07', NULL, -1726781632);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minamount_settled AS amount_settled, amount_claimed FROM (SELECT LHS.claim_id AS claim_id, LHS.policy_id AS policy_id, LHS.date_claim_made AS date_claim_made, LHS.date_claim_settled AS date_claim_settled, LHS.amount_claimed AS amount_claimed, LHS.amount_settled AS amount_settled, LHS.minamount_settled AS minamount_settled, RHS.policy_id AS policy_id_other, RHS.date_claim_made AS date_claim_made_other, RHS.date_claim_settled AS date_claim_settled_other, RHS.amount_claimed AS amount_claimed_other FROM (SELECT claim_id, policy_id, date_claim_made, date_claim_settled, amount_claimed, amount_settled, MIN(amount_settled) OVER () AS minamount_settled FROM claims) AS LHS INNER JOIN claims AS RHS ON (LHS.claim_id = RHS.claim_id AND LHS.minamount_settled = RHS.amount_settled)) ORDER BY amount_settled, amount_claimed NULLS LAST;

/*
Gold Result:
(-1726781632, None)
*/

-- Prediction Query
SELECT Amount_Settled, Amount_Claimed FROM Claims ORDER BY Amount_Settled ASC, Claims.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, -921145356)
*/