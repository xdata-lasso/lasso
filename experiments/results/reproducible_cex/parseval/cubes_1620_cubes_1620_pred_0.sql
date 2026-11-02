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
INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_1', 'document_stru_1', 'doc_cb6a2c', -55602865, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('t1__ceec4c', 'document_stru_1', 'doc_cb6a2c', -921145356, 't1__da0bf6');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('C', 'document_stru_1', 'doc_cb6a2c', -1726781632, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('A', 'document_stru_1', 'doc_cb6a2c', 1610062532, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('t1__c19dad', 'document_stru_1', 'doc_cb6a2c', 1871297066, 't1__cf5f49');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_6', 'document_stru_1', 'doc_cb6a2c', -1633151678, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_7', 'document_stru_1', 'doc_cb6a2c', 1914020640, 'doc_7ee600');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('Q', 'document_stru_1', 'doc_cb6a2c', 1219478689, 't1__da0bf6');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_code_9', 'document_stru_1', 'doc_cb6a2c', 906324270, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('G', 'document_stru_1', 'doc_cb6a2c', 2122220075, 't1__da0bf6');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_11', 'document_stru_1', 'doc_cb6a2c', -1659388584, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_12', 'document_stru_1', 'doc_cb6a2c', 462974032, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_13', 'document_stru_1', 'doc_cb6a2c', -1576219117, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_14', 'document_stru_1', 'doc_cb6a2c', 1861536320, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('I', 'document_stru_1', 'doc_cb6a2c', -1399556171, 't1__da0bf6');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_16', 'document_stru_1', 'doc_cb6a2c', 1419861592, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_17', 'document_stru_1', 'doc_cb6a2c', -1683203397, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('t2__c08938', 'document_stru_1', 'doc_cb6a2c', -1585009206, 't1__da0bf6');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_19', 'document_stru_1', 'doc_cb6a2c', 757448742, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_20', 'document_stru_1', 'doc_cb6a2c', -967741825, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_21', 'document_stru_1', 'doc_cb6a2c', -921187550, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_22', 'document_stru_1', 'doc_cb6a2c', 882961052, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_23', 'document_stru_1', 'doc_cb6a2c', -1068298341, 'doc_db3056');

INSERT INTO "documents" ("document_code", "document_structure_code", "document_type_code", "access_count", "document_name") VALUES ('document_cod_24', 'document_stru_1', 'doc_cb6a2c', 1898504886, NULL);

-- Inserting into table: document_structures --
INSERT INTO "document_structures" ("document_structure_code", "parent_document_structure_code", "document_structure_description") VALUES ('document_stru_1', 'doc_5c8212', 'doc_cd87d2');

-- Inserting into table: images --
INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483648, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483647, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483646, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483645, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483644, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483643, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483642, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483641, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483640, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483639, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483638, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483637, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483636, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483635, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483634, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483633, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483632, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483631, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

INSERT INTO "images" ("image_id", "image_alt_text", "image_name", "image_url") VALUES (-2147483630, 'ima_ab3fdc', 'ima_c011f8', 'ima_d4f15d');

-- Inserting into table: document_sections --
INSERT INTO "document_sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (1, 't1__ceec4c', 1258409369, 'doc_a488c8', 'doc_350d4a');

INSERT INTO "document_sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (-2147483647, 't1__ceec4c', 809183447, 'doc_a488c8', 'doc_350d4a');

INSERT INTO "document_sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (-2147483646, 'Q', 1644814318, 'doc_a488c8', 'doc_350d4a');

INSERT INTO "document_sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (3, 't1__ceec4c', -1377057208, 'doc_a488c8', 'doc_350d4a');

INSERT INTO "document_sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (2, 'C', -1364429300, 'doc_a488c8', 'doc_350d4a');

INSERT INTO "document_sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (-2147483643, 't2__c08938', -53231346, 'doc_a488c8', 'doc_350d4a');

INSERT INTO "document_sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (-2147483642, 't2__c08938', 373262291, 'doc_a488c8', 'doc_350d4a');

INSERT INTO "document_sections" ("section_id", "document_code", "section_sequence", "section_code", "section_title") VALUES (-2147483641, 't2__c08938', -1822992503, 'doc_a488c8', 'doc_350d4a');

-- Inserting into table: document_sections_images --
INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483648);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483647);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483646);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483645);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483644);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483643);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (2, -2147483646);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483642);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (2, -2147483645);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483641);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (2, -2147483647);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483640);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483639);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483638);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483637);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483636);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483635);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483634);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483633);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483632);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483631);

INSERT INTO "document_sections_images" ("section_id", "image_id") VALUES (1, -2147483630);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_name FROM (SELECT * FROM documents AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT LHS.section_id AS section_id, LHS.image_id AS image_id, RHS.document_code AS document_code, RHS.section_sequence AS section_sequence, RHS.section_code AS section_code, RHS.section_title AS section_title FROM document_sections_images AS LHS INNER JOIN document_sections AS RHS ON (LHS.section_id = RHS.section_id)) AS RHS WHERE (LHS.document_code = RHS.document_code))) ORDER BY document_name;

/*
Gold Result:
(None,)
('doc_7ee600',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('doc_db3056',)
('t1__cf5f49',)
('t1__da0bf6',)
('t1__da0bf6',)
('t1__da0bf6',)
('t1__da0bf6',)
*/

-- Prediction Query
SELECT document_name FROM documents EXCEPT SELECT t1.document_name FROM documents AS t1 JOIN document_sections AS t2 ON t1.document_code = t2.document_code JOIN document_sections_images AS t3 ON t2.section_id = t3.section_id;

/*
Prediction Result:
(None,)
('doc_7ee600',)
('t1__cf5f49',)
*/