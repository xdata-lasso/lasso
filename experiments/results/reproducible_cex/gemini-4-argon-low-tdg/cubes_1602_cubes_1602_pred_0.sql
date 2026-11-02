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
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('T1', 'Type 1');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('S1', 'Status 1');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('A1', 'Agent 1', 'Desc 1');
INSERT INTO "Roles" ("role_code", "role_description") VALUES ('R1', 'Role 1');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (1, 'R1', 'CopyMatchedEmp', 'D1');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (2, 'R1', 'ZebraHistoryEmp', 'D2');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (3, 'R1', 'AlphaHistoryEmp', 'D3');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (4, 'R1', 'UnreferencedEmp', 'D4');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (10, 'A1', 'S1', 'T1', '2023-01-01', 'R10', 'O10');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (20, 'A1', 'S1', 'T1', '2023-01-02', 'R20', 'O20');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (10, 100, 'Draft 100');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (20, 200, 'Draft 200');
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (10, 100, 1);
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (20, 200, 999);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (10, 100, 1, 2);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (10, 100, 1, 3);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (20, 200, 999, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_name_other AS employee_name FROM (SELECT LHS.employee_id AS employee_id, LHS.role_code AS role_code, LHS.employee_name AS employee_name, LHS.other_details AS other_details, RHS.document_id AS document_id, RHS.draft_number AS draft_number, RHS.employee_id AS employee_id_other, RHS.role_code AS role_code_other, RHS.employee_name AS employee_name_other, RHS.other_details AS other_details_other FROM employees AS LHS INNER JOIN (SELECT LHS.document_id AS document_id, LHS.draft_number AS draft_number, LHS.copy_number AS copy_number, LHS.employee_id AS employee_id, RHS.role_code AS role_code, RHS.employee_name AS employee_name, RHS.other_details AS other_details FROM circulation_history AS LHS INNER JOIN employees AS RHS ON (LHS.employee_id = RHS.employee_id)) AS RHS ON (LHS.employee_id = RHS.copy_number)) ORDER BY employee_name;

/*
Gold Result:
('AlphaHistoryEmp',)
('ZebraHistoryEmp',)
*/

-- Prediction Query
SELECT Employees.employee_name FROM Employees JOIN Circulation_History ON Circulation_History.employee_id = Employees.employee_id WHERE Circulation_History.document_id = 1;

/*
Prediction Result:
*/