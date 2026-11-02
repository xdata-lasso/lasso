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
INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('rhs_5aa672', 'rhs_7d1caf', 'rhs_9fd3d7', 1, 'rhs_891547');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('rhs_6a508d', 'rhs_2e1877', 'rhs_802555', 1, 'rhs_e0f004');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('A', 'rhs_7d1caf', 'doc_cb6a2c', -59984348, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('G', 'rhs_2e1877', 'doc_cb6a2c', -1022641847, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('Q', 'rhs_2e1877', 'doc_cb6a2c', 247012447, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('P', 'rhs_7d1caf', 'doc_cb6a2c', -106629402, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('@', 'rhs_2e1877', 'doc_cb6a2c', 89267185, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('B', 'rhs_7d1caf', 'doc_cb6a2c', -1633151678, 'doc_a778b3');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('C', 'rhs_7d1caf', 'doc_cb6a2c', 1268590800, 'doc_a778b3');

-- Inserting into table: document_structures --
INSERT INTO "document_structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('rhs_7d1caf', 'doc_5c8212', 'doc_cd87d2');

INSERT INTO "document_structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('rhs_2e1877', 'doc_5c8212', 'doc_cd87d2');

-- Inserting into table: functional_areas --
INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('lhs_15f457', 'lhs_24b439', 'lhs_e5a9f7');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('lhs_26cebd', 'lhs_b42d53', 'lhs_b26090');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('functional_ar_3', 'fun_b553ca', 'Acknowledgement');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('A', 'fun_b553ca', 'fun_7c1b5d');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('functional_ar_5', 'fun_b553ca', 'Acknowledgement');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('@', 'fun_b553ca', 'fun_7c1b5d');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('functional_ar_7', 'fun_b553ca', 'Acknowledgement');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('`', 'fun_b553ca', 'fun_7c1b5d');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('functional_ar_9', 'fun_b553ca', 'Acknowledgement');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('a', 'fun_b553ca', 'fun_7c1b5d');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('functional_a_11', 'fun_b553ca', 'Acknowledgement');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('Q', 'fun_b553ca', 'fun_7c1b5d');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('functional_a_13', 'fun_b553ca', 'Acknowledgement');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('E', 'fun_b553ca', 'fun_7c1b5d');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('functional_a_15', 'fun_b553ca', 'Acknowledgement');

INSERT INTO "functional_areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('e', 'fun_b553ca', 'fun_7c1b5d');

-- Inserting into table: document_functional_areas --
INSERT INTO "document_functional_areas" ("functional_area_code", "document_code") VALUES ('A', 'rhs_6a508d');

INSERT INTO "document_functional_areas" ("functional_area_code", "document_code") VALUES ('A', 'rhs_5aa672');

INSERT INTO "document_functional_areas" ("functional_area_code", "document_code") VALUES ('@', 'Q');

INSERT INTO "document_functional_areas" ("functional_area_code", "document_code") VALUES ('@', 'rhs_5aa672');

INSERT INTO "document_functional_areas" ("functional_area_code", "document_code") VALUES ('A', 'rhs_5aa672');

INSERT INTO "document_functional_areas" ("functional_area_code", "document_code") VALUES ('E', 'A');

INSERT INTO "document_functional_areas" ("functional_area_code", "document_code") VALUES ('A', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanaccess_count" AS "avg_t1_access_count_" FROM (SELECT "functional_area_description", AVG("access_count") AS "meanaccess_count" FROM (SELECT "LHS"."functional_area_code" AS "functional_area_code", "LHS"."parent_functional_area_code" AS "parent_functional_area_code", "LHS"."functional_area_description" AS "functional_area_description", "LHS"."document_code" AS "document_code", "LHS"."document_structure_code" AS "document_structure_code", "LHS"."document_type_code" AS "document_type_code", "LHS"."access_count" AS "access_count", "LHS"."document_name" AS "document_name" FROM (SELECT "LHS"."functional_area_code" AS "functional_area_code", "LHS"."parent_functional_area_code" AS "parent_functional_area_code", "LHS"."functional_area_description" AS "functional_area_description", "RHS"."document_code" AS "document_code", "RHS"."document_structure_code" AS "document_structure_code", "RHS"."document_type_code" AS "document_type_code", "RHS"."access_count" AS "access_count", "RHS"."document_name" AS "document_name" FROM "functional_areas" AS "LHS" CROSS JOIN "documents" AS "RHS") AS "LHS" INNER JOIN "document_functional_areas" AS "RHS" ON ("LHS"."functional_area_code" = "RHS"."functional_area_code" AND "LHS"."document_code" = "RHS"."document_code")) GROUP BY "functional_area_description") WHERE ("functional_area_description" = 'Acknowledgement') ORDER BY avg_t1_access_count_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(t1.access_count) FROM documents AS t1 JOIN document_functional_areas AS t2 ON t1.document_code = t2.document_code JOIN functional_areas AS t3 ON t2.functional_area_code = t3.functional_area_code WHERE t3.functional_area_description = 'Acknowledgement';

/*
Prediction Result:
(None,)
*/