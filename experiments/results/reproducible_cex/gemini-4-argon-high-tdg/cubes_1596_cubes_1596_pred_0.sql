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
INSERT INTO Ref_Document_Types (document_type_code, document_type_description) VALUES ('T1', 'Contract');
INSERT INTO Ref_Document_Status (document_status_code, document_status_description) VALUES ('S1', 'Active');
INSERT INTO Ref_Shipping_Agents (shipping_agent_code, shipping_agent_name, shipping_agent_description) VALUES ('A1', 'FastShip', 'Express');
INSERT INTO Roles (role_code, role_description) VALUES ('R1', 'Manager');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (1, 'R1', 'Alice', 'HQ');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (-3, 'A1', 'S1', 'T1', '2023-01-01', 'R-3', 'D-3');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (-2, 'A1', 'S1', 'T1', '2023-01-02', 'R-2', 'D-2');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (-1, 'A1', 'S1', 'T1', '2023-01-03', 'R-1', 'D-1');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (0, 'A1', 'S1', 'T1', '2023-01-04', 'R0', 'D0');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (1, 'A1', 'S1', 'T1', '2023-01-05', 'R1', 'D1');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (2, 'A1', 'S1', 'T1', '2023-01-06', 'R2', 'D2');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (3, 'A1', 'S1', 'T1', '2023-01-07', 'R3', 'D3');
INSERT INTO Document_Drafts (document_id, draft_number, draft_details) VALUES (-3, 50, 'Draft only, no copy');
INSERT INTO Document_Drafts (document_id, draft_number, draft_details) VALUES (-2, 30, 'Draft -2');
INSERT INTO Document_Drafts (document_id, draft_number, draft_details) VALUES (-1, 10, 'Draft -1');
INSERT INTO Document_Drafts (document_id, draft_number, draft_details) VALUES (0, 40, 'Draft 0');
INSERT INTO Document_Drafts (document_id, draft_number, draft_details) VALUES (1, 20, 'Draft 1');
INSERT INTO Document_Drafts (document_id, draft_number, draft_details) VALUES (2, 5, 'Draft 2');
INSERT INTO Document_Drafts (document_id, draft_number, draft_details) VALUES (3, 15, 'Draft 3');
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (-2, 30, 400);
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (-1, 10, 300);
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (0, 40, 100);
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (1, 20, 200);
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (2, 5, 50);
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (3, 15, 60);
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (-1, 10, 300, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT draft_number AS count___ FROM (SELECT document_id, draft_number, COUNT(DISTINCT document_id) AS n_distinct FROM (SELECT * FROM draft_copies WHERE (document_id < 2)) GROUP BY document_id, draft_number) ORDER BY count___;

/*
Gold Result:
(10,)
(20,)
(30,)
(40,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Draft_Copies WHERE document_id = 2;

/*
Prediction Result:
(1,)
*/