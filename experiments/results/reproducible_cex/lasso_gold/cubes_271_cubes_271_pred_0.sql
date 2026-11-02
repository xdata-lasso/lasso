-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('evidence', 'Their institution deep much role cut find.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('own', 'Line six space couple best issue interest.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1041, 'evidence', 1042, '1990-10-21', '1991-11-22', 'remain');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1049, 'own', 1050, '1994-03-02', '1995-04-03', 'manage');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1043, 1041, 'Customer reviews', 'Just military building different full open.', 'drug');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1051, 1049, 'Customer reviews', 'Pull worker better.', 'interesting');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1044, 1043, 'per', 'discussion');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1048, 1043, 'worry', 'us');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1052, 1051, 'should', 'group');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "paragraph_text" FROM (SELECT * FROM "paragraphs" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" <> 'Customer reviews')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY paragraph_text, "paragraph_text" NULLS LAST;

/*
Gold Result:
('per',)
('should',)
('worry',)
*/

-- Prediction Query
SELECT T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id WHERE T2.document_name = 'Customer reviews';

/*
Prediction Result:
('per',)
('worry',)
('should',)
*/