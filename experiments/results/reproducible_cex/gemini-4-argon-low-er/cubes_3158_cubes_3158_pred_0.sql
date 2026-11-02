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
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (1, 'TypeA', '999-999-9999');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (2, 'TypeB', '111-111-1111');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_phone FROM available_policies ORDER BY customer_phone, available_policies.policy_id NULLS LAST;

/*
Gold Result:
('111-111-1111',)
('999-999-9999',)
*/

-- Prediction Query
SELECT customer_phone FROM available_policies;

/*
Prediction Result:
('999-999-9999',)
('111-111-1111',)
*/