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
-- Tests:
-- 1. ORDER BY budget_type_code ASC vs no ORDER BY (inserted out of order)
-- 2. ORDER BY budget_type_code vs ORDER BY budget_type_description (inverse alphabetical relationship)
-- 3. Unnecessary INNER JOIN with Documents_with_Expenses (B_CODE has 0 references, C_CODE has 2 references causing duplicates without DISTINCT)
-- 4. Confusing Ref_Budget_Codes with Ref_Document_Types
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('C_CODE', 'Alpha Budget');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('A_CODE', 'Zulu Budget');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B_CODE', 'Beta Budget');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DOC_1', 'Invoice', 'Standard Invoice');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project X');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (101, 1, 'DOC_1', '2023-01-01', 'Doc 1', 'Desc 1', 'Other 1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (102, 1, 'DOC_1', '2023-01-02', 'Doc 2', 'Desc 2', 'Other 2');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (101, 'C_CODE', 'Expense 1');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (102, 'C_CODE', 'Expense 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code, budget_type_description FROM ref_budget_codes ORDER BY budget_type_code;

/*
Gold Result:
('A_CODE', 'Zulu Budget')
('B_CODE', 'Beta Budget')
('C_CODE', 'Alpha Budget')
*/

-- Prediction Query
SELECT budget_type_code, budget_type_description FROM Ref_budget_codes;

/*
Prediction Result:
('C_CODE', 'Alpha Budget')
('A_CODE', 'Zulu Budget')
('B_CODE', 'Beta Budget')
*/