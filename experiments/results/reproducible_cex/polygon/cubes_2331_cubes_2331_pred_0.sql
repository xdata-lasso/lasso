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
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (32, '65');
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (31, '45');
INSERT INTO "Staff" ("staff_id", "staff_details") VALUES (34, '65');
INSERT INTO "Staff" ("staff_id", "staff_details") VALUES (33, '65');
INSERT INTO "Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (65, 31, '66', 67, 68);
INSERT INTO "Policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (46, 31, NULL, NULL, NULL);
INSERT INTO "Claim_Headers" ("claim_header_id", "policy_id", "claim_status_code", "claim_type_code", "date_of_claim", "date_of_settlement", "amount_claimed", "amount_piad") VALUES (53, 65, '54', '55', 56, 57, -93, 58);
INSERT INTO "Claim_Headers" ("claim_header_id", "policy_id", "claim_status_code", "claim_type_code", "date_of_claim", "date_of_settlement", "amount_claimed", "amount_piad") VALUES (59, 65, '60', '61', 62, 63, -93, NULL);
INSERT INTO "Claims_Documents" ("claim_id", "document_type_code", "created_by_staff_id", "created_date") VALUES (59, '36', 33, 65);
INSERT INTO "Claims_Documents" ("claim_id", "document_type_code", "created_by_staff_id", "created_date") VALUES (59, '35', NULL, 65);
INSERT INTO "Claims_Processing_Stages" ("claim_stage_id", "next_claim_stage_id", "claim_status_name", "claim_status_description") VALUES (38, 65, '65', '65');
INSERT INTO "Claims_Processing_Stages" ("claim_stage_id", "next_claim_stage_id", "claim_status_name", "claim_status_description") VALUES (37, 65, '65', '65');
INSERT INTO "Claims_Processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (40, 33, 59, '65', 65);
INSERT INTO "Claims_Processing" ("claim_processing_id", "staff_id", "claim_id", "claim_outcome_code", "claim_stage_id") VALUES (39, 33, 53, '65', 65);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_details FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_details AS customer_details, LHS.policy_id AS policy_id, LHS.policy_type_code AS policy_type_code, LHS.start_date AS start_date, LHS.end_date AS end_date, LHS.claim_header_id AS claim_header_id, LHS.claim_status_code AS claim_status_code, LHS.claim_type_code AS claim_type_code, LHS.date_of_claim AS date_of_claim, LHS.date_of_settlement AS date_of_settlement, LHS.amount_claimed AS amount_claimed, LHS.amount_piad AS amount_piad FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_details AS customer_details, LHS.policy_id AS policy_id, LHS.policy_type_code AS policy_type_code, LHS.start_date AS start_date, LHS.end_date AS end_date, RHS.claim_header_id AS claim_header_id, RHS.claim_status_code AS claim_status_code, RHS.claim_type_code AS claim_type_code, RHS.date_of_claim AS date_of_claim, RHS.date_of_settlement AS date_of_settlement, RHS.amount_claimed AS amount_claimed, RHS.amount_piad AS amount_piad FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_details AS customer_details, RHS.policy_id AS policy_id, RHS.policy_type_code AS policy_type_code, RHS.start_date AS start_date, RHS.end_date AS end_date FROM customers AS LHS INNER JOIN policies AS RHS ON (LHS.customer_id = RHS.customer_id)) AS LHS INNER JOIN claim_headers AS RHS ON (LHS.policy_id = RHS.policy_id)) AS LHS INNER JOIN (SELECT claim_header_id, claim_status_code, claim_type_code, policy_id, date_of_claim, date_of_settlement, MAX(amount_claimed) OVER () AS amount_claimed, amount_piad FROM claim_headers) AS RHS ON (LHS.policy_id = RHS.policy_id AND LHS.claim_header_id = RHS.claim_header_id AND LHS.claim_status_code = RHS.claim_status_code AND LHS.claim_type_code = RHS.claim_type_code AND LHS.date_of_claim = RHS.date_of_claim AND LHS.date_of_settlement = RHS.date_of_settlement AND LHS.amount_claimed = RHS.amount_claimed AND LHS.amount_piad = RHS.amount_piad)) ORDER BY customer_details;

/*
Gold Result:
('45',)
*/

-- Prediction Query
SELECT t3.customer_details FROM claim_headers AS t1 JOIN policies AS t2 ON t1.policy_id = t2.policy_id JOIN customers AS t3 ON t2.customer_id = t3.customer_id WHERE t1.amount_claimed = (SELECT MAX(amount_claimed) FROM claim_headers);

/*
Prediction Result:
('45',)
('45',)
*/