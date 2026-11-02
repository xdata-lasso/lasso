-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (1, 'Customer A');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (1, 1, 'AUTO', '2020-01-01', '2025-01-01');
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (1, 1, '2023-01-01', '2023-01-10', 1000, 1000);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (1, 1, '2023-02-01', '2023-02-10', 500, 500, 1);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (2, 1, '2023-01-01', '2023-01-10', 500, 500, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_claim_made, date_claim_settled FROM settlements ORDER BY date_claim_made, settlements.settlement_id NULLS LAST;

/*
Gold Result:
('2023-01-01', '2023-01-10')
('2023-02-01', '2023-02-10')
*/

-- Prediction Query
SELECT Date_Claim_Made, Date_Claim_Settled FROM Settlements;

/*
Prediction Result:
('2023-02-01', '2023-02-10')
('2023-01-01', '2023-01-10')
*/