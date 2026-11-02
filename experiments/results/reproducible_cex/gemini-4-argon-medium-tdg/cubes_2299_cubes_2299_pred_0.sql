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
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('TYPE_A', 'Name A', 'Desc A');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('TYPE_B', 'Name B', 'Desc B');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project 1');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (2, 'Project 2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 1, 'TYPE_A', '2023-01-01', 'Doc 1', 'Desc 1', 'Detail_1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 1, 'TYPE_A', '2023-01-02', 'Doc 2', 'Desc 2', 'Detail_2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (3, 1, 'TYPE_A', '2023-01-03', 'Doc 3', 'Desc 3', 'Detail_3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (4, 1, 'TYPE_A', '2023-01-04', 'Doc 4', 'Desc 4', 'Detail_4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (5, 2, 'TYPE_B', '2023-01-05', 'Doc 5', 'Desc 5', 'Detail_X');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (6, 2, 'TYPE_B', '2023-01-06', 'Doc 6', 'Desc 6', 'Detail_X');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (7, 2, 'TYPE_B', '2023-01-07', 'Doc 7', 'Desc 7', 'Detail_X');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT document_type_code, other_details, COUNT(*) AS n FROM documents GROUP BY document_type_code, other_details) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
('TYPE_B',)
*/

-- Prediction Query
SELECT document_type_code FROM Documents GROUP BY document_type_code ORDER BY COUNT(*) DESC, document_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('TYPE_A',)
*/