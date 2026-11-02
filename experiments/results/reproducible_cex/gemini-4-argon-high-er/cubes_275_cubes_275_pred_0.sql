-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('B', 'Type B');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('A', 'Type A');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'B', 1, '2020-01-01', '2021-01-01', 'Details 1');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (2, 'A', 1, '2020-01-01', '2021-01-01', 'Details 2');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 1, 'Data base', 'Desc 1', 'Other 1');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 1, 'Data base', 'Desc 2', 'Other 2');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (3, 2, 'Data base', 'Desc 3', 'Other 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "template_type_code" FROM (SELECT * FROM "templates" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" = 'Data base')) AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY template_type_code, "template_type_code" NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id WHERE T2.document_name = 'Data base';

/*
Prediction Result:
('B',)
('B',)
('A',)
*/