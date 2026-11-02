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
-- 1. Boundary conditions around document_id = 7 (6, 7, 8).
-- 2. Wrong column predicate mutants (e.g., mailed_to_address_id = 7 when document_id != 7).
-- 3. Wrong table/column projection mutants (Documents.receipt_date vs Documents_Mailed.mailing_date).
-- 4. Duplicate mailing_date values for document_id = 7 (catches DISTINCT, GROUP BY, or LIMIT 1 mutants).
-- 5. Ordering mutants (DESC vs ASC, missing ORDER BY).
-- 6. Unnecessary INNER JOIN mutants with child tables (Document_Drafts is empty for doc 7).
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('TYPE1', 'Standard');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('STAT1', 'Active');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('AG1', 'Agent One', 'Desc');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (1, '100 First St');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (2, '200 Second St');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (3, '300 Third St');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (7, '700 Seventh St');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (6, 'AG1', 'STAT1', 'TYPE1', '2020-01-06 00:00:00', 'R6', 'Doc 6');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (7, 'AG1', 'STAT1', 'TYPE1', '1999-12-31 23:59:59', 'R7', 'Doc 7');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (8, 'AG1', 'STAT1', 'TYPE1', '2020-01-08 00:00:00', 'R8', 'Doc 8');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (6, 7, '2023-01-01 10:00:00');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (8, 1, '2023-01-02 10:00:00');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (7, 1, '2023-05-10 12:00:00');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (7, 2, '2023-02-15 08:30:00');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (7, 3, '2023-05-10 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mailing_date FROM documents_mailed WHERE (document_id = 7) ORDER BY mailing_date, documents_mailed.document_id NULLS LAST, documents_mailed.mailed_to_address_id NULLS LAST;

/*
Gold Result:
('2023-02-15 08:30:00',)
('2023-05-10 12:00:00',)
('2023-05-10 12:00:00',)
*/

-- Prediction Query
SELECT mailing_date FROM Documents_Mailed WHERE document_id = 7;

/*
Prediction Result:
('2023-05-10 12:00:00',)
('2023-02-15 08:30:00',)
('2023-05-10 12:00:00',)
*/