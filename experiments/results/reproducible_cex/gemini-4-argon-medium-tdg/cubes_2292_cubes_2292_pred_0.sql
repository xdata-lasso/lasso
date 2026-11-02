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
-- DATASET 2
-- Tests GROUP BY (document_name, project_id) vs GROUP BY (project_id) when a mutant orders or filters by count.
-- Project 50 has 2 docs with DIFFERENT names (count 1 each per group, total 2 for project).
-- Project 40 has 2 docs with the SAME name (count 2 in group).
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('T1', 'Type 1', 'Desc 1');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (40, 'Project 40');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (50, 'Project 50');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 40, 'T1', '2023-01-01', 'Shared_Name', 'D1', 'O1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 40, 'T1', '2023-01-02', 'Shared_Name', 'D2', 'O2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (3, 50, 'T1', '2023-01-03', 'Unique_Name_1', 'D3', 'O3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (4, 50, 'T1', '2023-01-04', 'Unique_Name_2', 'D4', 'O4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id FROM (SELECT * FROM (SELECT * FROM (SELECT document_name, project_id, COUNT(*) AS n FROM documents GROUP BY document_name, project_id) ORDER BY project_id DESC) LIMIT 1);

/*
Gold Result:
(50,)
*/

-- Prediction Query
SELECT project_id FROM Documents GROUP BY project_id ORDER BY COUNT(*) ASC, project_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(40,)
*/