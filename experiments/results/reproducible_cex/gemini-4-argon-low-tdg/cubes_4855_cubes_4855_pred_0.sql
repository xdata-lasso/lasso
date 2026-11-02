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
-- Tests ties for the maximum count (kills LIMIT 1 mutants) and tests ORDER BY direction (Z_TYPE vs A_TYPE).
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (1, 'Cust 1');
INSERT INTO "Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (1, 1, 'Z_TYPE', '2020-01-01', '2021-01-01');
INSERT INTO "Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (2, 1, 'Z_TYPE', '2020-01-01', '2021-01-01');
INSERT INTO "Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (3, 1, 'Z_TYPE', '2020-01-01', '2021-01-01');
INSERT INTO "Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (4, 1, 'A_TYPE', '2020-01-01', '2021-01-01');
INSERT INTO "Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (5, 1, 'A_TYPE', '2020-01-01', '2021-01-01');
INSERT INTO "Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (6, 1, 'A_TYPE', '2020-01-01', '2021-01-01');
INSERT INTO "Policies" ("Policy_ID", "Customer_ID", "Policy_Type_Code", "Start_Date", "End_Date") VALUES (7, 1, 'M_TYPE', '2020-01-01', '2021-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT policy_type_code_other AS policy_type_code FROM (SELECT LHS.policy_type_code AS policy_type_code, LHS.n AS n, LHS.maxn AS maxn, RHS.policy_type_code AS policy_type_code_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT policy_type_code, n, MAX(n) OVER () AS maxn FROM (SELECT policy_type_code, COUNT(*) AS n FROM policies GROUP BY policy_type_code)) AS LHS CROSS JOIN (SELECT policy_type_code, n, MAX(n) OVER () AS maxn FROM (SELECT policy_type_code, COUNT(*) AS n FROM policies GROUP BY policy_type_code)) AS RHS) WHERE (maxn = maxn_other AND n_other >= maxn_other) ORDER BY policy_type_code;

/*
Gold Result:
('A_TYPE',)
('Z_TYPE',)
*/

-- Prediction Query
SELECT policy_type_code FROM policies GROUP BY policy_type_code ORDER BY COUNT(*) DESC, policy_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_TYPE',)
*/