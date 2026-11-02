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
-- Tests basic composite grouping (Project_ID, Document_Description), secondary sorting on count___, and duplicate output rows (to kill SELECT DISTINCT mutants).
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('T1', 'Type1', 'TypeDesc1');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('T2', 'Type2', 'TypeDesc2');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Alpha');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (2, 'Project Beta');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (3, 'Project Empty');
-- Project 1: DescA (count 3), DescB (count 1), DescC (count 1). Tests tie in count___ for Project 1 and sorting (1, 1, 3).
-- Also uses differing Document_Name, Document_Type_Code, and Other_Details to kill mutants grouping by the wrong columns.
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (101, 1, 'T1', '2023-01-01', 'Name1', 'DescA', 'Other1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (102, 1, 'T1', '2023-01-02', 'Name2', 'DescA', 'Other2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (103, 1, 'T2', '2023-01-03', 'Name3', 'DescA', 'Other3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (104, 1, 'T1', '2023-01-04', 'Name1', 'DescB', 'Other1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (105, 1, 'T2', '2023-01-05', 'Name1', 'DescC', 'Other1');
-- Project 2: DescA (count 2). Tests same Document_Description across different projects.
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (201, 2, 'T1', '2023-02-01', 'Name4', 'DescA', 'Other4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (202, 2, 'T2', '2023-02-02', 'Name5', 'DescA', 'Other5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id, n AS count___ FROM (SELECT document_description, project_id, COUNT(*) AS n FROM documents GROUP BY document_description, project_id) ORDER BY project_id, count___ NULLS LAST;

/*
Gold Result:
(1, 1)
(1, 1)
(1, 3)
(2, 2)
*/

-- Prediction Query
SELECT project_id, COUNT(*) FROM Documents GROUP BY project_id;

/*
Prediction Result:
(1, 5)
(2, 2)
*/