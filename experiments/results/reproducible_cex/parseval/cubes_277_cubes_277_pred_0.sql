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
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483648, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483647, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483646, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483645, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483644, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483643, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483642, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483641, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483640, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483639, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', NULL);

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483638, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', NULL);

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483637, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', NULL);

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483636, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', NULL);

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483635, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', NULL);

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483634, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483633, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483632, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483631, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483630, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483629, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_292f18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_template_id_ FROM (SELECT other_details, COUNT(DISTINCT template_id) AS n_distinct FROM documents GROUP BY other_details) ORDER BY count_distinct_template_id_;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT template_id) FROM Documents;

/*
Prediction Result:
(1,)
*/