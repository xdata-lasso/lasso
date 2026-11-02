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
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('CV', 'CV');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'AD', 9, '2020-01-01 00:00:00', '2021-01-01 00:00:00', 'Detail 1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'BK', 5, '2020-02-01 00:00:00', '2021-02-01 00:00:00', 'Detail 2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'CV', 7, '2020-03-01 00:00:00', '2021-03-01 00:00:00', 'Detail 3');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (6, 'AD', 4, '2020-04-01 00:00:00', '2021-04-01 00:00:00', 'Detail 4');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (7, 'BK', 0, '2020-05-01 00:00:00', '2021-05-01 00:00:00', 'Detail 5');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (8, 'CV', NULL, '2020-06-01 00:00:00', '2021-06-01 00:00:00', 'Detail 6');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (9, 'BK', 6, '2020-07-01 00:00:00', '2021-07-01 00:00:00', 'Detail 7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT version_number, template_type_code FROM templates WHERE (version_number > 5) ORDER BY version_number, templates.template_id NULLS LAST;

/*
Gold Result:
(6, 'BK')
(7, 'CV')
(9, 'AD')
*/

-- Prediction Query
SELECT version_number, template_type_code FROM Templates WHERE version_number > 5;

/*
Prediction Result:
(9, 'AD')
(7, 'CV')
(6, 'BK')
*/