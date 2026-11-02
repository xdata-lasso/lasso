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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1036, 'box');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1037, 'serve');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('BK', 'Andrew Ruiz', 'Staff least figure somebody dinner.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1037, 1036, 'BK', '1987-07-18', 'Corey Murphy', 'Whom evidence political hundred.', 'threat');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1039, 1036, 'BK', '1988-08-19', 'Emily Obrien', 'Break tonight couple and job mind southern.', 'right');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1041, 1037, 'BK', '1989-09-20', 'Eric Ortiz', 'Recent never court professor here security.', 'contain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___", "project_id" FROM (SELECT "project_id", COUNT(*) AS "n" FROM (SELECT * FROM "documents" WHERE ("document_type_code" = 'BK')) GROUP BY project_id) ORDER BY count___, "project_id" NULLS LAST;

/*
Gold Result:
(1, 1037)
(2, 1036)
*/

-- Prediction Query
SELECT COUNT(*), project_id FROM Documents WHERE document_type_code = 'BK' GROUP BY project_id;

/*
Prediction Result:
(2, 1036)
(1, 1037)
*/