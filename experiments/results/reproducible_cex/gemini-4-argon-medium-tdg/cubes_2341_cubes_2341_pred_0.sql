-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (1, 'Alice');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (10, 1, 'AUTO', '2022-01-01', '2023-01-01');
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (100, 10, '2022-05-01', '2022-06-01', 5000, 4000);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (1000, 100, '2022-05-01', '2022-06-01', 5000, 4000, 10);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (30, 1000, 'VISA', '2022-06-05', 1500);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (10, 1000, 'CASH', '2022-06-15', 2500);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (20, 1000, 'CASH', '2022-06-10', 1000);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (5, 1000, 'AMEX', '2022-06-20', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code, date_payment_made, amount_payment FROM payments ORDER BY payment_method_code, payments.payment_id NULLS LAST;

/*
Gold Result:
('AMEX', '2022-06-20', 500)
('CASH', '2022-06-15', 2500)
('CASH', '2022-06-10', 1000)
('VISA', '2022-06-05', 1500)
*/

-- Prediction Query
SELECT Payment_Method_Code, Date_Payment_Made, Amount_Payment FROM Payments ORDER BY Date_Payment_Made ASC, Payments.payment_id NULLS LAST;

/*
Prediction Result:
('VISA', '2022-06-05', 1500)
('CASH', '2022-06-10', 1000)
('CASH', '2022-06-15', 2500)
('AMEX', '2022-06-20', 500)
*/