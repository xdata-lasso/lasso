-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate template_type_code in Templates)
-- 2. Querying Ref_Template_Types instead of Templates (unreferenced 'UNREF_CODE' in Ref_Template_Types)
-- 3. Missing ORDER BY or DESC ordering (inserted out of alphabetical order: 'Z_TYPE' then 'A_TYPE')
-- 4. Unnecessary INNER JOIN with Documents (Template 3 has no matching Document)
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('Z_TYPE', 'Z Description');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('A_TYPE', 'A Description');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('UNREF_CODE', 'Unreferenced Description');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'Z_TYPE', 2, '2023-01-01', '2023-12-31', 'Details Z1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'Z_TYPE', 1, '2022-01-01', '2022-12-31', 'Details Z2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'A_TYPE', 5, '2020-01-01', '2025-12-31', 'Details A1');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (10, 1, 'Doc Z', 'Desc Z', 'Other Z');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (100, 10, 'Para Z', 'Other Para Z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_code FROM templates ORDER BY template_type_code;

/*
Gold Result:
('A_TYPE',)
('Z_TYPE',)
*/

-- Prediction Query
SELECT DISTINCT template_type_code FROM Templates;

/*
Prediction Result:
('Z_TYPE',)
('A_TYPE',)
*/