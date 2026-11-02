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
INSERT INTO Claim_Headers (Claim_Header_ID, Policy_ID, Claim_Status_Code, Claim_Type_Code, Date_of_Claim, Date_of_Settlement, Amount_Claimed, Amount_Piad) VALUES (1, 1, 'OPEN', 'COLLISION', '2023-06-01', NULL, 1500.00, 0.00);
INSERT INTO Claims_Documents (Claim_ID, Document_Type_Code, Created_by_Staff_ID, Created_Date) VALUES (1, 'PHOTO', 1, 20230602);
INSERT INTO Claims_Processing (Claim_Processing_ID, Staff_ID, Claim_ID, Claim_Outcome_Code, Claim_Stage_ID) VALUES (1, 1, 1, 'PENDING', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM claims_processing_stages ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM claims_processing_stages;

/*
Prediction Result:
(0,)
*/