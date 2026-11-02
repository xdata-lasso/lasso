-- Schema DDL
CREATE TABLE "Ref_Document_Types" ("Document_Type_Code" TEXT(15) PRIMARY KEY, "Document_Type_Name" TEXT(255), "Document_Type_Description" TEXT(255));

CREATE TABLE "Ref_Budget_Codes" ("Budget_Type_Code" TEXT(15) PRIMARY KEY, "Budget_Type_Description" TEXT(255));

CREATE TABLE "Projects" ("Project_ID" INTEGER PRIMARY KEY, "Project_Details" TEXT(255));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Project_ID" INTEGER, "Document_Type_Code" TEXT(15), "Document_Date" DATETIME, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Project_ID") REFERENCES "Projects" ("Project_ID"), FOREIGN KEY ("Document_Type_Code") REFERENCES "Ref_Document_Types" ("Document_Type_Code"));

CREATE TABLE "Statements" ("Statement_ID" INTEGER PRIMARY KEY, "Statement_Details" TEXT(255), FOREIGN KEY ("Statement_ID") REFERENCES "Documents" ("Document_ID"));

CREATE TABLE "Documents_with_Expenses" ("Document_ID" INTEGER PRIMARY KEY, "Budget_Type_Code" TEXT(15), "Document_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"), FOREIGN KEY ("Budget_Type_Code") REFERENCES "Ref_Budget_Codes" ("Budget_Type_Code"));

CREATE TABLE "Accounts" ("Account_ID" INTEGER PRIMARY KEY, "Statement_ID" INTEGER, "Account_Details" TEXT(255), FOREIGN KEY ("Statement_ID") REFERENCES "Statements" ("Statement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (10, 'Zeta Project');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (20, 'Alpha Project');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (30, 'Beta Project');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (40, NULL);
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('BK', 'Book', 'Book Type');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 10, 'BK', '2023-01-01', 'King Book', 'First King Book', 'None');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 20, 'BK', '2023-01-02', 'King Book', 'Second King Book', 'None');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (3, 20, 'BK', '2023-01-03', 'King Book', 'Duplicate Project King Book', 'None');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (4, NULL, 'BK', '2023-01-04', 'King Book', 'Unassigned King Book', 'None');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (5, 40, 'BK', '2023-01-05', 'King Book', 'Null Details Project', 'None');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (6, 30, 'BK', '2023-01-06', 'Queen Book', 'King Book', 'King Book');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "project_details" FROM (SELECT "LHS"."document_id" AS "document_id", "LHS"."document_type_code" AS "document_type_code", "LHS"."project_id" AS "project_id", "LHS"."document_date" AS "document_date", "LHS"."document_name" AS "document_name", "LHS"."document_description" AS "document_description", "LHS"."other_details" AS "other_details", "RHS"."project_details" AS "project_details" FROM (SELECT * FROM "documents" WHERE ("document_name" = 'King Book')) AS LHS LEFT JOIN projects AS RHS ON (LHS.project_id = RHS.project_id)) ORDER BY project_details, "project_details" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('Alpha Project',)
('Alpha Project',)
('Zeta Project',)
*/

-- Prediction Query
SELECT T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id = T2.project_id WHERE T2.document_name = 'King Book';

/*
Prediction Result:
('Zeta Project',)
('Alpha Project',)
('Alpha Project',)
(None,)
*/