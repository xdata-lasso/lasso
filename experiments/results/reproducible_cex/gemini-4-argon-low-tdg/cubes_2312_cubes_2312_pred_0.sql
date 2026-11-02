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
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('BOOK', 'Book', 'A book document');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Beta Project');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (2, 'Alpha Project');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (3, 'Alpha Project');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (4, NULL);
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (5, 'Unreferenced Project');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (101, 1, 'BOOK', '2023-01-01', 'King Book', 'Desc 1', 'Other 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (102, 2, 'BOOK', '2023-01-02', 'King Book', 'Desc 2', 'Other 2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (103, 3, 'BOOK', '2023-01-03', 'King Book', 'Desc 3', 'Other 3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (104, 4, 'BOOK', '2023-01-04', 'King Book', 'Desc 4', 'Other 4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (105, NULL, 'BOOK', '2023-01-05', 'King Book', 'Desc 5', 'Other 5');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (106, 1, 'BOOK', '2023-01-06', 'Queen Book', 'King Book', 'King Book');
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
('Beta Project',)
*/

-- Prediction Query
SELECT T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id = T2.project_id WHERE T2.document_name = 'King Book';

/*
Prediction Result:
('Beta Project',)
('Alpha Project',)
('Alpha Project',)
(None,)
*/