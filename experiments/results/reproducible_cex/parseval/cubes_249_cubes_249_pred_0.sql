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
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (2, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (3, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

-- Inserting into table: paragraphs --
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483648, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483647, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483646, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (2, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (3, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483645, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483642, 2, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483641, 2, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483640, 3, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483639, 2, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483638, 2, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483637, 3, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483636, 2, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483635, 2, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483634, 3, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483633, 2, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483632, 2, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483631, 3, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483630, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483629, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483628, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483627, 2, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483626, 1, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483625, 1, 'par_442e65', 'par_b43722');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id FROM (SELECT * FROM (SELECT * FROM (SELECT paragraph_id, document_id, paragraph_text, other_details, COUNT(*) OVER () AS n FROM paragraphs) ORDER BY document_id) LIMIT 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT document_id FROM Paragraphs GROUP BY document_id ORDER BY COUNT(*) ASC, document_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(3,)
*/