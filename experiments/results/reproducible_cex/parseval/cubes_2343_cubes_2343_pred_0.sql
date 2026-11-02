-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1, 'lhs_f95183');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483647, 'lhs_8b0d04');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483646, 'q_0_700b1e');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483645, 'q_0_700b1e');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (2, 'cus_8a62ed');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (3, 'cus_8a62ed');

-- Inserting into table: customer_policies --
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (4, 2, 'cus_56250a', '2025-06-17', '2021-11-08');

INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (5, 3, 'cus_56250a', '2025-06-13', '2023-03-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_details FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM customer_policies AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_details;

/*
Gold Result:
('lhs_8b0d04',)
('lhs_f95183',)
('q_0_700b1e',)
('q_0_700b1e',)
*/

-- Prediction Query
SELECT customer_details FROM Customers EXCEPT SELECT T1.customer_details FROM Customers AS T1 JOIN Customer_Policies AS T2 ON T1.customer_id = T2.customer_id;

/*
Prediction Result:
('lhs_8b0d04',)
('lhs_f95183',)
('q_0_700b1e',)
*/