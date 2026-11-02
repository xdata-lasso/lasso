-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (1, 'John Doe');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (1, 1, 'A', '2020-01-01', '2021-01-01');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (2, 1, 'A', '2020-01-01', '2021-01-01');
INSERT INTO "Customer_Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (3, 1, 'B', '2023-01-01', '2024-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT policy_type_code, start_date, COUNT(*) AS n FROM customer_policies GROUP BY policy_type_code, start_date) ORDER BY start_date DESC) LIMIT 1);

/*
Gold Result:
('B',)
*/

-- Prediction Query
SELECT Policy_Type_Code FROM Customer_Policies GROUP BY Policy_Type_Code ORDER BY COUNT(*) DESC, Policy_Type_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('A',)
*/