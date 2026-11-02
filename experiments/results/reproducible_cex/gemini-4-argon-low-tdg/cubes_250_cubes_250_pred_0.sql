-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE boundary conditions (4, 5, 6, 10, NULL), ORDER BY primary/secondary sort, and DISTINCT vs ALL with duplicate output projections.
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('AD', 'Advertisement');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('BK', 'Book');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CV', 'CV');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'AD', 4, '2020-01-01', '2020-12-31', 'Below boundary');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'BK', 5, '2020-01-01', '2020-12-31', 'Exact boundary');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'CV', NULL, '2020-01-01', '2020-12-31', 'Null version');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (10, 'CV', 6, '2020-01-01', '2020-12-31', 'Above boundary, high ID');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (4, 'BK', 6, '2020-01-01', '2020-12-31', 'Above boundary, low ID');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (5, 'AD', 10, '2020-01-01', '2020-12-31', 'High version, duplicate output 1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (6, 'AD', 10, '2020-01-01', '2020-12-31', 'High version, duplicate output 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT version_number, template_type_code FROM templates WHERE (version_number > 5) ORDER BY version_number, templates.template_id NULLS LAST;

/*
Gold Result:
(6, 'BK')
(6, 'CV')
(10, 'AD')
(10, 'AD')
*/

-- Prediction Query
SELECT version_number, template_type_code FROM Templates WHERE version_number > 5;

/*
Prediction Result:
(6, 'BK')
(10, 'AD')
(10, 'AD')
(6, 'CV')
*/