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
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (1, 1, 'AUTO', '2022-01-01', '2023-01-01');
INSERT INTO Claims (Claim_ID, Policy_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled) VALUES (1, 1, '2022-03-01', '2022-03-15', 5000, 4500);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (1, 1, '2022-03-01', '2022-03-15', 5000, 4500, 1);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (2, 1, '2022-04-01', '2022-04-15', 3000, 3000, 1);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (3, 1, '2022-05-01', '2022-05-15', 2000, 1800, 1);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Date_Claim_Made, Date_Claim_Settled, Amount_Claimed, Amount_Settled, Customer_Policy_ID) VALUES (99, 1, '2022-06-01', '2022-06-15', 1000, 1000, 1);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (1, 99, 'WIRE', '2022-03-20', 1500);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (2, 99, 'ACH', '2022-04-20', 1000);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (3, 99, 'CHECK', '2022-05-20', 1800);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (4, 99, 'UNMATCHED_LHS', '2022-06-20', 500);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (10, 1, 'RHS_ONLY_A', '2022-07-01', 700);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (11, 1, 'RHS_ONLY_B', '2022-07-02', 800);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (12, 2, 'RHS_ONLY_C', '2022-07-03', 300);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (13, 2, 'RHS_ONLY_D', '2022-07-04', 300);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (14, 2, 'RHS_ONLY_E', '2022-07-05', 400);
INSERT INTO Payments (Payment_ID, Settlement_ID, Payment_Method_Code, Date_Payment_Made, Amount_Payment) VALUES (15, 3, 'RHS_ONLY_F', '2022-07-06', 1800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT payment_method_code, MIN(n) AS minn FROM (SELECT payment_method_code, settlement_id, COUNT(*) AS n FROM (SELECT payment_id, payment_id AS settlement_id, payment_method_code, date_payment_made, amount_payment, payment_id_other, payment_method_code_other, date_payment_made_other, amount_payment_other FROM (SELECT LHS.payment_id AS payment_id, LHS.settlement_id AS settlement_id, LHS.payment_method_code AS payment_method_code, LHS.date_payment_made AS date_payment_made, LHS.amount_payment AS amount_payment, RHS.payment_id AS payment_id_other, RHS.payment_method_code AS payment_method_code_other, RHS.date_payment_made AS date_payment_made_other, RHS.amount_payment AS amount_payment_other FROM payments AS LHS INNER JOIN payments AS RHS ON (LHS.payment_id = RHS.settlement_id))) GROUP BY payment_method_code, settlement_id) GROUP BY payment_method_code) ORDER BY payment_method_code;

/*
Gold Result:
('ACH',)
('CHECK',)
('WIRE',)
*/

-- Prediction Query
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY COUNT(*) ASC, Payment_Method_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('ACH',)
*/