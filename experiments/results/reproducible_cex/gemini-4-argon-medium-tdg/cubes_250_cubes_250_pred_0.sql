-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY version_number, template_id and SELECT DISTINCT mutations
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('AD', 'Advertisement');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('CV', 'CV');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('PR', 'Presentation');
-- Duplicate (version_number, template_type_code) to kill DISTINCT mutants
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (30, 'AD', 7, '2020-01-01', '2021-01-01', 'Dup 1');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (10, 'AD', 7, '2020-01-01', '2021-01-01', 'Dup 2');
-- Same version_number, different template_type_code where template_id order conflicts with template_type_code alphabetical order
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (20, 'PR', 8, '2020-01-01', '2021-01-01', 'Tie breaker 1');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (40, 'CV', 8, '2020-01-01', '2021-01-01', 'Tie breaker 2');
-- Out of order version_number to test primary sort
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (5, 'CV', 6, '2020-01-01', '2021-01-01', 'Smallest valid version');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT version_number, template_type_code FROM templates WHERE (version_number > 5) ORDER BY version_number, templates.template_id NULLS LAST;

/*
Gold Result:
(6, 'CV')
(7, 'AD')
(7, 'AD')
(8, 'PR')
(8, 'CV')
*/

-- Prediction Query
SELECT version_number, template_type_code FROM Templates WHERE version_number > 5;

/*
Prediction Result:
(6, 'CV')
(7, 'AD')
(8, 'PR')
(7, 'AD')
(8, 'CV')
*/