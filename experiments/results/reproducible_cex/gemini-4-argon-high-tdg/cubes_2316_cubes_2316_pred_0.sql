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
-- DATASET 1
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('T1', 'Type One', 'First Type');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('T2', 'Type Two', 'Second Type');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (30, 'Alpha');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (10, 'Beta');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (20, 'Gamma');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (40, 'Delta');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (1, 30, 'T1', '2023-01-01', 'Doc A1', 'Spec', 'Detail 1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (2, 30, 'T2', '2023-01-02', 'Doc A2', 'Spec', 'Detail 2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (3, 10, 'T1', '2023-02-01', 'Doc B1', 'Report', 'Detail 3');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (4, 10, 'T1', '2023-02-02', 'Doc B2', 'Report', 'Detail 4');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (5, 10, 'T2', '2023-02-03', 'Doc B3', 'Report', 'Detail 5');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (6, 20, 'T1', '2023-03-01', 'SameName', 'UniqueDesc1', 'SameDetail');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Document_Date, Document_Name, Document_Description, Other_Details) VALUES (7, 20, 'T1', '2023-03-01', 'SameName', 'UniqueDesc2', 'SameDetail');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id, project_details FROM (SELECT LHS.project_id AS project_id, LHS.project_details AS project_details, RHS.document_description AS document_description, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT document_description, project_id, COUNT(*) AS n FROM documents GROUP BY document_description, project_id) AS RHS ON (LHS.project_id = RHS.project_id)) WHERE (n >= 2) ORDER BY project_id, project_details NULLS LAST;

/*
Gold Result:
(10, 'Beta')
(30, 'Alpha')
*/

-- Prediction Query
SELECT T1.project_id, T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id = T2.project_id GROUP BY T1.project_id HAVING COUNT(*) > 2;

/*
Prediction Result:
(10, 'Beta')
*/