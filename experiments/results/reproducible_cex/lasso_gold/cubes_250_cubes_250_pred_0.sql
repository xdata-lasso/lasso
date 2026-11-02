-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('size', 'Much section investment on gun young catch.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('benefit', 'Technology check civil.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1014, 'size', 7, '1992-01-23', '1993-02-01', 'minute');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1015, 'benefit', 6, '1994-03-02', '1995-04-03', 'response');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT version_number, template_type_code FROM templates WHERE (version_number > 5) ORDER BY version_number, templates.template_id NULLS LAST;

/*
Gold Result:
(6, 'benefit')
(7, 'size')
*/

-- Prediction Query
SELECT version_number, template_type_code FROM Templates WHERE version_number > 5;

/*
Prediction Result:
(7, 'size')
(6, 'benefit')
*/