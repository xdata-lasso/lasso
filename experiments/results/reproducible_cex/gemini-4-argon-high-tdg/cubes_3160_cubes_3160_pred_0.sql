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
-- DATASET 1
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (101, 'Zelda');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (102, 'Aaron');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (103, 'Mindy');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (104, 'Unused Customer');
INSERT INTO Services (Service_ID, Service_name) VALUES (301, 'Close a policy');
INSERT INTO Services (Service_ID, Service_name) VALUES (302, 'Upgrade a policy');
INSERT INTO Services (Service_ID, Service_name) VALUES (303, 'Open a policy');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (201, 'AUTO', '555-0101');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (202, 'HOME', '555-0102');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (203, 'LIFE', '555-0103');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (101, 201, '2020-01-01', '2021-01-01');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (102, 202, '2020-02-01', NULL);
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (103, 203, '2020-03-01', NULL);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (401, 101, 201, 301);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (402, 102, 202, 302);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (403, 103, 203, 303);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."fnol_id" AS "fnol_id", "LHS"."policy_id" AS "policy_id", "LHS"."service_id" AS "service_id", "RHS"."service_name" AS "service_name" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "RHS"."fnol_id" AS "fnol_id", "RHS"."policy_id" AS "policy_id", "RHS"."service_id" AS "service_id" FROM "customers" AS "LHS" INNER JOIN "first_notification_of_loss" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" INNER JOIN (SELECT * FROM "services" WHERE ("service_name" = 'Close a policy' OR "service_name" = 'Upgrade a policy')) AS RHS ON (LHS.service_id = RHS.service_id)) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Aaron',)
('Zelda',)
*/

-- Prediction Query
SELECT t1.customer_name FROM customers AS t1 JOIN first_notification_of_loss AS t2 ON t1.customer_id = t2.customer_id JOIN services AS t3 ON t2.service_id = t3.service_id WHERE t3.service_name = 'Close a policy' OR t3.service_name = 'Upgrade a policy';

/*
Prediction Result:
('Zelda',)
('Aaron',)
*/