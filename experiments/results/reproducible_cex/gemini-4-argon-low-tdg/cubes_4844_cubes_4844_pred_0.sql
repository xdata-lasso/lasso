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
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Beta');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT1', 'Type 1', 'Description 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (5, 1, 'DT1', '2023-02-01', 'Doc 5', 'Desc 5', 'Other 5');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (15, 1, 'DT1', '2023-02-02', 'Doc 15', 'Desc 15', 'Other 15');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (25, 1, 'DT1', '2023-02-03', 'Doc 25', 'Desc 25', 'Other 25');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (5, 'Same Details');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (15, NULL);
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (25, 'Same Details');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (1, 25, 'A1');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (2, 25, 'A2');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (3, 15, 'A3');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (4, 15, 'A4');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (5, 5, 'A5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT STATEMENT_ID, statement_details FROM (SELECT LHS.statement_id AS STATEMENT_ID, LHS.statement_details AS statement_details, LHS.account_id AS account_id, LHS.account_details AS account_details, LHS.n AS n FROM (SELECT LHS.statement_id AS STATEMENT_ID, LHS.statement_details AS statement_details, LHS.account_id AS account_id, LHS.account_details AS account_details, RHS.n AS n FROM (SELECT LHS.statement_id AS STATEMENT_ID, LHS.statement_details AS statement_details, RHS.account_id AS account_id, RHS.account_details AS account_details FROM statements AS LHS INNER JOIN accounts AS RHS ON (LHS.statement_id = RHS.statement_id)) AS LHS INNER JOIN (SELECT STATEMENT_ID, COUNT(*) AS n FROM accounts GROUP BY STATEMENT_ID) AS RHS ON (LHS.statement_id = RHS.statement_id)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT STATEMENT_ID, COUNT(*) AS n FROM accounts GROUP BY STATEMENT_ID)) AS RHS ON (LHS.n = RHS.n)) ORDER BY STATEMENT_ID, statement_details NULLS LAST;

/*
Gold Result:
(15, None)
(25, 'Same Details')
*/

-- Prediction Query
SELECT T1.statement_id, T2.statement_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id = T2.statement_id GROUP BY T1.statement_id ORDER BY COUNT(*) DESC, T1.statement_id NULLS LAST, T2.statement_details NULLS LAST LIMIT 1;

/*
Prediction Result:
(15, None)
*/