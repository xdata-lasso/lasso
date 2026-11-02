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
-- Tests GROUP BY (document_id, draft_number) vs GROUP BY document_id alone,
-- tests SELECT DISTINCT vs SELECT ALL when multiple drafts of the same document have the same or different counts,
-- and tests ORDER BY document_id, count_distinct_employee_id_ sorting order.
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T1', 'Type 1');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('S1', 'Status 1');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('A1', 'Agent 1', 'Desc 1');
INSERT INTO "Roles" ("role_code", "role_description") VALUES ('R1', 'Role 1');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (1, 'R1', 'Emp 1', 'D1');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (2, 'R1', 'Emp 2', 'D2');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (3, 'R1', 'Emp 3', 'D3');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (10, 'A1', 'S1', 'T1', '2023-01-01', 'R1', 'Doc 10');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (20, 'A1', 'S1', 'T1', '2023-01-02', 'R2', 'Doc 20');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (30, 'A1', 'S1', 'T1', '2023-01-03', 'R3', 'Doc 30');
-- Each row in Document_Drafts and Draft_Copies has unique columns to satisfy UNIQUE constraints while providing valid FK targets for Circulation_History
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (10, 1, 'D1');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (20, 2, 'D2');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (30, 3, 'D3');
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (10, 1, 100);
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (20, 2, 200);
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (30, 3, 300);
-- Document 10 has three drafts in Circulation_History:
-- Draft 1 has 3 distinct employees ( inserted first to test secondary sort on count_distinct_employee_id_ )
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (10, 1, 100, 1);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (10, 1, 100, 2);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (10, 1, 100, 3);
-- Draft 2 of Document 10 has 1 distinct employee
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (10, 2, 200, 1);
-- Draft 3 of Document 10 also has 1 distinct employee (tests duplicate output rows (10, 1) and (10, 1) vs SELECT DISTINCT)
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (10, 3, 300, 2);
-- Document 20 has 2 distinct employees
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (20, 2, 200, 1);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (20, 2, 200, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id, n_distinct AS count_distinct_employee_id_ FROM (SELECT document_id, draft_number, COUNT(DISTINCT employee_id) AS n_distinct FROM circulation_history GROUP BY document_id, draft_number) ORDER BY document_id, count_distinct_employee_id_ NULLS LAST;

/*
Gold Result:
(10, 1)
(10, 1)
(10, 3)
(20, 2)
*/

-- Prediction Query
SELECT document_id, COUNT(DISTINCT employee_id) FROM Circulation_History GROUP BY document_id;

/*
Prediction Result:
(10, 3)
(20, 2)
*/