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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('BK', 'Book', 'Book Document');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('CV', 'CV', 'Curriculum Vitae');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('FL', 'Film', 'Film Document');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('UN', 'Unused', 'Unused Type');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B1', 'Internal');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B2', 'External');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (10, 'Alpha Project');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (20, 'Unused Project');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (1, 10, 'BK', '2023-01-01', 'Doc 1', 'Desc 1', 'Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (2, 10, 'BK', '2023-01-02', 'Doc 2', 'Desc 2', 'Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (3, 10, 'BK', '2023-01-03', 'Doc 3', 'Desc 3', 'Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (4, 10, 'BK', '2023-01-04', 'Doc 4', 'Desc 4', 'Beta');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (5, 10, 'BK', '2023-01-05', 'Doc 5', 'Desc 5', 'Gamma');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (6, 10, 'CV', '2023-01-06', 'Doc 6', 'Desc 6', 'Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (7, 10, 'CV', '2023-01-07', 'Doc 7', 'Desc 7', 'Alpha');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (8, 10, 'FL', '2023-01-08', 'Doc 8', 'Desc 8', 'Delta');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (9, 10, 'FL', '2023-01-09', 'Doc 9', 'Desc 9', 'Delta');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (10, 10, 'FL', '2023-01-10', 'Doc 10', 'Desc 10', 'Delta');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (11, 10, 'FL', '2023-01-11', 'Doc 11', 'Desc 11', 'Delta');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (1, 'Stmt 1');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (6, 'Stmt 6');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (1, 'B1', 'Exp 1');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (4, 'B1', 'Exp 4');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (100, 1, 'Acc 1');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (101, 1, 'Acc 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_code, n AS count___ FROM (SELECT document_type_code, other_details, COUNT(*) AS n FROM documents GROUP BY document_type_code, other_details) ORDER BY document_type_code, count___ NULLS LAST;

/*
Gold Result:
('BK', 1)
('BK', 1)
('BK', 3)
('CV', 2)
('FL', 4)
*/

-- Prediction Query
SELECT document_type_code, COUNT(*) FROM Documents GROUP BY document_type_code;

/*
Prediction Result:
('BK', 5)
('CV', 2)
('FL', 4)
*/