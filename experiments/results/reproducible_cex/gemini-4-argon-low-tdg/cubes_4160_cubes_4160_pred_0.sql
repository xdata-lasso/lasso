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
-- Tests multiple documents tied for the maximum access_count, with different document_names (tests ORDER BY, GROUP BY, LIMIT 1 mutants), and duplicates of the same document_name (tests DISTINCT).
INSERT INTO "Document_Structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('DS1', NULL, 'Structure 1');
INSERT INTO "Document_Structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('DS2', 'DS1', 'Structure 2');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D1', 'DS1', 'T1', 10, 'Alpha');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D2', 'DS1', 'T2', 50, 'Gamma');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D3', 'DS2', 'T1', 50, 'Beta');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D4', 'DS2', 'T2', 50, 'Beta');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D5', 'DS1', 'T1', 30, 'Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT document_name_other AS document_name, maxaccess_count AS access_count FROM (SELECT LHS.document_code AS document_code, LHS.document_structure_code AS document_structure_code, LHS.document_type_code AS document_type_code, LHS.access_count AS access_count, LHS.document_name AS document_name, LHS.maxaccess_count AS maxaccess_count, RHS.document_code AS document_code_other, RHS.document_structure_code AS document_structure_code_other, RHS.document_type_code AS document_type_code_other, RHS.access_count AS access_count_other, RHS.document_name AS document_name_other, RHS.maxaccess_count AS maxaccess_count_other FROM (SELECT document_code, document_structure_code, document_type_code, access_count, document_name, MAX(access_count) OVER () AS maxaccess_count FROM documents) AS LHS CROSS JOIN (SELECT document_code, document_structure_code, document_type_code, access_count, document_name, MAX(access_count) OVER () AS maxaccess_count FROM documents) AS RHS) WHERE (maxaccess_count = access_count_other AND access_count_other <= maxaccess_count_other) ORDER BY document_name, access_count NULLS LAST;

/*
Gold Result:
('Beta', 50)
('Gamma', 50)
*/

-- Prediction Query
SELECT document_name, access_count FROM documents ORDER BY access_count DESC, documents.document_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Gamma', 50)
*/