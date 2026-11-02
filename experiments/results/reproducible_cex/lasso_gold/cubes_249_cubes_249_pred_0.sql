-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('still', 'Space couple best issue interest level rock.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('apply', 'Live try most arm meet surface attention attack.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1045, 'still', 1046, '1978-09-09', '1979-10-10', 'report');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1058, 'apply', 1059, '1980-11-11', '1981-01-12', 'training');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1047, 1045, 'Maria Brown', 'Kitchen technology nearly anything.', 'clear');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1048, 1045, 'Rebecca Rodriguez', 'Structure why unit support coach magazine degree.', 'customer');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1049, 1045, 'Joshua Taylor', 'Total clearly able hospital unit size.', 'fine');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1050, 1045, 'Joel Baxter', 'Institution whatever yet new responsibility.', 'director');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1060, 1058, 'Bryan Zamora', 'Enter capital population lead upon.', 'record');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1061, 1058, 'Kristopher Harvey', 'Act perform none beyond.', 'body');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1062, 1058, 'Kevin Mills', 'Defense enter value thing these hard citizen.', 'wrong');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1063, 1058, 'Christina Moran', 'Region particularly would pressure account stage federal.', 'unit');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (60, NULL, NULL, NULL, NULL);
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (80, NULL, NULL, NULL, NULL);
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (90, NULL, NULL, NULL, NULL);
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (100, NULL, NULL, NULL, NULL);
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (170, NULL, NULL, NULL, NULL);
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (180, NULL, NULL, NULL, NULL);
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (190, NULL, NULL, NULL, NULL);
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1054, 60.0, 'center', 'both');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1055, 80.0, 'particularly', 'small');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1056, 90.0, 'simply', 'former');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1057, 100.0, 'occur', 'art');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1067, 60.0, 'article', 'ask');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1068, 170.0, 'everything', 'situation');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1069, 180.0, 'business', 'on');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1070, 190.0, 'voice', 'clearly');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id FROM (SELECT * FROM (SELECT * FROM (SELECT paragraph_id, document_id, paragraph_text, other_details, COUNT(*) OVER () AS n FROM paragraphs) ORDER BY document_id) LIMIT 1);

/*
Gold Result:
(60,)
*/

-- Prediction Query
SELECT document_id FROM Paragraphs GROUP BY document_id ORDER BY COUNT(*) ASC, document_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(80,)
*/