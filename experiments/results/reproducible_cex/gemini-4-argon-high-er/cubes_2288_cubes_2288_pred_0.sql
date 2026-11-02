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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('BK', 'Book', 'Book');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project 1');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (2, 'Project 2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code) VALUES (1, 1, 'BK');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code) VALUES (2, 1, 'BK');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code) VALUES (3, 2, 'BK');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code) VALUES (4, NULL, 'BK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___", "project_id" FROM (SELECT "project_id", COUNT(*) AS "n" FROM (SELECT * FROM "documents" WHERE ("document_type_code" = 'BK')) GROUP BY project_id) ORDER BY count___, "project_id" NULLS LAST;

/*
Gold Result:
(1, 2)
(1, None)
(2, 1)
*/

-- Prediction Query
SELECT COUNT(*), project_id FROM Documents WHERE document_type_code = 'BK' GROUP BY project_id;

/*
Prediction Result:
(1, None)
(2, 1)
(1, 2)
*/