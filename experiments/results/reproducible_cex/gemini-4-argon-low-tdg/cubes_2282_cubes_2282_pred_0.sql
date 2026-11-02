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
-- Tests INNER JOIN vs LEFT/RIGHT/FULL OUTER JOIN, 1-to-many relationships, NULL foreign keys, and tie-breaking in ORDER BY.
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT1', 'Invoice', 'Standard Invoice');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Alpha');
INSERT INTO "Ref_Budget_Codes" ("Budget_Type_Code", "Budget_Type_Description") VALUES ('B_UNMATCHED', 'Orphan Budget Code');
INSERT INTO "Ref_Budget_Codes" ("Budget_Type_Code", "Budget_Type_Description") VALUES ('B_MATCH_1', 'Single Match Budget');
INSERT INTO "Ref_Budget_Codes" ("Budget_Type_Code", "Budget_Type_Description") VALUES ('B_MATCH_2', NULL);
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (10, 1, 'DT1', '2023-01-10', 'Doc 10', 'Desc 10', 'Other 10');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (20, 1, 'DT1', '2023-01-20', 'Doc 20', 'Desc 20', 'Other 20');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (30, 1, 'DT1', '2023-01-30', 'Doc 30', 'Desc 30', 'Other 30');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (40, 1, 'DT1', '2023-02-10', 'Doc 40', 'Desc 40', 'Other 40');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (50, 1, 'DT1', '2023-02-20', 'Doc 50', 'Desc 50', 'Other 50');
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (30, 'B_MATCH_1', 'Expense 30');
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (10, 'B_MATCH_1', 'Expense 10');
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (20, 'B_MATCH_2', 'Expense 20');
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (40, NULL, 'Expense 40 with NULL budget code');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code, budget_type_description, document_id FROM (SELECT LHS.budget_type_code AS budget_type_code, LHS.budget_type_description AS budget_type_description, RHS.document_id AS document_id, RHS.document_details AS document_details FROM ref_budget_codes AS LHS INNER JOIN documents_with_expenses AS RHS ON (LHS.budget_type_code = RHS.budget_type_code)) ORDER BY budget_type_code, budget_type_description NULLS LAST, document_id NULLS LAST;

/*
Gold Result:
('B_MATCH_1', 'Single Match Budget', 10)
('B_MATCH_1', 'Single Match Budget', 30)
('B_MATCH_2', None, 20)
*/

-- Prediction Query
SELECT T2.budget_type_code, T2.budget_type_description, T1.document_id FROM Documents_with_expenses AS T1 JOIN Ref_budget_codes AS T2 ON T1.budget_type_code = T2.budget_type_code;

/*
Prediction Result:
('B_MATCH_1', 'Single Match Budget', 10)
('B_MATCH_2', None, 20)
('B_MATCH_1', 'Single Match Budget', 30)
*/