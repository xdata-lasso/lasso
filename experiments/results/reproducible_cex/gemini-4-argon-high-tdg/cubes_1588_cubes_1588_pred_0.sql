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
INSERT INTO Ref_Document_Types (document_type_code, document_type_description) VALUES ('DOC_T1', 'Contract');
INSERT INTO Ref_Document_Status (document_status_code, document_status_description) VALUES ('STAT_1', 'Active');
INSERT INTO Ref_Shipping_Agents (shipping_agent_code, shipping_agent_name, shipping_agent_description) VALUES ('AG_1', 'FastShip', 'Express Courier');
INSERT INTO Addresses (address_id, address_details) VALUES (4, '404 Distractor Blvd');
INSERT INTO Addresses (address_id, address_details) VALUES (6, '600 Unmailed Ln');
INSERT INTO Addresses (address_id, address_details) VALUES (10, 'Zebra Way');
INSERT INTO Addresses (address_id, address_details) VALUES (20, 'Alpha Rd');
INSERT INTO Addresses (address_id, address_details) VALUES (30, 'Middle St');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (3, 'AG_1', 'STAT_1', 'DOC_T1', '2023-01-01', 'R-003', 'Doc 3');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (4, 'AG_1', 'STAT_1', 'DOC_T1', '2023-01-02', 'R-004', 'Doc 4');
INSERT INTO Documents (document_id, shipping_agent_code, document_status_code, document_type_code, receipt_date, receipt_number, other_details) VALUES (5, 'AG_1', 'STAT_1', 'DOC_T1', '2023-01-03', 'R-005', 'Doc 5');
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (3, 4, '2023-01-05');
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (5, 4, '2023-01-06');
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (4, 10, '2023-02-02');
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (4, 20, '2023-02-03');
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (4, 30, '2023-02-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address_details FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, RHS.document_id AS document_id, RHS.mailing_date AS mailing_date FROM addresses AS LHS INNER JOIN (SELECT * FROM documents_mailed WHERE (document_id = 4)) AS RHS ON (LHS.address_id = RHS.mailed_to_address_id)) ORDER BY address_details;

/*
Gold Result:
('Alpha Rd',)
('Middle St',)
('Zebra Way',)
*/

-- Prediction Query
SELECT Addresses.address_details FROM Addresses JOIN Documents_Mailed ON Documents_Mailed.mailed_to_address_id = Addresses.address_id WHERE document_id = 4;

/*
Prediction Result:
('Zebra Way',)
('Alpha Rd',)
('Middle St',)
*/