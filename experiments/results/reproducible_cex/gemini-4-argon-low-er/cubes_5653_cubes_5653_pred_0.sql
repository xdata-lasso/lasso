-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_name" TEXT(40));

CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_name" TEXT(40));

CREATE TABLE "Available_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "policy_type_code" TEXT(15), "Customer_Phone" TEXT(255));

CREATE TABLE "Customers_Policies" ("Customer_ID" INTEGER UNIQUE, "Policy_ID" INTEGER UNIQUE, "Date_Opened" DATE, "Date_Closed" DATE, PRIMARY KEY ("Customer_ID", "Policy_ID"), FOREIGN KEY ("Policy_ID") REFERENCES "Available_Policies" ("Policy_ID"), FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "First_Notification_of_Loss" ("FNOL_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_ID" INTEGER, "Service_ID" INTEGER, FOREIGN KEY ("Customer_ID") REFERENCES "Customers_Policies" ("Customer_ID"), FOREIGN KEY ("Policy_ID") REFERENCES "Customers_Policies" ("Policy_ID"), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "FNOL_ID" INTEGER, "Effective_Date" DATE, FOREIGN KEY ("FNOL_ID") REFERENCES "First_Notification_of_Loss" ("FNOL_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Effective_Date" DATE, "Settlement_Amount" REAL, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (1, 'Alice');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (2, 'Bob');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (10, 'Auto', '123');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (20, 'Home', '456');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (1, 10, '2020-01-01', '2021-01-01');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (2, 20, '2020-01-01', '2021-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT customer_name FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_name AS customer_name, LHS.policy_id AS policy_id, LHS.date_opened AS date_opened, LHS.date_closed AS date_closed, LHS.n AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_name AS customer_name, LHS.policy_id AS policy_id, LHS.date_opened AS date_opened, LHS.date_closed AS date_closed, RHS.n AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_name AS customer_name, RHS.policy_id AS policy_id, RHS.date_opened AS date_opened, RHS.date_closed AS date_closed FROM customers AS LHS INNER JOIN customers_policies AS RHS ON (LHS.customer_id = RHS.customer_id)) AS LHS INNER JOIN (SELECT customer_id, COUNT(*) AS n FROM customers_policies GROUP BY customer_id) AS RHS ON (LHS.customer_id = RHS.customer_id)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT customer_id, COUNT(*) AS n FROM customers_policies GROUP BY customer_id)) AS RHS ON (LHS.n = RHS.n)) ORDER BY customer_name;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT t1.customer_name FROM customers AS t1 JOIN customers_policies AS t2 ON t1.customer_id = t2.customer_id GROUP BY t1.customer_name ORDER BY COUNT(*) DESC, t1.customer_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/