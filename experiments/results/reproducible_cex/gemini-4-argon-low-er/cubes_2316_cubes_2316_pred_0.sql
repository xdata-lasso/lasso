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
INSERT INTO "Projects" ("Project_ID", "Project_Details") VALUES (1, 'Project Alpha');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Description") VALUES (1, 1, 'Same Description');
INSERT INTO "Documents" ("Document_ID", "Project_ID", "Document_Description") VALUES (2, 1, 'Same Description');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id, project_details FROM (SELECT LHS.project_id AS project_id, LHS.project_details AS project_details, RHS.document_description AS document_description, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT document_description, project_id, COUNT(*) AS n FROM documents GROUP BY document_description, project_id) AS RHS ON (LHS.project_id = RHS.project_id)) WHERE (n >= 2) ORDER BY project_id, project_details NULLS LAST;

/*
Gold Result:
(1, 'Project Alpha')
*/

-- Prediction Query
SELECT T1.project_id, T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id = T2.project_id GROUP BY T1.project_id HAVING COUNT(*) > 2;

/*
Prediction Result:
*/