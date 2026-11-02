-- Schema DDL
CREATE TABLE "Roles" ("role_code" TEXT(15) PRIMARY KEY, "role_description" TEXT(80));

CREATE TABLE "Users" ("user_id" INTEGER PRIMARY KEY, "role_code" TEXT(15), "user_name" TEXT(40), "user_login" TEXT(40), "password" TEXT(40), FOREIGN KEY ("role_code") REFERENCES "Roles" ("role_code"));

CREATE TABLE "Document_Structures" ("document_structure_code" TEXT(15) PRIMARY KEY, "parent_document_structure_code" TEXT(15), "document_structure_description" TEXT(80));

CREATE TABLE "Functional_Areas" ("functional_area_code" TEXT(15) PRIMARY KEY, "parent_functional_area_code" TEXT(15), "functional_area_description" TEXT(80));

CREATE TABLE "Images" ("image_id" INTEGER PRIMARY KEY, "image_alt_text" TEXT(80), "image_name" TEXT(40), "image_url" TEXT(255));

CREATE TABLE "Documents" ("document_code" TEXT(15) PRIMARY KEY, "document_structure_code" TEXT(15), "document_type_code" TEXT(15), "access_count" INTEGER, "document_name" TEXT(80), FOREIGN KEY ("document_structure_code") REFERENCES "Document_Structures" ("document_structure_code"));

CREATE TABLE "Document_Functional_Areas" ("functional_area_code" TEXT(15), "document_code" TEXT(15), FOREIGN KEY ("functional_area_code") REFERENCES "Functional_Areas" ("functional_area_code"), FOREIGN KEY ("document_code") REFERENCES "Documents" ("document_code"));

CREATE TABLE "Document_Sections" ("section_id" INTEGER PRIMARY KEY, "document_code" TEXT(15), "section_sequence" INTEGER, "section_code" TEXT(20), "section_title" TEXT(80), FOREIGN KEY ("document_code") REFERENCES "Documents" ("document_code"));

CREATE TABLE "Document_Sections_Images" ("section_id" INTEGER, "image_id" INTEGER, PRIMARY KEY ("section_id", "image_id"), FOREIGN KEY ("image_id") REFERENCES "Images" ("image_id"), FOREIGN KEY ("section_id") REFERENCES "Document_Sections" ("section_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Document_Structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('DS1', NULL, 'Standard');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('DOC1', 'DS1', 'CV', 10, 'David CV');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('DOC2', 'DS1', 'CV', 5, 'Alice CV');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (1, 'DOC1', 1, 'S1', 'Zeta');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (2, 'DOC1', 2, 'S2', 'Alpha');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (3, 'DOC1', 3, 'S3', 'Alpha');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (4, 'DOC2', 1, 'S4', 'Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "section_title" FROM (SELECT * FROM "document_sections" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" = 'David CV')) AS RHS WHERE (LHS.document_code = RHS.document_code))) ORDER BY section_title, "section_title" NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT t2.section_title FROM documents AS t1 JOIN document_sections AS t2 ON t1.document_code = t2.document_code WHERE t1.document_name = 'David CV';

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Alpha',)
*/