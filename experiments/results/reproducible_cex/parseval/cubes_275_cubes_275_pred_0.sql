-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ref_template_types --
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('lhs_75f3c8', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('lhs_a6c374', 'ref_91d919');

-- Inserting into table: templates --
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1, 'lhs_75f3c8', 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_de8de3');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483648, 'lhs_a6c374', 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_d323c7');

-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1, 1, 'Data base', 'doc_51c73c', 'doc_00d586');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483648, 1, 'Data base', 'doc_759dcd', 'doc_9db3a2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "template_type_code" FROM (SELECT * FROM "templates" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" = 'Data base')) AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY template_type_code, "template_type_code" NULLS LAST;

/*
Gold Result:
('lhs_75f3c8',)
*/

-- Prediction Query
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id WHERE T2.document_name = 'Data base';

/*
Prediction Result:
('lhs_75f3c8',)
('lhs_75f3c8',)
*/