-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (9, '18');
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (8, '18');
INSERT INTO "Customer_Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (11, NULL, '18', '1000-01-19', '1000-01-19');
INSERT INTO "Customer_Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (10, 9, '18', '1000-01-19', '1000-01-19');
INSERT INTO "Claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (13, 10, '1000-01-19', '1000-01-19', 18, 18);
INSERT INTO "Claims" ("claim_id", "policy_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled") VALUES (12, NULL, '1000-01-19', '1000-01-19', 18, 18);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (15, 12, '1000-01-19', '1000-01-19', 18, 18, 18);
INSERT INTO "Settlements" ("settlement_id", "claim_id", "date_claim_made", "date_claim_settled", "amount_claimed", "amount_settled", "customer_policy_id") VALUES (14, 13, '1000-01-19', '1000-01-19', 18, 18, 18);
INSERT INTO "Payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (17, 15, '18', '1000-01-19', 18);
INSERT INTO "Payments" ("payment_id", "settlement_id", "payment_method_code", "date_payment_made", "amount_payment") VALUES (16, 14, '18', '1000-01-19', 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_details FROM customers ORDER BY customer_details, customers.customer_id NULLS LAST;

/*
Gold Result:
('18',)
('18',)
*/

-- Prediction Query
SELECT DISTINCT customer_details FROM Customers;

/*
Prediction Result:
('18',)
*/