-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Documents" ("Document_ID", "Document_Name") VALUES (1, NULL);
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text") VALUES (1, 1, 'Test paragraph');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "paragraph_text" FROM (SELECT * FROM "paragraphs" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" <> 'Customer reviews')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY paragraph_text, "paragraph_text" NULLS LAST;

/*
Gold Result:
('Test paragraph',)
*/

-- Prediction Query
SELECT T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id WHERE T2.document_name = 'Customer reviews';

/*
Prediction Result:
*/