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
INSERT INTO Customers (Customer_ID, Customer_Details) VALUES (1, 'Alice');
INSERT INTO Policies (Policy_ID, Customer_ID, Policy_Type_Code, Start_Date, End_Date) VALUES (1, 1, 'Uniform', '2020-01-01', '2021-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_details" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_details" AS "customer_details", "RHS"."policy_id" AS "policy_id", "RHS"."policy_type_code" AS "policy_type_code", "RHS"."start_date" AS "start_date", "RHS"."end_date" AS "end_date" FROM "customers" AS "LHS" INNER JOIN (SELECT * FROM "policies" WHERE ("policy_type_code" = 'Deputy')) AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_details, "customer_details" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT t2.customer_details FROM policies AS t1 JOIN customers AS t2 ON t1.customer_id = t2.customer_id WHERE t1.policy_type_code = 'Deputy' OR t1.policy_type_code = 'Uniform';

/*
Prediction Result:
('Alice',)
*/