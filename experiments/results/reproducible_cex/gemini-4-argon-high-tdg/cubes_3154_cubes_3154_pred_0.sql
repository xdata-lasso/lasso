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
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (1, 'Alice Smith');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (2, 'Bob Jones');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (3, 'Charlie Brown');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (4, 'Diana Prince');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (5, 'Evan Wright');
INSERT INTO Services (Service_ID, Service_name) VALUES (1, 'Towing');
INSERT INTO Services (Service_ID, Service_name) VALUES (2, 'Inspection');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (1, 'Auto', '999-9999');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (2, 'Auto', '555-0102');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (3, 'Auto', '555-0103');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (4, 'Life', '111-1111');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (7, 'Home', '555-0107');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (8, 'Health', '555-0108');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (9, 'Home', '555-0109');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (10, 'Health', '555-0110');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (1, 1, '2022-01-01', '2023-01-01');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (2, 2, '2022-02-01', '2023-02-01');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (3, 3, '2022-03-01', '2023-03-01');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (4, 4, '2022-04-01', '2023-04-01');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (5, 9, '2022-05-01', '2023-05-01');
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (101, 1, 1, 1);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (102, 3, 3, 1);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (103, 4, 4, 2);
INSERT INTO Claims (Claim_ID, FNOL_ID, Effective_Date) VALUES (201, 101, '2022-06-01');
INSERT INTO Claims (Claim_ID, FNOL_ID, Effective_Date) VALUES (202, 102, '2022-07-01');
INSERT INTO Settlements (Settlement_ID, Claim_ID, Effective_Date, Settlement_Amount) VALUES (301, 201, '2022-08-01', 1500.0);
INSERT INTO Settlements (Settlement_ID, Claim_ID, Effective_Date, Settlement_Amount) VALUES (302, 202, '2022-09-01', 3200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT policy_id, policy_type_code, COUNT(*) AS n FROM available_policies GROUP BY policy_id, policy_type_code) ORDER BY policy_id DESC) LIMIT 1);

/*
Gold Result:
('Health',)
*/

-- Prediction Query
SELECT policy_type_code FROM available_policies GROUP BY policy_type_code ORDER BY COUNT(*) DESC, policy_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Auto',)
*/