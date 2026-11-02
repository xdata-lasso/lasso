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
INSERT INTO "roles" ("role_code", "role_description") VALUES ('Brewing technologist', 'Health physicist');
INSERT INTO "roles" ("role_code", "role_description") VALUES ('Museum/gallery conservator', 'English as a foreign language teacher');
INSERT INTO "users" ("user_id", "role_code", "user_name", "user_login", "password") VALUES (1008, 'Brewing technologist', 'Roy Martin', 'Michael Miles', 'result');
INSERT INTO "users" ("user_id", "role_code", "user_name", "user_login", "password") VALUES (1009, 'Brewing technologist', 'Kimberly Sanchez', 'Devin Schaefer', 'rise');
INSERT INTO "users" ("user_id", "role_code", "user_name", "user_login", "password") VALUES (1010, 'Museum/gallery conservator', 'Sarah Parsons', 'Andrew Stewart', 'executive');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, role_code FROM (SELECT role_code, COUNT(*) AS n FROM users GROUP BY role_code) ORDER BY count___, role_code NULLS LAST;

/*
Gold Result:
(1, 'Museum/gallery conservator')
(2, 'Brewing technologist')
*/

-- Prediction Query
SELECT COUNT(*), role_code FROM users GROUP BY role_code;

/*
Prediction Result:
(2, 'Brewing technologist')
(1, 'Museum/gallery conservator')
*/