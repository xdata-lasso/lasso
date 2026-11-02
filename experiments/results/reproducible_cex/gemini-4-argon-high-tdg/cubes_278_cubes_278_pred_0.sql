-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('Z_TYPE', 'Type Z');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('A_TYPE', 'Type A');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('M_TYPE', 'Type M');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('B_TYPE', 'Type B');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'Z_TYPE', 1, '2020-01-01', '2020-12-31', 'Z v1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'Z_TYPE', 2, '2021-01-01', '2021-12-31', 'Z v2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'A_TYPE', 2, '2020-01-01', '2020-12-31', 'A v2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (4, 'A_TYPE', 9, '2021-01-01', '2021-12-31', 'A v9');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (5, 'M_TYPE', 3, '2020-01-01', '2020-12-31', 'M v3 first');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (6, 'M_TYPE', 3, '2021-01-01', '2021-12-31', 'M v3 duplicate');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (7, 'M_TYPE', 1, '2022-01-01', '2022-12-31', 'M v1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (8, 'B_TYPE', 1, '2020-01-01', '2020-12-31', 'B v1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (9, 'B_TYPE', 4, '2021-01-01', '2021-12-31', 'B v4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_code FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details FROM templates AS LHS INNER JOIN (SELECT template_type_code, COUNT(*) AS n FROM templates GROUP BY template_type_code) AS RHS ON (LHS.version_number = RHS.n AND LHS.template_type_code = RHS.template_type_code)) ORDER BY template_type_code;

/*
Gold Result:
('A_TYPE',)
('M_TYPE',)
('Z_TYPE',)
*/

-- Prediction Query
SELECT template_type_code FROM Templates GROUP BY template_type_code ORDER BY COUNT(*) DESC, template_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('M_TYPE',)
*/