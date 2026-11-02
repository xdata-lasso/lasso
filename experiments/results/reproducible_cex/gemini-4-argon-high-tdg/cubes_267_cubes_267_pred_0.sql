-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T1', 'Zebra Type');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T2', 'Alpha Type');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T3', 'Unused Type No Template');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T4', 'Unused Type No Document');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (10, 'T1', 1, '2020-01-01', '2025-01-01', 'Details 10');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (20, 'T2', 2, '2020-02-01', '2025-02-01', 'Details 20');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (40, 'T4', 3, '2020-03-01', '2025-03-01', 'Details 40');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (50, NULL, 4, '2020-04-01', '2025-04-01', 'Details 50');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (100, 10, 'Doc 100', 'Desc 100', 'Other 100');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (200, 20, 'Doc 200', 'Desc 200', 'Other 200');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (201, 20, 'Doc 201', 'Desc 201', 'Other 201');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (500, 50, 'Doc 500', 'Desc 500', 'Other 500');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (600, NULL, 'Doc 600', 'Desc 600', 'Other 600');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (1000, 200, 'Para 1000', 'Para Other 1');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (1001, 200, 'Para 1001', 'Para Other 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_description FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, LHS.document_id AS document_id, LHS.document_name AS document_name, LHS.document_description AS document_description, LHS.other_details AS other_details, RHS.template_type_description AS template_type_description FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, RHS.document_id AS document_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM templates AS LHS INNER JOIN documents AS RHS ON (LHS.template_id = RHS.template_id)) AS LHS INNER JOIN ref_template_types AS RHS ON (LHS.template_type_code = RHS.template_type_code)) ORDER BY template_type_description;

/*
Gold Result:
('Alpha Type',)
('Zebra Type',)
*/

-- Prediction Query
SELECT DISTINCT T1.template_type_description FROM Ref_template_types AS T1 JOIN Templates AS T2 ON T1.template_type_code = T2.template_type_code JOIN Documents AS T3 ON T2.Template_ID = T3.template_ID;

/*
Prediction Result:
('Zebra Type',)
('Alpha Type',)
*/