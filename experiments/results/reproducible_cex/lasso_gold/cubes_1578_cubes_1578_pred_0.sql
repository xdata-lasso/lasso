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
INSERT INTO "ref_document_status" ("document_status_code", "document_status_description") VALUES ('purpose', 'Agent every development say.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_description") VALUES ('require', 'Beautiful instead ahead despite measure ago current.');
INSERT INTO "ref_shipping_agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('rate', 'Jennifer Cole', 'Speak according south recently future.');
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1001, 'rate', 'purpose', 'require', '1970-01-01', 'throw', 'surface');
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1002, 'rate', 'purpose', 'require', '1970-01-02', 'guy', 'animal');
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1003, 'rate', 'purpose', 'require', '1970-01-03', 'PM', 'show');
INSERT INTO "documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1004, 'rate', 'purpose', 'require', '1970-01-04', 'everything', 'machine');
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (1001, 1005, 'not');
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (1002, 1006, 'capital');
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (1003, 1007, 'win');
INSERT INTO "document_drafts" ("document_id", "draft_number", "draft_details") VALUES (1004, 1008, 'human');
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (1001, 1005, 1009);
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (1002, 1006, 1010);
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (1003, 1007, 1011);
INSERT INTO "draft_copies" ("document_id", "draft_number", "copy_number") VALUES (1004, 1008, 1012);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT document_id, COUNT(*) AS n FROM draft_copies GROUP BY document_id) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(1001, 1)
*/

-- Prediction Query
SELECT document_id, COUNT(*) FROM Draft_Copies GROUP BY document_id HAVING COUNT(*) > 1;

/*
Prediction Result:
*/