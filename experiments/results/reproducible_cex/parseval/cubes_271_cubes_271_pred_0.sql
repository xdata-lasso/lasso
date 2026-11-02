-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ref_template_types --
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('template_type_1', 'ref_91d919');

-- Inserting into table: templates --
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483648, 'template_type_1', -55602865, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'tem_5b67eb');

-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1, -2147483648, 'Customer reviews', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483647, -2147483648, 'Customer reviews', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (3, -2147483648, 'Customer reviews', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (2, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (4, -2147483648, NULL, 'doc_3a0a1c', 'doc_576bec');

-- Inserting into table: paragraphs --
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483648, 1, 't1__75d0dd', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (2, 1, 't1__75d0dd', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (3, 1, 't1__75d0dd', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483645, 2, 't1__75d0dd', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483644, 2, 't1__75d0dd', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483643, 2, 't1__75d0dd', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483642, 1, 't1__75d0dd', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483641, 1, NULL, 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (4, 4, 'par_442e65', 'par_b43722');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "paragraph_text" FROM (SELECT * FROM "paragraphs" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" <> 'Customer reviews')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY paragraph_text, "paragraph_text" NULLS LAST;

/*
Gold Result:
(None,)
('par_442e65',)
('t1__75d0dd',)
('t1__75d0dd',)
('t1__75d0dd',)
('t1__75d0dd',)
*/

-- Prediction Query
SELECT T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id WHERE T2.document_name = 'Customer reviews';

/*
Prediction Result:
('t1__75d0dd',)
('t1__75d0dd',)
(None,)
('t1__75d0dd',)
('t1__75d0dd',)
*/