-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('PM', 'Southern role movie win her.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('trial', 'Herself law street class.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1008, 'PM', 1009, '1974-05-05', '1975-06-06', 'old');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1013, 'trial', 1011, '1976-07-07', '1977-08-08', 'hear');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1010, 1008, 'Mark Mcclure', 'Officer relate animal direction eye bag.', 'early');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1012, 1008, 'Derek Zuniga', 'Participant commercial rock clear.', 'hundred');
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