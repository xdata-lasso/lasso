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
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483648, 'cus_8a62ed');

-- Inserting into table: policies --
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483648, -2147483648, 'pol_d9feb5', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483647, -2147483648, 'pol_d9feb5', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483646, -2147483648, 'pol_d9feb5', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (2, -2147483648, 'pol_d9feb5', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (3, -2147483648, 'pol_d9feb5', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483645, -2147483648, 'pol_d9feb5', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483642, -2147483648, 'pol_d9feb5', '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483641, -2147483648, 'pol_d9feb5', '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483640, -2147483648, 'pol_d9feb5', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483639, -2147483648, NULL, '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483638, -2147483648, NULL, '2021-02-21 20:09:01+00:00', '2020-01-15 18:18:33+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483637, -2147483648, NULL, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483636, -2147483648, 'pol_d9feb5', '2023-05-25 17:04:36+00:00', '2020-12-10 17:36:20+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483635, -2147483648, 'pol_d9feb5', '2025-08-22 00:34:24+00:00', '2022-04-13 09:01:25+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483634, -2147483648, 'pol_d9feb5', '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (4, -2147483648, 'pol_c81f37', '2024-04-12 00:38:47+00:00', '2021-07-31 11:04:01+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (5, -2147483648, 'pol_c81f37', '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483631, -2147483648, 'pol_e52b04', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00');

INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (6, -2147483648, 'pol_5607cc', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT policy_type_code, COUNT(*) AS n FROM policies GROUP BY policy_type_code) WHERE (n >= 2) ORDER BY policy_type_code;

/*
Gold Result:
(None,)
('pol_c81f37',)
('pol_d9feb5',)
*/

-- Prediction Query
SELECT policy_type_code FROM policies GROUP BY policy_type_code HAVING COUNT(*) > 2;

/*
Prediction Result:
(None,)
('pol_d9feb5',)
*/