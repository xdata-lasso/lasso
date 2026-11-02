-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('AD', 'Advertisement');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('BK', 'Book');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CV', 'Curriculum Vitae');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('PP', 'Paper');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'AD', 4, '2018-01-01 00:00:00', '2019-01-01 00:00:00', 'Ad Template');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (4, 'BK', 2, '2018-02-01 00:00:00', '2019-02-01 00:00:00', 'Book Template');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (5, 'CV', 1, '2018-03-01 00:00:00', '2019-03-01 00:00:00', 'CV Template');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (10, 'PP', 3, '2018-04-01 00:00:00', '2019-04-01 00:00:00', 'Paper Template');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (101, 1, 'Doc A1', 'Desc A1', 'Details A1');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (102, 1, 'Doc A2', 'Desc A2', 'Details A2');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (103, 1, 'Doc A3', 'Desc A3', 'Details A3');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (104, 4, 'Doc B1', 'Desc B1', 'Details B1');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (105, 4, 'Doc B2', 'Desc B2', 'Details B2');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (4, 5, 'Doc C1', 'Desc C1', 'Details C1');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (106, 10, 'Doc P1', 'Desc P1', 'Details P1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, LHS.n AS n, RHS.document_id AS document_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM (SELECT template_id, version_number, template_type_code, date_effective_from, date_effective_to, template_details, template_id AS n FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details FROM templates AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM templates) AS RHS ON (LHS.template_id = RHS.n))) AS LHS INNER JOIN documents AS RHS ON (LHS.template_id = RHS.template_id)) ORDER BY template_type_code;

/*
Gold Result:
('BK',)
('BK',)
*/

-- Prediction Query
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id GROUP BY T1.template_type_code ORDER BY COUNT(*) DESC, T1.template_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('AD',)
*/