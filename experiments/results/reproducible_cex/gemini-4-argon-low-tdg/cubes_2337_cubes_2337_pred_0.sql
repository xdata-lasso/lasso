-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty Settlements table while parent tables are populated (distinguishes window function SUM OVER() returning 0 rows vs scalar aggregate SELECT SUM() returning 1 row with NULL).
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (1, 'Bob Jones');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (20, 1, 'HOME', '2021-01-01', '2022-01-01');
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (200, 20, '2021-06-01', '2021-06-20', 3000, 2500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM(amount_settled) OVER () AS sum_amount_settled_ FROM settlements ORDER BY sum_amount_settled_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(Amount_Settled) FROM Settlements;

/*
Prediction Result:
(None,)
*/