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
-- Comprehensive test:
-- 1. Doc with 0 sections (Z_Doc_No_Sections) -> Included
-- 2. Doc with 2 sections, 0 images (A_Doc_Two_Sec_No_Img) -> Included (tests duplicate document_name if INNER JOIN is used instead of NOT EXISTS)
-- 3. Doc with 1 section, 1 image (M_Doc_One_Sec_One_Img) -> Excluded
-- 4. Doc with 2 sections: 1 has image, 1 has no image (B_Doc_Mixed_Sec) -> Excluded (tests LEFT JOIN ... IS NULL on sections trap)
-- 5. Duplicate document_name on two valid documents (C_Duplicate_Name) -> Included twice (tests DISTINCT vs ALL)
-- 6. Orphaned section with image (document_code IS NULL) -> Tests NOT IN vs NOT EXISTS null-handling trap
INSERT INTO "Document_Structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('DS1', NULL, 'Main Structure');
INSERT INTO "Images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (1, 'Alt 1', 'Img1', 'http://img1.com');
INSERT INTO "Images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (2, 'Alt 2', 'Img2', 'http://img2.com');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D1', 'DS1', 'T1', 10, 'Z_Doc_No_Sections');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D2', 'DS1', 'T1', 20, 'A_Doc_Two_Sec_No_Img');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D3', 'DS1', 'T1', 30, 'M_Doc_One_Sec_One_Img');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D4', 'DS1', 'T1', 40, 'B_Doc_Mixed_Sec');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D5', 'DS1', 'T1', 50, 'C_Duplicate_Name');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D6', 'DS1', 'T1', 60, 'C_Duplicate_Name');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (101, 'D2', 1, 'S1', 'D2 Sec 1');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (102, 'D2', 2, 'S2', 'D2 Sec 2');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (103, 'D3', 1, 'S3', 'D3 Sec 1');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (104, 'D4', 1, 'S4', 'D4 Sec 1 With Img');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (105, 'D4', 2, 'S5', 'D4 Sec 2 No Img');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (106, NULL, 1, 'S6', 'Orphan Sec With Img');
INSERT INTO "Document_Sections_Images" ("section_id", "image_id") VALUES (103, 1);
INSERT INTO "Document_Sections_Images" ("section_id", "image_id") VALUES (104, 1);
INSERT INTO "Document_Sections_Images" ("section_id", "image_id") VALUES (106, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_name FROM (SELECT * FROM documents AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT LHS.section_id AS section_id, LHS.image_id AS image_id, RHS.document_code AS document_code, RHS.section_sequence AS section_sequence, RHS.section_code AS section_code, RHS.section_title AS section_title FROM document_sections_images AS LHS INNER JOIN document_sections AS RHS ON (LHS.section_id = RHS.section_id)) AS RHS WHERE (LHS.document_code = RHS.document_code))) ORDER BY document_name;

/*
Gold Result:
('A_Doc_Two_Sec_No_Img',)
('C_Duplicate_Name',)
('C_Duplicate_Name',)
('Z_Doc_No_Sections',)
*/

-- Prediction Query
SELECT document_name FROM documents EXCEPT SELECT t1.document_name FROM documents AS t1 JOIN document_sections AS t2 ON t1.document_code = t2.document_code JOIN document_sections_images AS t3 ON t2.section_id = t3.section_id;

/*
Prediction Result:
('A_Doc_Two_Sec_No_Img',)
('C_Duplicate_Name',)
('Z_Doc_No_Sections',)
*/