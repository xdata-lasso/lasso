-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1001, 'purpose');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1002, 1001, 'brother', '1970-01-01', '1971-02-02');
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1003, 1002, '1972-03-03', '1973-04-04', 1004, 1005);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1006, 1003, '1974-05-05', '1975-06-06', 1007, 1008, 1009);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1011, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1006, 1006, 'ago', '1976-07-07', 1010);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1011, 1011, 'site', '1977-08-08', 1012);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT LHS.payment_id AS payment_id, LHS.settlement_id AS settlement_id, LHS.payment_method_code AS payment_method_code, LHS.date_payment_made AS date_payment_made, LHS.amount_payment AS amount_payment, RHS.amount_payment AS amount_payment_other, RHS.n AS n FROM payments AS LHS INNER JOIN (SELECT amount_payment, settlement_id, COUNT(*) AS n FROM payments GROUP BY amount_payment, settlement_id) AS RHS ON (LHS.payment_id = RHS.settlement_id)) ORDER BY payment_method_code;

/*
Gold Result:
('ago',)
('site',)
*/

-- Prediction Query
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY COUNT(*) ASC, Payment_Method_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('ago',)
*/