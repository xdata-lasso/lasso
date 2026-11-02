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
-- Tests GROUP BY attributes (project_id AND document_description), boundary conditions on n >= 2 (n=0, n=1, n=2, n=3), and duplicate output rows when a single project has multiple document_descriptions with >= 2 documents.
INSERT INTO Projects (Project_ID, Project_Details) VALUES (1, 'Project Zero Docs');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (2, 'Project Diff Descs');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (3, 'Project Boundary Two');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (4, 'Project Multi Groups');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (5, 'Project Shared Desc');
INSERT INTO Projects (Project_ID, Project_Details) VALUES (6, 'Project Shared Desc Two');
-- Project 2: 2 documents, but different descriptions (n=1 for each). Should NOT be returned unless mutant forgets to group by document_description.
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (201, 2, 'NameSame', 'Desc_A');
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (202, 2, 'NameSame', 'Desc_B');
-- Project 3: 2 documents with exact same description (n=2). Boundary condition test for n >= 2 vs n > 2.
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (301, 3, 'Name1', 'Desc_C');
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (302, 3, 'Name2', 'Desc_C');
-- Project 4: Two separate description groups that both meet n >= 2 (one has n=2, one has n=3). Tests SELECT vs SELECT DISTINCT.
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (401, 4, 'N1', 'Desc_D1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (402, 4, 'N2', 'Desc_D1');
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (403, 4, 'N3', 'Desc_D2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (404, 4, 'N4', 'Desc_D2');
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (405, 4, 'N5', 'Desc_D2');
-- Projects 5 and 6: Share the exact same document_description ('Desc_Shared'), 1 doc each. Tests if mutant forgets to group by project_id.
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (501, 5, 'N6', 'Desc_Shared');
INSERT INTO Documents (Document_ID, Project_ID, Document_Name, Document_Description) VALUES (601, 6, 'N7', 'Desc_Shared');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id, project_details FROM (SELECT LHS.project_id AS project_id, LHS.project_details AS project_details, RHS.document_description AS document_description, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT document_description, project_id, COUNT(*) AS n FROM documents GROUP BY document_description, project_id) AS RHS ON (LHS.project_id = RHS.project_id)) WHERE (n >= 2) ORDER BY project_id, project_details NULLS LAST;

/*
Gold Result:
(3, 'Project Boundary Two')
(4, 'Project Multi Groups')
(4, 'Project Multi Groups')
*/

-- Prediction Query
SELECT T1.project_id, T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id = T2.project_id GROUP BY T1.project_id HAVING COUNT(*) > 2;

/*
Prediction Result:
(4, 'Project Multi Groups')
*/