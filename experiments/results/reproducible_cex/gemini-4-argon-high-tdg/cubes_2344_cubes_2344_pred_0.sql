-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (1, 'Zebra Corp');
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (2, 'Alpha Inc');
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (3, NULL);
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (4, 'Beta LLC');
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (5, 'Alpha Inc');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (101, 1, 'AUTO', '2022-01-01', '2023-01-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (102, 1, 'HOME', '2022-06-01', '2023-06-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (103, 2, 'LIFE', '2021-03-15', '2031-03-15');
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (201, 101, '2022-05-10', '2022-06-15', 5000, 4500);
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (202, 101, '2022-08-20', '2022-09-01', 1200, 1200);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (301, 201, '2022-05-10', '2022-06-15', 5000, 4500, 101);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (401, 301, 'BANK_TRANSFER', '2022-06-20', 4500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_details FROM customers ORDER BY customer_details, customers.customer_id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Inc',)
('Alpha Inc',)
('Beta LLC',)
('Zebra Corp',)
*/

-- Prediction Query
SELECT DISTINCT customer_details FROM Customers;

/*
Prediction Result:
('Zebra Corp',)
('Alpha Inc',)
(None,)
('Beta LLC',)
*/