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
-- Tests basic join conditions (employee_id match AND n = document_id where n = 1), duplicate rows (SELECT vs SELECT DISTINCT), and ordering by employee_name and employee_id.
INSERT INTO Documents (document_id) VALUES (1);
INSERT INTO Documents (document_id) VALUES (2);
INSERT INTO Document_Drafts (document_id, draft_number) VALUES (1, 10);
INSERT INTO Document_Drafts (document_id, draft_number) VALUES (2, 20);
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (1, 10, 100);
INSERT INTO Draft_Copies (document_id, draft_number, copy_number) VALUES (2, 20, 200);
INSERT INTO Employees (employee_id, employee_name) VALUES (1, 'Bob');
INSERT INTO Employees (employee_id, employee_name) VALUES (2, 'Alice');
INSERT INTO Employees (employee_id, employee_name) VALUES (3, 'Alice');
INSERT INTO Employees (employee_id, employee_name) VALUES (4, 'Charlie');
INSERT INTO Employees (employee_id, employee_name) VALUES (5, 'David');
-- Employee 1 ('Bob'): matches document_id = 1
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (1, 10, 100, 1);
-- Employee 2 ('Alice'): matches document_id = 1 AND has a non-matching record for document_id = 2
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (1, 10, 100, 2);
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (2, 20, 200, 2);
-- Employee 3 ('Alice'): matches document_id = 1 across multiple draft/copy combinations (tests duplicate output rows & tie-breaking order)
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (1, 10, 100, 3);
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (1, 20, 200, 3);
-- Employee 4 ('Charlie'): only has document_id = 2 (should be filtered out since n = 1 != 2)
INSERT INTO Circulation_History (document_id, draft_number, copy_number, employee_id) VALUES (2, 20, 200, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_name, employee_id AS count___ FROM (SELECT LHS.employee_id AS employee_id, LHS.employee_name AS employee_name, LHS.n AS n, RHS.draft_number AS draft_number, RHS.copy_number AS copy_number FROM (SELECT employee_id, employee_name, COUNT(*) AS n FROM employees GROUP BY employee_id, employee_name) AS LHS INNER JOIN circulation_history AS RHS ON (LHS.employee_id = RHS.employee_id AND LHS.n = RHS.document_id)) ORDER BY employee_name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 2)
('Alice', 3)
('Alice', 3)
('Bob', 1)
*/

-- Prediction Query
SELECT Employees.employee_name, COUNT(*) FROM Employees JOIN Circulation_History ON Circulation_History.employee_id = Employees.employee_id GROUP BY Circulation_History.document_id, Circulation_History.draft_number, Circulation_History.copy_number ORDER BY COUNT(*) DESC, Employees.employee_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bob', 3)
*/