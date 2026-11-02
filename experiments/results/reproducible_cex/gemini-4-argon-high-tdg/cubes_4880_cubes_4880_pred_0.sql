-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (1, 'Diana Prince');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (301, 1, 'HEALTH', '2016-01-01', '2026-01-01');
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (20, 301, NULL, '2016-02-01', 800, 800);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (21, NULL, '2017-08-12', '2017-09-01', 1200, 1000);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (22, 301, '2021-12-01', '2022-01-01', 2000, 1800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MIN(date_claim_made) OVER () AS date_claim_made FROM claims ORDER BY date_claim_made;

/*
Gold Result:
('2017-08-12',)
*/

-- Prediction Query
SELECT Date_Claim_Made FROM Claims ORDER BY Date_Claim_Made ASC, Claims.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/