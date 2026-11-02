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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1052, 'they');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1054, 'serious');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('beat', 'Paul Williams', 'Difference attention whatever American all easy.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('building', 'Carla Collins', 'Agent find quality when however resource away real.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1053, 1052, 'beat', '1994-03-02', 'Madison Poole', 'Prove nor design record short cold parent.', 'actually');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1055, 1054, 'building', '1995-04-03', 'Lisa Allen', 'South someone not American mouth product attention positive.', 'small');
INSERT INTO "statements" ("statement_id", "statement_details") VALUES (1053, 'Private Project');
INSERT INTO "statements" ("statement_id", "statement_details") VALUES (1055, 'Private Project');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "statement_details", "document_name" FROM (SELECT "document_id", "document_type_code", "project_id", "document_date", "document_name", "document_description", "other_details", "statement_details", "document_id" AS "statement_id" FROM (SELECT "LHS"."document_id" AS "document_id", "LHS"."document_type_code" AS "document_type_code", "LHS"."project_id" AS "project_id", "LHS"."document_date" AS "document_date", "LHS"."document_name" AS "document_name", "LHS"."document_description" AS "document_description", "LHS"."other_details" AS "other_details", "RHS"."statement_details" AS "statement_details" FROM "documents" AS "LHS" INNER JOIN "statements" AS "RHS" ON ("LHS"."document_id" = "RHS"."statement_id"))) WHERE ("statement_details" = 'Private Project') ORDER BY statement_details, "statement_details" NULLS LAST, "document_name" NULLS LAST;

/*
Gold Result:
('Private Project', 'Lisa Allen')
('Private Project', 'Madison Poole')
*/

-- Prediction Query
SELECT T1.statement_details, T2.document_name FROM Statements AS T1 JOIN Documents AS T2 ON T1.statement_id = T2.document_id WHERE T1.statement_details = 'Private Project';

/*
Prediction Result:
('Private Project', 'Madison Poole')
('Private Project', 'Lisa Allen')
*/