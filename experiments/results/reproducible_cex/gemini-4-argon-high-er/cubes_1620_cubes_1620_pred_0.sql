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
INSERT INTO Document_Structures (document_structure_code, parent_document_structure_code, document_structure_description) VALUES ('DS1', 'DS1', 'Desc');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D1', 'DS1', 'T1', 1, 'DocA');
INSERT INTO Documents (document_code, document_structure_code, document_type_code, access_count, document_name) VALUES ('D2', 'DS1', 'T1', 1, 'DocA');
INSERT INTO Images (image_id, image_alt_text, image_name, image_url) VALUES (1, 'alt', 'img1', 'http://example.com');
INSERT INTO Document_Sections (section_id, document_code, section_sequence, section_code, section_title) VALUES (1, 'D1', 1, 'S1', 'Sec1');
INSERT INTO Document_Sections_Images (section_id, image_id) VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_name FROM (SELECT * FROM documents AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT LHS.section_id AS section_id, LHS.image_id AS image_id, RHS.document_code AS document_code, RHS.section_sequence AS section_sequence, RHS.section_code AS section_code, RHS.section_title AS section_title FROM document_sections_images AS LHS INNER JOIN document_sections AS RHS ON (LHS.section_id = RHS.section_id)) AS RHS WHERE (LHS.document_code = RHS.document_code))) ORDER BY document_name;

/*
Gold Result:
('DocA',)
*/

-- Prediction Query
SELECT document_name FROM documents EXCEPT SELECT t1.document_name FROM documents AS t1 JOIN document_sections AS t2 ON t1.document_code = t2.document_code JOIN document_sections_images AS t3 ON t2.section_id = t3.section_id;

/*
Prediction Result:
*/