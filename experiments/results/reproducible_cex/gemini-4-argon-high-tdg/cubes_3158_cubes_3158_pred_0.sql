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
INSERT INTO Services (Service_ID, Service_name) VALUES (1, 'New Policy Application');
INSERT INTO Services (Service_ID, Service_name) VALUES (2, 'Loss Adjustment');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (1, 'Motor', '+1-555-0300');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (2, 'Property', '+1-555-0100');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (3, 'Life', '+1-555-0200');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (4, 'Travel', '+1-555-0100');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (1, 1, '2022-01-15', '2023-01-15');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (2, 2, '2022-06-01', NULL);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (1, 1, 1, 1);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (2, 1, 1, 2);
INSERT INTO Claims (Claim_ID, FNOL_ID, Effective_Date) VALUES (1, 1, '2022-05-10');
INSERT INTO Settlements (Settlement_ID, Claim_ID, Effective_Date, Settlement_Amount) VALUES (1, 1, '2022-06-01', 1500.50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_phone FROM available_policies ORDER BY customer_phone, available_policies.policy_id NULLS LAST;

/*
Gold Result:
('+1-555-0100',)
('+1-555-0100',)
('+1-555-0200',)
('+1-555-0300',)
*/

-- Prediction Query
SELECT customer_phone FROM available_policies;

/*
Prediction Result:
('+1-555-0300',)
('+1-555-0100',)
('+1-555-0200',)
('+1-555-0100',)
*/