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
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('AAA', 'Unused Budget Code');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B_CODE', 'Y_Desc');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('C_CODE', 'Z_Desc');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('D_CODE', 'A_Desc');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (1, 1, 'DT1', '2023-05-01 10:00:00', 'Doc Z', 'Desc 1', 'Other 1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (2, 1, 'DT1', '2023-05-02 10:00:00', 'Doc Y', 'Desc 2', 'Other 2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (3, 1, 'DT1', '2023-05-03 10:00:00', 'Doc X', 'Desc 3', 'Other 3');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (4, 1, 'DT1', '2023-01-01 10:00:00', 'Doc A', 'Desc 4', 'Other 4');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (5, 1, 'DT1', '2023-01-02 10:00:00', 'Doc B', 'Desc 5', 'Other 5');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (6, 1, 'DT1', '2023-01-03 10:00:00', 'Doc C', 'Desc 6', 'Other 6');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (1, 'Stmt 1');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (101, 1, 'Acct 1');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (1, 'C_CODE', 'M_Details');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (2, 'B_CODE', 'Z_Details_1');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (3, 'B_CODE', 'Z_Details_2');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (4, 'D_CODE', 'A_Details_1');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (5, 'D_CODE', 'A_Details_2');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (6, 'D_CODE', 'A_Details_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT budget_type_code, document_id, COUNT(*) AS n FROM documents_with_expenses GROUP BY budget_type_code, document_id) ORDER BY budget_type_code) LIMIT 1);

/*
Gold Result:
('B_CODE',)
*/

-- Prediction Query
SELECT budget_type_code FROM Documents_with_expenses GROUP BY budget_type_code ORDER BY COUNT(*) DESC, budget_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('D_CODE',)
*/