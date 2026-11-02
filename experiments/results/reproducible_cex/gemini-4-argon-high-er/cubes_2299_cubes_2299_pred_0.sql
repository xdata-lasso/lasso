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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('A', 'Type A', 'Desc A');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('B', 'Type B', 'Desc B');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project 1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Other_Details) VALUES (1, 1, 'A', 'x');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Other_Details) VALUES (2, 1, 'A', 'y');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Other_Details) VALUES (3, 1, 'A', 'z');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Other_Details) VALUES (4, 1, 'B', 'x');
INSERT INTO Documents (Document_ID, Project_ID, Document_Type_Code, Other_Details) VALUES (5, 1, 'B', 'x');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT document_type_code, other_details, COUNT(*) AS n FROM documents GROUP BY document_type_code, other_details) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
('B',)
*/

-- Prediction Query
SELECT document_type_code FROM Documents GROUP BY document_type_code ORDER BY COUNT(*) DESC, document_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('A',)
*/