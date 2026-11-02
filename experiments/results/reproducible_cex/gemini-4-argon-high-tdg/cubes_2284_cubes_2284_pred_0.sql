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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DOC_STMT', 'Statement', 'Financial Statement Document');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('BDG_01', 'Operations Budget');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (100, 'Project Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (1, 100, 'DOC_STMT', '2023-01-10 10:00:00', 'Doc 1', 'Desc 1', 'Other 1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (2, NULL, NULL, '2023-02-15 12:00:00', 'Doc 2', 'Desc 2', 'Other 2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (3, 100, 'DOC_STMT', '2023-03-20 14:00:00', 'Doc 3', 'Desc 3', 'Other 3');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (4, 100, 'DOC_STMT', '2023-04-25 16:00:00', 'Doc 4', 'Desc 4', 'Other 4');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (1, 'BDG_01', 'Expense Details 1');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (4, 'BDG_01', 'Expense Details 4');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (1, 'Statement One Details');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (2, 'Statement Two Details');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (3, 'Statement Three Unmatched');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (10, 1, 'Account Ten');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (11, 1, 'Account Eleven');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (12, 2, 'Duplicate Account Detail');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (13, 2, 'Duplicate Account Detail');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (14, NULL, 'Orphan Account');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STATEMENT_ID, statement_details, account_details FROM (SELECT LHS.statement_id AS STATEMENT_ID, LHS.statement_details AS statement_details, RHS.account_id AS account_id, RHS.account_details AS account_details FROM statements AS LHS INNER JOIN accounts AS RHS ON (LHS.statement_id = RHS.statement_id)) ORDER BY STATEMENT_ID, statement_details NULLS LAST, account_details NULLS LAST;

/*
Gold Result:
(1, 'Statement One Details', 'Account Eleven')
(1, 'Statement One Details', 'Account Ten')
(2, 'Statement Two Details', 'Duplicate Account Detail')
(2, 'Statement Two Details', 'Duplicate Account Detail')
*/

-- Prediction Query
SELECT T1.statement_id, T2.statement_details, T1.account_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id = T2.statement_id;

/*
Prediction Result:
(1, 'Statement One Details', 'Account Ten')
(1, 'Statement One Details', 'Account Eleven')
(2, 'Statement Two Details', 'Duplicate Account Detail')
(2, 'Statement Two Details', 'Duplicate Account Detail')
*/