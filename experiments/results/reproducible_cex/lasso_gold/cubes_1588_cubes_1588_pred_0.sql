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
INSERT INTO "addresses" ("address_id", "address_details") VALUES (1017, '4431 Leslie Summit Apt. 337
Jennyhaven, PA 37594');
INSERT INTO "addresses" ("address_id", "address_details") VALUES (1018, '41904 Sanders Stravenue
North Brittany, MP 82714');
INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('eight', 'Recent feeling range south.');
INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('grow', 'They red everybody act way.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('style', 'Site girl into have media game support.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('bed', 'Result major serve real position.');
INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('test', 'Jeffrey Cox PhD', 'Religious itself safe whole establish space Mrs.');
INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('military', 'Alan Phillips', 'Reality fill ok list most international.');
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (4, 'test', 'eight', 'style', '1970-08-07', 'member', 'make');
INSERT INTO "documents_mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (4, 1017, '1971-09-08');
INSERT INTO "documents_mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (4, 1018, '1973-11-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address_details FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, RHS.document_id AS document_id, RHS.mailing_date AS mailing_date FROM addresses AS LHS INNER JOIN (SELECT * FROM documents_mailed WHERE (document_id = 4)) AS RHS ON (LHS.address_id = RHS.mailed_to_address_id)) ORDER BY address_details;

/*
Gold Result:
('41904 Sanders Stravenue\nNorth Brittany, MP 82714',)
('4431 Leslie Summit Apt. 337\nJennyhaven, PA 37594',)
*/

-- Prediction Query
SELECT Addresses.address_details FROM Addresses JOIN Documents_Mailed ON Documents_Mailed.mailed_to_address_id = Addresses.address_id WHERE document_id = 4;

/*
Prediction Result:
('4431 Leslie Summit Apt. 337\nJennyhaven, PA 37594',)
('41904 Sanders Stravenue\nNorth Brittany, MP 82714',)
*/