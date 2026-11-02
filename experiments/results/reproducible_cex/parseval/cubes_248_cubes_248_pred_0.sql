-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ref_template_types --
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('t1__dd3339', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('G', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('A', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('O', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('E', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('!', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('I', 'ref_91d919');

-- Inserting into table: templates --
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1, 't1__dd3339', -55602865, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (2, 't1__dd3339', -664303813, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (3, 't1__dd3339', -1726781632, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483645, 'G', 247012447, '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483644, 'O', 1610062532, '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483643, 'E', 1871297066, '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483642, 'I', 89267185, '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (4, '!', -55602865, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (5, '!', -664303813, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'tem_5b67eb');

-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483648, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483647, 2, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483646, 2, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (2, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (3, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483643, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483642, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483641, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483640, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483639, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483638, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (5, 4, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (4, 2, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, LHS.n AS n, RHS.document_id AS document_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM (SELECT template_id, version_number, template_type_code, date_effective_from, date_effective_to, template_details, template_id AS n FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details FROM templates AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM templates) AS RHS ON (LHS.template_id = RHS.n))) AS LHS INNER JOIN documents AS RHS ON (LHS.template_id = RHS.template_id)) ORDER BY template_type_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id GROUP BY T1.template_type_code ORDER BY COUNT(*) DESC, T1.template_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__dd3339',)
*/