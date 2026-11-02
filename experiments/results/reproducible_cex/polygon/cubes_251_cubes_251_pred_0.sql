-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ref_Template_Types" ("template_type_code", "template_type_description") VALUES ('CV11', 'CV');
INSERT INTO "Ref_Template_Types" ("template_type_code", "template_type_description") VALUES ('CV', 'CV');
INSERT INTO "Templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (10, 'CV11', 3601446103343025469, 3601446103343025469, 3601446103343025469, 'CV');
INSERT INTO "Templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (9, 'CV', 18, 19, 20, 'CV21');
INSERT INTO "Documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (12, 9, 'CV', 'CV', 'CV');
INSERT INTO "Paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (15, 12, 'CV', 'CV');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "template_type_code", COUNT(*) AS "n" FROM "templates" GROUP BY "template_type_code") WHERE ("template_type_code" = 'CV') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Templates WHERE template_type_code = 'CV';

/*
Prediction Result:
(1,)
*/