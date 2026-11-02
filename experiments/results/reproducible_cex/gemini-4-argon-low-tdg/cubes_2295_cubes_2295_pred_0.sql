-- Schema DDL
CREATE TABLE "Ref_Document_Types" ("Document_Type_Code" TEXT(15) PRIMARY KEY, "Document_Type_Name" TEXT(255), "Document_Type_Description" TEXT(255));

CREATE TABLE "Ref_Budget_Codes" ("Budget_Type_Code" TEXT(15) PRIMARY KEY, "Budget_Type_Description" TEXT(255));

CREATE TABLE "Projects" ("Project_ID" INTEGER PRIMARY KEY, "Project_Details" TEXT(255));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Project_ID" INTEGER, "Document_Type_Code" TEXT(15), "Document_Date" DATETIME, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Project_ID") REFERENCES "Projects" ("Project_ID"), FOREIGN KEY ("Document_Type_Code") REFERENCES "Ref_Document_Types" ("Document_Type_Code"));

CREATE TABLE "Statements" ("Statement_ID" INTEGER PRIMARY KEY, "Statement_Details" TEXT(255), FOREIGN KEY ("Statement_ID") REFERENCES "Documents" ("Document_ID"));

CREATE TABLE "Documents_with_Expenses" ("Document_ID" INTEGER PRIMARY KEY, "Budget_Type_Code" TEXT(15), "Document_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"), FOREIGN KEY ("Budget_Type_Code") REFERENCES "Ref_Budget_Codes" ("Budget_Type_Code"));

CREATE TABLE "Accounts" ("Account_ID" INTEGER PRIMARY KEY, "Statement_ID" INTEGER, "Account_Details" TEXT(255), FOREIGN KEY ("Statement_ID") REFERENCES "Statements" ("Statement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Beta');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C1', NULL, 'Type Desc Z');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C2', 'Alpha', NULL);
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C3', 'Alpha', 'Desc A');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C4', 'Alpha', 'Desc B');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C5', 'Beta', 'Desc A');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 1, 'C1', '2023-01-10', 'Doc 1', 'Different Doc Desc 1', 'O1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 1, 'C2', '2023-01-05', 'Doc 2', 'Different Doc Desc 2', 'O2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (3, 1, 'C3', NULL, 'Doc 3', 'Different Doc Desc 3', 'O3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (4, 1, 'C3', '2023-01-02', 'Doc 4', 'Different Doc Desc 4', 'O4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (5, 1, 'C3', '2023-01-01', 'Doc 5', 'Different Doc Desc 5', 'O5');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (6, 1, 'C4', '2022-12-31', 'Doc 6', 'Different Doc Desc 6', 'O6');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (7, 1, 'C5', '2020-01-01', 'Doc 7', 'Different Doc Desc 7', 'O7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_name, document_type_description, document_date FROM (SELECT LHS.document_type_code AS document_type_code, LHS.document_type_name AS document_type_name, LHS.document_type_description AS document_type_description, RHS.document_id AS document_id, RHS.project_id AS project_id, RHS.document_date AS document_date, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM ref_document_types AS LHS INNER JOIN documents AS RHS ON (LHS.document_type_code = RHS.document_type_code)) ORDER BY document_type_name, document_type_description NULLS LAST, document_date NULLS LAST;

/*
Gold Result:
(None, 'Type Desc Z', '2023-01-10')
('Alpha', 'Desc A', '2023-01-01')
('Alpha', 'Desc A', '2023-01-02')
('Alpha', 'Desc A', None)
('Alpha', 'Desc B', '2022-12-31')
('Alpha', None, '2023-01-05')
('Beta', 'Desc A', '2020-01-01')
*/

-- Prediction Query
SELECT T1.document_type_name, T1.document_type_description, T2.Document_date FROM Ref_document_types AS T1 JOIN Documents AS T2 ON T1.document_type_code = T2.document_type_code;

/*
Prediction Result:
(None, 'Type Desc Z', '2023-01-10')
('Alpha', None, '2023-01-05')
('Alpha', 'Desc A', None)
('Alpha', 'Desc A', '2023-01-02')
('Alpha', 'Desc A', '2023-01-01')
('Alpha', 'Desc B', '2022-12-31')
('Beta', 'Desc A', '2020-01-01')
*/