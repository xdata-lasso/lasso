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
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT3', 'Film', 'Cinema reel');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT1', 'Film', 'Video archive');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT2', 'Film', 'Cinema reel');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT4', 'Book', 'Printed media');
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Archive Project');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (101, 1, 'DT1', '2023-01-10 10:00:00', 'Doc A', 'First doc', 'None');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (102, 1, 'DT1', '2023-01-11 11:00:00', 'Doc B', 'Second doc', 'None');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (103, 1, 'DT4', '2023-01-12 12:00:00', 'Film', 'Film', 'Film');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_type_description" FROM "ref_document_types" WHERE ("document_type_name" = 'Film') ORDER BY document_type_description, ref_document_types.document_type_code NULLS LAST;

/*
Gold Result:
('Cinema reel',)
('Cinema reel',)
('Video archive',)
*/

-- Prediction Query
SELECT document_type_description FROM Ref_document_types WHERE document_type_name = 'Film';

/*
Prediction Result:
('Cinema reel',)
('Video archive',)
('Cinema reel',)
*/