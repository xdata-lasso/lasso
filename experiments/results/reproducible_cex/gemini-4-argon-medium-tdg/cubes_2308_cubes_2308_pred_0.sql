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
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('TYPE_A', 'Type A', 'Description A');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Alpha');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (2, 'Private Project');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 1, 'TYPE_A', '2023-01-01', 'Zeta Doc', 'Desc 1', 'Other 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 1, 'TYPE_A', '2023-01-02', 'Alpha Doc', 'Desc 2', 'Other 2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (3, 1, 'TYPE_A', '2023-01-03', NULL, 'Desc 3', 'Other 3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (4, 1, 'TYPE_A', '2023-01-04', 'Alpha Doc', 'Desc 4', 'Other 4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (5, 2, 'TYPE_A', '2023-01-05', 'Public Doc', 'Private Project', 'Private Project');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (6, 2, 'TYPE_A', '2023-01-06', 'Private Project', 'Desc 6', 'Other 6');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (7, 1, 'TYPE_A', '2023-01-07', 'Unlinked Doc', 'Private Project', 'Other 7');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (1, 'Private Project');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (2, 'Private Project');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (3, 'Private Project');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (4, 'Private Project');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (5, 'Public Project');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "statement_details", "document_name" FROM (SELECT "document_id", "document_type_code", "project_id", "document_date", "document_name", "document_description", "other_details", "statement_details", "document_id" AS "statement_id" FROM (SELECT "LHS"."document_id" AS "document_id", "LHS"."document_type_code" AS "document_type_code", "LHS"."project_id" AS "project_id", "LHS"."document_date" AS "document_date", "LHS"."document_name" AS "document_name", "LHS"."document_description" AS "document_description", "LHS"."other_details" AS "other_details", "RHS"."statement_details" AS "statement_details" FROM "documents" AS "LHS" INNER JOIN "statements" AS "RHS" ON ("LHS"."document_id" = "RHS"."statement_id"))) WHERE ("statement_details" = 'Private Project') ORDER BY statement_details, "statement_details" NULLS LAST, "document_name" NULLS LAST;

/*
Gold Result:
('Private Project', 'Alpha Doc')
('Private Project', 'Alpha Doc')
('Private Project', 'Zeta Doc')
('Private Project', None)
*/

-- Prediction Query
SELECT T1.statement_details, T2.document_name FROM Statements AS T1 JOIN Documents AS T2 ON T1.statement_id = T2.document_id WHERE T1.statement_details = 'Private Project';

/*
Prediction Result:
('Private Project', 'Zeta Doc')
('Private Project', 'Alpha Doc')
('Private Project', None)
('Private Project', 'Alpha Doc')
*/