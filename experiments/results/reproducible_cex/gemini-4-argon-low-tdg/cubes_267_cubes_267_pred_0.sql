-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT behavior (1-to-many relationships across Documents and Templates, and duplicate descriptions across different codes)
-- and tests ORDER BY direction and tie-breaking.
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CODE_Z', 'Zebra_Description');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CODE_A', 'Alpha_Description');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CODE_M1', 'Middle_Duplicate_Description');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CODE_M2', 'Middle_Duplicate_Description');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (10, 'CODE_Z', 1, '2021-01-01', '2022-01-01', 'Details Z1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (11, 'CODE_Z', 2, '2022-01-01', '2023-01-01', 'Details Z2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (20, 'CODE_A', 1, '2021-01-01', '2022-01-01', 'Details A');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (30, 'CODE_M1', 1, '2021-01-01', '2022-01-01', 'Details M1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (31, 'CODE_M2', 1, '2021-01-01', '2022-01-01', 'Details M2');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (1, 10, 'Doc Z1_a', 'Desc', 'Other');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (2, 10, 'Doc Z1_b', 'Desc', 'Other');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (3, 11, 'Doc Z2_a', 'Desc', 'Other');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (4, 20, 'Doc A_a', 'Desc', 'Other');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (5, 30, 'Doc M1_a', 'Desc', 'Other');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (6, 31, 'Doc M2_a', 'Desc', 'Other');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (1, 1, 'Text 1', 'Other');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (2, 1, 'Text 2', 'Other');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_description FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, LHS.document_id AS document_id, LHS.document_name AS document_name, LHS.document_description AS document_description, LHS.other_details AS other_details, RHS.template_type_description AS template_type_description FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, RHS.document_id AS document_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM templates AS LHS INNER JOIN documents AS RHS ON (LHS.template_id = RHS.template_id)) AS LHS INNER JOIN ref_template_types AS RHS ON (LHS.template_type_code = RHS.template_type_code)) ORDER BY template_type_description;

/*
Gold Result:
('Alpha_Description',)
('Middle_Duplicate_Description',)
('Zebra_Description',)
*/

-- Prediction Query
SELECT DISTINCT T1.template_type_description FROM Ref_template_types AS T1 JOIN Templates AS T2 ON T1.template_type_code = T2.template_type_code JOIN Documents AS T3 ON T2.Template_ID = T3.template_ID;

/*
Prediction Result:
('Zebra_Description',)
('Alpha_Description',)
('Middle_Duplicate_Description',)
*/