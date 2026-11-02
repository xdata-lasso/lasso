-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1013, 'face');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1014, 1013, 'election', '1978-09-09', '1979-10-10');
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (1015, 1014, '1980-11-11', '1981-01-12', 1016, 1017);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1018, 1015, '1982-02-13', '1983-03-14', 1019, 1020, 1021);
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1025, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1018, 1018, 'dog', '1984-04-15', 1022);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1023, 1018, 'chair', '1985-05-16', 1024);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1025, 1018, 'dog', '1984-04-15', 1022);
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1026, 1025, 'chair', '1985-05-16', 1024);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT payment_method_code, MIN(n) AS minn FROM (SELECT payment_method_code, settlement_id, COUNT(*) AS n FROM (SELECT payment_id, payment_id AS settlement_id, payment_method_code, date_payment_made, amount_payment, payment_id_other, payment_method_code_other, date_payment_made_other, amount_payment_other FROM (SELECT LHS.payment_id AS payment_id, LHS.settlement_id AS settlement_id, LHS.payment_method_code AS payment_method_code, LHS.date_payment_made AS date_payment_made, LHS.amount_payment AS amount_payment, RHS.payment_id AS payment_id_other, RHS.payment_method_code AS payment_method_code_other, RHS.date_payment_made AS date_payment_made_other, RHS.amount_payment AS amount_payment_other FROM payments AS LHS INNER JOIN payments AS RHS ON (LHS.payment_id = RHS.settlement_id))) GROUP BY payment_method_code, settlement_id) GROUP BY payment_method_code) ORDER BY payment_method_code;

/*
Gold Result:
('dog',)
*/

-- Prediction Query
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY COUNT(*) ASC, Payment_Method_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('chair',)
*/