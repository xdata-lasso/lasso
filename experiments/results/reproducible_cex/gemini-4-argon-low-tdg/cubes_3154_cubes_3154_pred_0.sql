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
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (1, 'Life Insurance', '555-9999');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (2, 'Life Insurance', '555-8888');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (3, 'Life Insurance', '555-7777');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (10, 'Auto Insurance', '555-1111');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (100, 'Alice');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (100, 1, '2020-01-01', '2025-01-01');
INSERT INTO Services (Service_ID, Service_name) VALUES (1, 'Towing');
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (1, 100, 1, 1);
INSERT INTO Claims (Claim_ID, FNOL_ID, Effective_Date) VALUES (1, 1, '2021-01-01');
INSERT INTO Settlements (Settlement_ID, Claim_ID, Effective_Date, Settlement_Amount) VALUES (1, 1, '2021-02-01', 5000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT policy_id, policy_type_code, COUNT(*) AS n FROM available_policies GROUP BY policy_id, policy_type_code) ORDER BY policy_id DESC) LIMIT 1);

/*
Gold Result:
('Auto Insurance',)
*/

-- Prediction Query
SELECT policy_type_code FROM available_policies GROUP BY policy_type_code ORDER BY COUNT(*) DESC, policy_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Life Insurance',)
*/