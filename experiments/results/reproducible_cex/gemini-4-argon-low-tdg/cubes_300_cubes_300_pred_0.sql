-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('BK', 'Book');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('PP', 'Paper');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'BK', 1, '2020-01-01', '2021-01-01', 'Details 1');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (2, 'PP', 1, '2020-01-01', '2021-01-01', 'Details 2');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (3, 'BK', 2, '2020-01-01', '2021-01-01', 'Details 3');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (10, 1, 'Zeta', 'Desc Z', 'Other');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (11, 2, 'Beta', 'Desc B', 'Other');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (12, 1, 'Alpha', 'Desc A1', 'Other');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (13, 3, 'Alpha', 'Desc A2', 'Other');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_name" FROM (SELECT * FROM "documents" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "templates" WHERE ("template_type_code" <> 'BK')) AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY document_name, "document_name" NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.document_name FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id WHERE T1.template_type_code = 'BK';

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Alpha',)
*/