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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('T1', 'Type1', 'Desc1');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('T2', 'Type2', 'Desc2');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B1', 'Budget1');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Proj1');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (2, 'Proj2');
-- Desc_A: 3 documents without expenses, 1 with expenses -> count = 3
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (1, 1, 'T1', '2023-01-01', 'Doc1', 'Desc_A', 'O1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (2, 1, 'T2', '2023-01-02', 'Doc2', 'Desc_A', 'O2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (3, 2, 'T1', '2023-01-03', 'Doc3', 'Desc_A', 'O3');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (4, 1, 'T1', '2023-01-04', 'Doc4', 'Desc_A', 'O4');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (4, 'B1', 'Exp4');
-- Desc_B: 1 document without expenses -> count = 1
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (5, 2, 'T2', '2023-01-05', 'Doc5', 'Desc_B', 'O5');
-- Desc_C: 2 documents without expenses (same name, testing COUNT(document_id) vs COUNT(DISTINCT document_name)) -> count = 2
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (6, 1, 'T1', '2023-01-06', 'SameName', 'Desc_C', 'O6');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (7, 1, 'T1', '2023-01-06', 'SameName', 'Desc_C', 'O6');
-- Desc_D: 1 document, and it has expenses -> should be completely excluded (not count = 0)
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (8, 1, 'T1', '2023-01-07', 'Doc8', 'Desc_D', 'O8');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (8, 'B1', 'Exp8');
-- Statements for some documents (testing confusion between Statements and Documents_with_Expenses)
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (1, 'Stat1');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (5, 'Stat5');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (101, 1, 'Acc1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT document_description, COUNT(DISTINCT document_id) AS n_distinct FROM (SELECT * FROM documents AS LHS WHERE NOT EXISTS(SELECT 1 FROM documents_with_expenses AS RHS WHERE (LHS.document_id = RHS.document_id))) GROUP BY document_description) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Documents WHERE NOT document_id IN (SELECT document_id FROM Documents_with_expenses);

/*
Prediction Result:
(6,)
*/