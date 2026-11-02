-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('purpose', 'Agent every development say.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('sense', 'Agent every development say.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1001, 'purpose', 1002, '1970-01-01', '1971-02-02', 'require');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1005, 'purpose', 1002, '1970-01-01', '1971-02-02', 'require');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1003, 1001, 'Kimberly Garza', 'Ahead despite measure.', 'agreement');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1007, 1001, 'Kimberly Garza', 'Ahead despite measure.', 'agreement');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1004, 1003, 'option', 'decide');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1008, NULL, 'option', 'decide');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "LHS"."paragraph_id" AS "paragraph_id", "LHS"."document_id" AS "document_id", "LHS"."paragraph_text" AS "paragraph_text", "LHS"."other_details" AS "other_details", "RHS"."document_name" AS "document_name", "RHS"."n" AS "n" FROM "paragraphs" AS "LHS" LEFT JOIN (SELECT "document_id", "document_name", COUNT(*) AS "n" FROM "documents" GROUP BY "document_id", "document_name") AS "RHS" ON ("LHS"."document_id" = "RHS"."document_id")) WHERE ("document_name" <> 'Summer Show') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_ID = T2.document_ID WHERE T2.document_name = 'Summer Show';

/*
Prediction Result:
(0,)
*/