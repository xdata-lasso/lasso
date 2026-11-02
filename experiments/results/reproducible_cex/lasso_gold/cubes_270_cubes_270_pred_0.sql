-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('such', 'Eat couple large instead.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1052, 'such', 1053, '1996-05-04', '1997-06-05', 'family');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1054, 1052, 'Welcome to NY', 'Economic type kitchen technology nearly anything yourself.', 'think');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1064, NULL, NULL, NULL, NULL);
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1055, 1054, 'administration', 'better');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1056, 1064, 'administration', 'better');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "paragraph_id", "paragraph_text" FROM (SELECT * FROM "paragraphs" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" <> 'Welcome to NY')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY paragraph_id, "paragraph_id" NULLS LAST, "paragraph_text" NULLS LAST;

/*
Gold Result:
(1055, 'administration')
(1056, 'administration')
*/

-- Prediction Query
SELECT T1.paragraph_id, T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id WHERE T2.Document_Name = 'Welcome to NY';

/*
Prediction Result:
(1055, 'administration')
*/