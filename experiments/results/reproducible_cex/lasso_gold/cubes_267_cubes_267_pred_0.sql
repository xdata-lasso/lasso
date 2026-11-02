-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('purpose', 'Participant check several much single morning a.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('down', 'Full open discover detail.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1023, 'purpose', 1024, '1984-04-15', '1985-05-16', 'game');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1029, 'down', 1030, '1988-08-19', '1989-09-20', 'avoid');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1025, 1023, 'Brian Cox DVM', 'Dream drive note bad rule.', 'team');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1028, 1023, 'Nicole Vaughn', 'Human public health tonight later.', 'end');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1031, 1029, 'Amy Jones', 'Teacher audience draw.', 'relationship');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_description FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, LHS.document_id AS document_id, LHS.document_name AS document_name, LHS.document_description AS document_description, LHS.other_details AS other_details, RHS.template_type_description AS template_type_description FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, RHS.document_id AS document_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM templates AS LHS INNER JOIN documents AS RHS ON (LHS.template_id = RHS.template_id)) AS LHS INNER JOIN ref_template_types AS RHS ON (LHS.template_type_code = RHS.template_type_code)) ORDER BY template_type_description;

/*
Gold Result:
('Full open discover detail.',)
('Participant check several much single morning a.',)
*/

-- Prediction Query
SELECT DISTINCT T1.template_type_description FROM Ref_template_types AS T1 JOIN Templates AS T2 ON T1.template_type_code = T2.template_type_code JOIN Documents AS T3 ON T2.Template_ID = T3.template_ID;

/*
Prediction Result:
('Participant check several much single morning a.',)
('Full open discover detail.',)
*/