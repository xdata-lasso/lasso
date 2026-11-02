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
INSERT INTO "Ref_Budget_Codes" ("Budget_Type_Code", "Budget_Type_Description") VALUES ('B_Z', 'Zebra Budget');
INSERT INTO "Ref_Budget_Codes" ("Budget_Type_Code", "Budget_Type_Description") VALUES ('B_A', 'Apple Budget');
INSERT INTO "Ref_Budget_Codes" ("Budget_Type_Code", "Budget_Type_Description") VALUES ('B_M', 'Mango Budget');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (1, NULL, NULL, '2023-05-01', 'D1', 'Desc1', NULL);
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (2, NULL, NULL, '2023-05-02', 'D2', 'Desc2', NULL);
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (3, NULL, NULL, '2023-05-03', 'D3', 'Desc3', NULL);
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Type_Code", "Document_Date", "Document_Name", "Document_Description", "Other_Details") VALUES (4, NULL, NULL, '2023-05-04', 'D4', 'Desc4', NULL);
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (1, 'B_Z', 'Detail A');
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (2, 'B_A', 'Detail B');
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (4, 'B_M', 'Detail C');
INSERT INTO "Documents_with_Expenses" ("Document_ID", "Budget_Type_Code", "Document_Details") VALUES (3, 'B_M', 'Detail C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_type_code, budget_type_description, document_id FROM (SELECT LHS.budget_type_code AS budget_type_code, LHS.budget_type_description AS budget_type_description, RHS.document_id AS document_id, RHS.document_details AS document_details FROM ref_budget_codes AS LHS INNER JOIN documents_with_expenses AS RHS ON (LHS.budget_type_code = RHS.budget_type_code)) ORDER BY budget_type_code, budget_type_description NULLS LAST, document_id NULLS LAST;

/*
Gold Result:
('B_A', 'Apple Budget', 2)
('B_M', 'Mango Budget', 3)
('B_M', 'Mango Budget', 4)
('B_Z', 'Zebra Budget', 1)
*/

-- Prediction Query
SELECT T2.budget_type_code, T2.budget_type_description, T1.document_id FROM Documents_with_expenses AS T1 JOIN Ref_budget_codes AS T2 ON T1.budget_type_code = T2.budget_type_code;

/*
Prediction Result:
('B_Z', 'Zebra Budget', 1)
('B_A', 'Apple Budget', 2)
('B_M', 'Mango Budget', 3)
('B_M', 'Mango Budget', 4)
*/