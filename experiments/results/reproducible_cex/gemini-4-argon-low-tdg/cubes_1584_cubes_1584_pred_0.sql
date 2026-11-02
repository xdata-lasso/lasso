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
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('done', 'Completed');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('mailed', 'Mailed');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('pending', 'Pending');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('CV', 'Curriculum Vitae');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('Paper', 'Research Paper');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('Film', 'Film');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('Book', 'Book');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('USPS', 'United States Postal Service', 'Mail');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('FedEx', 'FedEx', 'Courier');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1, 'USPS', 'done', 'CV', '2023-01-01 10:00:00', 'R1', 'D1');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (2, 'FedEx', 'done', 'CV', '2023-01-02 10:00:00', 'R2', 'D2');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (3, NULL, 'done', 'CV', NULL, NULL, NULL);
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (4, 'USPS', 'done', 'Paper', '2023-01-03 10:00:00', 'R4', 'D4');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (5, 'USPS', 'done', 'Film', '2023-01-04 10:00:00', 'R5', 'D5');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (6, 'USPS', 'done', 'Film', '2023-01-04 10:00:00', 'R5', 'D5');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (7, 'USPS', 'mailed', 'CV', '2023-01-05 10:00:00', 'R7', 'D7');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (8, 'USPS', 'mailed', 'Book', '2023-01-06 10:00:00', 'R8', 'D8');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (9, 'USPS', NULL, 'Paper', '2023-01-07 10:00:00', 'R9', 'D9');
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