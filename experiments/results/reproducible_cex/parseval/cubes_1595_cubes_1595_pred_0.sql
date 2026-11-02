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
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (4, -2147483648, -2147483648);

INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (5, -2147483647, -2147483647);

-- Inserting into table: documents --
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (4, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2023-01-16 20:10:41+00:00', 'doc_aeb029', 'doc_8f106e');

INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (5, 'shipping_agen_1', 'document_stat_1', 'document_type_1', '2025-02-21 23:30:13+00:00', 'doc_aeb029', 'doc_8f106e');

-- Inserting into table: document_drafts --
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (4, -2147483648, 'doc_421927');

INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (5, -2147483647, 'doc_421927');

-- Inserting into table: ref_document_types --
INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('document_type_1', 'ref_478ef7');

-- Inserting into table: roles --
INSERT INTO "roles" ("role_code", "role_description") VALUES ('lhs_c3aa65', 'rol_ef6dd0');

INSERT INTO "roles" ("role_code", "role_description") VALUES ('lhs_8730a3', 'rol_ef6dd0');

-- Inserting into table: ref_document_status --
INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('document_stat_1', 'ref_2145f1');

-- Inserting into table: ref_shipping_agents --
INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('shipping_agen_1', 'ref_08ec79', 'ref_43360b');

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (1, 'lhs_c3aa65', 'lhs_83b59f', 'lhs_f0a28a');

INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (-2147483647, 'lhs_8730a3', 'lhs_e9fc15', 'lhs_62a635');

INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (-2147483646, 'lhs_c3aa65', 'q_0_6f3382', 'emp_7ba8c6');

INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (-2147483645, 'lhs_8730a3', 'q_0_6f3382', 'emp_7ba8c6');

INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (2, 'lhs_8730a3', 'emp_9e07dc', 'emp_7ba8c6');

INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (3, 'lhs_8730a3', 'emp_9e07dc', 'emp_7ba8c6');

-- Inserting into table: circulation_history --
INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (4, -2147483648, -2147483648, 2);

INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (5, -2147483647, -2147483648, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_name FROM (SELECT * FROM employees AS LHS WHERE NOT EXISTS(SELECT 1 FROM circulation_history AS RHS WHERE (LHS.employee_id = RHS.employee_id))) ORDER BY employee_name;

/*
Gold Result:
('lhs_83b59f',)
('lhs_e9fc15',)
('q_0_6f3382',)
('q_0_6f3382',)
*/

-- Prediction Query
SELECT employee_name FROM Employees EXCEPT SELECT Employees.employee_name FROM Employees JOIN Circulation_History ON Circulation_History.employee_id = Employees.employee_id;

/*
Prediction Result:
('lhs_83b59f',)
('lhs_e9fc15',)
('q_0_6f3382',)
*/