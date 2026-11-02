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
-- DATASET 4
-- Tests empty result set vs single NULL row (kills mutants that omit GROUP BY and filter in WHERE when no matching rows exist, or LEFT JOIN mutants when 'Acknowledgement' has no documents).
INSERT INTO "Document_Structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('DS1', NULL, 'Structure 1');
INSERT INTO "Functional_Areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('FA1', NULL, 'Acknowledgement');
INSERT INTO "Functional_Areas" ("functional_area_code", "parent_functional_area_code", "functional_area_description") VALUES ('FA2', NULL, 'Sales');
INSERT INTO "Documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('D1', 'DS1', 'T1', 42, 'Doc 1');
INSERT INTO "Document_Functional_Areas" ("functional_area_code", "document_code") VALUES ('FA2', 'D1');
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