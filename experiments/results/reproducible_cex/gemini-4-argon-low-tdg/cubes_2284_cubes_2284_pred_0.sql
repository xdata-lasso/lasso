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
-- DATASET 2
-- Tests DISTINCT vs ALL semantics (1-to-many relationship with duplicate Account_Details for the same Statement_ID).
-- Also tests ordering of Account_Details including NULLS LAST behavior.
INSERT INTO "Documents" ("Document_ID") VALUES (1);
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (1, 'Single_Statement');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (101, 1, 'B_Account');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (102, 1, 'A_Account');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (103, 1, 'A_Account');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (104, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STATEMENT_ID, statement_details, account_details FROM (SELECT LHS.statement_id AS STATEMENT_ID, LHS.statement_details AS statement_details, RHS.account_id AS account_id, RHS.account_details AS account_details FROM statements AS LHS INNER JOIN accounts AS RHS ON (LHS.statement_id = RHS.statement_id)) ORDER BY STATEMENT_ID, statement_details NULLS LAST, account_details NULLS LAST;

/*
Gold Result:
(1, 'Single_Statement', 'A_Account')
(1, 'Single_Statement', 'A_Account')
(1, 'Single_Statement', 'B_Account')
(1, 'Single_Statement', None)
*/

-- Prediction Query
SELECT T1.statement_id, T2.statement_details, T1.account_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id = T2.statement_id;

/*
Prediction Result:
(1, 'Single_Statement', 'B_Account')
(1, 'Single_Statement', 'A_Account')
(1, 'Single_Statement', 'A_Account')
(1, 'Single_Statement', None)
*/