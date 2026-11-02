-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching, non-matching (Version_Number != COUNT), duplicate matches requiring DISTINCT, and ORDER BY sorting.
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('A', 'Type A');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('B', 'Type B');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('C', 'Type C');
-- Type C: count = 1, version = 1 (Matches)
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'C', 1, '2020-01-01', '2021-01-01', 'Det 1');
-- Type A: count = 2, both versions = 2 (Matches twice, tests DISTINCT)
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'A', 2, '2020-01-01', '2021-01-01', 'Det 2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'A', 2, '2020-01-01', '2021-01-01', 'Det 3');
-- Type B: count = 2, versions = 1 and 3 (No match, tests Version_Number = COUNT(*) condition)
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (4, 'B', 1, '2020-01-01', '2021-01-01', 'Det 4');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (5, 'B', 3, '2020-01-01', '2021-01-01', 'Det 5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_code FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details FROM templates AS LHS INNER JOIN (SELECT template_type_code, COUNT(*) AS n FROM templates GROUP BY template_type_code) AS RHS ON (LHS.version_number = RHS.n AND LHS.template_type_code = RHS.template_type_code)) ORDER BY template_type_code;

/*
Gold Result:
('A',)
('C',)
*/

-- Prediction Query
SELECT template_type_code FROM Templates GROUP BY template_type_code ORDER BY COUNT(*) DESC, template_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('A',)
*/