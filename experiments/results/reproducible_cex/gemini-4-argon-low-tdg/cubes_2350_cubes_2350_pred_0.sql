-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by date_claim_settled ASC, anti-pattern check for sorting by date_claim_made, and table confusion between Claims and Settlements.
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (1, 'John Doe');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (10, 1, 'AUTO', '2020-01-01', '2025-01-01');
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (102, 10, '2023-05-01', '2023-06-01', 1000, 900);
INSERT INTO "Claims" ("Claim_ID", "Policy_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled") VALUES (101, 10, '2023-04-01', '2023-07-01', 2000, 1800);
INSERT INTO "Settlements" ("Settlement_ID", "Claim_ID", "Date_Claim_Made", "Date_Claim_Settled", "Amount_Claimed", "Amount_Settled", "Customer_Policy_ID") VALUES (1001, 101, '2021-01-01', '2021-02-01', 2000, 1800, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_claim_made FROM (SELECT * FROM (SELECT * FROM claims ORDER BY date_claim_settled, claims.claim_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('2023-05-01',)
*/

-- Prediction Query
SELECT Date_Claim_Made FROM Claims ORDER BY Date_Claim_Made ASC, Claims.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('2023-04-01',)
*/