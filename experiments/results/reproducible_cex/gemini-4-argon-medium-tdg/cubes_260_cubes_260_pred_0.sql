-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate Template_Type_Code in Templates)
-- 2. Wrong source table (Ref_Template_Types has 'TYPE_UNUSED' which is not in Templates)
-- 3. Unnecessary INNER JOIN with Documents (Template 2 and 3 have no Documents; Template 1 has multiple Documents)
-- 4. Missing or inverted ORDER BY (inserted in non-alphabetical order 'TYPE_Z', 'TYPE_A', 'TYPE_M')
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_Z', 'Zebra Template');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_A', 'Alpha Template');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_M', 'Middle Template');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_UNUSED', 'Unused Template Type');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'TYPE_Z', 1, '2020-01-01', '2025-01-01', 'Details 1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'TYPE_A', 2, '2021-01-01', '2026-01-01', 'Details 2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'TYPE_Z', 3, '2022-01-01', '2027-01-01', 'Details 3');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (4, 'TYPE_M', 1, '2019-01-01', '2024-01-01', 'Details 4');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (10, 1, 'Doc 1', 'Desc 1', 'Other 1');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (11, 1, 'Doc 2', 'Desc 2', 'Other 2');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (100, 10, 'Para 1', 'Other P1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_code FROM templates ORDER BY template_type_code;

/*
Gold Result:
('TYPE_A',)
('TYPE_M',)
('TYPE_Z',)
*/

-- Prediction Query
SELECT DISTINCT template_type_code FROM Templates;

/*
Prediction Result:
('TYPE_Z',)
('TYPE_A',)
('TYPE_M',)
*/