-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('TXT', 'Plain Text');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'TXT', 1, '2020-01-01 00:00:00', '2030-01-01 00:00:00', 'Base Template');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (10, 1, 'Welcome to NY', 'Valid NY', 'D10');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (20, 1, 'Welcome to LA', 'Valid LA', 'D20');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (30, 1, NULL, 'Null Name Doc', 'D30');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (10, 10, NULL, 'Null text in NY doc');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (20, 10, 'Non-null text in NY doc', 'Normal text');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (30, 20, 'Text in LA doc', 'Excluded');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (40, 30, 'Text in NULL-named doc', 'Included by NOT EXISTS');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (50, NULL, 'Orphan paragraph with NULL Document_ID', 'Included by NOT EXISTS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "paragraph_id", "paragraph_text" FROM (SELECT * FROM "paragraphs" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" <> 'Welcome to NY')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY paragraph_id, "paragraph_id" NULLS LAST, "paragraph_text" NULLS LAST;

/*
Gold Result:
(10, None)
(20, 'Non-null text in NY doc')
(40, 'Text in NULL-named doc')
(50, 'Orphan paragraph with NULL Document_ID')
*/

-- Prediction Query
SELECT T1.paragraph_id, T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id WHERE T2.Document_Name = 'Welcome to NY';

/*
Prediction Result:
(10, None)
(20, 'Non-null text in NY doc')
*/