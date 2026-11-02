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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1013, 'collection');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1017, 'authority');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1015, NULL);
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('structure', 'Linda Cruz', 'You more wife team activity result race Mr.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('soon', 'Beth Keller', 'Close month parent who up sense ready.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1014, 1013, 'structure', '1975-06-06', 'Martin Rodriguez', 'Citizen about reveal rest will seven.', 'movement');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1016, 1015, 'structure', '1976-07-07', 'Jack Galloway', 'Dream drive note bad rule.', 'team');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1018, 1017, 'soon', '1977-08-08', 'Jennifer Powers', 'Just military building different full open.', 'drug');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_name, document_type_description, document_date FROM (SELECT LHS.document_type_code AS document_type_code, LHS.document_type_name AS document_type_name, LHS.document_type_description AS document_type_description, RHS.document_id AS document_id, RHS.project_id AS project_id, RHS.document_date AS document_date, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM ref_document_types AS LHS INNER JOIN documents AS RHS ON (LHS.document_type_code = RHS.document_type_code)) ORDER BY document_type_name, document_type_description NULLS LAST, document_date NULLS LAST;

/*
Gold Result:
('Beth Keller', 'Close month parent who up sense ready.', '1977-08-08')
('Linda Cruz', 'You more wife team activity result race Mr.', '1975-06-06')
('Linda Cruz', 'You more wife team activity result race Mr.', '1976-07-07')
*/

-- Prediction Query
SELECT T1.document_type_name, T1.document_type_description, T2.Document_date FROM Ref_document_types AS T1 JOIN Documents AS T2 ON T1.document_type_code = T2.document_type_code;

/*
Prediction Result:
('Linda Cruz', 'You more wife team activity result race Mr.', '1975-06-06')
('Linda Cruz', 'You more wife team activity result race Mr.', '1976-07-07')
('Beth Keller', 'Close month parent who up sense ready.', '1977-08-08')
*/