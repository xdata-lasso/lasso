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
-- Tests basic filtering, join correctness, orphaned documents, childless projects, and basic ordering.
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT1', 'Report', 'Technical Report');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Graph Database project');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (2, 'Relational Database project');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (3, 'Graph Database project');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (4, NULL);
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (101, 1, 'DT1', '2023-05-10', 'Zebra Doc', 'Desc 1', 'Other 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (102, 1, 'DT1', '2023-01-15', 'Alpha Doc', 'Desc 2', 'Other 2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (103, 2, 'DT1', '2023-03-20', 'Beta Doc', 'Graph Database project', 'Other 3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (104, NULL, 'DT1', '2023-04-01', 'Orphan Doc', 'Desc 4', 'Other 4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_name", "document_date" FROM (SELECT "LHS"."project_id" AS "project_id", "LHS"."project_details" AS "project_details", "RHS"."document_id" AS "document_id", "RHS"."document_type_code" AS "document_type_code", "RHS"."document_date" AS "document_date", "RHS"."document_name" AS "document_name", "RHS"."document_description" AS "document_description", "RHS"."other_details" AS "other_details" FROM "projects" AS "LHS" INNER JOIN "documents" AS "RHS" ON ("LHS"."project_id" = "RHS"."project_id")) WHERE ("project_details" = 'Graph Database project') ORDER BY document_name, "document_name" NULLS LAST, "document_date" NULLS LAST;

/*
Gold Result:
('Alpha Doc', '2023-01-15')
('Zebra Doc', '2023-05-10')
*/

-- Prediction Query
SELECT document_name, document_date FROM Documents AS T1 JOIN projects AS T2 ON T1.project_id = T2.project_id WHERE T2.project_details = 'Graph Database project';

/*
Prediction Result:
('Zebra Doc', '2023-05-10')
('Alpha Doc', '2023-01-15')
*/