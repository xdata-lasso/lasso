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
-- Inserting into table: customers_policies --
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (2, -2147483648, '2025-06-17', '2021-11-08');

INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (3, -2147483647, '2023-03-15', '2023-11-15');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1, 'lhs_1ffc4a');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483647, 'lhs_b88d59');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483646, 'q_0_d72b6d');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (-2147483645, 'q_0_d72b6d');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (2, 'cus_89115a');

INSERT INTO "customers" ("customer_id", "customer_name") VALUES (3, 'cus_89115a');

-- Inserting into table: services --
INSERT INTO "services" ("service_id", "service_name") VALUES (-2147483648, 'ser_d14b03');

-- Inserting into table: available_policies --
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483648, 'ava_9edf9e', 'ava_89bb8a');

INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (-2147483647, 'ava_9edf9e', 'ava_89bb8a');

-- Inserting into table: first_notification_of_loss --
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (4, 2, -2147483648, -2147483648);

INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (5, 3, -2147483647, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM first_notification_of_loss AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name;

/*
Gold Result:
('lhs_1ffc4a',)
('lhs_b88d59',)
('q_0_d72b6d',)
('q_0_d72b6d',)
*/

-- Prediction Query
SELECT customer_name FROM customers EXCEPT SELECT t1.customer_name FROM customers AS t1 JOIN first_notification_of_loss AS t2 ON t1.customer_id = t2.customer_id;

/*
Prediction Result:
('lhs_1ffc4a',)
('lhs_b88d59',)
('q_0_d72b6d',)
*/