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
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (12, '13');
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (11, '13');
INSERT INTO "Staff" ("staff_id", "staff_details") VALUES (14, '13');
INSERT INTO "Staff" ("staff_id", "staff_details") VALUES (13, '13');
INSERT INTO "Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (16, 11, '13', 13, 13);
INSERT INTO "Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (15, 11, '13', 13, 13);
INSERT INTO "Claim_Headers" ("claim_header_id", "policy_id", "claim_status_code", "claim_type_code", "date_of_claim", "date_of_settlement", "amount_claimed", "amount_piad") VALUES (18, 15, '23', '24', 25, 26, 27, -4386);
INSERT INTO "Claim_Headers" ("claim_header_id", "policy_id", "claim_status_code", "claim_type_code", "date_of_claim", "date_of_settlement", "amount_claimed", "amount_piad") VALUES (17, 15, '13', '13', 13, 13, 13, 4387);
INSERT INTO "Claims_Documents" ("claim_id", "document_type_code", "created_by_staff_id", "created_date") VALUES (18, '20', 13, 13);
INSERT INTO "Claims_Documents" ("claim_id", "document_type_code", "created_by_staff_id", "created_date") VALUES (17, '19', 13, 13);
INSERT INTO "Claims_Processing_Stages" ("claim_stage_id", "next_claim_stage_id", "claim_status_name", "claim_status_description") VALUES (22, 13, '13', '13');
INSERT INTO "Claims_Processing_Stages" ("claim_stage_id", "next_claim_stage_id", "claim_status_name", "claim_status_description") VALUES (21, 13, '13', '13');
INSERT INTO "Claims_Processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (13, 13, 18, '13', 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM(amount_piad) OVER () AS sum_amount_piad_, meanamount_piad AS avg_amount_piad_ FROM (SELECT claim_header_id, claim_status_code, claim_type_code, policy_id, date_of_claim, date_of_settlement, amount_claimed, amount_piad, AVG(amount_piad) OVER () AS meanamount_piad FROM claim_headers) ORDER BY sum_amount_piad_, avg_amount_piad_ NULLS LAST;

/*
Gold Result:
(1.0, 0.5)
*/

-- Prediction Query
SELECT SUM(amount_piad), AVG(amount_piad) FROM claim_headers;

/*
Prediction Result:
(1.0, 0.5)
*/