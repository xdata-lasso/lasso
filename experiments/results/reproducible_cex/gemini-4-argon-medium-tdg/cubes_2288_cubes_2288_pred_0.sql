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
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('BK', 'Book', 'Book Document');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('CV', 'CV', 'Curriculum Vitae');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('bk', 'book_lower', 'Lowercase Book');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (10, 'Project Ten');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (20, 'Project Twenty');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (30, 'Project Thirty');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (40, 'Project Forty (No Docs)');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 10, 'BK', '2023-01-01', 'Doc 1', 'Desc 1', 'Details 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 10, 'BK', '2023-01-01', 'Doc 1', 'Desc 1', 'Details 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (3, 10, 'BK', '2023-01-02', NULL, NULL, NULL);
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (4, 10, 'CV', '2023-01-03', 'Doc 4', 'Desc 4', 'Details 4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (5, 20, 'BK', '2023-01-04', 'Doc 5', 'Desc 5', 'Details 5');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (6, 20, 'CV', '2023-01-05', 'Doc 6', 'Desc 6', 'Details 6');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (7, 20, 'bk', '2023-01-06', 'Doc 7', 'Desc 7', 'Details 7');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (8, 30, 'CV', '2023-01-07', 'Doc 8', 'Desc 8', 'Details 8');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (9, 30, NULL, '2023-01-08', 'Doc 9', 'Desc 9', 'Details 9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___", "project_id" FROM (SELECT "project_id", COUNT(*) AS "n" FROM (SELECT * FROM "documents" WHERE ("document_type_code" = 'BK')) GROUP BY project_id) ORDER BY count___, "project_id" NULLS LAST;

/*
Gold Result:
(1, 20)
(3, 10)
*/

-- Prediction Query
SELECT COUNT(*), project_id FROM Documents WHERE document_type_code = 'BK' GROUP BY project_id;

/*
Prediction Result:
(3, 10)
(1, 20)
*/