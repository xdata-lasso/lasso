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
INSERT INTO Document_Structures (document_structure_code, parent_document_structure_code, document_structure_description) VALUES ('DS1', NULL, 'Root Structure');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('DOC_A', 'DS1', 'TYPE1', 10, 'Zebra Manual');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('DOC_B', 'DS1', 'TYPE1', 20, 'Alpha Guide');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('DOC_C', 'DS1', 'TYPE2', 5, 'Mango Handbook');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('DOC_D', 'DS1', 'TYPE2', 15, 'Beta Reference');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('DOC_E', 'DS1', 'TYPE1', 30, 'Gamma Spec');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (1, 'DOC_D', 1, 'SEC1', 'Single Section');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (2, 'DOC_E', 1, 'SEC2', 'First Section');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (3, 'DOC_E', 2, 'SEC3', 'Second Section');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_name FROM (SELECT * FROM documents AS LHS WHERE NOT EXISTS(SELECT 1 FROM document_sections AS RHS WHERE (LHS.document_code = RHS.document_code))) ORDER BY document_name;

/*
Gold Result:
('Alpha Guide',)
('Mango Handbook',)
('Zebra Manual',)
*/

-- Prediction Query
SELECT document_name FROM documents WHERE NOT document_code IN (SELECT document_code FROM document_sections);

/*
Prediction Result:
('Zebra Manual',)
('Alpha Guide',)
('Mango Handbook',)
*/