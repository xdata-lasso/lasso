-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('T1', 'Standard Template');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'T1', 1, '2020-01-01', '2030-01-01', 'Details 1');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 1, 'Customer reviews', 'Desc 1', 'Other 1');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 1, 'Annual Report', 'Desc 2', 'Other 2');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (3, 1, NULL, 'Desc 3', 'Other 3');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (4, 1, 'Customer reviews', 'Desc 4', 'Other 4');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (1, 1, 'Zeta paragraph', 'P1');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (2, 1, 'Alpha paragraph', 'P2');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (3, 1, 'Alpha paragraph', 'P3');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (4, 1, NULL, 'P4');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (5, 2, 'Excluded paragraph', 'P5');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (6, 3, 'Paragraph from NULL doc name', 'P6');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (7, NULL, 'Orphan paragraph', 'P7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "paragraph_text" FROM (SELECT * FROM "paragraphs" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" <> 'Customer reviews')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY paragraph_text, "paragraph_text" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha paragraph',)
('Alpha paragraph',)
('Orphan paragraph',)
('Paragraph from NULL doc name',)
('Zeta paragraph',)
*/

-- Prediction Query
SELECT T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id WHERE T2.document_name = 'Customer reviews';

/*
Prediction Result:
('Zeta paragraph',)
('Alpha paragraph',)
('Alpha paragraph',)
(None,)
*/