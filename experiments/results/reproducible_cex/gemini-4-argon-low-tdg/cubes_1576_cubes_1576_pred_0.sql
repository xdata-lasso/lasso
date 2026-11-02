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
-- 1. COUNT(DISTINCT employee_id) vs COUNT(employee_id) vs COUNT(*)
-- 2. GROUP BY (document_id, draft_number) vs GROUP BY document_id alone or GROUP BY (document_id, draft_number, copy_number)
-- 3. Outer query retaining duplicate (document_id, count_distinct_employee_id_) rows across different drafts (SELECT vs SELECT DISTINCT)
-- 4. Ordering by document_id ASC, count_distinct_employee_id_ ASC (with draft_number inversely ordered to count to catch ORDER BY draft_number mutants)
-- 5. Unreferenced parent rows in Documents, Document_Drafts, Draft_Copies, and Employees to catch INNER/LEFT JOIN mutants
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T1', 'Type 1');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('S1', 'Status 1');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('A1', 'Agent 1', 'Desc 1');
INSERT INTO "Roles" ("role_code", "role_description") VALUES ('R1', 'Role 1');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (1, 'R1', 'Emp 1', 'D1');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (2, 'R1', 'Emp 2', 'D2');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (3, 'R1', 'Emp 3', 'D3');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (99, 'R1', 'Unused Emp', 'D99');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1, 'A1', 'S1', 'T1', '2023-01-01', 'R1', 'Doc 1');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (2, 'A1', 'S1', 'T1', '2023-01-02', 'R2', 'Doc 2');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (3, 'A1', 'S1', 'T1', '2023-01-03', 'R3', 'Doc 3');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (4, 'A1', 'S1', 'T1', '2023-01-04', 'R4', 'Unused Doc');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (10, 'A1', 'S1', 'T1', '2023-01-10', 'R10', 'Doc 10');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (20, 'A1', 'S1', 'T1', '2023-01-20', 'R20', 'Doc 20');
-- Note: Document_Drafts has UNIQUE on document_id and UNIQUE on draft_number in DDL
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (1, 10, 'Draft 10');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (2, 20, 'Draft 20');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (3, 30, 'Draft 30');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (4, 40, 'Unused Draft');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (10, 100, 'Draft 100');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (20, 200, 'Draft 200');
-- Note: Draft_Copies has UNIQUE on document_id, UNIQUE on draft_number, and UNIQUE on copy_number in DDL
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (1, 10, 101);
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (2, 20, 102);
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (3, 30, 103);
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (4, 40, 104);
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (10, 100, 110);
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (20, 200, 120);
-- Circulation_History FKs reference Draft_Copies(document_id), Draft_Copies(draft_number), Draft_Copies(copy_number) individually!
-- This allows combining (document_id=1, draft_number=10) with different copy_numbers (101, 102) and (document_id=1, draft_number=20) with copy_number 101.
-- Group (doc=1, draft=10): employee 1 appears across copy 101 and copy 102, plus employee 2 and 3 -> 3 distinct employees, 4 total rows
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 10, 101, 1);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 10, 102, 1);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 10, 101, 2);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 10, 101, 3);
-- Group (doc=1, draft=20): higher draft_number (20 > 10), but smaller distinct employee count (1 < 3) to test ORDER BY count_distinct_employee_id_
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 20, 101, 1);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 20, 102, 1);
-- Group (doc=1, draft=30): same distinct employee count (1) as (doc=1, draft=20) to ensure duplicate (document_id, count) pairs are preserved (kills SELECT DISTINCT)
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 30, 103, 2);
-- Group (doc=2, draft=20): 2 distinct employees
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (2, 20, 102, 1);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (2, 20, 102, 2);
-- Group (doc=3, draft=30): 1 distinct employee (emp 3)
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (3, 30, 103, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id, n_distinct AS count_distinct_employee_id_ FROM (SELECT document_id, draft_number, COUNT(DISTINCT employee_id) AS n_distinct FROM circulation_history GROUP BY document_id, draft_number) ORDER BY document_id, count_distinct_employee_id_ NULLS LAST;

/*
Gold Result:
(1, 1)
(1, 1)
(1, 3)
(2, 2)
(3, 1)
*/

-- Prediction Query
SELECT document_id, COUNT(DISTINCT employee_id) FROM Circulation_History GROUP BY document_id;

/*
Prediction Result:
(1, 3)
(2, 2)
(3, 1)
*/