-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ref_template_types --
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('tem_344d03', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('t1__1e5262', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('tem_0c35e8', 'ref_91d919');

INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('t1__3d895f', 'ref_91d919');

-- Inserting into table: templates --
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1, 'tem_344d03', -55602865, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483647, 'tem_0c35e8', -664303813, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (2, 't1__1e5262', -1726781632, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (3, 't1__1e5262', 247012447, '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'tem_5b67eb');

INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (-2147483644, 't1__1e5262', 1610062532, '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00', 'tem_5b67eb');

-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483648, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483647, 2, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483646, 2, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483645, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483644, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483643, 2, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483642, 2, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483641, 2, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (2, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (3, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (-2147483638, 1, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM templates AS LHS WHERE NOT EXISTS(SELECT 1 FROM documents AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY date_effective_from DESC) LIMIT 1);

/*
Gold Result:
('t1__1e5262',)
*/

-- Prediction Query
SELECT template_type_code FROM Templates EXCEPT SELECT template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id;

/*
Prediction Result:
('tem_0c35e8',)
*/