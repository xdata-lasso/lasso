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
-- Tests basic composite GROUP BY (Document_Type_Code, Other_Details), duplicate output rows (DISTINCT vs ALL), and secondary sorting on count___
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DOC_A', 'Type A', 'Description A');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DOC_B', 'Type B', 'Description B');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DOC_C', 'Type C', 'Description C');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project Alpha');
-- DOC_A has two distinct Other_Details ('Det1' with count 2, 'Det2' with count 1) to test secondary ordering (1 before 2) and multi-column grouping
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (1, 1, 'DOC_A', '2023-01-01', 'Doc 1', 'Desc 1', 'Det1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (2, 1, 'DOC_A', '2023-01-02', 'Doc 2', 'Desc 2', 'Det1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (3, 1, 'DOC_A', '2023-01-03', 'Doc 3', 'Desc 3', 'Det2');
-- DOC_B has two distinct Other_Details ('Det1' and 'Det3'), both with count 1.
-- This produces two identical output rows ('DOC_B', 1) to catch mutants that mistakenly add SELECT DISTINCT.
-- Also shares 'Det1' with DOC_A to catch mutants that only GROUP BY Other_Details.
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (4, 1, 'DOC_B', '2023-01-04', 'Doc 4', 'Desc 4', 'Det1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (5, 1, 'DOC_B', '2023-01-05', 'Doc 5', 'Desc 5', 'Det3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_code, n AS count___ FROM (SELECT document_type_code, other_details, COUNT(*) AS n FROM documents GROUP BY document_type_code, other_details) ORDER BY document_type_code, count___ NULLS LAST;

/*
Gold Result:
('DOC_A', 1)
('DOC_A', 2)
('DOC_B', 1)
('DOC_B', 1)
*/

-- Prediction Query
SELECT document_type_code, COUNT(*) FROM Documents GROUP BY document_type_code;

/*
Prediction Result:
('DOC_A', 3)
('DOC_B', 2)
*/