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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DT1', 'Invoice', 'Invoice Document');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B_LOW', 'Low Count Alphabetically First');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('M_HIGH', 'High Count Alphabetically Middle');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('Z_FIRST', 'Inserted First Alphabetically Last');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (1, 1, 'DT1', '2023-01-01', 'Doc 1', 'Desc 1', 'Other 1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (2, 1, 'DT1', '2023-01-02', 'Doc 2', 'Desc 2', 'Other 2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (3, 1, 'DT1', '2023-01-03', 'Doc 3', 'Desc 3', 'Other 3');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (4, 1, 'DT1', '2023-01-04', 'Doc 4', 'Desc 4', 'Other 4');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (5, 1, 'DT1', '2023-01-05', 'Doc 5', 'Desc 5', 'Other 5');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (1, 'Z_FIRST', 'Details 1');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (2, 'M_HIGH', 'Details 2');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (3, 'M_HIGH', 'Details 3');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (4, 'M_HIGH', 'Details 4');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (5, 'B_LOW', 'Details 5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT budget_type_code, document_id, COUNT(*) AS n FROM documents_with_expenses GROUP BY budget_type_code, document_id) ORDER BY budget_type_code) LIMIT 1);

/*
Gold Result:
('B_LOW',)
*/

-- Prediction Query
SELECT budget_type_code FROM Documents_with_expenses GROUP BY budget_type_code ORDER BY COUNT(*) DESC, budget_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('M_HIGH',)
*/