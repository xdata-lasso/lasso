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
-- Inserting into table: documents --
INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_1', 'document_stru_1', 'doc_f73fb0', -55602865, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_2', 'document_stru_1', 'doc_f73fb0', -921145356, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_3', 'document_stru_1', 'doc_f73fb0', -1022641847, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('A', 'document_stru_1', 'doc_f73fb0', -890215420, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('C', 'document_stru_1', 'doc_f73fb0', -1980249628, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_4', 'document_stru_1', 'doc_f73fb0', 1871297066, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_7', 'document_stru_1', 'doc_f73fb0', 89267185, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_8', 'document_stru_1', 'doc_f73fb0', 1744686505, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_9', 'document_stru_1', 'doc_f73fb0', 1160656988, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_10', 'document_stru_1', NULL, -252690330, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_11', 'document_stru_1', NULL, -1670923962, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_12', 'document_stru_1', NULL, 906324270, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_13', 'document_stru_1', 'doc_f73fb0', 2122220075, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_14', 'document_stru_1', 'doc_f73fb0', 13244799, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_15', 'document_stru_1', 'doc_f73fb0', 1019800248, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('@', 'document_stru_1', 'doc_07a9e7', 1526238907, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('E', 'document_stru_1', 'doc_07a9e7', -845863578, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('B', 'document_stru_1', 'doc_cb6a2c', -1437333179, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_19', 'document_stru_1', 'doc_95ef6e', -664303813, 'doc_a778b3');

-- Inserting into table: document_structures --
INSERT INTO "document_structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('document_stru_1', 'doc_5c8212', 'doc_cd87d2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT document_type_code FROM (SELECT document_code, document_structure_code, document_type_code, access_count, document_name, COUNT(*) OVER () AS n FROM documents) WHERE (n > 2) ORDER BY document_type_code;

/*
Gold Result:
(None,)
('doc_07a9e7',)
('doc_95ef6e',)
('doc_cb6a2c',)
('doc_f73fb0',)
*/

-- Prediction Query
SELECT document_type_code FROM documents GROUP BY document_type_code HAVING COUNT(*) > 2;

/*
Prediction Result:
(None,)
('doc_f73fb0',)
*/