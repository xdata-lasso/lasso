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
-- Tests basic filtering, column confusion (code vs name vs description), case sensitivity, partial matches (LIKE vs =), NULL handling, and ORDER BY direction (inserted out of alphabetical order).
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('Z_CODE', 'UPS', 'Standard UPS Agent');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('A_CODE', 'UPS', 'Express UPS Agent');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('UPS', 'FedEx', 'Code is UPS, but name is FedEx');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('DESC_UPS', 'DHL', 'UPS');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('CASE_LOW', 'ups', 'Lowercase name');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('SUB_1', 'UPS Ground', 'Prefix match');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('SUB_2', 'My UPS', 'Suffix match');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('NULL_NAME', NULL, 'UPS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "shipping_agent_code" FROM "ref_shipping_agents" WHERE ("shipping_agent_name" = 'UPS') ORDER BY shipping_agent_code;

/*
Gold Result:
('A_CODE',)
('Z_CODE',)
*/

-- Prediction Query
SELECT shipping_agent_code FROM Ref_Shipping_Agents WHERE shipping_agent_name = 'UPS';

/*
Prediction Result:
('Z_CODE',)
('A_CODE',)
*/