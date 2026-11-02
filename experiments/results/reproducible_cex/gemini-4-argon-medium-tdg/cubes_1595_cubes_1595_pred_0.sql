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
-- General case: Mix of employees with and without circulation history, duplicates in employee_name, and ordering inverse to employee_id.
INSERT INTO Roles (role_code, role_description) VALUES ('R1', 'Manager');
INSERT INTO Roles (role_code, role_description) VALUES ('R2', 'Clerk');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (1, 'R1', 'Zack', 'No history');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (2, 'R2', 'Alice', 'Has history');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (3, 'R1', 'Bob', 'No history 1');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (4, NULL, 'Bob', 'No history 2 - duplicate name & NULL role');
INSERT INTO Employees (employee_id, role_code, employee_name, other_details) VALUES (5, 'R2', 'Charlie', 'Has multiple history entries');
INSERT INTO Ref_Document_Types (document_type_code, document_type_description) VALUES ('DT1', 'Contract');
INSERT INTO Ref_Document_Status (document_status_code, document_status_description) VALUES ('DS1', 'Active');
INSERT INTO Ref_Shipping_Agents (shipping_agent_code, shipping_agent_name, shipping_agent_description) VALUES ('SA1', 'FedEx', 'Courier');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (10, 'SA1', 'DS1', 'DT1', '2023-01-01', 'R100', 'Doc 10');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (20, 'SA1', 'DS1', 'DT1', '2023-01-02', 'R200', 'Doc 20');
INSERT INTO Document_Drafts (document_id, draft_number, draft_details) VALUES (10, 1, 'Draft 1');
INSERT INTO Document_Drafts (document_id, draft_number, draft_details) VALUES (20, 2, 'Draft 2');
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (10, 1, 1);
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (20, 2, 2);
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (10, 1, 1, 2);
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (10, 1, 1, 5);
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (20, 2, 2, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_name FROM (SELECT * FROM employees AS LHS WHERE NOT EXISTS(SELECT 1 FROM circulation_history AS RHS WHERE (LHS.employee_id = RHS.employee_id))) ORDER BY employee_name;

/*
Gold Result:
('Bob',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT employee_name FROM Employees EXCEPT SELECT Employees.employee_name FROM Employees JOIN Circulation_History ON Circulation_History.employee_id = Employees.employee_id;

/*
Prediction Result:
('Bob',)
('Zack',)
*/