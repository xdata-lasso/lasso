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
INSERT INTO Roles (role_code, role_description) VALUES ('R_A', 'Standard Role');
INSERT INTO Roles (role_code, role_description) VALUES ('R_B', 'Standard Role');
INSERT INTO Roles (role_code, role_description) VALUES ('R_C', 'Admin Role');
INSERT INTO Roles (role_code, role_description) VALUES ('R_D', 'Manager Role');
INSERT INTO Roles (role_code, role_description) VALUES ('R_UNUSED', 'Unused Role');
INSERT INTO Users (user_id, role_code, user_name, user_login, password) VALUES (1, 'R_D', 'Dave', 'dave1', 'pass1');
INSERT INTO Users (user_id, role_code, user_name, user_login, password) VALUES (2, 'R_D', 'Dan', 'dan2', 'pass2');
INSERT INTO Users (user_id, role_code, user_name, user_login, password) VALUES (3, 'R_C', 'Carol', 'carol1', 'pass3');
INSERT INTO Users (user_id, role_code, user_name, user_login, password) VALUES (4, 'R_A', 'Alice', 'alice1', 'pass4');
INSERT INTO Users (user_id, role_code, user_name, user_login, password) VALUES (5, 'R_A', 'Alice', 'alice1', 'pass4');
INSERT INTO Users (user_id, role_code, user_name, user_login, password) VALUES (6, 'R_B', 'Bob', 'bob1', 'pass5');
INSERT INTO Users (user_id, role_code, user_name, user_login, password) VALUES (7, 'R_B', NULL, NULL, NULL);
INSERT INTO Users (user_id, role_code, user_name, user_login, password) VALUES (8, 'R_B', 'Charlie', 'charlie1', 'pass6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, role_code FROM (SELECT role_code, COUNT(*) AS n FROM users GROUP BY role_code) ORDER BY count___, role_code NULLS LAST;

/*
Gold Result:
(1, 'R_C')
(2, 'R_A')
(2, 'R_D')
(3, 'R_B')
*/

-- Prediction Query
SELECT COUNT(*), role_code FROM users GROUP BY role_code;

/*
Prediction Result:
(2, 'R_A')
(3, 'R_B')
(1, 'R_C')
(2, 'R_D')
*/