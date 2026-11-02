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
-- Tests basic anti-join, ordering (where document_code order conflicts with document_name order), duplicate document_names (SELECT vs SELECT DISTINCT), multiple sections per document, and decoupling from other tables (Document_Functional_Areas, Document_Structures).
INSERT INTO Document_Structures (document_structure_code, parent_document_structure_code, document_structure_description) VALUES ('DS1', NULL, 'Struct 1');
INSERT INTO Functional_Areas (functional_area_code, parent_functional_area_code, functional_area_description) VALUES ('FA1', NULL, 'Area 1');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D1', 'DS1', 'T1', 10, 'Zebra Report');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D2', 'DS1', 'T1', 20, 'Alpha Report');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D3', 'DS1', 'T2', 5, 'Beta Report');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D4', NULL, 'T2', 0, 'Alpha Report');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D5', 'DS1', 'T1', 100, 'Gamma Report');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (1, 'D3', 1, 'S1', 'Intro');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (2, 'D3', 2, 'S2', 'Body');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (3, 'D5', 1, 'S1', 'Summary');
INSERT INTO Document_Functional_Areas (functional_area_code, document_code) VALUES ('FA1', 'D1');
INSERT INTO Document_Functional_Areas (functional_area_code, document_code) VALUES ('FA1', 'D3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_name FROM (SELECT * FROM documents AS LHS WHERE NOT EXISTS(SELECT 1 FROM document_sections AS RHS WHERE (LHS.document_code = RHS.document_code))) ORDER BY document_name;

/*
Gold Result:
('Alpha Report',)
('Alpha Report',)
('Zebra Report',)
*/

-- Prediction Query
SELECT document_name FROM documents WHERE NOT document_code IN (SELECT document_code FROM document_sections);

/*
Prediction Result:
('Zebra Report',)
('Alpha Report',)
('Alpha Report',)
*/