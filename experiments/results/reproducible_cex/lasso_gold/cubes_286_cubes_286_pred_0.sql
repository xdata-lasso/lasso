-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('purpose', 'Agent every development say.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1001, 'purpose', 1002, '1970-01-01', '1971-02-02', 'require');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1003, 1001, 'Kimberly Garza', 'Ahead despite measure.', 'agreement');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1004, 1003, 'Brazil', 'option');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_id" FROM "paragraphs" WHERE ("paragraph_text" <> 'Ireland' AND "paragraph_text" = 'Brazil') ORDER BY document_id, paragraphs.paragraph_id NULLS LAST;

/*
Gold Result:
(1003,)
*/

-- Prediction Query
SELECT document_id FROM Paragraphs WHERE paragraph_text = 'Brazil' INTERSECT SELECT document_id FROM Paragraphs WHERE paragraph_text = 'Ireland';

/*
Prediction Result:
*/