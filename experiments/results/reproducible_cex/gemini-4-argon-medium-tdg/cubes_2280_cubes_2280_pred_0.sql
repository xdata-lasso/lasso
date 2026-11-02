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
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('TYPE_A', 'Type A', 'Description A');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('TYPE_B', 'Type B', 'Description B');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Alpha');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (10, 1, 'TYPE_B', '2023-01-01 00:00:00', 'Noel CV', 'Desc 1', 'Detail 1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (20, 1, 'TYPE_A', '2023-01-02 00:00:00', 'King Book', 'Desc 2', 'Detail 2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (30, 1, 'TYPE_A', '2023-01-03 00:00:00', 'Other Doc', 'Desc 3', 'Detail 3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (40, 1, 'TYPE_B', '2023-01-04 00:00:00', 'Noel CV Extra', 'Desc 4', 'Detail 4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (50, 1, 'TYPE_A', '2023-01-05 00:00:00', 'noel cv', 'Desc 5', 'Detail 5');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (60, 1, 'TYPE_B', '2023-01-06 00:00:00', NULL, 'Noel CV', 'King Book');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_type_code", "document_name", "document_description" FROM "documents" WHERE ("document_name" = 'Noel CV' OR "document_name" = 'King Book') ORDER BY document_type_code, documents.document_id NULLS LAST;

/*
Gold Result:
('TYPE_A', 'King Book', 'Desc 2')
('TYPE_B', 'Noel CV', 'Desc 1')
*/

-- Prediction Query
SELECT document_type_code, document_name, document_description FROM Documents WHERE document_name = 'Noel CV' OR document_name = 'King Book';

/*
Prediction Result:
('TYPE_B', 'Noel CV', 'Desc 1')
('TYPE_A', 'King Book', 'Desc 2')
*/