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
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (1, 'Customer A');
INSERT INTO "Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (1, 1, 'AUTO', '2023-01-01', '2024-01-01');
INSERT INTO "Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (2, 1, 'AUTO', '2023-02-01', '2024-02-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT policy_type_code, COUNT(*) AS n FROM policies GROUP BY policy_type_code) WHERE (n >= 2) ORDER BY policy_type_code;

/*
Gold Result:
('AUTO',)
*/

-- Prediction Query
SELECT policy_type_code FROM policies GROUP BY policy_type_code HAVING COUNT(*) > 2;

/*
Prediction Result:
*/