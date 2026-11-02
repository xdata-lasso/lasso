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
-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_details") VALUES (-2147483648, 'sta_d7e62c');

-- Inserting into table: claim_headers --
INSERT INTO "claim_headers" ("claim_header_id", "policy_id", "claim_status_code", "claim_type_code", "date_of_claim", "date_of_settlement", "amount_claimed", "amount_piad") VALUES (-2147483648, -2147483648, 'cla_c0a40a', 'cla_b23b30', '2025-10-14 06:39:08+00:00', '2025-06-10 18:20:47+00:00', 0.0001, 0.0001);

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (-2147483648, 'cus_8a62ed');

-- Inserting into table: policies --
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (-2147483648, -2147483648, 'pol_5607cc', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: claims_processing_stages --
INSERT INTO "claims_processing_stages" ("claim_stage_id", "next_claim_stage_id", "claim_status_name", "claim_status_description") VALUES (1, -664303813, 'rhs_4eb31d', 'rhs_2f1e04');

INSERT INTO "claims_processing_stages" ("claim_stage_id", "next_claim_stage_id", "claim_status_name", "claim_status_description") VALUES (-2147483647, -1980249628, 'rhs_d16ef7', 'rhs_e068d2');

INSERT INTO "claims_processing_stages" ("claim_stage_id", "next_claim_stage_id", "claim_status_name", "claim_status_description") VALUES (2, -1585009206, 'cla_8028e7', 'cla_1b1a23');

-- Inserting into table: claims_processing --
INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483648, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483647, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483646, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483645, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483644, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483643, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483642, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483641, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483640, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483639, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483638, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483637, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483636, -2147483648, -2147483648, 'cla_bbfdfe', NULL);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483635, -2147483648, -2147483648, 'cla_bbfdfe', NULL);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483634, -2147483648, -2147483648, 'cla_bbfdfe', NULL);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483633, -2147483648, -2147483648, NULL, 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483632, -2147483648, -2147483648, NULL, 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483631, -2147483648, -2147483648, NULL, 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483630, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483629, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483628, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483627, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483626, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483625, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483624, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483623, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483622, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483621, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483620, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483619, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483618, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483617, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483616, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483615, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483614, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483613, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483612, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483611, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (-2147483610, -2147483648, -2147483648, 'cla_bbfdfe', 1);

INSERT INTO "claims_processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (2, -2147483648, -2147483648, 'cla_335583', 742285925);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT claim_status_name FROM (SELECT claim_outcome_code, claim_stage_id, n, claim_status_name, claim_status_description, claim_stage_id AS next_claim_stage_id FROM (SELECT LHS.claim_outcome_code AS claim_outcome_code, LHS.claim_stage_id AS claim_stage_id, LHS.n AS n, RHS.claim_status_name AS claim_status_name, RHS.claim_status_description AS claim_status_description FROM (SELECT claim_outcome_code, claim_stage_id, COUNT(*) AS n FROM claims_processing GROUP BY claim_outcome_code, claim_stage_id) AS LHS INNER JOIN claims_processing_stages AS RHS ON (LHS.claim_stage_id = RHS.next_claim_stage_id AND LHS.n = RHS.claim_stage_id))) ORDER BY claim_status_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT t2.claim_status_name FROM claims_processing AS t1 JOIN claims_processing_stages AS t2 ON t1.claim_stage_id = t2.claim_stage_id GROUP BY t1.claim_stage_id ORDER BY COUNT(*) DESC, t2.claim_status_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('rhs_4eb31d',)
*/