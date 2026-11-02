-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_UNUSED', 'Unused template type');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_DOC_NEW', 'Has document and newest date');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_NODOC_OLD', 'No document and oldest date');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_WINNER', 'No document and newest among no-doc');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_NODOC_MID', 'No document and middle date');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('TYPE_DOC_OLD', 'Has document and oldest overall');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (5, 'TYPE_DOC_NEW', 100, '2024-11-20 00:00:00', '2026-11-20 00:00:00', 'Details 5');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (10, 'TYPE_NODOC_OLD', 50, '2018-01-01 00:00:00', '2025-12-31 00:00:00', 'Details 10');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (20, 'TYPE_WINNER', 20, '2022-05-15 00:00:00', '2023-05-15 00:00:00', 'Details 20');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (30, 'TYPE_NODOC_MID', 1, '2020-03-10 00:00:00', '2021-03-10 00:00:00', 'Details 30');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (40, 'TYPE_DOC_OLD', 80, '2015-01-01 00:00:00', '2029-01-01 00:00:00', 'Details 40');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (10, 40, 'Doc 10', 'Desc 10', 'Other 10');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (20, 5, 'Doc 20', 'Desc 20', 'Other 20');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (1, 10, 'Paragraph 1', 'Other P1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM templates AS LHS WHERE NOT EXISTS(SELECT 1 FROM documents AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY date_effective_from DESC) LIMIT 1);

/*
Gold Result:
('TYPE_WINNER',)
*/

-- Prediction Query
SELECT template_type_code FROM Templates EXCEPT SELECT template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id;

/*
Prediction Result:
('TYPE_NODOC_MID',)
('TYPE_NODOC_OLD',)
('TYPE_WINNER',)
*/