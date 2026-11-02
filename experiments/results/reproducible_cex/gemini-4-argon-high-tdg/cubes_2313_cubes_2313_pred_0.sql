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
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('BK', 'Book', 'Book Document');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('CV', 'CV', 'Curriculum Vitae');
INSERT INTO "Ref_Budget_Codes" ("Budget_Type_Code", "Budget_Type_Description") VALUES ('BG1', 'General Budget');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (10, 'Project Alpha');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (20, 'Project Beta');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (3, 10, 'BK', '2023-01-15', 'Alpha', 'Desc 3', 'Details 3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 10, 'BK', '2023-01-10', 'Beta', 'Desc 1', 'Details 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 20, 'BK', '2023-01-12', 'Alpha', 'Desc 2', 'Details 2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (4, 10, 'CV', '2023-01-20', 'Gamma', 'Desc 4', 'Details 4');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (1, 'Statement for Doc 1');
INSERT INTO "Statements" ("Statement_ID", "Statement_Details") VALUES (4, 'Statement for Doc 4');
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (1, 'BG1', 'Expense for Doc 1');
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (4, 'BG1', 'Expense for Doc 4');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (100, 1, 'Account A for Doc 1');
INSERT INTO "Accounts" ("Account_ID", "Statement_ID", "Account_Details") VALUES (101, 1, 'Account B for Doc 1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_name", "document_id" FROM "documents" WHERE ("document_type_code" = 'BK') ORDER BY document_name, documents.document_id NULLS LAST;

/*
Gold Result:
('Alpha', 2)
('Alpha', 3)
('Beta', 1)
*/

-- Prediction Query
SELECT document_name, document_id FROM Documents WHERE document_type_code = 'BK';

/*
Prediction Result:
('Beta', 1)
('Alpha', 2)
('Alpha', 3)
*/