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
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('PR', 'Presentation');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'PR', 2, '2020-01-01 00:00:00', '2025-01-01 00:00:00', 'Presentation Template v2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'BK', 1, '2022-05-10 00:00:00', '2023-05-10 00:00:00', 'Book Template v1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'PR', 1, '2019-01-01 00:00:00', '2020-01-01 00:00:00', 'Presentation Template v1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (4, 'CV', 5, '2021-03-15 00:00:00', '2024-03-15 00:00:00', 'Resume Template');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (5, 'BK', 2, '2023-05-11 00:00:00', '2026-05-11 00:00:00', 'Book Template v2');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (101, 1, 'Q1 Pitch', 'Quarterly Pitch Deck', 'Confidential');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (102, 2, 'SQL Guide', 'Database Textbook', 'Draft');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (1001, 101, 'Introduction to Q1 goals.', 'Page 1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT template_type_code FROM templates ORDER BY template_type_code;

/*
Gold Result:
('BK',)
('CV',)
('PR',)
*/

-- Prediction Query
SELECT DISTINCT template_type_code FROM Templates;

/*
Prediction Result:
('PR',)
('BK',)
('CV',)
*/