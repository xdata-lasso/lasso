-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (1, NULL, 'B', '2020-01-01', 100);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (2, NULL, 'A', '2020-01-02', 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code, date_payment_made, amount_payment FROM payments ORDER BY payment_method_code, payments.payment_id NULLS LAST;

/*
Gold Result:
('A', '2020-01-02', 200)
('B', '2020-01-01', 100)
*/

-- Prediction Query
SELECT Payment_Method_Code, Date_Payment_Made, Amount_Payment FROM Payments ORDER BY Date_Payment_Made ASC, Payments.payment_id NULLS LAST;

/*
Prediction Result:
('B', '2020-01-01', 100)
('A', '2020-01-02', 200)
*/