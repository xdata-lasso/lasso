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
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (1, -2147483648, -2147483648);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483647, -2147483647, -2147483647);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483646, -2147483646, -2147483646);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483645, -2147483645, -2147483645);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483644, -2147483644, -2147483644);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (2, -2147483643, -2147483643);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (-2147483642, -2147483642, -2147483642);

-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2024-12-15 00:56:33+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483647, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2021-06-17 14:22:38+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483646, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2025-08-22 00:34:24+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483645, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2020-12-19 01:52:21+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483644, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2021-07-20 10:41:36+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (2, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2021-02-17 05:47:13+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (-2147483642, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2020-09-15 12:11:12+00:00', 'doc_aeb029', 'doc_8f106e');

-- Inserting into table: document_drafts --
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (1, -2147483648, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483647, -2147483647, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483646, -2147483646, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483645, -2147483645, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483644, -2147483644, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (2, -2147483643, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (-2147483642, -2147483642, 'doc_421927');

-- Inserting into table: ref_document_types --
INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('document_type_1', 'ref_478ef7');

-- Inserting into table: roles --
INSERT INTO "roles" ("role_code", "role_description") VALUES ('role_code_1', 'rol_ef6dd0');

-- Inserting into table: ref_document_status --
INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('document_stat_1', 'ref_2145f1');

-- Inserting into table: ref_shipping_agents --
INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('shipping_agen_1', 'ref_08ec79', 'ref_43360b');

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (1, 'role_code_1', 'emp_a2a644', 'emp_7ba8c6');

INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (3, 'role_code_1', 'emp_a2a644', 'emp_7ba8c6');

INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (2, 'role_code_1', 'emp_9e07dc', 'emp_7ba8c6');

-- Inserting into table: circulation_history --
INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483648, -2147483648, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483647, -2147483648, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483648, -2147483647, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483647, -2147483647, 2);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483648, -2147483647, 2);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483647, -2147483648, 2);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483647, -2147483647, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483646, -2147483647, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483645, -2147483648, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483644, -2147483647, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483647, -2147483646, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483647, -2147483644, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (2, -2147483648, -2147483645, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483642, -2147483647, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483644, -2147483642, 1);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, -2147483643, -2147483645, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_name_other AS employee_name FROM (SELECT LHS.employee_id AS employee_id, LHS.role_code AS role_code, LHS.employee_name AS employee_name, LHS.other_details AS other_details, RHS.document_id AS document_id, RHS.draft_number AS draft_number, RHS.employee_id AS employee_id_other, RHS.role_code AS role_code_other, RHS.employee_name AS employee_name_other, RHS.other_details AS other_details_other FROM employees AS LHS INNER JOIN (SELECT LHS.document_id AS document_id, LHS.draft_number AS draft_number, LHS.copy_number AS copy_number, LHS.employee_id AS employee_id, RHS.role_code AS role_code, RHS.employee_name AS employee_name, RHS.other_details AS other_details FROM circulation_history AS LHS INNER JOIN employees AS RHS ON (LHS.employee_id = RHS.employee_id)) AS RHS ON (LHS.employee_id = RHS.copy_number)) ORDER BY employee_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT Employees.employee_name FROM Employees JOIN Circulation_History ON Circulation_History.employee_id = Employees.employee_id WHERE Circulation_History.document_id = 1;

/*
Prediction Result:
('emp_a2a644',)
('emp_a2a644',)
('emp_9e07dc',)
('emp_a2a644',)
('emp_9e07dc',)
('emp_a2a644',)
('emp_9e07dc',)
('emp_a2a644',)
('emp_a2a644',)
('emp_a2a644',)
('emp_a2a644',)
('emp_a2a644',)
('emp_a2a644',)
('emp_a2a644',)
('emp_a2a644',)
*/