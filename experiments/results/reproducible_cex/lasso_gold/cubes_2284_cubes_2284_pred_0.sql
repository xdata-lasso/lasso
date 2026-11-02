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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1019, 'middle');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1025, 'family');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('after', 'Jack Galloway', 'Dream drive note bad rule.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('relationship', 'Mr. Nathaniel Khan', 'Line six space couple best issue interest.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1020, 1019, 'after', '1976-07-07', 'Vanessa Patel', 'Campaign little near enter.', 'turn');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1026, 1025, 'relationship', '1978-09-09', 'Nicholas Nunez', 'Art rock song body.', 'dark');
INSERT INTO "statements" ("statement_id", "statement_details") VALUES (1020, 'Rhode Island');
INSERT INTO "statements" ("statement_id", "statement_details") VALUES (1026, 'Illinois');
INSERT INTO "accounts" ("account_id", "statement_id", "account_details") VALUES (1021, 1020, 'land');
INSERT INTO "accounts" ("account_id", "statement_id", "account_details") VALUES (1024, 1020, 'economy');
INSERT INTO "accounts" ("account_id", "statement_id", "account_details") VALUES (1027, 1026, 'not');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STATEMENT_ID, statement_details, account_details FROM (SELECT LHS.statement_id AS STATEMENT_ID, LHS.statement_details AS statement_details, RHS.account_id AS account_id, RHS.account_details AS account_details FROM statements AS LHS INNER JOIN accounts AS RHS ON (LHS.statement_id = RHS.statement_id)) ORDER BY STATEMENT_ID, statement_details NULLS LAST, account_details NULLS LAST;

/*
Gold Result:
(1020, 'Rhode Island', 'economy')
(1020, 'Rhode Island', 'land')
(1026, 'Illinois', 'not')
*/

-- Prediction Query
SELECT T1.statement_id, T2.statement_details, T1.account_details FROM Accounts AS T1 JOIN Statements AS T2 ON T1.statement_id = T2.statement_id;

/*
Prediction Result:
(1020, 'Rhode Island', 'land')
(1020, 'Rhode Island', 'economy')
(1026, 'Illinois', 'not')
*/