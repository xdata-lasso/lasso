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
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (1, 1, 1);

-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2024-12-15 00:56:33+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483647, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2022-06-06 02:35:43+00:00', 'doc_aeb029', 'doc_8f106e');

-- Inserting into table: document_drafts --
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (1, -2147483648, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483647, 1, 'doc_421927');

-- Inserting into table: ref_document_types --
INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('document_type_1', 'ref_478ef7');

-- Inserting into table: ref_document_status --
INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('document_stat_1', 'ref_2145f1');

-- Inserting into table: ref_shipping_agents --
INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('shipping_agen_1', 'ref_08ec79', 'ref_43360b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT draft_number AS count___ FROM (SELECT document_id, draft_number, COUNT(DISTINCT document_id) AS n_distinct FROM (SELECT * FROM draft_copies WHERE (document_id < 2)) GROUP BY document_id, draft_number) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Draft_Copies WHERE document_id = 2;

/*
Prediction Result:
(0,)
*/