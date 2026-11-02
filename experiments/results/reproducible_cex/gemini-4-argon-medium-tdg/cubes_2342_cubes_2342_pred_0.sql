-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Ordering by Start_Date DESC vs COUNT(*) DESC (latest Start_Date has lowest count, older Start_Date has highest count).
-- 2. Ordering by Start_Date DESC vs Start_Date ASC.
-- 3. Ordering by Start_Date vs End_Date (earliest Start_Date has latest End_Date).
-- 4. Ordering by Start_Date vs Policy_ID / Policy_Type_Code.
-- 5. Unnecessary INNER JOINs with Customers (via NULL Customer_ID) or Claims (via policies with no claims).
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (1, 'Alice Smith');
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (2, 'Bob Jones');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (10, NULL, 'AUTO', '2023-12-01', '2024-01-01');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (20, 1, 'HOME', '2022-06-15', '2025-06-15');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (30, 1, 'HOME', '2022-06-15', '2025-06-15');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (40, 2, 'HOME', '2022-06-15', '2025-06-15');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (50, 2, 'LIFE', '2020-01-01', '2030-12-31');
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (100, 20, '2022-07-01', '2022-08-01', 5000, 4500);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (1000, 100, '2022-07-01', '2022-08-01', 5000, 4500, 20);
INSERT INTO "Payments" ("Payment_ID", "Settlement_ID", "Payment_Method_Code", "Date_Payment_Made", "Amount_Payment") VALUES (10000, 1000, 'BANK_TRANSFER', '2022-08-05', 4500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT policy_type_code, start_date, COUNT(*) AS n FROM customer_policies GROUP BY policy_type_code, start_date) ORDER BY start_date DESC) LIMIT 1);

/*
Gold Result:
('AUTO',)
*/

-- Prediction Query
SELECT Policy_Type_Code FROM Customer_Policies GROUP BY Policy_Type_Code ORDER BY COUNT(*) DESC, Policy_Type_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('HOME',)
*/