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
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1, 'Dayana Robel');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483647, 'Dayana Robel');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (3, 'Dayana Robel');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (2, 'cus_8a62ed');

INSERT INTO "customers" ("customer_id", "customer_details") VALUES (4, NULL);

-- Inserting into table: policies --
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483648, 1, 't1__ff35f8', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (2, 1, 't1__ff35f8', '2025-10-14 06:39:08+00:00', '2025-06-10 18:20:47+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (3, 1, 't1__ff35f8', '2024-02-22 05:22:28+00:00', '2021-05-28 17:00:04+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483645, 2, 't1__ff35f8', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483644, 2, 't1__ff35f8', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483643, 2, 't1__ff35f8', '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483642, 1, 't1__ff35f8', '2020-10-31 07:51:16+00:00', '2022-06-28 11:34:24+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483641, 1, NULL, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (4, 4, 'pol_5607cc', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "policy_type_code" FROM (SELECT * FROM "policies" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "customers" WHERE ("customer_details" <> 'Dayana Robel')) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY policy_type_code, "policy_type_code" NULLS LAST;

/*
Gold Result:
(None,)
('pol_5607cc',)
('t1__ff35f8',)
('t1__ff35f8',)
('t1__ff35f8',)
('t1__ff35f8',)
*/

-- Prediction Query
SELECT policy_type_code FROM policies AS t1 JOIN customers AS t2 ON t1.customer_id = t2.customer_id WHERE t2.customer_details = 'Dayana Robel';

/*
Prediction Result:
('t1__ff35f8',)
('t1__ff35f8',)
(None,)
('t1__ff35f8',)
('t1__ff35f8',)
*/