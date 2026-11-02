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
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('bk', 'Book Lower', 'Lowercase Book');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Alpha');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (2, 'Project Beta');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (3, 'Project Gamma');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (4, 'Project Delta');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (5, 'Project Epsilon');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (101, 2, 'BK', '2023-01-01', 'Doc 1', 'Desc 1', 'Det 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (102, 2, 'CV', '2023-01-02', 'Doc 2', 'Desc 2', 'Det 2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (103, 1, 'BK', '2023-01-03', 'Doc 3', 'Desc 3', 'Det 3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (104, 1, 'BK', '2023-01-04', 'Doc 4', 'Desc 4', 'Det 4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (105, 1, 'BK', '2023-01-05', 'Doc 5', 'Desc 5', 'Det 5');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (106, 3, 'BK', '2023-01-06', 'Doc 6', 'Desc 6', 'Det 6');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (107, 3, 'BK', '2023-01-07', 'Doc 7', 'Desc 7', 'Det 7');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (108, 4, 'CV', '2023-01-08', 'Doc 8', 'Desc 8', 'Det 8');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (109, 4, 'bk', '2023-01-09', 'Doc 9', 'Desc 9', 'Det 9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___", "project_id" FROM (SELECT "project_id", COUNT(*) AS "n" FROM (SELECT * FROM "documents" WHERE ("document_type_code" = 'BK')) GROUP BY project_id) ORDER BY count___, "project_id" NULLS LAST;

/*
Gold Result:
(1, 2)
(2, 3)
(3, 1)
*/

-- Prediction Query
SELECT COUNT(*), project_id FROM Documents WHERE document_type_code = 'BK' GROUP BY project_id;

/*
Prediction Result:
(3, 1)
(1, 2)
(2, 3)
*/