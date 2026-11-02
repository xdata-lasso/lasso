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
-- Tests COUNT(*) threshold boundaries (n = 0, n = 1, n = 2, n = 3),
-- grouping by both (project_id, document_description) vs just project_id or just document_description,
-- and DISTINCT vs ALL in the outer SELECT (Project 4 has two distinct descriptions each with >= 2 docs).
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('T1', 'Type 1', 'Desc 1');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Zero Docs');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (2, 'Project Split Descriptions');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (3, 'Project Boundary Two');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (4, 'Project Multiple Qualifying Groups');
-- Project 2 has 2 documents total, but different descriptions (n=1 for each group).
-- "Desc Shared" appears in Project 2 and Project 3 (tests grouping without project_id).
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (101, 2, 'T1', '2023-01-01', 'Doc 1', 'Desc A', 'Other');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (102, 2, 'T1', '2023-01-02', 'Doc 2', 'Desc Shared', 'Other');
-- Project 3 has 2 documents with the exact same description (n=2, hits boundary) and 1 with "Desc Shared".
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (103, 3, 'T1', '2023-01-03', 'Doc 3', 'Desc B', 'Other');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (104, 3, 'T1', '2023-01-04', 'Doc 4', 'Desc B', 'Other');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (105, 3, 'T1', '2023-01-05', 'Doc 5', 'Desc Shared', 'Other');
-- Project 4 has two different descriptions that BOTH have >= 2 documents (n=2 and n=3).
-- Reference query does not have DISTINCT, so Project 4 should be output twice.
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (106, 4, 'T1', '2023-01-06', 'Doc 6', 'Desc C', 'Other');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (107, 4, 'T1', '2023-01-07', 'Doc 7', 'Desc C', 'Other');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (108, 4, 'T1', '2023-01-08', 'Doc 8', 'Desc D', 'Other');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (109, 4, 'T1', '2023-01-09', 'Doc 9', 'Desc D', 'Other');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (110, 4, 'T1', '2023-01-10', 'Doc 10', 'Desc D', 'Other');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id, project_details FROM (SELECT LHS.project_id AS project_id, LHS.project_details AS project_details, RHS.document_description AS document_description, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT document_description, project_id, COUNT(*) AS n FROM documents GROUP BY document_description, project_id) AS RHS ON (LHS.project_id = RHS.project_id)) WHERE (n >= 2) ORDER BY project_id, project_details NULLS LAST;

/*
Gold Result:
(3, 'Project Boundary Two')
(4, 'Project Multiple Qualifying Groups')
(4, 'Project Multiple Qualifying Groups')
*/

-- Prediction Query
SELECT T1.project_id, T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id = T2.project_id GROUP BY T1.project_id HAVING COUNT(*) > 2;

/*
Prediction Result:
(3, 'Project Boundary Two')
(4, 'Project Multiple Qualifying Groups')
*/