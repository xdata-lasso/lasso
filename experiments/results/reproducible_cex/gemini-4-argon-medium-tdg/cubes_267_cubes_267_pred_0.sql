-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CODE_B', 'Description Z');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CODE_A', 'Description A');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CODE_C', 'Description M');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CODE_D', 'Description Unused');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'CODE_B', 1, '2020-01-01', '2025-01-01', 'Details 1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'CODE_A', 2, '2021-01-01', '2026-01-01', 'Details 2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'CODE_A', 1, '2019-01-01', '2024-01-01', 'Details 3');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (4, 'CODE_C', 1, '2022-01-01', '2027-01-01', 'Template with no documents');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (10, 1, 'Doc 10', 'Desc 10', 'Other 10');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (11, 1, 'Doc 11', 'Desc 11', 'Other 11');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (12, 2, 'Doc 12', 'Desc 12', 'Other 12');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (13, 3, 'Doc 13', 'Desc 13', 'Other 13');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (14, NULL, 'Doc 14', 'Orphan Doc', 'Other 14');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (100, 10, 'Para 100', 'Details 100');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_description FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, LHS.document_id AS document_id, LHS.document_name AS document_name, LHS.document_description AS document_description, LHS.other_details AS other_details, RHS.template_type_description AS template_type_description FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, RHS.document_id AS document_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM templates AS LHS INNER JOIN documents AS RHS ON (LHS.template_id = RHS.template_id)) AS LHS INNER JOIN ref_template_types AS RHS ON (LHS.template_type_code = RHS.template_type_code)) ORDER BY template_type_description;

/*
Gold Result:
('Description A',)
('Description Z',)
*/

-- Prediction Query
SELECT DISTINCT T1.template_type_description FROM Ref_template_types AS T1 JOIN Templates AS T2 ON T1.template_type_code = T2.template_type_code JOIN Documents AS T3 ON T2.Template_ID = T3.template_ID;

/*
Prediction Result:
('Description Z',)
('Description A',)
*/