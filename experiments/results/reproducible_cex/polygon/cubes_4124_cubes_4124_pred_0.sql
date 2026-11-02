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
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('22', '1');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_description") VALUES ('21', '1');
INSERT INTO "Roles" ("role_code", "role_description") VALUES ('24', '1');
INSERT INTO "Roles" ("role_code", "role_description") VALUES ('23', '1');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (26, '1');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (25, '1');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('28', '1');
INSERT INTO "Ref_Document_Status" ("document_status_code", "document_status_description") VALUES ('27', '1');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('30', '1', '1');
INSERT INTO "Ref_Shipping_Agents" ("shipping_agent_code", "shipping_agent_name", "shipping_agent_description") VALUES ('29', '1', '1');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (1, '29', '27', '21', 1, '1', '1');
INSERT INTO "Documents" ("document_id", "shipping_agent_code", "document_status_code", "document_type_code", "receipt_date", "receipt_number", "other_details") VALUES (31, '29', '27', '21', 1, '1', '1');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (33, NULL, '38', NULL);
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "other_details") VALUES (32, NULL, '37', '1');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (31, 19, '1');
INSERT INTO "Document_Drafts" ("document_id", "draft_number", "draft_details") VALUES (1, 35, '1');
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (31, 19, 20);
INSERT INTO "Draft_Copies" ("document_id", "draft_number", "copy_number") VALUES (1, 35, 36);
INSERT INTO "Circulation_History" ("document_id", "draft_number", "copy_number", "employee_id") VALUES (1, 35, 36, 33);
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (31, 25, 1);
INSERT INTO "Documents_Mailed" ("document_id", "mailed_to_address_id", "mailing_date") VALUES (31, 26, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_name, employee_id AS count___ FROM (SELECT LHS.employee_id AS employee_id, LHS.employee_name AS employee_name, LHS.maxn AS maxn, RHS.draft_number AS draft_number, RHS.copy_number AS copy_number FROM (SELECT employee_id, employee_name, MAX(n) AS maxn FROM (SELECT employee_id, employee_name, COUNT(*) AS n FROM employees GROUP BY employee_id, employee_name) GROUP BY employee_id, employee_name) AS LHS INNER JOIN circulation_history AS RHS ON (LHS.employee_id = RHS.employee_id AND LHS.maxn = RHS.document_id)) ORDER BY employee_name, count___ NULLS LAST;

/*
Gold Result:
('38', 33)
*/

-- Prediction Query
SELECT Employees.employee_name, COUNT(*) FROM Employees JOIN Circulation_History ON Circulation_History.employee_id = Employees.employee_id GROUP BY Circulation_History.document_id, Circulation_History.draft_number, Circulation_History.copy_number ORDER BY COUNT(*) DESC, Employees.employee_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('38', 1)
*/