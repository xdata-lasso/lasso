-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (10, 'SameName');
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (20, 'SameName');
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (5, 'SameName');
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (30, NULL);
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (1, 10, 'TypeA', '2020-01-01', '2021-01-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (2, 10, 'TypeA', '2020-01-01', '2021-01-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (3, 20, NULL, NULL, NULL);
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (4, 20, NULL, NULL, NULL);
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (5, 5, 'TypeB', '2021-01-01', '2022-01-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (6, 30, 'TypeC', '2020-01-01', '2021-01-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (7, 30, 'TypeD', '2020-01-01', '2021-01-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (8, NULL, 'TypeE', '2020-01-01', '2021-01-01');
INSERT INTO Customer_Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (9, NULL, 'TypeF', '2020-01-01', '2021-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT customer_details, customer_id FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_details AS customer_details, LHS.policy_id AS policy_id, LHS.policy_type_code AS policy_type_code, LHS.start_date AS start_date, LHS.end_date AS end_date, LHS.n AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_details AS customer_details, LHS.policy_id AS policy_id, LHS.policy_type_code AS policy_type_code, LHS.start_date AS start_date, LHS.end_date AS end_date, RHS.n AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_details AS customer_details, RHS.policy_id AS policy_id, RHS.policy_type_code AS policy_type_code, RHS.start_date AS start_date, RHS.end_date AS end_date FROM customers AS LHS INNER JOIN customer_policies AS RHS ON (LHS.customer_id = RHS.customer_id)) AS LHS INNER JOIN (SELECT customer_id, COUNT(*) AS n FROM customer_policies GROUP BY customer_id) AS RHS ON (LHS.customer_id = RHS.customer_id)) AS LHS INNER JOIN (SELECT * FROM (SELECT customer_id, COUNT(*) AS n FROM customer_policies GROUP BY customer_id) WHERE (n <> 1)) AS RHS ON (LHS.customer_id = RHS.customer_id AND LHS.n = RHS.n)) ORDER BY customer_details, customer_id NULLS LAST;

/*
Gold Result:
(None, 30)
('SameName', 10)
('SameName', 20)
*/

-- Prediction Query
SELECT T1.customer_details, T1.customer_id FROM Customers AS T1 JOIN Customer_Policies AS T2 ON T1.Customer_id = T2.Customer_id GROUP BY T1.customer_id HAVING COUNT(*) > 1;

/*
Prediction Result:
('SameName', 10)
('SameName', 20)
(None, 30)
*/