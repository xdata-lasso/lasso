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
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1038, 'sell', '565-578-7133x1509');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1043, 'author', '4519834738');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1039, 'Michael Brown');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1044, 'John Russell');
INSERT INTO "services" ("service_id", "service_name") VALUES (1040, 'Close a policy');
INSERT INTO "services" ("service_id", "service_name") VALUES (1041, 'Upgrade a policy');
INSERT INTO "services" ("service_id", "service_name") VALUES (1045, 'Close a policy');
INSERT INTO "services" ("service_id", "service_name") VALUES (1046, 'Upgrade a policy');
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (1039, 1038, '1988-08-19', '1989-09-20');
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (1044, 1043, '1990-10-21', '1991-11-22');
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1042, 1039, 1038, 1040);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1047, 1044, 1043, 1045);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."fnol_id" AS "fnol_id", "LHS"."policy_id" AS "policy_id", "LHS"."service_id" AS "service_id", "RHS"."service_name" AS "service_name" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "RHS"."fnol_id" AS "fnol_id", "RHS"."policy_id" AS "policy_id", "RHS"."service_id" AS "service_id" FROM "customers" AS "LHS" INNER JOIN "first_notification_of_loss" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" INNER JOIN (SELECT * FROM "services" WHERE ("service_name" = 'Close a policy' OR "service_name" = 'Upgrade a policy')) AS RHS ON (LHS.service_id = RHS.service_id)) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('John Russell',)
('Michael Brown',)
*/

-- Prediction Query
SELECT t1.customer_name FROM customers AS t1 JOIN first_notification_of_loss AS t2 ON t1.customer_id = t2.customer_id JOIN services AS t3 ON t2.service_id = t3.service_id WHERE t3.service_name = 'Close a policy' OR t3.service_name = 'Upgrade a policy';

/*
Prediction Result:
('Michael Brown',)
('John Russell',)
*/