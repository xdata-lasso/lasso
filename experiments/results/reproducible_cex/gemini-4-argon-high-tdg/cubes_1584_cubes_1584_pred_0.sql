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
-- DATASET 1
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T1', 'Contract');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T2', 'Invoice');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T3', 'Report');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T4', 'Memo');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T5', 'Unused Type');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('done', 'Finished');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('pending', 'In Progress');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('archived', 'Archived');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('SA1', 'FedEx', 'Express');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('SA2', 'DHL', 'International');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (1, '100 Main St');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (2, '200 Oak Ave');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1, 'SA1', 'done', 'T1', '2023-01-01', 'R101', 'D1');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (2, 'SA1', 'done', 'T1', '2023-01-02', 'R102', 'D2');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (3, 'SA2', 'done', 'T1', '2023-01-03', 'R103', 'D3');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (4, 'SA1', 'done', 'T2', '2023-01-04', 'R104', 'D4');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (5, 'SA2', 'done', 'T3', '2023-01-05', 'R105', 'D5');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (6, 'SA2', 'done', 'T3', '2023-01-06', 'R106', 'D6');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (7, 'SA1', 'pending', 'T1', '2023-01-07', 'R107', 'D7');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (8, 'SA1', 'pending', 'T2', '2023-01-08', 'R108', 'D8');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (9, 'SA2', 'pending', 'T2', '2023-01-09', 'R109', 'D9');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (10, 'SA2', 'pending', 'T4', '2023-01-10', 'R110', 'D10');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (11, 'SA1', 'archived', 'T4', '2023-01-11', 'R111', 'D11');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (1, 1, '2023-02-01');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (1, 2, '2023-02-02');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (1, 10, 'First draft');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "document_status_code", "document_type_code", COUNT(*) AS "n" FROM (SELECT * FROM "documents" WHERE ("document_status_code" = 'done')) GROUP BY document_status_code, document_type_code) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Documents WHERE document_status_code = 'done';

/*
Prediction Result:
(6,)
*/