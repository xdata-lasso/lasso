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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1022, 'Graph Database project');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1026, 'Graph Database project');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('family', 'Shannon Jones', 'Better present music address behavior send door.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('year', 'Danielle Wheeler', 'Bank price north first end prove fire enter.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('look', NULL, NULL);
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1023, 1022, 'family', '1979-10-10', 'John Hancock', 'Clearly able hospital unit.', 'still');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1025, 1022, 'look', '1980-11-11', 'Anthony Woods', 'Church whether bag control organization push dog.', 'call');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1027, 1026, 'year', '1981-01-12', 'Matthew Bryant', 'Act perform none beyond.', 'note');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_name", "document_date" FROM (SELECT "LHS"."project_id" AS "project_id", "LHS"."project_details" AS "project_details", "RHS"."document_id" AS "document_id", "RHS"."document_type_code" AS "document_type_code", "RHS"."document_date" AS "document_date", "RHS"."document_name" AS "document_name", "RHS"."document_description" AS "document_description", "RHS"."other_details" AS "other_details" FROM "projects" AS "LHS" INNER JOIN "documents" AS "RHS" ON ("LHS"."project_id" = "RHS"."project_id")) WHERE ("project_details" = 'Graph Database project') ORDER BY document_name, "document_name" NULLS LAST, "document_date" NULLS LAST;

/*
Gold Result:
('Anthony Woods', '1980-11-11')
('John Hancock', '1979-10-10')
('Matthew Bryant', '1981-01-12')
*/

-- Prediction Query
SELECT document_name, document_date FROM Documents AS T1 JOIN projects AS T2 ON T1.project_id = T2.project_id WHERE T2.project_details = 'Graph Database project';

/*
Prediction Result:
('John Hancock', '1979-10-10')
('Anthony Woods', '1980-11-11')
('Matthew Bryant', '1981-01-12')
*/