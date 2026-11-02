-- Schema DDL
CREATE TABLE "Ref_Document_Types" ("document_type_code" TEXT(15) PRIMARY KEY, "document_type_description" TEXT(255));

CREATE TABLE "Roles" ("role_code" TEXT(15) PRIMARY KEY, "role_description" TEXT(255));

CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_details" TEXT(255));

CREATE TABLE "Ref_Document_Status" ("document_status_code" TEXT(15) PRIMARY KEY, "document_status_description" TEXT(255));

CREATE TABLE "Ref_Shipping_Agents" ("shipping_agent_code" TEXT(15) PRIMARY KEY, "shipping_agent_name" TEXT(255), "shipping_agent_description" TEXT(255));

CREATE TABLE "Documents" ("document_id" INTEGER PRIMARY KEY, "shipping_agent_code" TEXT(15), "document_status_code" TEXT(15), "document_type_code" TEXT(15), "receipt_date" DATETIME, "receipt_number" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("shipping_agent_code") REFERENCES "Ref_Shipping_Agents" ("shipping_agent_code"), FOREIGN KEY ("document_status_code") REFERENCES "Ref_Document_Status" ("document_status_code"), FOREIGN KEY ("document_type_code") REFERENCES "Ref_Document_Types" ("document_type_code"));

CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "role_code" TEXT(15), "employee_name" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("role_code") REFERENCES "Roles" ("role_code"));

CREATE TABLE "Document_Drafts" ("document_id" INTEGER UNIQUE, "draft_number" INTEGER UNIQUE, "draft_details" TEXT(255), PRIMARY KEY ("document_id", "draft_number"), FOREIGN KEY ("document_id") REFERENCES "Documents" ("document_id"));

CREATE TABLE "Draft_Copies" ("document_id" INTEGER UNIQUE, "draft_number" INTEGER UNIQUE, "copy_number" INTEGER UNIQUE, PRIMARY KEY ("document_id", "draft_number", "copy_number"), FOREIGN KEY ("document_id") REFERENCES "Document_Drafts" ("document_id"), FOREIGN KEY ("draft_number") REFERENCES "Document_Drafts" ("draft_number"));

CREATE TABLE "Circulation_History" ("document_id" INTEGER, "draft_number" INTEGER, "copy_number" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("document_id", "draft_number", "copy_number", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employees" ("employee_id"), FOREIGN KEY ("document_id") REFERENCES "Draft_Copies" ("document_id"), FOREIGN KEY ("draft_number") REFERENCES "Draft_Copies" ("draft_number"), FOREIGN KEY ("copy_number") REFERENCES "Draft_Copies" ("copy_number"));

CREATE TABLE "Documents_Mailed" ("document_id" INTEGER, "mailed_to_address_id" INTEGER, "mailing_date" DATETIME, PRIMARY KEY ("document_id", "mailed_to_address_id"), FOREIGN KEY ("mailed_to_address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("document_id") REFERENCES "Documents" ("document_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: draft_copies --
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483648, -2147483648, -2147483648);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (1, -2147483647, -2147483647);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483646, 1, -2147483646);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483645, -2147483646, -2147483645);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483644, -2147483644, -2147483644);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483643, -2147483643, -2147483643);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483642, -2147483642, -2147483642);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483641, -2147483641, -2147483641);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483640, -2147483640, -2147483640);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483639, -2147483639, -2147483639);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483638, -2147483638, -2147483638);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483637, -2147483637, -2147483637);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483636, -2147483636, -2147483636);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483635, -2147483635, -2147483635);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483634, -2147483634, -2147483634);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483633, -2147483633, -2147483633);

-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483648, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2024-12-15 00:56:33+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2022-03-24 16:30:12+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483646, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2024-11-14 12:35:58+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483645, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2022-02-14 19:27:39+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483644, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2022-10-06 13:20:05+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483643, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2020-04-05 14:43:51+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483642, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2021-07-11 07:27:32+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483641, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2025-02-07 06:53:31+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483640, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2021-12-31 07:20:26+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483639, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2024-02-29 12:08:41+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483638, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2022-07-16 22:41:51+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483637, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2021-02-04 01:21:18+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483636, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2021-02-10 21:10:52+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483635, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2021-11-30 23:39:10+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483634, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2025-01-30 02:54:07+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483633, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2022-01-22 16:14:13+00:00', 'doc_aeb029', 'doc_8f106e');

-- Inserting into table: document_drafts --
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483648, -2147483648, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (1, -2147483647, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483646, -2147483646, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483645, 1, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483644, -2147483644, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483643, -2147483643, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483642, -2147483642, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483641, -2147483641, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483640, -2147483640, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483639, -2147483639, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483638, -2147483638, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483637, -2147483637, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483636, -2147483636, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483635, -2147483635, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483634, -2147483634, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483633, -2147483633, 'doc_421927');

-- Inserting into table: ref_document_types --
INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('document_type_1', 'ref_478ef7');

-- Inserting into table: roles --
INSERT INTO "roles" ("role_code", "role_description") VALUES ('role_code_1', 'rol_ef6dd0');

-- Inserting into table: ref_document_status --
INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('document_stat_1', 'ref_2145f1');

-- Inserting into table: ref_shipping_agents --
INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('shipping_agen_1', 'ref_08ec79', 'ref_43360b');

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (1, 'role_code_1', 'emp_9e07dc', 'emp_7ba8c6');

-- Inserting into table: circulation_history --
INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (-2147483648, -2147483648, -2147483648, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483648, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483646, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483647, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (-2147483646, -2147483647, -2147483648, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (-2147483648, -2147483647, -2147483646, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483645, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483644, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483643, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (-2147483643, -2147483647, -2147483644, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (-2147483642, 1, -2147483643, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483641, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483640, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483639, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (-2147483645, -2147483643, -2147483640, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (-2147483646, 1, -2147483647, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483638, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483637, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483636, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (-2147483645, -2147483636, -2147483636, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (-2147483639, -2147483641, -2147483641, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483635, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483634, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 1, -2147483633, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id, n_distinct AS count_distinct_employee_id_ FROM (SELECT document_id, draft_number, COUNT(DISTINCT employee_id) AS n_distinct FROM circulation_history GROUP BY document_id, draft_number) ORDER BY document_id, count_distinct_employee_id_ NULLS LAST;

/*
Gold Result:
(-2147483648, 1)
(-2147483648, 1)
(-2147483646, 1)
(-2147483646, 1)
(-2147483645, 1)
(-2147483645, 1)
(-2147483643, 1)
(-2147483642, 1)
(-2147483639, 1)
(1, 1)
*/

-- Prediction Query
SELECT document_id, COUNT(DISTINCT employee_id) FROM Circulation_History GROUP BY document_id;

/*
Prediction Result:
(-2147483648, 1)
(-2147483646, 1)
(-2147483645, 1)
(-2147483643, 1)
(-2147483642, 1)
(-2147483639, 1)
(1, 1)
*/