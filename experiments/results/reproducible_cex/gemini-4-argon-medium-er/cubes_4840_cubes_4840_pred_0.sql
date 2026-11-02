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
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B1', 'Budget 1');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B2', 'Budget 2');
INSERT INTO Documents (Document_ID) VALUES (1);
INSERT INTO Documents (Document_ID) VALUES (2);
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code) VALUES (1, 'B1');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code) VALUES (2, 'B2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code FROM (SELECT LHS.budget_type_code AS budget_type_code, LHS.n AS n FROM (SELECT budget_type_code, COUNT(*) AS n FROM documents_with_expenses GROUP BY budget_type_code) AS LHS INNER JOIN (SELECT MAX(n) AS maxn FROM (SELECT budget_type_code, COUNT(*) AS n FROM documents_with_expenses GROUP BY budget_type_code)) AS RHS ON (LHS.n = RHS.maxn)) ORDER BY budget_type_code;

/*
Gold Result:
('B1',)
('B2',)
*/

-- Prediction Query
SELECT budget_type_code FROM Documents_with_expenses GROUP BY budget_type_code ORDER BY COUNT(*) DESC, budget_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('B1',)
*/