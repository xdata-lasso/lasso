-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests semi-join vs inner join (1 template with multiple 'Data base' documents)
-- Tests DISTINCT vs non-DISTINCT (2 different templates with the same Template_Type_Code)
-- Tests ORDER BY and NULLS LAST (multiple codes and NULL Template_Type_Code)
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('AD', 'Advertisement');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('BK', 'Book');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('CV', 'Curriculum Vitae');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'BK', 1, '2020-01-01', '2025-01-01', 'Detail 1');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (2, 'BK', 2, '2020-01-01', '2025-01-01', 'Detail 2');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (3, 'AD', 1, '2020-01-01', '2025-01-01', 'Detail 3');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (4, NULL, 1, '2020-01-01', '2025-01-01', 'Detail 4');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (5, 'CV', 1, '2020-01-01', '2025-01-01', 'Detail 5');
-- Template 1 has TWO 'Data base' documents (kills INNER JOIN without DISTINCT)
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (101, 1, 'Data base', 'Desc 1', 'Other 1');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (102, 1, 'Data base', 'Desc 2', 'Other 2');
-- Template 2 also has 'BK' and ONE 'Data base' document (kills SELECT DISTINCT template_type_code)
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (103, 2, 'Data base', 'Desc 3', 'Other 3');
-- Template 3 has 'AD' and ONE 'Data base' document (tests ordering: 'AD' before 'BK')
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (104, 3, 'Data base', 'Desc 4', 'Other 4');
-- Template 4 has NULL Template_Type_Code and ONE 'Data base' document (tests NULLS LAST)
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (105, 4, 'Data base', 'Desc 5', 'Other 5');
-- Template 5 has a non-matching document (tests WHERE predicate)
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (106, 5, 'Other Doc', 'Desc 6', 'Other 6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "template_type_code" FROM (SELECT * FROM "templates" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" = 'Data base')) AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY template_type_code, "template_type_code" NULLS LAST;

/*
Gold Result:
(None,)
('AD',)
('BK',)
('BK',)
*/

-- Prediction Query
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id WHERE T2.document_name = 'Data base';

/*
Prediction Result:
('BK',)
('BK',)
('BK',)
('AD',)
(None,)
*/