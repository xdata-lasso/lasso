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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1006, 'hospital');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1008, 'everyone');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('hear', 'Prove reduce raise author play.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('skin', 'Investment on gun young catch management sense technology.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('none', 'Carla Gray', 'Detail food shoulder argue start source husband.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('claim', 'Rebecca Henderson', 'His other life edge.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1007, 1006, 'none', '1972-03-03', 'Thomas Bradley', 'Defense material those poor central cause.', 'size');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1009, 1008, 'claim', '1973-04-04', 'Terri Frazier', 'Race Mr environment political.', 'brother');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1007, 'hear', 'option');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1009, 'skin', 'finally');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code FROM (SELECT LHS.budget_type_code AS budget_type_code, LHS.n AS n FROM (SELECT budget_type_code, COUNT(*) AS n FROM documents_with_expenses GROUP BY budget_type_code) AS LHS INNER JOIN (SELECT MAX(n) AS maxn FROM (SELECT budget_type_code, COUNT(*) AS n FROM documents_with_expenses GROUP BY budget_type_code)) AS RHS ON (LHS.n = RHS.maxn)) ORDER BY budget_type_code;

/*
Gold Result:
('hear',)
('skin',)
*/

-- Prediction Query
SELECT budget_type_code FROM Documents_with_expenses GROUP BY budget_type_code ORDER BY COUNT(*) DESC, budget_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('hear',)
*/