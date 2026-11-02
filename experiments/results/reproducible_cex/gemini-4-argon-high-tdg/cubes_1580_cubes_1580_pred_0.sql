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
INSERT INTO Roles (role_code, role_description) VALUES ('R_C', 'Alpha');
INSERT INTO Roles (role_code, role_description) VALUES ('R_B', 'Alpha');
INSERT INTO Roles (role_code, role_description) VALUES ('R_A', 'Beta');
INSERT INTO Roles (role_code, role_description) VALUES ('R_EMPTY', 'AAA_Unused');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (1, 'R_C', 'Emp 1', 'Detail 1');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (2, 'R_B', 'Emp 2', 'Detail 2');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (3, 'R_B', 'Emp 3', 'Detail 3');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (4, 'R_B', 'Emp 4', 'Detail 4');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (5, 'R_A', 'Emp 5', 'Detail 5');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (6, 'R_A', 'Emp 6', 'Detail 6');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (7, NULL, 'Unassigned Emp', 'No Role');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT role_description, role_code, n AS count___ FROM (SELECT LHS.role_code AS role_code, LHS.role_description AS role_description, LHS.employee_id AS employee_id, LHS.employee_name AS employee_name, LHS.other_details AS other_details, RHS.n AS n FROM (SELECT LHS.role_code AS role_code, LHS.role_description AS role_description, RHS.employee_id AS employee_id, RHS.employee_name AS employee_name, RHS.other_details AS other_details FROM roles AS LHS INNER JOIN employees AS RHS ON (LHS.role_code = RHS.role_code)) AS LHS INNER JOIN (SELECT role_code, COUNT(*) AS n FROM employees GROUP BY role_code) AS RHS ON (LHS.role_code = RHS.role_code)) ORDER BY role_description, role_code NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 'R_B', 3)
('Alpha', 'R_C', 1)
('Beta', 'R_A', 2)
*/

-- Prediction Query
SELECT T1.role_description, T2.role_code, COUNT(*) FROM ROLES AS T1 JOIN Employees AS T2 ON T1.role_code = T2.role_code GROUP BY T2.role_code;

/*
Prediction Result:
('Beta', 'R_A', 2)
('Alpha', 'R_B', 3)
('Alpha', 'R_C', 1)
*/