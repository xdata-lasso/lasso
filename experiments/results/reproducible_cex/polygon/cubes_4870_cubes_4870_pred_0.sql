-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (16, '1');
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (15, '1');
INSERT INTO "Customer_Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (17, 16, '1', '1000-01-02', '1000-01-02');
INSERT INTO "Claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (20, 17, '1000-01-02', '1000-01-02', 1, 1);
INSERT INTO "Claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (19, NULL, '1000-01-02', '1000-01-02', 1, 1);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (21, 19, '1000-01-02', '1000-01-02', 1, 1, 1);
INSERT INTO "Payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (24, 21, NULL, '1000-01-02', 1);
INSERT INTO "Payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (23, NULL, '25', '1000-01-02', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT payment_method_code_other AS payment_method_code FROM (SELECT LHS.payment_method_code AS payment_method_code, LHS.n AS n, LHS.maxn AS maxn, RHS.payment_method_code AS payment_method_code_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT payment_method_code, n, MAX(n) OVER () AS maxn FROM (SELECT payment_method_code, COUNT(*) AS n FROM payments GROUP BY payment_method_code)) AS LHS CROSS JOIN (SELECT payment_method_code, n, MAX(n) OVER () AS maxn FROM (SELECT payment_method_code, COUNT(*) AS n FROM payments GROUP BY payment_method_code)) AS RHS) WHERE (n < maxn_other AND maxn <= n_other) ORDER BY payment_method_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY COUNT(*) DESC, Payment_Method_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('25',)
*/