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
INSERT INTO Addresses (address_id, address_details) VALUES (1, '200 Beta Rd');
INSERT INTO Addresses (address_id, address_details) VALUES (2, '100 Alpha St');
INSERT INTO Addresses (address_id, address_details) VALUES (3, '100 Alpha St');
INSERT INTO Addresses (address_id, address_details) VALUES (4, '300 Gamma Ave');
INSERT INTO Documents (document_id) VALUES (3);
INSERT INTO Documents (document_id) VALUES (4);
INSERT INTO Documents (document_id) VALUES (5);
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (4, 1, '2023-01-01');
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (4, 2, '2023-01-02');
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (4, 3, '2023-01-03');
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (3, 4, '2023-01-04');
INSERT INTO Documents_Mailed (document_id, mailed_to_address_id, mailing_date) VALUES (5, 4, '2023-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address_details FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, RHS.document_id AS document_id, RHS.mailing_date AS mailing_date FROM addresses AS LHS INNER JOIN (SELECT * FROM documents_mailed WHERE (document_id = 4)) AS RHS ON (LHS.address_id = RHS.mailed_to_address_id)) ORDER BY address_details;

/*
Gold Result:
('100 Alpha St',)
('100 Alpha St',)
('200 Beta Rd',)
*/

-- Prediction Query
SELECT Addresses.address_details FROM Addresses JOIN Documents_Mailed ON Documents_Mailed.mailed_to_address_id = Addresses.address_id WHERE document_id = 4;

/*
Prediction Result:
('200 Beta Rd',)
('100 Alpha St',)
('100 Alpha St',)
*/