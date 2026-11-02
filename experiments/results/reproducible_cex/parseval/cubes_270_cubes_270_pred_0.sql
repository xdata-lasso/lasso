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
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1, -2147483648, 'Welcome to NY', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (2, -2147483648, 'Welcome to NY', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (3, -2147483648, 'doc_a80aa9', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (4, -2147483648, 't2__944962', 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (5, -2147483648, NULL, 'doc_3a0a1c', 'doc_576bec');

INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (6, -2147483648, 'Welcome to NY', 'doc_3a0a1c', 'doc_576bec');

-- Inserting into table: paragraphs --
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1, 1, 't1__969be0', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483647, 1, 't1__1aa877', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483646, 1, 't1__1aa877', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (-2147483645, 1, 't1__1aa877', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (2, 4, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (3, 5, 'par_442e65', 'par_b43722');

INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (4, 6, NULL, 'par_b43722');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "paragraph_id", "paragraph_text" FROM (SELECT * FROM "paragraphs" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" <> 'Welcome to NY')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY paragraph_id, "paragraph_id" NULLS LAST, "paragraph_text" NULLS LAST;

/*
Gold Result:
(-2147483647, 't1__1aa877')
(-2147483646, 't1__1aa877')
(-2147483645, 't1__1aa877')
(1, 't1__969be0')
(3, 'par_442e65')
(4, None)
*/

-- Prediction Query
SELECT T1.paragraph_id, T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id WHERE T2.Document_Name = 'Welcome to NY';

/*
Prediction Result:
(-2147483647, 't1__1aa877')
(-2147483646, 't1__1aa877')
(-2147483645, 't1__1aa877')
(1, 't1__969be0')
(4, None)
*/