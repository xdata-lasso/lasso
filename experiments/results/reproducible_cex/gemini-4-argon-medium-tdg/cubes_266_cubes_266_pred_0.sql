-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, sorting (ASC vs DESC), and JOIN/DISTINCT mutants (child rows: 0, 1, and multiple).
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('C_CODE', 'Book');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('A_CODE', 'Book');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('B_CODE', 'Magazine');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'C_CODE', 1, '2020-01-01', '2025-01-01', 'Detail 1');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (2, 'C_CODE', 2, '2020-01-01', '2025-01-01', 'Detail 2');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (3, 'B_CODE', 1, '2020-01-01', '2025-01-01', 'Detail 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "template_type_code" FROM "ref_template_types" WHERE ("template_type_description" = 'Book') ORDER BY template_type_code;

/*
Gold Result:
('A_CODE',)
('C_CODE',)
*/

-- Prediction Query
SELECT template_type_code FROM Ref_template_types WHERE template_type_description = 'Book';

/*
Prediction Result:
('C_CODE',)
('A_CODE',)
*/