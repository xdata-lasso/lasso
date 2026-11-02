-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_A', 'Desc A');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_B', 'Desc B');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_C', 'Desc C');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'TYPE_A', 3, '2020-01-01', '2025-01-01', 'Details 1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'TYPE_B', 1, '2020-01-01', '2025-01-01', 'Details 3');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (5, 'TYPE_C', 2, '2020-01-01', '2025-01-01', 'Details 5');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (10, 1, 'Doc 10', 'Desc 10', 'Other 10');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (20, 3, 'Doc 20', 'Desc 20', 'Other 20');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (21, 3, 'Doc 21', 'Desc 21', 'Other 21');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (3, 5, 'Doc 3', 'Desc 3', 'Other 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, LHS.n AS n, RHS.document_id AS document_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM (SELECT template_id, version_number, template_type_code, date_effective_from, date_effective_to, template_details, template_id AS n FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details FROM templates AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM templates) AS RHS ON (LHS.template_id = RHS.n))) AS LHS INNER JOIN documents AS RHS ON (LHS.template_id = RHS.template_id)) ORDER BY template_type_code;

/*
Gold Result:
('TYPE_B',)
('TYPE_B',)
*/

-- Prediction Query
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id GROUP BY T1.template_type_code ORDER BY COUNT(*) DESC, T1.template_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('TYPE_B',)
*/