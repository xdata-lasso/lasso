-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ref_Template_Types" ("template_type_code", "template_type_description") VALUES ('8', '1');
INSERT INTO "Ref_Template_Types" ("template_type_code", "template_type_description") VALUES ('7', '1');
INSERT INTO "Templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (9, '7', 1, 1, 1, '1');
INSERT INTO "Templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (12, '8', 1, 1, 1, '1');
INSERT INTO "Documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (11, 12, '1', '1', '16');
INSERT INTO "Documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (10, 12, '1', '1', NULL);
INSERT INTO "Paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (14, 10, '1', '1');
INSERT INTO "Paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (13, 10, '1', '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_template_id_ FROM (SELECT other_details, COUNT(DISTINCT template_id) AS n_distinct FROM documents GROUP BY other_details) ORDER BY count_distinct_template_id_;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT template_id) FROM Documents;

/*
Prediction Result:
(1,)
*/