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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1027, 'land');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1031, 'really');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('same', 'Whitney Peters', 'Choice father why often my security arm.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('past', 'Emily Green', 'Draw how public feel first sell.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1028, 1027, 'same', '1983-03-14', 'Noel CV', 'Me system church whether bag control organization.', 'beat');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1029, 1027, 'same', '1983-03-15', 'King Book', 'Identify walk now often always.', 'kind');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1032, 1031, 'past', '1985-05-16', 'Noel CV', 'Leader your you.', 'authority');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1033, 1031, 'past', '1985-05-17', 'King Book', 'Mrs media car give.', 'until');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_type_code", "document_name", "document_description" FROM "documents" WHERE ("document_name" = 'Noel CV' OR "document_name" = 'King Book') ORDER BY document_type_code, documents.document_id NULLS LAST;

/*
Gold Result:
('past', 'Noel CV', 'Leader your you.')
('past', 'King Book', 'Mrs media car give.')
('same', 'Noel CV', 'Me system church whether bag control organization.')
('same', 'King Book', 'Identify walk now often always.')
*/

-- Prediction Query
SELECT document_type_code, document_name, document_description FROM Documents WHERE document_name = 'Noel CV' OR document_name = 'King Book';

/*
Prediction Result:
('same', 'Noel CV', 'Me system church whether bag control organization.')
('same', 'King Book', 'Identify walk now often always.')
('past', 'Noel CV', 'Leader your you.')
('past', 'King Book', 'Mrs media car give.')
*/