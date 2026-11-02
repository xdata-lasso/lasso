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
-- Tests multi-column ORDER BY precedence, ASC vs DESC, and NULLS FIRST vs NULLS LAST across all three sort keys.
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C1', NULL, 'Null Name Desc');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C2', 'Alpha', 'Desc A');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C3', 'Alpha', 'Desc B');
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C4', 'Alpha', NULL);
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('C5', 'Beta', 'Desc A');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (1, NULL, 'C1', '2023-05-01', 'D1', 'DD1', 'O1');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (2, NULL, 'C2', '2023-05-02', 'D2', 'DD2', 'O2');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (3, NULL, 'C2', '2023-05-01', 'D3', 'DD3', 'O3');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (4, NULL, 'C2', NULL, 'D4', 'DD4', 'O4');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (5, NULL, 'C3', '2023-01-01', 'D5', 'DD5', 'O5');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (6, NULL, 'C4', '2023-01-01', 'D6', 'DD6', 'O6');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (7, NULL, 'C5', '2022-01-01', 'D7', 'DD7', 'O7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_name, document_type_description, document_date FROM (SELECT LHS.document_type_code AS document_type_code, LHS.document_type_name AS document_type_name, LHS.document_type_description AS document_type_description, RHS.document_id AS document_id, RHS.project_id AS project_id, RHS.document_date AS document_date, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM ref_document_types AS LHS INNER JOIN documents AS RHS ON (LHS.document_type_code = RHS.document_type_code)) ORDER BY document_type_name, document_type_description NULLS LAST, document_date NULLS LAST;

/*
Gold Result:
(None, 'Null Name Desc', '2023-05-01')
('Alpha', 'Desc A', '2023-05-01')
('Alpha', 'Desc A', '2023-05-02')
('Alpha', 'Desc A', None)
('Alpha', 'Desc B', '2023-01-01')
('Alpha', None, '2023-01-01')
('Beta', 'Desc A', '2022-01-01')
*/

-- Prediction Query
SELECT T1.document_type_name, T1.document_type_description, T2.Document_date FROM Ref_document_types AS T1 JOIN Documents AS T2 ON T1.document_type_code = T2.document_type_code;

/*
Prediction Result:
(None, 'Null Name Desc', '2023-05-01')
('Alpha', 'Desc A', '2023-05-02')
('Alpha', 'Desc A', '2023-05-01')
('Alpha', 'Desc A', None)
('Alpha', 'Desc B', '2023-01-01')
('Alpha', None, '2023-01-01')
('Beta', 'Desc A', '2022-01-01')
*/