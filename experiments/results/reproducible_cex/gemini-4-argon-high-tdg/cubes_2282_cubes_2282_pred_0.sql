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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DT_INV', 'Invoice', 'Standard Invoice Document');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DT_REC', 'Receipt', 'Payment Receipt Document');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('BC_20', 'Operations');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('BC_10', 'Capital');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('BC_30', 'Unallocated');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Infrastructure Upgrade');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (2, 'Cloud Migration');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (103, 1, 'DT_INV', '2023-03-15 10:00:00', 'Doc 103', 'Server Purchase', 'Urgent');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (101, 1, 'DT_REC', '2023-01-10 09:30:00', 'Doc 101', 'Cable Purchase', 'Standard');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (102, 2, 'DT_INV', '2023-02-20 14:15:00', 'Doc 102', 'License Fee', 'Annual');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (104, 2, 'DT_REC', '2023-04-05 11:00:00', 'Doc 104', 'Misc Expense', 'Pending Code');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (105, 1, 'DT_INV', '2023-05-01 16:00:00', 'Doc 105', 'Statement Only Doc', 'No Expenses');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (105, 'Q1 Financial Statement');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (501, 105, 'Main Operating Account');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (103, 'BC_20', 'Expense Alpha');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (101, 'BC_20', 'Expense Zeta');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (102, 'BC_10', 'Expense Mu');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (104, NULL, 'Expense Without Budget');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code, budget_type_description, document_id FROM (SELECT LHS.budget_type_code AS budget_type_code, LHS.budget_type_description AS budget_type_description, RHS.document_id AS document_id, RHS.document_details AS document_details FROM ref_budget_codes AS LHS INNER JOIN documents_with_expenses AS RHS ON (LHS.budget_type_code = RHS.budget_type_code)) ORDER BY budget_type_code, budget_type_description NULLS LAST, document_id NULLS LAST;

/*
Gold Result:
('BC_10', 'Capital', 102)
('BC_20', 'Operations', 101)
('BC_20', 'Operations', 103)
*/

-- Prediction Query
SELECT T2.budget_type_code, T2.budget_type_description, T1.document_id FROM Documents_with_expenses AS T1 JOIN Ref_budget_codes AS T2 ON T1.budget_type_code = T2.budget_type_code;

/*
Prediction Result:
('BC_20', 'Operations', 101)
('BC_10', 'Capital', 102)
('BC_20', 'Operations', 103)
*/