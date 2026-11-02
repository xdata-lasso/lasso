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
INSERT INTO "claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (-2147483648, -2147483648, '2025-06-13', '2023-03-15', -664303813, -1022641847);

-- Inserting into table: settlements --
INSERT INTO "settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (1, -2147483648, '2021-02-05', '2023-04-14', 247012447, -1980249628, -734455130);

-- Inserting into table: payments --
INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483648, 1, 'pay_d1cae8', '2020-09-26', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483647, 1, 'pay_d1cae8', '2025-06-04', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483646, 1, 'pay_d1cae8', '2021-05-05', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (1, 1, 'lhs_55bded', '2024-06-15', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483644, 1, 'pay_d1cae8', '2023-01-06', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483643, 1, 'pay_d1cae8', '2021-07-04', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483642, 1, 'pay_d1cae8', '2020-01-20', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483641, 1, NULL, '2024-12-12', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483640, 1, NULL, '2024-03-30', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483639, 1, NULL, '2022-09-17', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483638, 1, 'pay_d1cae8', '2023-08-23', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483637, 1, 'pay_d1cae8', '2024-06-23', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483636, 1, 'pay_d1cae8', '2021-03-30', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483635, 1, 'pay_d1cae8', NULL, 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483634, 1, 'pay_d1cae8', NULL, 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483633, 1, 'pay_d1cae8', NULL, 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483632, 1, 'pay_d1cae8', '2023-01-03', NULL);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483631, 1, 'pay_d1cae8', '2023-11-30', NULL);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483630, 1, 'pay_d1cae8', '2020-05-06', NULL);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483629, 1, 'pay_d1cae8', '2020-03-30', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483628, 1, 'pay_d1cae8', '2022-08-24', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483627, 1, 'pay_d1cae8', '2025-08-22', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483626, 1, 'pay_d1cae8', '2022-01-31', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483625, 1, 'pay_d1cae8', '2023-08-07', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483624, 1, 'pay_d1cae8', '2021-04-10', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483623, 1, 'pay_d1cae8', '2023-10-03', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483622, 1, 'pay_d1cae8', '2020-08-14', 1);

INSERT INTO "payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (-2147483621, 1, 'pay_d1cae8', '2022-01-04', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT LHS.payment_id AS payment_id, LHS.settlement_id AS settlement_id, LHS.payment_method_code AS payment_method_code, LHS.date_payment_made AS date_payment_made, LHS.amount_payment AS amount_payment, RHS.amount_payment AS amount_payment_other, RHS.n AS n FROM payments AS LHS INNER JOIN (SELECT amount_payment, settlement_id, COUNT(*) AS n FROM payments GROUP BY amount_payment, settlement_id) AS RHS ON (LHS.payment_id = RHS.settlement_id)) ORDER BY payment_method_code;

/*
Gold Result:
('lhs_55bded',)
('lhs_55bded',)
*/

-- Prediction Query
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY COUNT(*) ASC, Payment_Method_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('lhs_55bded',)
*/