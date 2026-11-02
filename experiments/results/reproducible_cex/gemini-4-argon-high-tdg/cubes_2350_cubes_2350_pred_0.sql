-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (1, 'Alice Smith');
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (2, 'Bob Jones');
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (3, 'Charlie Brown');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (10, 1, 'AUTO', '2020-01-01', '2022-01-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (20, 2, 'HOME', '2020-02-01', '2022-02-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (30, 3, 'LIFE', '2020-03-01', '2022-03-01');
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (1, 10, '2021-01-10', '2021-06-15', 100, 100);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (2, 20, '2021-02-15', '2021-03-01', 500, 400);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (3, 30, '2021-05-20', '2021-09-10', 900, 800);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (100, 1, '2020-01-01', '2020-01-02', 100, 100, 10);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (300, 3, '2020-01-05', '2020-01-06', 900, 800, 30);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (1000, 100, 'CARD', '2021-06-16', 100);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (3000, 300, 'WIRE', '2021-09-11', 800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_claim_made FROM (SELECT * FROM (SELECT * FROM claims ORDER BY date_claim_settled, claims.claim_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('2021-02-15',)
*/

-- Prediction Query
SELECT Date_Claim_Made FROM Claims ORDER BY Date_Claim_Made ASC, Claims.claim_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('2021-01-10',)
*/