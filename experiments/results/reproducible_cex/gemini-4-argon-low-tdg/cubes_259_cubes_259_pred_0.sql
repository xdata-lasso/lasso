-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive discrimination dataset:
-- Tests anti-join (NOT EXISTS vs EXISTS/JOIN), ORDER BY column & direction, LIMIT 1, and NULL handling in Documents.Template_ID (NOT IN vs NOT EXISTS).
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('TYPE_USED_NEW', 'Newest overall, but has a document');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('TYPE_UNUSED_MAX', 'Newest unused template (Expected Winner)');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('TYPE_UNUSED_OLD', 'Oldest unused template, highest ID/Version/DateTo');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('TYPE_UNUSED_NULL', 'Unused template with NULL effective date');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('TYPE_ORPHAN_REF', 'Unused in Templates table altogether');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'TYPE_USED_NEW', 1, '2025-01-01 00:00:00', '2026-01-01 00:00:00', 'Has documents');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (2, 'TYPE_UNUSED_MAX', 2, '2023-06-15 12:00:00', '2024-01-01 00:00:00', 'Target row');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (3, 'TYPE_UNUSED_OLD', 99, '2020-01-01 00:00:00', '2030-01-01 00:00:00', 'Older date_from, but max ID, Version, and date_to');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (4, 'TYPE_UNUSED_NULL', 50, NULL, '2029-01-01 00:00:00', 'NULL date_effective_from');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (101, 1, 'Doc 1', 'Links to Template 1', 'Details 1');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (102, 1, 'Doc 2', 'Second doc for Template 1', 'Details 2');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (103, NULL, 'Doc 3', 'Null Template_ID to break NOT IN mutants', 'Details 3');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (1001, 101, 'Paragraph for Doc 1', 'Other');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM templates AS LHS WHERE NOT EXISTS(SELECT 1 FROM documents AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY date_effective_from DESC) LIMIT 1);

/*
Gold Result:
('TYPE_UNUSED_MAX',)
*/

-- Prediction Query
SELECT template_type_code FROM Templates EXCEPT SELECT template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id;

/*
Prediction Result:
('TYPE_UNUSED_MAX',)
('TYPE_UNUSED_NULL',)
('TYPE_UNUSED_OLD',)
*/