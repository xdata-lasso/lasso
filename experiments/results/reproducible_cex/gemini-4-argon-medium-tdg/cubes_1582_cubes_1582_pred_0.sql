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
-- DATASET 2
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('Paper', 'Paper Document');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('Book', 'Book Document');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('done', 'Completed');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('archived', 'Archived');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('USPS', 'FedEx', 'Code is USPS but name is FedEx');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('FEDEX', 'USPS', 'Code is FEDEX but name is USPS');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('NULL_NAME', NULL, 'Agent with NULL name');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('UNMATCHED', 'UPS', 'Agent with no documents');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (100, 'USPS', 'done', 'Paper', '2023-02-01', 'R100', 'Should be included');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (200, 'FEDEX', 'done', 'Paper', '2023-02-02', 'R200', 'Should be excluded');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (300, 'NULL_NAME', 'done', 'Paper', '2023-02-03', 'R300', 'Tests NULL shipping_agent_name');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (400, NULL, 'done', 'Paper', '2023-02-04', 'R400', 'Tests NULL shipping_agent_code');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (50, 'USPS', NULL, 'Paper', '2023-02-05', 'R50', 'Tests NULL document_status_code');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (60, 'USPS', 'done', NULL, '2023-02-06', 'R60', 'Tests NULL document_type_code');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_id" FROM (SELECT "LHS"."shipping_agent_code" AS "shipping_agent_code", "LHS"."shipping_agent_name" AS "shipping_agent_name", "LHS"."shipping_agent_description" AS "shipping_agent_description", "RHS"."document_id" AS "document_id", "RHS"."document_status_code" AS "document_status_code", "RHS"."document_type_code" AS "document_type_code", "RHS"."receipt_date" AS "receipt_date", "RHS"."receipt_number" AS "receipt_number", "RHS"."other_details" AS "other_details" FROM "ref_shipping_agents" AS "LHS" INNER JOIN (SELECT * FROM "documents" WHERE ("document_status_code" = 'done' AND "document_type_code" = 'Paper')) AS "RHS" ON ("LHS"."shipping_agent_code" = "RHS"."shipping_agent_code")) WHERE ("document_status_code" <> 'done' OR "shipping_agent_name" <> 'USPS') ORDER BY document_id, "document_id" NULLS LAST;

/*
Gold Result:
(100,)
*/

-- Prediction Query
SELECT document_id FROM Documents WHERE document_status_code = 'done' AND document_type_code = 'Paper' EXCEPT SELECT document_id FROM Documents JOIN Ref_Shipping_Agents ON Documents.shipping_agent_code = Ref_Shipping_Agents.shipping_agent_code WHERE Ref_Shipping_Agents.shipping_agent_name = 'USPS';

/*
Prediction Result:
(100,)
(300,)
(400,)
*/