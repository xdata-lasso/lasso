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
-- Tests standard composite grouping (project_id, document_description), tie-breaking counts, and sorting order.
-- Kills mutants that group only by project_id, group only by document_description, use SELECT DISTINCT, or reverse ORDER BY directions.
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Alpha');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (2, 'Project Beta');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (3, 'Project Gamma (No Docs)');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('T1', 'Type 1', 'Type 1 Desc');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (101, 2, 'T1', '2023-01-01', 'Doc 1', 'Spec', 'Det 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (102, 2, 'T1', '2023-01-02', 'Doc 2', 'Spec', 'Det 2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (103, 2, 'T1', '2023-01-03', 'Doc 3', 'Report', 'Det 3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (104, 1, 'T1', '2023-01-04', 'Doc 4', 'Spec', 'Det 4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (105, 1, 'T1', '2023-01-05', 'Doc 5', 'Invoice', 'Det 5');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (106, 1, 'T1', '2023-01-06', 'Doc 6', 'Invoice', 'Det 6');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (107, 1, 'T1', '2023-01-07', 'Doc 7', 'Invoice', 'Det 7');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (108, 1, 'T1', '2023-01-08', 'Doc 8', 'Plan', 'Det 8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id, n AS count___ FROM (SELECT document_description, project_id, COUNT(*) AS n FROM documents GROUP BY document_description, project_id) ORDER BY project_id, count___ NULLS LAST;

/*
Gold Result:
(1, 1)
(1, 1)
(1, 3)
(2, 1)
(2, 2)
*/

-- Prediction Query
SELECT project_id, COUNT(*) FROM Documents GROUP BY project_id;

/*
Prediction Result:
(1, 5)
(2, 3)
*/