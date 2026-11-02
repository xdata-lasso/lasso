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
-- Core logic, sorting, duplicates, and mixed section-image states
INSERT INTO Document_Structures (document_structure_code, parent_document_structure_code, document_structure_description) VALUES ('DS1', NULL, 'Structure 1');
INSERT INTO Images (image_id, image_alt_text, image_name, image_url) VALUES (1, 'Alt 1', 'Img 1', 'http://img1');
INSERT INTO Images (image_id, image_alt_text, image_name, image_url) VALUES (2, 'Alt 2', 'Img 2', 'http://img2');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D1', 'DS1', 'DT1', 10, 'Zebra_NoSections');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D2', 'DS1', 'DT1', 20, 'Alpha_SectionsNoImages');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D3', 'DS1', 'DT1', 30, 'Beta_MixedSections');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D4', 'DS1', 'DT1', 40, 'Alpha_SectionsNoImages');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D5', 'DS1', 'DT1', 50, 'Gamma_SharedName');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D6', 'DS1', 'DT1', 60, 'Gamma_SharedName');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (101, 'D2', 1, 'S1', 'Sec 1');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (102, 'D2', 2, 'S2', 'Sec 2');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (103, 'D3', 1, 'S3', 'Sec 3 No Img');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (104, 'D3', 2, 'S4', 'Sec 4 Has Img');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (105, 'D5', 1, 'S5', 'Sec 5 Has Img');
INSERT INTO Document_Sections_Images (section_id, image_id) VALUES (104, 1);
INSERT INTO Document_Sections_Images (section_id, image_id) VALUES (104, 2);
INSERT INTO Document_Sections_Images (section_id, image_id) VALUES (105, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_name FROM (SELECT * FROM documents AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT LHS.section_id AS section_id, LHS.image_id AS image_id, RHS.document_code AS document_code, RHS.section_sequence AS section_sequence, RHS.section_code AS section_code, RHS.section_title AS section_title FROM document_sections_images AS LHS INNER JOIN document_sections AS RHS ON (LHS.section_id = RHS.section_id)) AS RHS WHERE (LHS.document_code = RHS.document_code))) ORDER BY document_name;

/*
Gold Result:
('Alpha_SectionsNoImages',)
('Alpha_SectionsNoImages',)
('Gamma_SharedName',)
('Zebra_NoSections',)
*/

-- Prediction Query
SELECT document_name FROM documents EXCEPT SELECT t1.document_name FROM documents AS t1 JOIN document_sections AS t2 ON t1.document_code = t2.document_code JOIN document_sections_images AS t3 ON t2.section_id = t3.section_id;

/*
Prediction Result:
('Alpha_SectionsNoImages',)
('Zebra_NoSections',)
*/