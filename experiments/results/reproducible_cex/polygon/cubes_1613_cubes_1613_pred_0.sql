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
INSERT INTO "Roles" ("role_code", "role_description") VALUES ('15', '32');
INSERT INTO "Roles" ("role_code", "role_description") VALUES ('14', '32');
INSERT INTO "Users" ("user_id", "role_code", "user_name", "user_login", "password") VALUES (17, '15', '32', '32', '32');
INSERT INTO "Users" ("user_id", "role_code", "user_name", "user_login", "password") VALUES (16, '15', '32', '32', '32');
INSERT INTO "Document_Structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('24', '32', '32');
INSERT INTO "Document_Structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('18', '32', '32');
INSERT INTO "Functional_Areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('20', '32', '32');
INSERT INTO "Functional_Areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('19', '32', '32');
INSERT INTO "Images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (21, '32', '32', '32');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('23', '24', '32', 10001, '29');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('22', NULL, '28', 10001, '32');
INSERT INTO "Document_Functional_Areas" ("functional_area_code", "document_code") VALUES ('19', '22');
INSERT INTO "Document_Functional_Areas" ("functional_area_code", "document_code") VALUES ('19', '22');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (26, '22', 32, '32', '32');
INSERT INTO "Document_Sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (25, '22', 32, '32', '32');
INSERT INTO "Document_Sections_Images" ("section_id", "image_id") VALUES (25, 21);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT document_type_code FROM (SELECT document_code, document_structure_code, document_type_code, access_count, document_name, SUM(access_count) OVER () AS sumaccess_count FROM documents) WHERE (access_count <> 10000 OR sumaccess_count < access_count) ORDER BY document_type_code;

/*
Gold Result:
('28',)
('32',)
*/

-- Prediction Query
SELECT document_type_code FROM documents GROUP BY document_type_code HAVING SUM(access_count) > 10000;

/*
Prediction Result:
('28',)
('32',)
*/