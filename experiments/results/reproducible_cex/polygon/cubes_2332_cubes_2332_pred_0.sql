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
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (18, '1');
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (17, '1');
INSERT INTO "Staff" ("staff_id", "staff_details") VALUES (19, '1');
INSERT INTO "Staff" ("staff_id", "staff_details") VALUES (30, '1');
INSERT INTO "Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (21, NULL, '1', 1, 1);
INSERT INTO "Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (20, 17, '1', 1, 1);
INSERT INTO "Claim_Headers" ("claim_header_id", "policy_id", "claim_status_code", "claim_type_code", "date_of_claim", "date_of_settlement", "amount_claimed", "amount_piad") VALUES (23, NULL, '1', '1', 1, 1, 1, 1);
INSERT INTO "Claim_Headers" ("claim_header_id", "policy_id", "claim_status_code", "claim_type_code", "date_of_claim", "date_of_settlement", "amount_claimed", "amount_piad") VALUES (22, 21, '1', '1', 1, 1, 1, 1);
INSERT INTO "Claims_Documents" ("claim_id", "document_type_code", "created_by_staff_id", "created_date") VALUES (22, '25', 30, 1);
INSERT INTO "Claims_Documents" ("claim_id", "document_type_code", "created_by_staff_id", "created_date") VALUES (22, '24', 30, 1);
INSERT INTO "Claims_Processing_Stages" ("claim_stage_id", "next_claim_stage_id", "claim_status_name", "claim_status_description") VALUES (26, NULL, NULL, NULL);
INSERT INTO "Claims_Processing_Stages" ("claim_stage_id", "next_claim_stage_id", "claim_status_name", "claim_status_description") VALUES (1, 1, NULL, '41');
INSERT INTO "Claims_Processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (28, NULL, NULL, NULL, 26);
INSERT INTO "Claims_Processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (27, 30, 22, '32', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT claim_status_name FROM (SELECT claim_outcome_code, claim_stage_id, n, claim_status_name, claim_status_description, claim_stage_id AS next_claim_stage_id FROM (SELECT LHS.claim_outcome_code AS claim_outcome_code, LHS.claim_stage_id AS claim_stage_id, LHS.n AS n, RHS.claim_status_name AS claim_status_name, RHS.claim_status_description AS claim_status_description FROM (SELECT claim_outcome_code, claim_stage_id, COUNT(*) AS n FROM claims_processing GROUP BY claim_outcome_code, claim_stage_id) AS LHS INNER JOIN claims_processing_stages AS RHS ON (LHS.claim_stage_id = RHS.next_claim_stage_id AND LHS.n = RHS.claim_stage_id))) ORDER BY claim_status_name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT t2.claim_status_name FROM claims_processing AS t1 JOIN claims_processing_stages AS t2 ON t1.claim_stage_id = t2.claim_stage_id GROUP BY t1.claim_stage_id ORDER BY COUNT(*) DESC, t2.claim_status_name NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/