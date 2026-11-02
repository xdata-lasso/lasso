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
-- Core logic: Tests multiple addresses for document_id = 4 (in reverse alphabetical order by ID to test ORDER BY), duplicate address_details (tests SELECT vs SELECT DISTINCT), unmailed addresses (tests INNER vs LEFT JOIN), and boundary document_ids (3 and 5) as well as address_id = 4 (tests filtering on wrong column).
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T1', 'Type 1');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('S1', 'Status 1');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('A1', 'Agent 1', 'Desc 1');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (3, 'A1', 'S1', 'T1', '2023-01-01 10:00:00', 'R3', 'D3');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (4, 'A1', 'S1', 'T1', '2023-01-02 10:00:00', 'R4', 'D4');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (5, 'A1', 'S1', 'T1', '2023-01-03 10:00:00', 'R5', 'D5');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (1, 'Zeta Street');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (2, 'Alpha Avenue');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (3, 'Alpha Avenue');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (4, 'Delta Road');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (5, 'Unmailed Lane');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (4, 1, '2023-02-01 10:00:00');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (4, 2, '2023-02-03 10:00:00');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (4, 3, '2023-02-02 10:00:00');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (3, 4, '2023-02-04 10:00:00');
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (5, 4, '2023-02-05 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address_details FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, RHS.document_id AS document_id, RHS.mailing_date AS mailing_date FROM addresses AS LHS INNER JOIN (SELECT * FROM documents_mailed WHERE (document_id = 4)) AS RHS ON (LHS.address_id = RHS.mailed_to_address_id)) ORDER BY address_details;

/*
Gold Result:
('Alpha Avenue',)
('Alpha Avenue',)
('Zeta Street',)
*/

-- Prediction Query
SELECT Addresses.address_details FROM Addresses JOIN Documents_Mailed ON Documents_Mailed.mailed_to_address_id = Addresses.address_id WHERE document_id = 4;

/*
Prediction Result:
('Zeta Street',)
('Alpha Avenue',)
('Alpha Avenue',)
*/