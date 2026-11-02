-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Staff" ("Staff_ID" INTEGER PRIMARY KEY, "Staff_Details" TEXT(255));

CREATE TABLE "Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATETIME, "End_Date" DATETIME, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claim_Headers" ("Claim_Header_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Claim_Status_Code" TEXT(15), "Claim_Type_Code" TEXT(15), "Date_of_Claim" DATETIME, "Date_of_Settlement" DATETIME, "Amount_Claimed" REAL(20, 4), "Amount_Piad" REAL(20, 4), FOREIGN KEY ("Policy_ID") REFERENCES "Policies" ("Policy_ID"));

CREATE TABLE "Claims_Documents" ("Claim_ID" INTEGER, "Document_Type_Code" TEXT(15), "Created_by_Staff_ID" INTEGER, "Created_Date" INTEGER, PRIMARY KEY ("Claim_ID", "Document_Type_Code"), FOREIGN KEY ("Created_by_Staff_ID") REFERENCES "Staff" ("Staff_ID"), FOREIGN KEY ("Claim_ID") REFERENCES "Claim_Headers" ("Claim_Header_ID"));

CREATE TABLE "Claims_Processing_Stages" ("Claim_Stage_ID" INTEGER PRIMARY KEY, "Next_Claim_Stage_ID" INTEGER, "Claim_Status_Name" TEXT(255), "Claim_Status_Description" TEXT(255));

CREATE TABLE "Claims_Processing" ("Claim_Processing_ID" INTEGER PRIMARY KEY, "Staff_ID" INTEGER, "Claim_ID" INTEGER, "Claim_Outcome_Code" TEXT(15), "Claim_Stage_ID" INTEGER, FOREIGN KEY ("Staff_ID") REFERENCES "Staff" ("Staff_ID"), FOREIGN KEY ("Claim_ID") REFERENCES "Claim_Headers" ("Claim_Header_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1, 'lhs_4cfd16');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483647, 'lhs_f2d60c');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483646, 'q_0_33e5ab');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483645, 'q_0_33e5ab');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (2, 'cus_8a62ed');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (3, 'cus_8a62ed');

-- Inserting into table: policies --
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (4, 2, 'pol_5607cc', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (5, 3, 'pol_5607cc', '2025-10-14 06:39:08+00:00', '2025-06-10 18:20:47+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_details FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM policies AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_details;

/*
Gold Result:
('lhs_4cfd16',)
('lhs_f2d60c',)
('q_0_33e5ab',)
('q_0_33e5ab',)
*/

-- Prediction Query
SELECT customer_details FROM customers EXCEPT SELECT t2.customer_details FROM policies AS t1 JOIN customers AS t2 ON t1.customer_id = t2.customer_id;

/*
Prediction Result:
('lhs_4cfd16',)
('lhs_f2d60c',)
('q_0_33e5ab',)
*/