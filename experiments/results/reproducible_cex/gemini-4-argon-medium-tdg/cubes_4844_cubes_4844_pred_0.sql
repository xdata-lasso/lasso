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
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (10, NULL, NULL, '2023-02-01', 'Doc10', 'Desc10', 'Other10');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (20, NULL, NULL, '2023-02-02', 'Doc20', 'Desc20', 'Other20');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (30, NULL, NULL, '2023-02-03', 'Doc30', 'Desc30', 'Other30');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (10, 'Details_Z');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (20, 'Details_A');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (30, 'Details_M');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (1, 10, 'D1');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (2, 10, 'D2');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (3, 20, 'D3');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (4, 20, 'D4');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (5, 30, 'D5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT STATEMENT_ID, statement_details FROM (SELECT LHS.statement_id AS STATEMENT_ID, LHS.statement_details AS statement_details, LHS.account_id AS account_id, LHS.account_details AS account_details, LHS.n AS n FROM (SELECT LHS.statement_id AS STATEMENT_ID, LHS.statement_details AS statement_details, LHS.account_id AS account_id, LHS.account_details AS account_details, RHS.n AS n FROM (SELECT LHS.statement_id AS STATEMENT_ID, LHS.statement_details AS statement_details, RHS.account_id AS account_id, RHS.account_details AS account_details FROM statements AS LHS INNER JOIN accounts AS RHS ON (LHS.statement_id = RHS.statement_id)) AS LHS INNER JOIN (SELECT STATEMENT_ID, COUNT(*) AS n FROM accounts GROUP BY STATEMENT_ID) AS RHS ON (LHS.statement_id = RHS.statement_id)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT STATEMENT_ID, COUNT(*) AS n FROM accounts GROUP BY STATEMENT_ID)) AS RHS ON (LHS.n = RHS.n)) ORDER BY STATEMENT_ID, statement_details NULLS LAST;

/*
Gold Result:
(10, 'Details_Z')
(20, 'Details_A')
*/

-- Prediction Query
SELECT T1.statement_id, T2.statement_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id = T2.statement_id GROUP BY T1.statement_id ORDER BY COUNT(*) DESC, T1.statement_id NULLS LAST, T2.statement_details NULLS LAST LIMIT 1;

/*
Prediction Result:
(10, 'Details_Z')
*/