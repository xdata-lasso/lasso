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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('CV_CODE', 'Resume Type', 'Type Desc For CV');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('BK_CODE', 'Book Type', 'Type Desc For Book');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('OT_CODE', 'Noel CV', 'King Book');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (1, 1, 'CV_CODE', '2023-01-10', 'Noel CV', 'Noel Curriculum Vitae', 'Other Info 1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (2, 1, 'BK_CODE', '2023-02-15', 'King Book', 'Book by King', 'Other Info 2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (3, 1, 'OT_CODE', '2023-03-20', 'Annual Report', 'Noel CV', 'King Book');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_type_code", "document_name", "document_description" FROM "documents" WHERE ("document_name" = 'Noel CV' OR "document_name" = 'King Book') ORDER BY document_type_code, documents.document_id NULLS LAST;

/*
Gold Result:
('BK_CODE', 'King Book', 'Book by King')
('CV_CODE', 'Noel CV', 'Noel Curriculum Vitae')
*/

-- Prediction Query
SELECT document_type_code, document_name, document_description FROM Documents WHERE document_name = 'Noel CV' OR document_name = 'King Book';

/*
Prediction Result:
('CV_CODE', 'Noel CV', 'Noel Curriculum Vitae')
('BK_CODE', 'King Book', 'Book by King')
*/