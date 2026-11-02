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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1101, 'central');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1109, 'ask');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('important', 'Industry score choice increase between majority impact.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('long', 'Allow have kitchen wear talk.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('hospital', 'Wonder happen top population.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('religious', 'Huge couple business summer.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('measure', 'Make travel available ball.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('throw', 'Chance call person one Republican herself our far.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('interest', 'Painting between reduce table prepare shoulder result.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('last', 'Involve thousand including still human.');
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('however', NULL);
INSERT INTO "ref_budget_codes" ("budget_type_code", "budget_type_description") VALUES ('kind', NULL);
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('look', 'Daniel Fowler', 'Anything four writer.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('show', 'Jeffery Ortega', 'Well rather listen before be it.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1102, 1101, 'look', '1988-04-02', 'Phillip Clark', 'Sometimes body term capital group.', 'when');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1103, 1101, 'look', '1988-04-03', 'Sergio Murphy', 'Open administration enter camera inside.', 'trial');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1104, 1101, 'look', '1988-04-04', 'Steven Smith', 'Second live sing message.', 'reason');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1105, 1101, 'look', '1988-04-05', 'Brianna Anderson', 'Later develop past road.', 'near');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1110, 1109, 'show', '1992-08-06', 'Kristie Willis', 'Fine billion medical choice lot suggest glass news.', 'available');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1111, 1109, 'show', '1992-08-07', 'Erin Martinez', 'Several off southern suddenly.', 'change');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1112, 1109, 'show', '1992-08-08', 'Maurice Christensen', 'Party poor ago upon stop environment Congress reflect.', 'sit');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1113, 1109, 'show', '1992-08-09', 'Michelle Schmitt', 'Tv go consider century price.', 'property');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1102, 'however', 'fish');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1103, 'kind', 'low');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1104, 'kind', 'question');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1105, 'kind', 'allow');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1110, 'however', 'benefit');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1111, 'kind', 'skin');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1112, 'kind', 'nice');
INSERT INTO "documents_with_expenses" ("document_id", "budget_type_code", "document_details") VALUES (1113, 'kind', 'dinner');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT budget_type_code, document_id, COUNT(*) AS n FROM documents_with_expenses GROUP BY budget_type_code, document_id) ORDER BY budget_type_code) LIMIT 1);

/*
Gold Result:
('however',)
*/

-- Prediction Query
SELECT budget_type_code FROM Documents_with_expenses GROUP BY budget_type_code ORDER BY COUNT(*) DESC, budget_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('kind',)
*/