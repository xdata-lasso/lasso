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
INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('step', 'Product main couple design around save article.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('former', 'Anyone live try most.');
INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('art', 'Angela Lopez', 'Attack technology identify walk now often always bank.');
INSERT INTO "roles" ("role_code", "role_description") VALUES ('Television production assistant', 'Systems analyst');
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1043, 'art', 'step', 'former', '1977-08-08', 'necessary', 'four');
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1054, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (1044, 'Television production assistant', 'Christina Moran', 'edge');
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (1043, 1045, 'evidence');
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (1054, 1047, NULL);
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (1043, 1045, 1046);
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (1054, 1047, 1048);
INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1043, 1045, 1046, 1044);
INSERT INTO "circulation_history" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1043, 1047, 1048, 1044);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id, n_distinct AS count_distinct_employee_id_ FROM (SELECT document_id, draft_number, COUNT(DISTINCT employee_id) AS n_distinct FROM circulation_history GROUP BY document_id, draft_number) ORDER BY document_id, count_distinct_employee_id_ NULLS LAST;

/*
Gold Result:
(1043, 1)
(1043, 1)
*/

-- Prediction Query
SELECT document_id, COUNT(DISTINCT employee_id) FROM Circulation_History GROUP BY document_id;

/*
Prediction Result:
(1043, 1)
*/