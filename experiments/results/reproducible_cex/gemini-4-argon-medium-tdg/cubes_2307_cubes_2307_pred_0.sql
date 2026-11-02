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
-- Tests basic selection, column order, and ordering by Document_Type_Code (out-of-order inserts, reverse alphabetical correlation with Name/Description).
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C03', 'Alpha Name', 'Middle Description');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('A01', 'Zeta Name', 'Last Description');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('B02', 'Beta Name', 'First Description');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_code, document_type_name, document_type_description FROM ref_document_types ORDER BY document_type_code;

/*
Gold Result:
('A01', 'Zeta Name', 'Last Description')
('B02', 'Beta Name', 'First Description')
('C03', 'Alpha Name', 'Middle Description')
*/

-- Prediction Query
SELECT document_type_code, document_type_name, document_type_description FROM Ref_document_types;

/*
Prediction Result:
('C03', 'Alpha Name', 'Middle Description')
('A01', 'Zeta Name', 'Last Description')
('B02', 'Beta Name', 'First Description')
*/