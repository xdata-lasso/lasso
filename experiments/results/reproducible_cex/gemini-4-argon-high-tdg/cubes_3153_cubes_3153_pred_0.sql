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
-- DATASET 2
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (1, 'Alice');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (2, 'Alice');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (3, 'Bob');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (4, 'Bob');
INSERT INTO Services (Service_ID, Service_name) VALUES (1, 'Towing');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (10, 'AUTO', '555-1111');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (20, 'AUTO', '555-2222');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (1, 10, '2021-05-10', '2022-05-10');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (2, 20, '2021-06-10', '2022-06-10');
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (100, 1, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM first_notification_of_loss AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name;

/*
Gold Result:
('Alice',)
('Bob',)
('Bob',)
*/

-- Prediction Query
SELECT customer_name FROM customers EXCEPT SELECT t1.customer_name FROM customers AS t1 JOIN first_notification_of_loss AS t2 ON t1.customer_id = t2.customer_id;

/*
Prediction Result:
('Bob',)
*/