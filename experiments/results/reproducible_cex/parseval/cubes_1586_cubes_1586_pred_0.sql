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
-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1, 'lhs_147fb4', 'document_stat_1', 'document_type_1', '2024-12-15 00:56:33+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (2, 'rhs_570101', 'rhs_433fb3', 'rhs_dc03d5', '2024-06-15 00:00:00+00:00', 'rhs_c0fd9c', 'rhs_2dd0b0');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (3, 'rhs_570101', 'rhs_a6a40a', 'rhs_13b141', '2024-06-15 00:00:00+00:00', 'rhs_d431d2', 'rhs_bd5065');

-- Inserting into table: ref_document_types --
INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('document_type_1', 'ref_478ef7');

INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('rhs_dc03d5', 'ref_478ef7');

INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('rhs_13b141', 'ref_478ef7');

-- Inserting into table: ref_document_status --
INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('document_stat_1', 'ref_2145f1');

INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('rhs_433fb3', 'ref_2145f1');

INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('rhs_a6a40a', 'ref_2145f1');

-- Inserting into table: ref_shipping_agents --
INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('lhs_147fb4', 'USPS', 'lhs_dbeb8e');

INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('C', 'USPS', 'lhs_dbeb8e');

INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('A', 'ref_08ec79', 'ref_43360b');

INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('_', 'USPS', 'lhs_dbeb8e');

INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('O', 'USPS', 'lhs_dbeb8e');

INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('rhs_570101', 'USPS', 'lhs_dbeb8e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "LHS"."shipping_agent_code" AS "shipping_agent_code", "LHS"."shipping_agent_name" AS "shipping_agent_name", "LHS"."shipping_agent_description" AS "shipping_agent_description", "LHS"."document_id" AS "document_id", "LHS"."document_status_code" AS "document_status_code", "LHS"."document_type_code" AS "document_type_code", "LHS"."receipt_date" AS "receipt_date", "LHS"."receipt_number" AS "receipt_number", "LHS"."other_details" AS "other_details", "RHS"."n" AS "n" FROM (SELECT "LHS"."shipping_agent_code" AS "shipping_agent_code", "LHS"."shipping_agent_name" AS "shipping_agent_name", "LHS"."shipping_agent_description" AS "shipping_agent_description", "RHS"."document_id" AS "document_id", "RHS"."document_status_code" AS "document_status_code", "RHS"."document_type_code" AS "document_type_code", "RHS"."receipt_date" AS "receipt_date", "RHS"."receipt_number" AS "receipt_number", "RHS"."other_details" AS "other_details" FROM "ref_shipping_agents" AS "LHS" INNER JOIN "documents" AS "RHS" ON ("LHS"."shipping_agent_code" = "RHS"."shipping_agent_code")) AS "LHS" INNER JOIN (SELECT "shipping_agent_code", COUNT(*) AS "n" FROM "documents" GROUP BY "shipping_agent_code") AS "RHS" ON ("LHS"."shipping_agent_code" = "RHS"."shipping_agent_code")) WHERE ("shipping_agent_name" = 'USPS') ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Ref_Shipping_Agents JOIN Documents ON Documents.shipping_agent_code = Ref_Shipping_Agents.shipping_agent_code WHERE Ref_Shipping_Agents.shipping_agent_name = 'USPS';

/*
Prediction Result:
(3,)
*/