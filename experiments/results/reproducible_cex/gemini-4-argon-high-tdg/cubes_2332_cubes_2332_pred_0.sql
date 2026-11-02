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
-- DATASET 1
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (1, 'Alice Smith');
INSERT INTO Staff (Staff_ID, Staff_Details) VALUES (1, 'John Doe');
INSERT INTO Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (1, 1, 'AUTO', '2023-01-01', '2024-01-01');
INSERT INTO Claim_Headers (Claim_Header_ID, Policy_ID, Claim_Status_Code, Claim_Type_Code, Date_of_Claim, Date_of_Settlement, Amount_Claimed, Amount_Piad) VALUES (1, 1, 'OPEN', 'COLL', '2023-06-01', '2023-06-15', 1000.0, 800.0);
INSERT INTO Claims_Processing_Stages (Claim_Stage_ID, Next_Claim_Stage_ID, Claim_Status_Name, Claim_Status_Description) VALUES (1, 20, 'Alpha', 'Desc9');
INSERT INTO Claims_Processing_Stages (Claim_Stage_ID, Next_Claim_Stage_ID, Claim_Status_Name, Claim_Status_Description) VALUES (2, 10, 'Zebra', 'Desc1');
INSERT INTO Claims_Processing_Stages (Claim_Stage_ID, Next_Claim_Stage_ID, Claim_Status_Name, Claim_Status_Description) VALUES (3, 30, 'Middle', 'Desc5');
INSERT INTO Claims_Processing_Stages (Claim_Stage_ID, Next_Claim_Stage_ID, Claim_Status_Name, Claim_Status_Description) VALUES (4, 40, 'Decoy_StageOnly', 'Desc2');
INSERT INTO Claims_Processing_Stages (Claim_Stage_ID, Next_Claim_Stage_ID, Claim_Status_Name, Claim_Status_Description) VALUES (5, 50, 'Decoy_CountOnly', 'Desc3');
INSERT INTO Claims_Processing_Stages (Claim_Stage_ID, Next_Claim_Stage_ID, Claim_Status_Name, Claim_Status_Description) VALUES (6, 2, 'Decoy_Swapped', 'Desc4');
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (1, 1, 1, 'OUT1', 10);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (2, 1, 1, 'OUT1', 10);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (3, 1, 1, 'OUT2', 20);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (4, 1, 1, 'OUT3', 30);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (5, 1, 1, 'OUT3', 30);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (6, 1, 1, 'OUT3', 30);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (7, 1, 1, 'OUT4', 40);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (8, 1, 1, 'OUT5', 55);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (9, 1, 1, 'OUT5', 55);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (10, 1, 1, 'OUT5', 55);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (11, 1, 1, 'OUT5', 55);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (12, 1, 1, 'OUT5', 55);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (13, 1, 1, 'OUT6', 6);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (14, 1, 1, 'OUT6', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT claim_status_name FROM (SELECT claim_outcome_code, claim_stage_id, n, claim_status_name, claim_status_description, claim_stage_id AS next_claim_stage_id FROM (SELECT LHS.claim_outcome_code AS claim_outcome_code, LHS.claim_stage_id AS claim_stage_id, LHS.n AS n, RHS.claim_status_name AS claim_status_name, RHS.claim_status_description AS claim_status_description FROM (SELECT claim_outcome_code, claim_stage_id, COUNT(*) AS n FROM claims_processing GROUP BY claim_outcome_code, claim_stage_id) AS LHS INNER JOIN claims_processing_stages AS RHS ON (LHS.claim_stage_id = RHS.next_claim_stage_id AND LHS.n = RHS.claim_stage_id))) ORDER BY claim_status_name;

/*
Gold Result:
('Alpha',)
('Middle',)
('Zebra',)
*/

-- Prediction Query
SELECT t2.claim_status_name FROM claims_processing AS t1 JOIN claims_processing_stages AS t2 ON t1.claim_stage_id = t2.claim_stage_id GROUP BY t1.claim_stage_id ORDER BY COUNT(*) DESC, t2.claim_status_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Decoy_Swapped',)
*/