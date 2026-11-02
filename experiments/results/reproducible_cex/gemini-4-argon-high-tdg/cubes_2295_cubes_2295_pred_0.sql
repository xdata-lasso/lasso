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
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Infrastructure Upgrade');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (2, 'Cloud Migration');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('INV', 'Invoice', 'Billing document');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('CNT', 'Contract', 'Legal agreement');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('UNUSED', 'Unused Type', 'No matching documents');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('CAP', 'Capital Expenditure');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (101, 1, 'INV', '2023-03-15 09:00:00', 'Doc Alpha', 'Desc Alpha', 'Detail 1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (102, 2, 'CNT', '2023-01-10 14:30:00', 'Invoice', 'Billing document', 'Detail 2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (103, 1, NULL, '2023-02-20 11:15:00', 'Unassigned Doc', 'No type code', 'Detail 3');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (101, 'Q1 Financial Statement');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (501, 101, 'Main Operating Account');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (101, 'CAP', 'Server purchase expense');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_name, document_type_description, document_date FROM (SELECT LHS.document_type_code AS document_type_code, LHS.document_type_name AS document_type_name, LHS.document_type_description AS document_type_description, RHS.document_id AS document_id, RHS.project_id AS project_id, RHS.document_date AS document_date, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM ref_document_types AS LHS INNER JOIN documents AS RHS ON (LHS.document_type_code = RHS.document_type_code)) ORDER BY document_type_name, document_type_description NULLS LAST, document_date NULLS LAST;

/*
Gold Result:
('Contract', 'Legal agreement', '2023-01-10 14:30:00')
('Invoice', 'Billing document', '2023-03-15 09:00:00')
*/

-- Prediction Query
SELECT T1.document_type_name, T1.document_type_description, T2.Document_date FROM Ref_document_types AS T1 JOIN Documents AS T2 ON T1.document_type_code = T2.document_type_code;

/*
Prediction Result:
('Invoice', 'Billing document', '2023-03-15 09:00:00')
('Contract', 'Legal agreement', '2023-01-10 14:30:00')
*/