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
-- Tests basic ordering (reverse insert order vs ascending output), column distinction, and joins vs standalone table selection.
-- Includes unreferenced document types (C_CODE) and multiple references to the same document type (A_CODE) to catch spurious INNER JOINs or missing DISTINCT in joined mutants.
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('C_CODE', 'A_Name', 'M_Description');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('B_CODE', 'C_Name', 'A_Description');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('A_CODE', 'B_Name', 'Z_Description');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (101, 1, 'A_CODE', '2023-01-01 10:00:00', 'Doc 1', 'Desc 1', 'Other 1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (102, 1, 'A_CODE', '2023-01-02 10:00:00', 'Doc 2', 'Desc 2', 'Other 2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (103, 1, 'B_CODE', '2023-01-03 10:00:00', 'Doc 3', 'Desc 3', 'Other 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_code, document_type_name, document_type_description FROM ref_document_types ORDER BY document_type_code;

/*
Gold Result:
('A_CODE', 'B_Name', 'Z_Description')
('B_CODE', 'C_Name', 'A_Description')
('C_CODE', 'A_Name', 'M_Description')
*/

-- Prediction Query
SELECT document_type_code, document_type_name, document_type_description FROM Ref_document_types;

/*
Prediction Result:
('C_CODE', 'A_Name', 'M_Description')
('B_CODE', 'C_Name', 'A_Description')
('A_CODE', 'B_Name', 'Z_Description')
*/