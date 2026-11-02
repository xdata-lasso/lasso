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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('C_DOC', 'D_Name', 'D_Desc');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('A_DOC', 'B_Name', 'C_Desc');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('D_DOC', 'A_Name', 'B_Desc');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('B_DOC', 'C_Name', 'A_Desc');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B_01', 'Operational Budget');
INSERT INTO Ref_Budget_Codes (Budget_Type_Code, Budget_Type_Description) VALUES ('B_02', 'Capital Budget');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project Alpha');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (2, 'Project Beta');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (101, 1, 'A_DOC', '2023-01-15 10:00:00', 'Doc One', 'First Document', 'None');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (102, 1, 'A_DOC', '2023-02-20 11:30:00', 'Doc Two', 'Second Document', 'Urgent');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (103, 2, 'C_DOC', '2023-03-10 09:15:00', 'Doc Three', 'Third Document', 'Archived');
INSERT INTO Statements (Statement_ID, Statement_Details) VALUES (101, 'Q1 Financial Statement');
INSERT INTO Documents_with_Expenses (Document_ID, Budget_Type_Code, Document_Details) VALUES (102, 'B_01', 'Travel Expense');
INSERT INTO Accounts (Account_ID, Statement_ID, Account_Details) VALUES (1001, 101, 'Main Checking Account');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_code, document_type_name, document_type_description FROM ref_document_types ORDER BY document_type_code;

/*
Gold Result:
('A_DOC', 'B_Name', 'C_Desc')
('B_DOC', 'C_Name', 'A_Desc')
('C_DOC', 'D_Name', 'D_Desc')
('D_DOC', 'A_Name', 'B_Desc')
*/

-- Prediction Query
SELECT document_type_code, document_type_name, document_type_description FROM Ref_document_types;

/*
Prediction Result:
('C_DOC', 'D_Name', 'D_Desc')
('A_DOC', 'B_Name', 'C_Desc')
('D_DOC', 'A_Name', 'B_Desc')
('B_DOC', 'C_Name', 'A_Desc')
*/