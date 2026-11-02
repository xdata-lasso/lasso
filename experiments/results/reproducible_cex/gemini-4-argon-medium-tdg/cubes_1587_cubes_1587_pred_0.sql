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
-- Tests:
-- 1. WHERE document_id = 7 vs >, <, !=, >=, <=, or missing WHERE
-- 2. SELECT DISTINCT vs SELECT (duplicate mailing_dates for document_id = 7)
-- 3. ORDER BY mailing_date ASC vs DESC (unsorted insertion order)
-- 4. NULL handling in mailing_date
-- 5. Confounding columns (receipt_date in Documents, address_id = 7 in Addresses)
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T1', 'Type 1');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('S1', 'Status 1');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('A1', 'Agent 1', 'Desc 1');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (1, '100 Main St');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (2, '200 Main St');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (3, '300 Main St');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (4, '400 Main St');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (7, '700 Main St');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (6, 'A1', 'S1', 'T1', '2023-01-06', 'R6', 'Doc 6');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (7, 'A1', 'S1', 'T1', '2023-01-07', 'R7', 'Doc 7');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (8, 'A1', 'S1', 'T1', '2023-01-08', 'R8', 'Doc 8');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (6, 1, '2023-05-01');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (6, 7, '2023-05-02');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (7, 1, '2023-05-20');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (7, 2, '2023-05-10');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (7, 3, '2023-05-10');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (7, 4, NULL);
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (8, 1, '2023-05-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mailing_date FROM documents_mailed WHERE (document_id = 7) ORDER BY mailing_date, documents_mailed.document_id NULLS LAST, documents_mailed.mailed_to_address_id NULLS LAST;

/*
Gold Result:
(None,)
('2023-05-10',)
('2023-05-10',)
('2023-05-20',)
*/

-- Prediction Query
SELECT mailing_date FROM Documents_Mailed WHERE document_id = 7;

/*
Prediction Result:
('2023-05-20',)
('2023-05-10',)
('2023-05-10',)
(None,)
*/