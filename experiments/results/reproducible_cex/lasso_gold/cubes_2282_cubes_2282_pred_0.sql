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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1013, 'end');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1017, 'medical');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('down', 'Full open discover detail.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('different', 'Total clearly able hospital unit size.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('avoid', 'Amy Jones', 'Teacher audience draw.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('feeling', 'Tyler Cowan', 'Product main couple design around save article.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1014, 1013, 'avoid', '1976-07-07', 'Cindy Anderson', 'Office drug list imagine behind probably great.', 'item');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1018, 1017, 'feeling', '1978-09-09', 'Anthony Woods', 'Church whether bag control organization push dog.', 'call');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1016, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1014, 'down', 'manage');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1016, 'down', 'mention');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1018, 'different', 'year');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code, budget_type_description, document_id FROM (SELECT LHS.budget_type_code AS budget_type_code, LHS.budget_type_description AS budget_type_description, RHS.document_id AS document_id, RHS.document_details AS document_details FROM ref_budget_codes AS LHS INNER JOIN documents_with_expenses AS RHS ON (LHS.budget_type_code = RHS.budget_type_code)) ORDER BY budget_type_code, budget_type_description NULLS LAST, document_id NULLS LAST;

/*
Gold Result:
('different', 'Total clearly able hospital unit size.', 1018)
('down', 'Full open discover detail.', 1014)
('down', 'Full open discover detail.', 1016)
*/

-- Prediction Query
SELECT T2.budget_type_code, T2.budget_type_description, T1.document_id FROM Documents_with_expenses AS T1 JOIN Ref_budget_codes AS T2 ON T1.budget_type_code = T2.budget_type_code;

/*
Prediction Result:
('down', 'Full open discover detail.', 1014)
('down', 'Full open discover detail.', 1016)
('different', 'Total clearly able hospital unit size.', 1018)
*/